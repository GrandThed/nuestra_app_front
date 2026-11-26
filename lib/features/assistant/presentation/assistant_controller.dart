import 'dart:async';
import 'dart:convert';

import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_edge_ai/flutter_edge_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:nuestra_app/features/assistant/data/a2ui_bridge.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/assistant/data/assistant_engine.dart';
import 'package:nuestra_app/features/assistant/data/assistant_history_repository.dart';
import 'package:nuestra_app/features/assistant/data/assistant_tools.dart';
import 'package:nuestra_app/features/expenses/data/repositories/expense_repository.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';

// ==================== STATE ====================

/// Where the on-device model is.
enum ModelStatus {
  /// Web or desktop: the model only runs on Android/iOS.
  unsupported,
  checking,
  notInstalled,
  downloading,
  ready,
  failed,
}

/// One entry in the conversation.
sealed class AssistantItem {
  const AssistantItem();
}

class UserItem extends AssistantItem {
  final String text;

  /// True when it came from tapping a button on a card, not from typing.
  final bool fromAction;

  /// Name of the household member who wrote it; null when it was you.
  final String? authorName;

  const UserItem(this.text, {this.fromAction = false, this.authorName});

  bool get isMine => authorName == null;
}

class AssistantTextItem extends AssistantItem {
  final String text;
  const AssistantTextItem(this.text);
}

class SurfaceItem extends AssistantItem {
  final SurfaceModel<ComponentImplementation> surface;
  const SurfaceItem(this.surface);
}

enum ProposalStatus { pending, saving, saved, cancelled, failed }

/// An expense the model proposed; saved only after the user confirms.
class ProposalItem extends AssistantItem {
  final int id;
  final ExpenseProposal proposal;
  final ProposalStatus status;

  /// Id of the stored history message, once saved in the backend.
  final String? messageId;

  const ProposalItem(this.id, this.proposal, this.status, {this.messageId});

  ProposalItem withStatus(ProposalStatus s) =>
      ProposalItem(id, proposal, s, messageId: messageId);

  ProposalItem withMessageId(String? m) =>
      ProposalItem(id, proposal, status, messageId: m);
}

/// A note from the app (errors, context resets). Not saved in history.
class NoticeItem extends AssistantItem {
  final String text;
  const NoticeItem(this.text);
}

class AssistantState {
  final ModelStatus modelStatus;
  final int downloadPercent;
  final String? error;
  final List<AssistantItem> items;

  /// The saved conversation is being loaded from the backend.
  final bool loadingHistory;

  /// The conversation open on this phone.
  final String? conversationId;

  /// The household's conversations (most recent activity first), as of the
  /// last refresh.
  final List<ConversationSummary> conversations;

  /// Reply text streaming in (UI blocks hidden), null when idle.
  final String? streamingText;

  /// What the assistant is doing right now ("Revisando tus gastos…").
  final String? busyLabel;

  const AssistantState({
    this.modelStatus = ModelStatus.checking,
    this.downloadPercent = 0,
    this.error,
    this.items = const [],
    this.loadingHistory = false,
    this.conversationId,
    this.conversations = const [],
    this.streamingText,
    this.busyLabel,
  });

  bool get isBusy => busyLabel != null;

  AssistantState copyWith({
    ModelStatus? modelStatus,
    int? downloadPercent,
    String? Function()? error,
    List<AssistantItem>? items,
    bool? loadingHistory,
    String? conversationId,
    List<ConversationSummary>? conversations,
    String? Function()? streamingText,
    String? Function()? busyLabel,
  }) {
    return AssistantState(
      modelStatus: modelStatus ?? this.modelStatus,
      downloadPercent: downloadPercent ?? this.downloadPercent,
      error: error != null ? error() : this.error,
      items: items ?? this.items,
      loadingHistory: loadingHistory ?? this.loadingHistory,
      conversationId: conversationId ?? this.conversationId,
      conversations: conversations ?? this.conversations,
      streamingText: streamingText != null ? streamingText() : this.streamingText,
      busyLabel: busyLabel != null ? busyLabel() : this.busyLabel,
    );
  }
}

// ==================== CONTROLLER ====================

final assistantProvider =
    NotifierProvider<AssistantController, AssistantState>(AssistantController.new);

/// Runs the on-device assistant conversation and keeps its history in the
/// backend (private to the user).
class AssistantController extends Notifier<AssistantState> {
  final _engine = AssistantEngine.instance;
  A2uiBridge? _bridge;
  InferenceChat? _chat;
  CancelToken? _downloadCancel;
  int _proposalCounter = 0;

