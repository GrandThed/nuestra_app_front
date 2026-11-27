import 'dart:async';
import 'dart:typed_data';

import 'package:a2ui_core/a2ui_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_edge_ai/flutter_edge_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/utils/money_format.dart';
import 'package:nuestra_app/features/assistant/application/assistant_actions.dart';
import 'package:nuestra_app/features/assistant/application/week_planner.dart';
import 'package:nuestra_app/features/assistant/data/assistant_engine.dart';
import 'package:nuestra_app/features/assistant/data/assistant_history_repository.dart';
import 'package:nuestra_app/features/assistant/data/form_surfaces.dart';
import 'package:nuestra_app/features/assistant/domain/assistant_request.dart';
import 'package:nuestra_app/features/assistant/domain/chat_items.dart';
import 'package:nuestra_app/features/assistant/domain/spanish_parsing.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/expenses/data/repositories/expense_repository.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/food/data/food_models.dart';
import 'package:nuestra_app/features/food/data/food_repository.dart';
import 'package:nuestra_app/features/food/forms/food_form_handler.dart';
import 'package:nuestra_app/features/food/forms/food_forms.dart';
import 'package:nuestra_app/features/food/presentation/food_providers.dart';
import 'package:nuestra_app/features/food/presentation/recipe_photo_flow.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';

export 'package:nuestra_app/features/assistant/domain/chat_items.dart';

// ==================== STATE ====================

/// Where the on-device model is.
enum ModelStatus { unsupported, checking, notInstalled, downloading, ready, failed }

/// An item in the conversation, with a key that survives updates (a card
/// changing status keeps its place and its widget).
class ChatEntry {
  final int key;
  final ChatItem item;
  const ChatEntry(this.key, this.item);
}

class AssistantState {
  final ModelStatus modelStatus;
  final int downloadPercent;
  final String? error;
  final List<ChatEntry> entries;
  final bool loadingHistory;
  final String? conversationId;
  final List<ConversationSummary> conversations;

  /// What the assistant is doing ("Entendiendo…"), null when idle.
  final String? status;

  /// A reply being written, shown as it streams.
  final String? streamingText;

  const AssistantState({
    this.modelStatus = ModelStatus.checking,
    this.downloadPercent = 0,
    this.error,
    this.entries = const [],
    this.loadingHistory = false,
    this.conversationId,
    this.conversations = const [],
    this.status,
    this.streamingText,
  });

  bool get isBusy => status != null;

  AssistantState copyWith({
    ModelStatus? modelStatus,
    int? downloadPercent,
    String? Function()? error,
    List<ChatEntry>? entries,
    bool? loadingHistory,
    String? conversationId,
    List<ConversationSummary>? conversations,
    String? Function()? status,
    String? Function()? streamingText,
  }) =>
      AssistantState(
        modelStatus: modelStatus ?? this.modelStatus,
        downloadPercent: downloadPercent ?? this.downloadPercent,
        error: error != null ? error() : this.error,
        entries: entries ?? this.entries,
        loadingHistory: loadingHistory ?? this.loadingHistory,
        conversationId: conversationId ?? this.conversationId,
        conversations: conversations ?? this.conversations,
        status: status != null ? status() : this.status,
        streamingText: streamingText != null ? streamingText() : this.streamingText,
      );
}

// ==================== CONTROLLER ====================

final assistantProvider = NotifierProvider<AssistantController, AssistantState>(AssistantController.new);

/// The household assistant.
///
/// Each message goes through the same steps:
/// 1. "sí" / "no" with an expense waiting on screen save or discard it
///    (no model involved);
/// 2. the model reads the message into an [AssistantRequest] (constrained
///    JSON: it can only classify and copy text);
/// 3. [AssistantActions] runs it with the app's data and returns cards;
/// 4. only small talk and open questions get an answer written by the model.
/// The turn is then saved in the household's conversation.
class AssistantController extends Notifier<AssistantState> {
  final _engine = AssistantEngine.instance;
  FormSurfaces? _forms;
  CancelToken? _downloadCancel;
  AssistantActions? _actions;
  String _conversationId = AssistantHistoryRepository.newConversationId();
  int _keys = 0;
  bool _stopRequested = false;

