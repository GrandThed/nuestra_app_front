import 'package:a2ui_core/a2ui_core.dart';
import 'package:a2ui_flutter/a2ui_flutter.dart';

/// One entry in the conversation. Cards keep a snapshot of their data so a
/// saved conversation looks the same when it is opened again.
sealed class ChatItem {
  const ChatItem();
}

class UserMessage extends ChatItem {
  final String text;

  /// Name of the household member who wrote it; null when it was you.
  final String? authorName;

  /// From a form or a button, not typed.
  final bool fromAction;

  const UserMessage(this.text, {this.authorName, this.fromAction = false});
}

/// Text written by the model (only for open questions and small talk).
class AssistantText extends ChatItem {
  final String text;
  const AssistantText(this.text);
}

/// A short line from the app ("No encontré…", errors). Not saved.
class Notice extends ChatItem {
  final String text;
  const Notice(this.text);
}

/// A form built by the app (food forms). Not saved: what the user answers is.
class FormCard extends ChatItem {
  final SurfaceModel<ComponentImplementation> surface;
  const FormCard(this.surface);
}

/// A card with data. Saved in the conversation as `{type, ...}`.
sealed class DataCard extends ChatItem {
  /// Id of the stored message, once saved (to update its status).
  final String? messageId;
  const DataCard({this.messageId});

  String get type;
  Map<String, dynamic> toJson();

  /// One line for the conversation list and for the model's memory.
  String get summary;

  DataCard withMessageId(String id);

  static DataCard? fromJson(Map<String, dynamic> json, {String? messageId}) {
    try {
      return switch (json['type']) {
        'expense_draft' => ExpenseDraftCard.fromJson(json, messageId: messageId),
        'spending' => SpendingCard.fromJson(json, messageId: messageId),
        'month_summary' => MonthSummaryCard.fromJson(json, messageId: messageId),
        'fixed_expenses' => FixedExpensesCard.fromJson(json, messageId: messageId),
        'recipes' => RecipesCard.fromJson(json, messageId: messageId),
        'menu' => MenuCard.fromJson(json, messageId: messageId),
        'preference' => PreferenceCard.fromJson(json, messageId: messageId),
        'link' => LinkCard.fromJson(json, messageId: messageId),
        _ => null,
      };
    } catch (_) {
      return null;
    }
  }
}

double _num(Object? v) => v is num ? v.toDouble() : double.tryParse('$v') ?? 0;
List<Map<String, dynamic>> _maps(Object? v) =>
    [for (final e in v as List? ?? const []) (e as Map).cast<String, dynamic>()];

// ---------- Expenses ----------

enum DraftStatus { pending, saving, saved, discarded, failed }

/// An expense read from a message, shown to check and save. Nothing is saved
/// until the user taps Guardar (or says "sí").
class ExpenseDraftCard extends DataCard {
  final String description;

  /// Null when the message had no amount: the card asks for it.
  final double? amount;
  final DateTime date;
  final String? categoryId;
  final String? categoryName;
  final DraftStatus status;

  /// Set when it was saved.
  final String? expenseId;

  const ExpenseDraftCard({
    required this.description,
    required this.amount,
    required this.date,
    this.categoryId,
    this.categoryName,
    this.status = DraftStatus.pending,
    this.expenseId,
    super.messageId,
  });

  bool get isOpen => status == DraftStatus.pending || status == DraftStatus.failed;

  @override
  String get type => 'expense_draft';

  ExpenseDraftCard copyWith({
    String? description,
    double? Function()? amount,
    DateTime? date,
    String? Function()? categoryId,
    String? Function()? categoryName,
    DraftStatus? status,
    String? expenseId,
    String? messageId,
  }) =>
      ExpenseDraftCard(
        description: description ?? this.description,
        amount: amount != null ? amount() : this.amount,
        date: date ?? this.date,
        categoryId: categoryId != null ? categoryId() : this.categoryId,
        categoryName: categoryName != null ? categoryName() : this.categoryName,
        status: status ?? this.status,
        expenseId: expenseId ?? this.expenseId,
        messageId: messageId ?? this.messageId,
      );

  @override
  ExpenseDraftCard withMessageId(String id) => copyWith(messageId: id);

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'description': description,
        'amount': amount,
        'date': DateTime(date.year, date.month, date.day).toIso8601String(),
        'categoryId': categoryId,
        'categoryName': categoryName,
        // "saving" interrupted by closing the app is still unconfirmed
        'status': status == DraftStatus.saving ? DraftStatus.pending.name : status.name,
        'expenseId': expenseId,
      };

  factory ExpenseDraftCard.fromJson(Map<String, dynamic> j, {String? messageId}) => ExpenseDraftCard(
        description: '${j['description'] ?? ''}',
        amount: j['amount'] == null ? null : _num(j['amount']),
        date: DateTime.tryParse('${j['date']}') ?? DateTime.now(),
        categoryId: j['categoryId'] as String?,
        categoryName: j['categoryName'] as String?,
        status: DraftStatus.values.where((s) => s.name == j['status']).firstOrNull ?? DraftStatus.pending,
        expenseId: j['expenseId'] as String?,
        messageId: messageId,
      );

  @override
  String get summary => switch (status) {
        DraftStatus.saved => 'Gasto guardado: $description',
        DraftStatus.discarded => 'Gasto descartado: $description',
        _ => 'Gasto para revisar: $description',
      };
}