  String _conversationId = AssistantHistoryRepository.newConversationId();

  /// Previous turns to feed the model when the chat is first opened after
  /// loading a saved conversation, so it remembers what was said.
  List<Message> _replay = const [];

  /// Rough size of the conversation in characters, to reset the context
  /// before it overflows the model's window (~4k tokens ≈ 16k chars).
  int _contextChars = 0;
  static const _contextBudgetChars = 11000;

  /// How much of a saved conversation is replayed into a new chat.
  static const _replayBudgetChars = 3000;

  static const _toolLabels = {
    'resumen_del_mes': 'Calculando el resumen…',
    'listar_gastos': 'Revisando tus gastos…',
    'gastos_fijos_sugeridos': 'Buscando gastos fijos…',
    'proponer_gasto': 'Preparando el gasto…',
  };

  AssistantHistoryRepository get _history =>
      ref.read(assistantHistoryRepositoryProvider);

  @override
  AssistantState build() {
    ref.onDispose(_disposeConversation);
    if (!_engine.isSupportedPlatform) {
      return const AssistantState(modelStatus: ModelStatus.unsupported);
    }
    Future.microtask(_checkInstalled);
    Future.microtask(_loadHistory);
    return const AssistantState(loadingHistory: true);
  }

  A2uiBridge get _ui => _bridge ??= A2uiBridge(onAction: _onSurfaceAction);

  Future<void> _checkInstalled() async {
    try {
      final installed = await _engine.isInstalled();
      state = state.copyWith(
        modelStatus: installed ? ModelStatus.ready : ModelStatus.notInstalled,
      );
    } catch (e) {
      state = state.copyWith(
        modelStatus: ModelStatus.failed,
        error: () => 'No se pudo iniciar el asistente: $e',
      );
    }
  }

  // ---------- History ----------

  String? get _myUserId {
    final auth = ref.read(authProvider);
    return auth is AuthStateAuthenticated ? auth.user.id : null;
  }