  AssistantHistoryRepository get _history => ref.read(assistantHistoryRepositoryProvider);
  FormSurfaces get _surfaces => _forms ??= FormSurfaces(onAction: _onFormAction);
  String? get _householdId => ref.read(currentHouseholdIdProvider);

  @override
  AssistantState build() {
    ref.onDispose(_dispose);
    if (!_engine.isSupportedPlatform) return const AssistantState(modelStatus: ModelStatus.unsupported);
    Future.microtask(_checkInstalled);
    Future.microtask(_loadHistory);
    // The household may arrive after startup (saved login restored first)
    ref.listen(currentHouseholdIdProvider, (previous, next) {
      if (next != null && next != previous && !state.isBusy) {
        _actions = null;
        unawaited(_loadHistory());
      }
    });
    return const AssistantState(loadingHistory: true);
  }

  Future<void> _checkInstalled() async {
    try {
      final installed = await _engine.isInstalled();
      final partial = installed ? 0 : await _engine.downloadedPercent();
      state = state.copyWith(
        modelStatus: installed ? ModelStatus.ready : ModelStatus.notInstalled,
        downloadPercent: partial,
      );
    } catch (e) {
      state = state.copyWith(modelStatus: ModelStatus.failed, error: () => 'No se pudo iniciar el asistente: $e');
    }
  }

  Future<AssistantActions> _actionsFor(String householdId) async {
    final existing = _actions;
    if (existing != null && existing.householdId == householdId) return existing;
    final categories =
        await ref.read(expenseRepositoryProvider).getCategories(householdId).catchError((_) => <Never>[]);
    return _actions = AssistantActions(
      expenses: ref.read(expenseRepositoryProvider),
      food: ref.read(foodRepositoryProvider),
      householdId: householdId,
      categories: categories,
      members: ref.read(foodMembersProvider),
    );
  }

  // ---------- Entries ----------

  int _append(ChatItem item) {
    final key = ++_keys;
    state = state.copyWith(entries: [...state.entries, ChatEntry(key, item)]);
    return key;
  }

  ChatItem? _item(int key) => state.entries.where((e) => e.key == key).firstOrNull?.item;

  void _replace(int key, ChatItem item) {
    state = state.copyWith(entries: [
      for (final e in state.entries) e.key == key ? ChatEntry(key, item) : e,
    ]);
  }

  void _idle() => state = state.copyWith(status: () => null, streamingText: () => null);

  /// The expense waiting on screen, if any (the most recent open one).
  ({int key, ExpenseDraftCard draft})? get _openDraft {
    for (final e in state.entries.reversed) {
      final item = e.item;
      if (item is ExpenseDraftCard) return item.isOpen ? (key: e.key, draft: item) : null;
    }
    return null;
  }

  // ---------- History ----------

  String? get _myUserId {
    final auth = ref.read(authProvider);
    return auth is AuthStateAuthenticated ? auth.user.id : null;
  }

  Future<void> _loadHistory() async {
    final householdId = _householdId;
    if (householdId == null) {
      state = state.copyWith(loadingHistory: false);
      return;
    }
    final current = await _history.readCurrentConversationId(householdId);
    await _open(householdId, conversationId: current);
    unawaited(refreshConversations());
  }

  Future<void> _open(String householdId, {String? conversationId}) async {
    state = state.copyWith(loadingHistory: true);
    try {
      final saved = await _history.loadConversation(householdId, conversationId: conversationId);
      _conversationId = saved.conversationId ?? conversationId ?? AssistantHistoryRepository.newConversationId();
      state = state.copyWith(
        entries: [
          for (final m in saved.messages)
            if (_fromStored(m) case final item?) ChatEntry(++_keys, item),
        ],
        conversationId: _conversationId,
        loadingHistory: false,
      );
    } catch (e) {
      debugPrint('Could not load assistant history: $e');
      _conversationId = conversationId ?? _conversationId;
      state = state.copyWith(conversationId: _conversationId, loadingHistory: false);
    }
    await _history.saveCurrentConversationId(householdId, _conversationId);
  }