class ExpenseRow {
  final DateTime date;
  final String description;
  final double amount;
  final String who;
  final String? category;
  const ExpenseRow(this.date, this.description, this.amount, this.who, this.category);

  Map<String, dynamic> toJson() => {
        'date': date.toIso8601String(),
        'description': description,
        'amount': amount,
        'who': who,
        'category': category,
      };

  factory ExpenseRow.fromJson(Map<String, dynamic> j) => ExpenseRow(
        DateTime.tryParse('${j['date']}') ?? DateTime.now(),
        '${j['description'] ?? ''}',
        _num(j['amount']),
        '${j['who'] ?? ''}',
        j['category'] as String?,
      );
}

/// What was spent on something in a month ("Nafta · noviembre").
class SpendingCard extends DataCard {
  final String title;
  final int year;
  final int month;
  final double total;
  final int count;

  /// The most recent ones (the card shows a few).
  final List<ExpenseRow> rows;

  const SpendingCard({
    required this.title,
    required this.year,
    required this.month,
    required this.total,
    required this.count,
    required this.rows,
    super.messageId,
  });

  @override
  String get type => 'spending';

  @override
  SpendingCard withMessageId(String id) =>
      SpendingCard(title: title, year: year, month: month, total: total, count: count, rows: rows, messageId: id);

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'title': title,
        'year': year,
        'month': month,
        'total': total,
        'count': count,
        'rows': [for (final r in rows) r.toJson()],
      };

  factory SpendingCard.fromJson(Map<String, dynamic> j, {String? messageId}) => SpendingCard(
        title: '${j['title']}',
        year: (j['year'] as num).toInt(),
        month: (j['month'] as num).toInt(),
        total: _num(j['total']),
        count: (j['count'] as num).toInt(),
        rows: [for (final r in _maps(j['rows'])) ExpenseRow.fromJson(r)],
        messageId: messageId,
      );

  @override
  String get summary => '$title: $count gastos, total $total';
}

class Slice {
  final String name;
  final double amount;
  final String? icon;
  const Slice(this.name, this.amount, {this.icon});

  Map<String, dynamic> toJson() => {'name': name, 'amount': amount, 'icon': icon};
  factory Slice.fromJson(Map<String, dynamic> j) => Slice('${j['name']}', _num(j['amount']), icon: j['icon'] as String?);
}

/// The month's total, by category and by who paid.
class MonthSummaryCard extends DataCard {
  final int year;
  final int month;
  final double total;
  final int count;
  final List<Slice> byCategory;
  final List<Slice> byMember;

  const MonthSummaryCard({
    required this.year,
    required this.month,
    required this.total,
    required this.count,
    required this.byCategory,
    required this.byMember,
    super.messageId,
  });

  @override
  String get type => 'month_summary';

  @override
  MonthSummaryCard withMessageId(String id) => MonthSummaryCard(
      year: year, month: month, total: total, count: count, byCategory: byCategory, byMember: byMember, messageId: id);

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'year': year,
        'month': month,
        'total': total,
        'count': count,
        'byCategory': [for (final s in byCategory) s.toJson()],
        'byMember': [for (final s in byMember) s.toJson()],
      };

  factory MonthSummaryCard.fromJson(Map<String, dynamic> j, {String? messageId}) => MonthSummaryCard(
        year: (j['year'] as num).toInt(),
        month: (j['month'] as num).toInt(),
        total: _num(j['total']),
        count: (j['count'] as num).toInt(),
        byCategory: [for (final s in _maps(j['byCategory'])) Slice.fromJson(s)],
        byMember: [for (final s in _maps(j['byMember'])) Slice.fromJson(s)],
        messageId: messageId,
      );

  @override
  String get summary => 'Resumen $month/$year: total $total en $count gastos';
}

class FixedExpense {
  final String description;
  final double amount;
  final int day;
  const FixedExpense(this.description, this.amount, this.day);

  Map<String, dynamic> toJson() => {'description': description, 'amount': amount, 'day': day};
  factory FixedExpense.fromJson(Map<String, dynamic> j) =>
      FixedExpense('${j['description']}', _num(j['amount']), (j['day'] as num?)?.toInt() ?? 1);
}

/// Fixed expenses of past months not loaded yet this month.
class FixedExpensesCard extends DataCard {
  final int year;
  final int month;
  final List<FixedExpense> items;

  const FixedExpensesCard({required this.year, required this.month, required this.items, super.messageId});

  @override
  String get type => 'fixed_expenses';

  @override
  FixedExpensesCard withMessageId(String id) =>
      FixedExpensesCard(year: year, month: month, items: items, messageId: id);

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'year': year,
        'month': month,
        'items': [for (final i in items) i.toJson()],
      };

  factory FixedExpensesCard.fromJson(Map<String, dynamic> j, {String? messageId}) => FixedExpensesCard(
        year: (j['year'] as num).toInt(),
        month: (j['month'] as num).toInt(),
        items: [for (final i in _maps(j['items'])) FixedExpense.fromJson(i)],
        messageId: messageId,
      );

  @override
  String get summary => '${items.length} gastos fijos sin cargar';
}