  /// On startup, reopen the conversation this phone had open (or the
  /// household's latest the first time). Another member starting a new chat
  /// does not change it: theirs only shows first in the conversation list.
  Future<void> _loadHistory() async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      state = state.copyWith(loadingHistory: false);
      return;
    }
    final current = await _history.readCurrentConversationId(householdId);
    await _openConversation(householdId, conversationId: current);
    unawaited(refreshConversations());
  }

  /// Load a conversation into the screen and prepare its replay. With no
  /// [conversationId], loads the household's latest one; if there is none,
  /// starts an empty conversation.
  Future<void> _openConversation(
    String householdId, {
    String? conversationId,
  }) async {
    state = state.copyWith(loadingHistory: true);
    try {
      final saved = await _history.loadConversation(
        householdId,
        conversationId: conversationId,
      );
      // A remembered id with no messages yet is still this phone's chat
      _conversationId = saved.conversationId ??
          conversationId ??
          AssistantHistoryRepository.newConversationId();
      final items = <AssistantItem>[];
      for (final m in saved.messages) {
        items.addAll(_itemsFromStored(m));
      }
      _replay =
          replayFromHistory(saved.messages, budgetChars: _replayBudgetChars);
      state = state.copyWith(
        items: items,
        conversationId: _conversationId,
        loadingHistory: false,
      );
    } catch (e) {
      debugPrint('Could not load assistant history: $e');
      _conversationId = conversationId ?? _conversationId;
      state = state.copyWith(
        conversationId: _conversationId,
        loadingHistory: false,
      );
    }
    await _history.saveCurrentConversationId(householdId, _conversationId);
  }

  /// Reload the household's conversation list (e.g. when opening it).
  Future<void> refreshConversations() async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return;
    try {
      final list = await _history.listConversations(householdId);
      state = state.copyWith(conversations: list);
    } catch (e) {
      debugPrint('Could not load conversation list: $e');
    }
  }

  /// Open another conversation of the household (from the list).
  Future<void> switchConversation(String conversationId) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null || state.isBusy) return;
    await _disposeConversation();
    await _openConversation(householdId, conversationId: conversationId);
  }

  List<AssistantItem> _itemsFromStored(StoredMessage m) {
    if (m.role == 'user') {
      final author = m.author;
      final mine = author == null || author.id == _myUserId;
      return [
        UserItem(
          m.content,
          fromAction: m.metadata?['fromAction'] == true,
          authorName: mine ? null : author.name,
        ),
      ];
    }
    if (m.kind == 'proposal') {
      final proposal = ExpenseProposal.tryFromJson(m.metadata?['proposal']);
      if (proposal == null) return const [];
      final status = ProposalStatus.values
              .where((s) => s.name == m.metadata?['status'])
              .firstOrNull ??
          ProposalStatus.pending;
      return [
        ProposalItem(
          ++_proposalCounter,
          proposal,
          // A save interrupted by closing the app is still unconfirmed
          status == ProposalStatus.saving ? ProposalStatus.pending : status,
          messageId: m.id,
        ),
      ];
    }
    return [
      for (final part in _ui.parseReply(m.content))
        switch (part) {
          ReplyText(:final text) => AssistantTextItem(text),
          ReplySurface(:final surface) => SurfaceItem(surface),
        },
    ];
  }

  /// Save a finished turn; proposals get their stored ids back.
  Future<void> _saveTurn(
    StoredMessage userMessage,
    List<int> proposalIds,
    String reply,
  ) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return;

    final proposals = [
      for (final id in proposalIds)
        if (_proposal(id) case final p?) p,
    ];
    try {
      final saved = await _history.append(
        householdId: householdId,
        conversationId: _conversationId,
        messages: [
          userMessage,
          for (final p in proposals)
            StoredMessage(
              role: 'assistant',
              content: '',
              metadata: _proposalMetadata(p),
            ),
          StoredMessage(
            role: 'assistant',
            content: reply,
            metadata: const {'kind': 'reply'},
          ),
        ],
      );
      for (var i = 0; i < proposals.length && i + 1 < saved.length; i++) {
        final current = _proposal(proposals[i].id);
        if (current == null) continue;
        _replaceProposal(current.withMessageId(saved[i + 1].id));
        // Confirmed or discarded while the turn was being saved
        if (current.status != proposals[i].status) {
          unawaited(_saveProposalStatus(current.withMessageId(saved[i + 1].id)));
        }
      }
      // The list shows this conversation first now
      unawaited(refreshConversations());
    } catch (e) {
      debugPrint('Could not save assistant turn: $e');
    }
  }

  Map<String, dynamic> _proposalMetadata(ProposalItem p) => {
        'kind': 'proposal',
        'status': p.status == ProposalStatus.saving
            ? ProposalStatus.pending.name
            : p.status.name,
        'proposal': p.proposal.toJson(),
      };

  Future<void> _saveProposalStatus(ProposalItem p) async {
    final messageId = p.messageId;
    if (messageId == null) return;
    try {
      await _history.updateMetadata(messageId, _proposalMetadata(p));
    } catch (e) {
      debugPrint('Could not save proposal status: $e');
    }
  }

  // ---------- Model download ----------

  Future<void> downloadModel() async {
    if (state.modelStatus == ModelStatus.downloading) return;
    _downloadCancel = CancelToken();
    state = state.copyWith(
      modelStatus: ModelStatus.downloading,
      downloadPercent: 0,
      error: () => null,
    );
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
        error: () => 'La descarga falló: $e',
      );
    } finally {
      _downloadCancel = null;
    }
  }

  void cancelDownload() => _downloadCancel?.cancel('cancelado por el usuario');

  Future<void> deleteModel() async {
    await _closeChat();
    await _engine.uninstall();
    // The conversation history stays in the backend
    state = state.copyWith(modelStatus: ModelStatus.notInstalled);
  }

  // ---------- Conversation ----------

  /// Start a new conversation on this phone. The previous one stays in the
  /// household's list; nobody else's screen changes.
  Future<void> newConversation() async {
    if (state.isBusy) return;
    await _disposeConversation();
    _conversationId = AssistantHistoryRepository.newConversationId();
    _replay = const [];
    state = state.copyWith(
      items: const [],
      conversationId: _conversationId,
      streamingText: () => null,
      busyLabel: () => null,
    );
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId != null) {
      await _history.saveCurrentConversationId(householdId, _conversationId);
    }
  }

  Future<void> send(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || state.isBusy) return;
    _append(UserItem(trimmed));
    await _runTurn(trimmed, StoredMessage(role: 'user', content: trimmed));
  }

  /// A button on a card was tapped: tell the model, like a user message.
  void _onSurfaceAction(A2uiRendererAction action) {
    if (state.isBusy) return;
    final label = action.userMessage ?? action.name.replaceAll('_', ' ');
    final context = action.context.isEmpty ? '' : ' ${jsonEncode(action.context)}';
    final modelText = '[El usuario tocó "${action.name}" en la tarjeta$context]';
    _append(UserItem(label, fromAction: true));
    unawaited(_runTurn(
      modelText,
      StoredMessage(
        role: 'user',
        content: label,
        metadata: {'fromAction': true, 'modelText': modelText},
      ),
    ));
  }

  Future<void> _runTurn(String message, StoredMessage userMessage) async {
    if (state.modelStatus != ModelStatus.ready) return;
    state = state.copyWith(
      busyLabel: () => 'Pensando…',
      streamingText: () => '',
    );

    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      _finishWithNotice('No hay un hogar seleccionado.');
      return;
    }
    final tools = AssistantToolExecutor(
      ref.read(expenseRepositoryProvider),
      householdId,
    );
    final proposalIds = <int>[];

    try {
      if (_contextChars + message.length > _contextBudgetChars && _chat != null) {
        await _closeChat();
        _append(const NoticeItem(
          'La conversación era larga: el asistente empezó de nuevo y no '
          'recuerda los mensajes anteriores.',
        ));
      }
      final chat = _chat ??= await _openChat(householdId);
      _contextChars += message.length;

      await chat.addQueryChunk(Message.text(text: message, isUser: true));

      final reply = StringBuffer();
      await for (final response in chat.generateChatResponseWithTools(
        maxToolTurns: 4,
        onToolCall: (call) async {
          // Text streamed before a tool call is not part of the answer
          reply.clear();
          state = state.copyWith(
            busyLabel: () => _toolLabels[call.name] ?? 'Trabajando…',
            streamingText: () => '',
          );
          final outcome = await tools.run(call.name, call.args);
          if (outcome.proposal != null) {
            final id = ++_proposalCounter;
            proposalIds.add(id);
            _append(ProposalItem(id, outcome.proposal!, ProposalStatus.pending));
          }
          _contextChars += jsonEncode(outcome.response).length;
          state = state.copyWith(busyLabel: () => 'Escribiendo…');
          return outcome.response;
        },
        onMaxToolTurns: () => debugPrint('Assistant hit the tool-turn limit'),
      )) {
        if (response is TextResponse) {
          reply.write(response.token);
          state = state.copyWith(
            streamingText: () => A2uiBridge.visibleWhileStreaming('$reply'),
          );
        }
      }

      final full = '$reply';
      _contextChars += full.length;
      final parts = _ui.parseReply(full);
      final newItems = <AssistantItem>[
        for (final part in parts)
          switch (part) {
            ReplyText(:final text) => AssistantTextItem(text),
            ReplySurface(:final surface) => SurfaceItem(surface),
          },
      ];
      if (newItems.isEmpty) {
        newItems.add(const AssistantTextItem('No tengo una respuesta para eso.'));
      }
      state = state.copyWith(
        items: [...state.items, ...newItems],
        streamingText: () => null,
        busyLabel: () => null,
      );
      unawaited(_saveTurn(userMessage, proposalIds, full));
    } catch (e) {
      debugPrint('Assistant turn failed: $e');
      // A failed turn can leave the model mid-conversation: start clean
      await _closeChat();
      _finishWithNotice('Algo salió mal con el asistente. Probá de nuevo.');
    }
  }

  void stop() => _chat?.stopGeneration();

  Future<InferenceChat> _openChat(String householdId) async {
    final categories = await ref
        .read(expenseRepositoryProvider)
        .getCategories(householdId)
        .catchError((_) => <Never>[]);
    final prompt = buildSystemPrompt(
      now: DateTime.now(),
      categoryNames: [for (final c in categories) c.name],
    );
    _contextChars = prompt.length;
    final chat = await _engine.openChat(systemInstruction: prompt);

    // First chat after restoring a saved conversation: remind the model
    if (_replay.isNotEmpty) {
      final replay = _replay;
      _replay = const [];
      try {
        await chat.clearHistory(replayHistory: replay);
        _contextChars += replay.fold(0, (sum, m) => sum + m.text.length);
      } catch (e) {
        // The chat restarts empty: the screen still shows the history
        debugPrint('Could not replay saved conversation: $e');
      }
    }
    return chat;
  }

  // ---------- Expense proposals ----------

  Future<void> confirmProposal(int id) async {
    final item = _proposal(id);
    if (item == null || item.status != ProposalStatus.pending) return;
    _replaceProposal(item.withStatus(ProposalStatus.saving));

    final p = item.proposal;
    final saved = await ref.read(expensesProvider.notifier).createExpense(
          description: p.description,
          amount: p.amount,
          date: p.date,
          categoryId: p.categoryId,
        );
    final updated = (_proposal(id) ?? item).withStatus(
      saved != null ? ProposalStatus.saved : ProposalStatus.failed,
    );
    _replaceProposal(updated);
    if (updated.status == ProposalStatus.saved) {
      unawaited(_saveProposalStatus(updated));
    }
  }

  void cancelProposal(int id) {
    final item = _proposal(id);
    if (item == null || item.status != ProposalStatus.pending) return;
    final updated = item.withStatus(ProposalStatus.cancelled);
    _replaceProposal(updated);
    unawaited(_saveProposalStatus(updated));
  }

  ProposalItem? _proposal(int id) =>
      state.items.whereType<ProposalItem>().where((p) => p.id == id).firstOrNull;

  void _replaceProposal(ProposalItem updated) {
    state = state.copyWith(items: [
      for (final i in state.items)
        if (i is ProposalItem && i.id == updated.id) updated else i,
    ]);
  }

  // ---------- Helpers ----------

  void _append(AssistantItem item) =>
      state = state.copyWith(items: [...state.items, item]);

  void _finishWithNotice(String text) {
    state = state.copyWith(
      items: [...state.items, NoticeItem(text)],
      streamingText: () => null,
      busyLabel: () => null,
    );
  }

  Future<void> _closeChat() async {
    final chat = _chat;
    _chat = null;
    _contextChars = 0;
    try {
      await chat?.close();
    } catch (e) {
      debugPrint('Error closing assistant chat: $e');
    }
  }

  Future<void> _disposeConversation() async {
    await _closeChat();
    _bridge?.dispose();
    _bridge = null;
  }
}