  /// Stored message → chat item. Reads the old format too (model replies
  /// with A2UI blocks, "proposal" messages).
  ChatItem? _fromStored(StoredMessage m) {
    if (m.role == 'user') {
      final author = m.author;
      final mine = author == null || author.id == _myUserId;
      return UserMessage(m.content, authorName: mine ? null : author.name, fromAction: m.metadata?['fromAction'] == true);
    }
    switch (m.kind) {
      case 'card':
        return DataCard.fromJson((m.metadata?['card'] as Map?)?.cast<String, dynamic>() ?? const {}, messageId: m.id);
      case 'proposal':
        final p = (m.metadata?['proposal'] as Map?)?.cast<String, dynamic>();
        if (p == null) return null;
        const statuses = {'saved': 'saved', 'cancelled': 'discarded', 'failed': 'failed'};
        return ExpenseDraftCard.fromJson(
          {...p, 'status': statuses[m.metadata?['status']] ?? 'pending'},
          messageId: m.id,
        );
      default:
        final text = stripOldCards(m.content);
        return text.isEmpty ? null : AssistantText(text);
    }
  }

  Future<void> refreshConversations() async {
    final householdId = _householdId;
    if (householdId == null) return;
    try {
      state = state.copyWith(conversations: await _history.listConversations(householdId));
    } catch (e) {
      debugPrint('Could not load conversation list: $e');
    }
  }

  Future<void> switchConversation(String conversationId) async {
    final householdId = _householdId;
    if (householdId == null || state.isBusy) return;
    _surfaces.reset();
    _actions?.profileAsked = false;
    await _open(householdId, conversationId: conversationId);
  }

  Future<void> newConversation() async {
    if (state.isBusy) return;
    _surfaces.reset();
    _actions?.profileAsked = false;
    _conversationId = AssistantHistoryRepository.newConversationId();
    state = state.copyWith(entries: const [], conversationId: _conversationId);
    final householdId = _householdId;
    if (householdId != null) await _history.saveCurrentConversationId(householdId, _conversationId);
  }

  /// Save what was just said: the user's message (if any) and the cards and
  /// replies given by [keys]. Cards get their stored ids back.
  Future<void> _save(String? userText, List<int> keys, {bool fromAction = false}) async {
    final householdId = _householdId;
    if (householdId == null) return;
    final saved = <(int?, Map<String, dynamic>?)>[];
    final messages = <StoredMessage>[];
    if (userText != null) {
      messages.add(StoredMessage(role: 'user', content: userText, metadata: fromAction ? const {'fromAction': true} : null));
      saved.add((null, null));
    }
    for (final key in keys) {
      final item = _item(key);
      if (item is DataCard) {
        final json = item.toJson();
        messages.add(StoredMessage(role: 'assistant', content: item.summary, metadata: {'kind': 'card', 'card': json}));
        saved.add((key, json));
      } else if (item is AssistantText) {
        messages.add(StoredMessage(role: 'assistant', content: item.text, metadata: const {'kind': 'reply'}));
        saved.add((null, null));
      }
    }
    if (messages.isEmpty) return;
    try {
      final stored = await _history.append(householdId: householdId, conversationId: _conversationId, messages: messages);
      for (var i = 0; i < saved.length && i < stored.length; i++) {
        final (key, json) = saved[i];
        final id = stored[i].id;
        if (key == null || id == null) continue;
        final current = _item(key);
        if (current is! DataCard) continue;
        final withId = current.withMessageId(id);
        _replace(key, withId);
        // Changed (saved, discarded...) while this was being stored
        if ('${withId.toJson()}' != '$json') unawaited(_saveCard(withId));
      }
      unawaited(refreshConversations());
    } catch (e) {
      debugPrint('Could not save assistant turn: $e');
    }
  }

  Future<void> _saveCard(DataCard card) async {
    final id = card.messageId;
    if (id == null) return;
    try {
      await _history.updateMetadata(id, {'kind': 'card', 'card': card.toJson()});
    } catch (e) {
      debugPrint('Could not update card: $e');
    }
  }