// ---------- Food ----------

class RecipeRow {
  final String slug;
  final String title;
  final int minutes;
  final String note;
  const RecipeRow(this.slug, this.title, this.minutes, this.note);

  Map<String, dynamic> toJson() => {'slug': slug, 'title': title, 'minutes': minutes, 'note': note};
  factory RecipeRow.fromJson(Map<String, dynamic> j) =>
      RecipeRow('${j['slug']}', '${j['title']}', (j['minutes'] as num?)?.toInt() ?? 0, '${j['note'] ?? ''}');
}

class RecipesCard extends DataCard {
  final String title;
  final List<RecipeRow> recipes;

  /// How many were left out because of the household's preferences.
  final int excluded;

  const RecipesCard({required this.title, required this.recipes, this.excluded = 0, super.messageId});

  @override
  String get type => 'recipes';

  @override
  RecipesCard withMessageId(String id) =>
      RecipesCard(title: title, recipes: recipes, excluded: excluded, messageId: id);

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'title': title,
        'recipes': [for (final r in recipes) r.toJson()],
        'excluded': excluded,
      };

  factory RecipesCard.fromJson(Map<String, dynamic> j, {String? messageId}) => RecipesCard(
        title: '${j['title']}',
        recipes: [for (final r in _maps(j['recipes'])) RecipeRow.fromJson(r)],
        excluded: (j['excluded'] as num?)?.toInt() ?? 0,
        messageId: messageId,
      );

  @override
  String get summary => '$title: ${recipes.map((r) => r.title).join(', ')}';
}

class MenuSlot {
  final String date;
  final String meal;
  final String title;
  final String? slug;
  const MenuSlot(this.date, this.meal, this.title, this.slug);

  Map<String, dynamic> toJson() => {'date': date, 'meal': meal, 'title': title, 'slug': slug};
  factory MenuSlot.fromJson(Map<String, dynamic> j) =>
      MenuSlot('${j['date']}', '${j['meal']}', '${j['title']}', j['slug'] as String?);
}

class MenuCard extends DataCard {
  final String weekStart;
  final List<MenuSlot> slots;
  const MenuCard({required this.weekStart, required this.slots, super.messageId});

  @override
  String get type => 'menu';

  @override
  MenuCard withMessageId(String id) => MenuCard(weekStart: weekStart, slots: slots, messageId: id);

  @override
  Map<String, dynamic> toJson() => {
        'type': type,
        'weekStart': weekStart,
        'slots': [for (final s in slots) s.toJson()],
      };

  factory MenuCard.fromJson(Map<String, dynamic> j, {String? messageId}) => MenuCard(
        weekStart: '${j['weekStart']}',
        slots: [for (final s in _maps(j['slots'])) MenuSlot.fromJson(s)],
        messageId: messageId,
      );

  @override
  String get summary => 'Menú de la semana del $weekStart: ${slots.length} comidas';
}

/// A food preference that was saved, with undo.
class PreferenceCard extends DataCard {
  final String label;
  final String? preferenceId;
  final bool undone;
  const PreferenceCard({required this.label, this.preferenceId, this.undone = false, super.messageId});

  @override
  String get type => 'preference';

  @override
  PreferenceCard withMessageId(String id) =>
      PreferenceCard(label: label, preferenceId: preferenceId, undone: undone, messageId: id);

  PreferenceCard asUndone() => PreferenceCard(label: label, preferenceId: preferenceId, undone: true, messageId: messageId);

  @override
  Map<String, dynamic> toJson() => {'type': type, 'label': label, 'preferenceId': preferenceId, 'undone': undone};

  factory PreferenceCard.fromJson(Map<String, dynamic> j, {String? messageId}) => PreferenceCard(
        label: '${j['label']}',
        preferenceId: j['preferenceId'] as String?,
        undone: j['undone'] == true,
        messageId: messageId,
      );

  @override
  String get summary => undone ? 'Preferencia borrada: $label' : 'Preferencia guardada: $label';
}

/// A shortcut to a screen of the app.
class LinkCard extends DataCard {
  final String title;
  final String subtitle;
  final String route;
  final String icon;
  const LinkCard({required this.title, required this.subtitle, required this.route, this.icon = 'open', super.messageId});

  @override
  String get type => 'link';

  @override
  LinkCard withMessageId(String id) =>
      LinkCard(title: title, subtitle: subtitle, route: route, icon: icon, messageId: id);

  @override
  Map<String, dynamic> toJson() => {'type': type, 'title': title, 'subtitle': subtitle, 'route': route, 'icon': icon};

  factory LinkCard.fromJson(Map<String, dynamic> j, {String? messageId}) => LinkCard(
        title: '${j['title']}',
        subtitle: '${j['subtitle'] ?? ''}',
        route: '${j['route']}',
        icon: '${j['icon'] ?? 'open'}',
        messageId: messageId,
      );

  @override
  String get summary => title;
}