/// The most recent turns of a saved conversation, as model messages, within
/// [budgetChars]. Cards are dropped (only their surrounding text is kept) and
/// proposals are summarized, so the replay stays small.
List<Message> replayFromHistory(
  List<StoredMessage> messages, {
  required int budgetChars,
}) {
  final replay = <Message>[];
  var used = 0;
  for (final m in messages.reversed) {
    final String text;
    final bool isUser = m.role == 'user';
    if (isUser) {
      text = (m.metadata?['modelText'] as String?) ?? m.content;
    } else if (m.kind == 'proposal') {
      final p = ExpenseProposal.tryFromJson(m.metadata?['proposal']);
      if (p == null) continue;
      text = '[Propuse el gasto "${p.description}" por ${p.amount} '
          '(${m.metadata?['status'] ?? 'pending'})]';
    } else {
      text = A2uiBridge.stripUiBlocks(m.content);
    }
    if (text.isEmpty) continue;
    if (used + text.length > budgetChars) break;
    used += text.length;
    replay.add(Message.text(text: text, isUser: isUser));
  }
  // Start on a user turn so the model sees a well-formed conversation
  final ordered = replay.reversed.toList();
  while (ordered.isNotEmpty && !ordered.first.isUser) {
    ordered.removeAt(0);
  }
  return ordered;
}