  // ---------- Model download ----------

  Future<void> downloadModel() async {
    if (state.modelStatus == ModelStatus.downloading) return;
    _downloadCancel = CancelToken();
    state = state.copyWith(modelStatus: ModelStatus.downloading, error: () => null);
    try {
      await _engine.install(
        onProgress: (p) => state = state.copyWith(downloadPercent: p),
        cancelToken: _downloadCancel,
      );
      state = state.copyWith(modelStatus: ModelStatus.ready);
    } on DownloadCancelledException {
      state = state.copyWith(modelStatus: ModelStatus.notInstalled);
    } catch (e) {
      state = state.copyWith(
        modelStatus: ModelStatus.notInstalled,
        error: () => 'La descarga se cortó: $e\nLo descargado se guarda; toca Continuar para seguir.',
      );
    } finally {
      _downloadCancel = null;
    }
  }

  void cancelDownload() => _downloadCancel?.cancel('cancelado por el usuario');

  Future<void> deleteModel() async {
    await _engine.uninstall();
    state = state.copyWith(modelStatus: ModelStatus.notInstalled, downloadPercent: 0);
  }

  // ---------- Messages ----------

  Future<void> send(String text) async {
    final message = text.trim();
    final householdId = _householdId;
    if (message.isEmpty || state.isBusy || householdId == null) return;
    _stopRequested = false;
    _append(UserMessage(message));

    // 1. "sí" / "no" answer the expense on screen
    final open = _openDraft;
    if (open != null && (isYes(message) || isNo(message))) {
      unawaited(_save(message, const []));
      if (isYes(message)) {
        await confirmDraft(open.key);
      } else {
        discardDraft(open.key);
      }
      return;
    }
    if (state.modelStatus != ModelStatus.ready) {
      _append(const Notice('El asistente necesita el modelo descargado.'));
      return;
    }

    final keys = <int>[];
    try {
      // 2. Read the message
      state = state.copyWith(status: () => 'Entendiendo…', streamingText: () => null);
      final actions = await _actionsFor(householdId);
      final request = await _read(message, actions, open?.draft);
      debugPrint('Assistant request: $request');
      if (_stopRequested) return;

      // 3. Run it
      state = state.copyWith(status: () => _statusFor(request.action));
      for (final output in await actions.run(request, message)) {
        switch (output) {
          case CardOut(:final card):
            keys.add(_append(card));
          case TextOut(:final text):
            keys.add(_append(AssistantText(text)));
          case FormOut(:final form):
            _showForm(form);
          case DraftPatch():
            final key = _applyPatch(output, open);
            if (key != null) keys.add(key);
          case ChatOut():
            // 4. Small talk: the model answers in its own words
            final key = await _chat(message);
            if (key != null) keys.add(key);
        }
      }
    } catch (e) {
      debugPrint('Assistant turn failed: $e');
      _append(Notice(e is AssistantUnavailableException
          ? AssistantUnavailableException.message
          : 'Algo salió mal con el asistente. Intenta de nuevo.'));
    } finally {
      _idle();
      unawaited(_save(message, keys));
    }
  }

  static String _statusFor(RequestAction a) => switch (a) {
        RequestAction.anotarGasto || RequestAction.corregirGasto => 'Preparando el gasto…',
        RequestAction.consultarGastos || RequestAction.resumenMes => 'Sumando los gastos…',
        RequestAction.gastosFijos => 'Buscando gastos fijos…',
        RequestAction.buscarReceta || RequestAction.cocinarConLoQueHay => 'Buscando recetas…',
        RequestAction.verMenu || RequestAction.armarMenu || RequestAction.listaCompras => 'Mirando el menú…',
        RequestAction.charlar => 'Escribiendo…',
        _ => 'Un momento…',
      };

