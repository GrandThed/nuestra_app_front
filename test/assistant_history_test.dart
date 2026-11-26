import 'package:flutter_test/flutter_test.dart';
import 'package:nuestra_app/features/assistant/data/a2ui_bridge.dart';
import 'package:nuestra_app/features/assistant/data/assistant_history_repository.dart';
import 'package:nuestra_app/features/assistant/data/assistant_tools.dart';
import 'package:nuestra_app/features/assistant/presentation/assistant_controller.dart';

String _exampleBlock() {
  final instructions = A2uiBridge.compactInstructions;
  return instructions.substring(instructions.lastIndexOf('<a2ui-json>'));
}

StoredMessage _user(String text) => StoredMessage(role: 'user', content: text);
StoredMessage _reply(String text) =>
    StoredMessage(role: 'assistant', content: text, metadata: const {'kind': 'reply'});

void main() {
  test('conversation ids are accepted by the backend format', () {
    final id = AssistantHistoryRepository.newConversationId();
    expect(RegExp(r'^[A-Za-z0-9-]{8,64}$').hasMatch(id), isTrue);
    expect(id, isNot(AssistantHistoryRepository.newConversationId()));
  });

  test('an expense proposal survives the JSON round trip', () {
    final proposal = ExpenseProposal(
      description: 'Nafta',
      amount: 15000.5,
      date: DateTime(2026, 11, 26),
      categoryId: 'cat-1',
      categoryName: 'Transporte',
    );
    final back = ExpenseProposal.tryFromJson(proposal.toJson())!;
    expect(back.description, 'Nafta');
    expect(back.amount, 15000.5);
    expect(back.date, DateTime(2026, 11, 26));
    expect(back.categoryName, 'Transporte');
    expect(ExpenseProposal.tryFromJson({'description': 'x'}), isNull);
  });

  test('replay keeps the latest turns within budget and drops cards', () {
    final messages = [
      _user('primera pregunta'),
      _reply('primera respuesta'),
      _user('¿Cuánto gastamos?'),
      _reply('Gastaron \$ 158.600 ${_exampleBlock()}'),
    ];
    final replay = replayFromHistory(messages, budgetChars: 60);
    expect(replay.map((m) => m.text), ['¿Cuánto gastamos?', 'Gastaron \$ 158.600']);
    expect(replay.first.isUser, isTrue);
    expect(replay.last.isUser, isFalse);
  });

  test('replay uses what the model saw for card taps and summarizes proposals', () {
    final messages = [
      const StoredMessage(
        role: 'user',
        content: 'listar gastos',
        metadata: {'fromAction': true, 'modelText': '[El usuario tocó "listar_gastos"]'},
      ),
      StoredMessage(role: 'assistant', content: '', metadata: {
        'kind': 'proposal',
        'status': 'saved',
        'proposal': ExpenseProposal(
          description: 'Nafta',
          amount: 15000,
          date: DateTime(2026, 11, 26),
        ).toJson(),
      }),
    ];
    final replay = replayFromHistory(messages, budgetChars: 1000);
    expect(replay.first.text, '[El usuario tocó "listar_gastos"]');
    expect(replay.last.text, contains('Nafta'));
    expect(replay.last.text, contains('saved'));
  });

  test('replay never starts with an assistant turn', () {
    final replay = replayFromHistory(
      [_user('una pregunta larga que no entra'), _reply('respuesta')],
      budgetChars: 15,
    );
    expect(replay, isEmpty);
  });

  test('a stored reply re-renders its card', () {
    final bridge = A2uiBridge(onAction: (_) {});
    final parts = bridge.parseReply(_reply('Este mes: ${_exampleBlock()}').content);
    expect(parts.whereType<ReplySurface>(), hasLength(1));
    bridge.dispose();
  });

  test('stored messages keep their author (shared household chat)', () {
    final m = StoredMessage.fromJson({
      'id': 'm1',
      'role': 'user',
      'content': 'Anotá 15000 de nafta',
      'metadata': null,
      'author': {'id': 'u-beto', 'name': 'Beto', 'avatarUrl': null},
    });
    expect(m.author?.id, 'u-beto');
    expect(m.author?.name, 'Beto');
  });

  test('conversation summaries parse from the backend list', () {
    final c = ConversationSummary.fromJson({
      'id': 'abc12345',
      'title': 'Gastos fijos de diciembre',
      'startedBy': {'id': 'u-beto', 'name': 'Beto'},
      'messageCount': 4,
      'startedAt': '2026-11-26T19:00:00.000Z',
      'lastMessageAt': '2026-11-26T20:00:00.000Z',
    });
    expect(c.title, 'Gastos fijos de diciembre');
    expect(c.startedBy?.name, 'Beto');
    expect(c.messageCount, 4);
    expect(c.lastMessageAt?.isUtc, isFalse);
  });
}