/// System prompt for the on-device model (Spanish, rioplatense).
String buildSystemPrompt({
  required DateTime now,
  required List<String> categoryNames,
}) {
  final today = DateFormat("EEEE d 'de' MMMM 'de' y", 'es').format(now);
  final month = DateFormat('yyyy-MM').format(now);
  final categories =
      categoryNames.isEmpty ? 'ninguna todavía' : categoryNames.join(', ');
  return '''
Sos el asistente de gastos del hogar en "Nuestra App". Hablás en español rioplatense, breve y claro.
Hoy es $today (mes actual: $month). Moneda: pesos argentinos.
Categorías del hogar: $categories.

REGLAS
- Para cualquier dato de gastos, presupuestos o gastos fijos usá las herramientas. Nunca inventes montos ni fechas.
- Los meses se pasan como YYYY-MM.
- Para registrar un gasto usá proponer_gasto. No queda guardado hasta que el usuario lo confirma en la tarjeta: decíselo.
- Si falta un dato (monto o descripción), preguntalo antes de proponer.
- Escribí los montos con formato argentino, por ejemplo \$ 15.000 o \$ 1.029,50.
- Si te preguntan algo que no es sobre los gastos del hogar, respondé que por ahora solo ayudás con gastos.

${A2uiBridge.compactInstructions}
''';
}