  /// The model reads the message into a request. Unreadable → small talk.
  Future<AssistantRequest> _read(String message, AssistantActions actions, ExpenseDraftCard? open) async {
    final names = [for (final c in actions.categories) c.name];
    final money = const MoneyFormat();
    final json = await _engine.readJson(
      instructions: requestPrompt(
        categoryNames: names,
        pendingExpense: open == null
            ? null
            : '${open.description}, ${open.amount == null ? 'sin monto' : money.format(open.amount!)}, '
                '${open.categoryName ?? 'sin categoría'}',
        lastAssistant: _lastAssistantLine(),
      ),
      message: message,
      schema: requestSchema(names),
      name: 'pedido',
    );
    return json == null ? const AssistantRequest(RequestAction.charlar) : AssistantRequest.fromJson(json);
  }

  String? _lastAssistantLine() {
    for (final e in state.entries.reversed) {
      final item = e.item;
      final text = switch (item) {
        AssistantText(:final text) => text,
        DataCard() => item.summary,
        _ => null,
      };
      if (text != null) return text.length > 140 ? '${text.substring(0, 140)}…' : text;
    }
    return null;
  }

  static const _chatInstructions = '''
Eres el asistente de "Nuestra App", una app para organizar el hogar: gastos y comida.
Responde en español neutro, sin voseo ni modismos regionales, en 1 a 3 oraciones cortas.
$argentineWords
Escribe texto plano: sin markdown, sin asteriscos, sin listas.
Nunca digas números, montos ni datos del hogar: no los tenés.
Para hacer cosas, el usuario las pide directamente, por ejemplo: "anota 5.000 de súper", "¿cuánto gastamos este mes?", "una receta con pollo", "arma el menú de la semana", "a Juan no le gusta la cebolla".
Si te piden algo que no sea del hogar, responde corto y amable.''';

  /// A free answer, streamed. Returns the key of the text it added.
  Future<int?> _chat(String message) async {
    final history = <(bool, String)>[];
    // The last few exchanges, without this message (added last)
    final recent = state.entries.reversed.skip(1).take(6).toList().reversed;
    for (final e in recent) {
      final item = e.item;
      switch (item) {
        case UserMessage(:final text):
          history.add((true, text));
        case AssistantText(:final text):
          history.add((false, text));
        case DataCard():
          history.add((false, '[${item.summary}]'));
        default:
          break;
      }
    }
    // The model expects the conversation to start with the user
    while (history.isNotEmpty && !history.first.$1) {
      history.removeAt(0);
    }
    final buffer = StringBuffer();
    state = state.copyWith(streamingText: () => '');
    await for (final token in _engine.reply(instructions: _chatInstructions, history: history, message: message)) {
      buffer.write(token);
      state = state.copyWith(streamingText: () => cleanModelText('$buffer'));
    }
    final text = cleanModelText('$buffer');
    state = state.copyWith(streamingText: () => null);
    if (text.isEmpty) return null;
    return _append(AssistantText(text));
  }

  Future<void> stop() async {
    _stopRequested = true;
    await _engine.stop();
  }

  void _showForm(FormBuilder form) {
    final surface = _surfaces.render(form);
    if (surface != null) _append(FormCard(surface));
  }

  // ---------- Expense drafts ----------

  int? _applyPatch(DraftPatch patch, ({int key, ExpenseDraftCard draft})? open) {
    if (open == null || patch.isEmpty) {
      _append(const Notice('No hay un gasto para corregir. Escribe el gasto y lo preparo.'));
      return null;
    }
    final updated = open.draft.copyWith(
      amount: patch.amount == null ? null : () => patch.amount,
      date: patch.date,
      categoryId: patch.category == null ? null : () => patch.category!.id,
      categoryName: patch.category == null ? null : () => patch.category!.name,
      description: patch.description,
    );
    _replace(open.key, updated);
    unawaited(_saveCard(updated));
    return null;
  }

  /// Save the expense on the card with key [key], with the user's edits.
  Future<void> confirmDraft(
    int key, {
    String? description,
    double? amount,
    DateTime? date,
    String? Function()? categoryId,
    String? Function()? categoryName,
  }) async {
    final current = _item(key);
    if (current is! ExpenseDraftCard || !current.isOpen) return;
    final draft = current.copyWith(
      description: description,
      amount: amount == null ? null : () => amount,
      date: date,
      categoryId: categoryId,
      categoryName: categoryName,
      status: DraftStatus.saving,
    );
    if (draft.amount == null || draft.amount! <= 0) {
      _append(const Notice('Falta el monto: complétalo en la tarjeta.'));
      return;
    }
    _replace(key, draft);
    final saved = await ref.read(expensesProvider.notifier).createExpense(
          description: draft.description,
          amount: draft.amount!,
          date: draft.date,
          categoryId: draft.categoryId,
        );
    final done = draft.copyWith(
      status: saved != null ? DraftStatus.saved : DraftStatus.failed,
      expenseId: saved?.id,
    );
    _replace(key, done);
    unawaited(_saveCard(done));
  }

  void discardDraft(int key) {
    final current = _item(key);
    if (current is! ExpenseDraftCard || !current.isOpen) return;
    final done = current.copyWith(status: DraftStatus.discarded);
    _replace(key, done);
    unawaited(_saveCard(done));
  }

  // ---------- Food ----------

  Future<void> undoPreference(int key) async {
    final current = _item(key);
    if (current is! PreferenceCard || current.undone || current.preferenceId == null) return;
    try {
      await ref.read(foodRepositoryProvider).deletePreference(current.preferenceId!);
      final done = current.asUndone();
      _replace(key, done);
      refreshFood(ref.invalidate, const {FoodData.preferences});
      unawaited(_saveCard(done));
    } catch (e) {
      _append(Notice('No se pudo deshacer: $e'));
    }
  }

  /// "Armar con el asistente" from the menu screen: straight to the form.
  Future<void> openWeekPlanner(DateTime monday) async {
    final householdId = _householdId;
    if (householdId == null || state.isBusy) return;
    final actions = await _actionsFor(householdId);
    final form = await actions.weekPlannerForm(monday);
    if (form is FormOut) _showForm(form.form);
  }

  /// A food form was sent: run it in code, then show what comes next.
  void _onFormAction(A2uiRendererAction action) {
    if (state.isBusy || !FoodFormHandler.handles(action.name)) return;
    unawaited(_handleForm(action));
  }

  Future<void> _handleForm(A2uiRendererAction action) async {
    final householdId = _householdId;
    if (householdId == null) return;
    if (action.name == FoodFormAction.cancelar) {
      _append(const Notice('Cancelado.'));
      return;
    }
    state = state.copyWith(status: () => 'Guardando…');
    final keys = <int>[];
    String? summary;
    try {
      final outcome = await ref.read(foodFormHandlerProvider).handle(action);
      refreshFood(ref.invalidate, outcome.changed);
      summary = outcome.summary;
      _append(UserMessage(outcome.summary, fromAction: true));
      if (outcome.next != null) _showForm(outcome.next!);
      final recipe = outcome.openRecipe;
      if (recipe != null) {
        keys.add(_append(LinkCard(
          title: 'Abrir la receta',
          subtitle: recipe.servings == null ? '' : 'Para ${recipe.servings} personas',
          route: '/food/recipes/${recipe.slug}${recipe.servings == null ? '' : '?servings=${recipe.servings}'}',
          icon: 'recipe',
        )));
      }
      if (outcome.done) keys.addAll(await _afterForm(action, householdId));
    } catch (e) {
      _append(Notice('No se pudo enviar el formulario: $e'));
    } finally {
      _idle();
      unawaited(_save(summary, keys, fromAction: true));
    }
  }

  /// Forms whose answer leads to something: plan the week, search recipes.
  Future<List<int>> _afterForm(A2uiRendererAction action, String householdId) async {
    final c = action.context;
    final actions = await _actionsFor(householdId);
    String? first(String k) => switch (c[k]) {
          final List l when l.isNotEmpty => '${l.first}',
          final String s when s.isNotEmpty => s,
          _ => null,
        };
    Output? output;
    switch (action.name) {
      case FoodFormAction.armarSemana:
        return [await _planWeek(WeekPlanRequest.fromForm(c), householdId)];
      case FoodFormAction.aclarar:
        final time = first('tiempo');
        final cuisine = first('cocina');
        output = await actions.recipeSearch(
          title: 'Ideas para vos',
          mealType: first('comida'),
          maxMinutes: time == null || time == 'sin_limite' ? null : int.tryParse(time),
          query: cuisine == null || cuisine == 'cualquiera' ? null : cuisine,
        );
      case FoodFormAction.invitados:
        output = await actions.recipeSearch(title: 'Ideas para los invitados');
      default:
        return const [];
    }
    return switch (output) {
      CardOut(:final card) => [_append(card)],
      TextOut(:final text) => [_append(AssistantText(text))],
      _ => const [],
    };
  }

  Future<int> _planWeek(WeekPlanRequest request, String householdId) async {
    final planner = WeekPlanner(
      ref.read(foodRepositoryProvider),
      householdId,
      pick: state.modelStatus == ModelStatus.ready ? _pickRecipe : null,
    );
    final week = await planner.plan(
      request,
      onProgress: (day) => state = state.copyWith(status: () => 'Armando el $day…'),
    );
    refreshFood(ref.invalidate, const {FoodData.menu});
    return _append(AssistantActions.menuCard(week));
  }

  /// The model chooses among the ranked options (its answer can only be one
  /// of their ids).
  Future<String?> _pickRecipe({
    required String day,
    required String meal,
    required List<RecipeSummary> options,
    required String notes,
  }) async {
    final list = [
      for (final o in options)
        '- ${o.slug}: ${o.title} (${o.totalMinutes} min${o.why.isEmpty ? '' : '; ${o.why.first}'})',
    ].join('\n');
    final json = await _engine.readJson(
      instructions: 'Elige una comida para el menú de una familia. Devuelve solo JSON {"receta": id}. '
          'Prefiere variedad y lo que les gusta.${notes.isEmpty ? '' : ' Pedido de la familia: $notes.'}',
      message: '${mealLabels[meal] ?? meal} del $day. Opciones:\n$list',
      schema: {
        'type': 'object',
        'properties': {
          'receta': {
            'type': 'string',
            'enum': [for (final o in options) o.slug],
          },
        },
        'required': ['receta'],
        'additionalProperties': false,
      },
      name: 'eleccion',
    );
    return json?['receta'] as String?;
  }

  /// A photo or screenshot of a recipe: read on the phone, then a
  /// pre-filled form to review it.
  Future<void> addRecipePhoto(Uint8List bytes) async {
    if (state.isBusy || state.modelStatus != ModelStatus.ready) return;
    _append(const UserMessage('📷 Foto de una receta', fromAction: true));
    state = state.copyWith(status: () => 'Leyendo la receta…');
    try {
      final json = await _engine.extractRecipeFromImage(bytes);
      _showForm((id) => recipeFormFromExtraction(id, json));
    } catch (e) {
      _append(Notice(switch (e) {
        FormatException(:final message) => message,
        AssistantUnavailableException() => AssistantUnavailableException.message,
        _ => 'No pude leer la imagen.',
      }));
    } finally {
      _idle();
    }
  }

  void _dispose() {
    _forms?.dispose();
    _forms = null;
  }
}

/// Text from the model as the user should see it: no markdown marks (the
/// model is told not to use them, but small models still do).
String cleanModelText(String text) => text
    .replaceAll(RegExp(r'\*\*|__'), '')
    .replaceAllMapped(RegExp(r'(^|\s)\*(\S[^*]*?\S|\S)\*(?=\s|$|[.,;:!?])'), (m) => '${m[1]}${m[2]}')
    .replaceAll(RegExp(r'^#{1,6}\s*', multiLine: true), '')
    .replaceAll(RegExp(r'^\s*[*-]\s+', multiLine: true), '• ')
    .replaceAll('`', '')
    .trim();

/// Old saved replies could carry A2UI blocks written by the model.
String stripOldCards(String reply) => cleanModelText(reply
    .replaceAll(RegExp(r'<a2ui[\s\S]*?</a2ui[^>]*>'), '')
    .replaceAll(RegExp(r'<a2ui[\s\S]*$'), ''));
