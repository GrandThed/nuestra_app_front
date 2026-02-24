import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/features/chat/data/models/chat_message_model.dart';
import 'package:nuestra_app/features/chat/presentation/providers/chat_state.dart';

part 'chat_notifier.g.dart';

@Riverpod(keepAlive: true)
class ChatNotifier extends _$ChatNotifier {
  @override
  ChatState build() {
    return const ChatState();
  }

  Future<void> sendMessage(String text, {List<String> imageUrls = const []}) async {
    final userMessage = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: 'user',
      content: text,
      imageUrls: imageUrls,
      createdAt: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isSending: true,
    );

    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    final response = _generateMockResponse(text, imageUrls);

    state = state.copyWith(
      messages: [...state.messages, response],
      isSending: false,
    );
  }

  void clearHistory() {
    state = const ChatState();
  }

  ChatMessageModel _generateMockResponse(String text, List<String> imageUrls) {
    final lower = text.toLowerCase();
    final now = DateTime.now();
    final id = (now.millisecondsSinceEpoch + 1).toString();

    // Image attached → recipe extraction
    if (imageUrls.isNotEmpty) {
      return ChatMessageModel(
        id: id,
        role: 'assistant',
        content: 'Encontré una receta en la foto. Acá están los detalles:',
        toolCalls: [
          ChatToolCallModel(
            tool: 'create_recipe',
            params: {
              'title': 'Tarta de manzana de la abuela',
              'ingredients': [
                {'name': 'Manzanas', 'quantity': 6, 'unit': 'unidades'},
                {'name': 'Azúcar', 'quantity': 200, 'unit': 'g'},
                {'name': 'Harina', 'quantity': 300, 'unit': 'g'},
              ],
              'instructions': [
                'Pelar y cortar las manzanas',
                'Mezclar con azúcar y canela',
                'Preparar la masa con harina y manteca',
                'Armar la tarta y hornear 40 minutos',
              ],
              'servings': 8,
            },
          ),
        ],
        createdAt: now,
      );
    }

    // Shopping list / wishlist
    if (lower.contains('lista') ||
        lower.contains('compra') ||
        lower.contains('super') ||
        lower.contains('leche')) {
      return ChatMessageModel(
        id: id,
        role: 'assistant',
        content: '¡Listo! Agregué los items a tu lista de compras.',
        toolCalls: [
          ChatToolCallModel(
            tool: 'add_wishlist_items',
            params: {
              'categoryName': 'Comprar ahora',
              'items': [
                {'name': 'Leche'},
                {'name': 'Huevos'},
                {'name': 'Pan'},
              ],
            },
          ),
        ],
        createdAt: now,
      );
    }

    // Expense
    if (lower.contains('gast') || lower.contains('pagu') || lower.contains('ticket')) {
      return ChatMessageModel(
        id: id,
        role: 'assistant',
        content: 'Registré el gasto. Se dividió automáticamente.',
        toolCalls: [
          ChatToolCallModel(
            tool: 'create_expense',
            params: {
              'description': 'Supermercado',
              'amount': 15000,
              'date': now.toIso8601String().substring(0, 10),
              'categoryName': 'Comida',
            },
          ),
        ],
        createdAt: now,
      );
    }

    // Calendar event
    if (lower.contains('evento') ||
        lower.contains('calendario') ||
        lower.contains('cumple') ||
        lower.contains('semana')) {
      return ChatMessageModel(
        id: id,
        role: 'assistant',
        content: 'Te agendé el evento en el calendario.',
        toolCalls: [
          ChatToolCallModel(
            tool: 'create_calendar_event',
            params: {
              'title': 'Cena con los viejos',
              'startDate': now.add(const Duration(days: 3)).toIso8601String(),
              'allDay': false,
            },
          ),
        ],
        createdAt: now,
      );
    }

    // Recipe
    if (lower.contains('receta') || lower.contains('cocin') || lower.contains('suger')) {
      return ChatMessageModel(
        id: id,
        role: 'assistant',
        content: '¿Qué te parece esta receta? Es perfecta para la temporada.',
        toolCalls: [
          ChatToolCallModel(
            tool: 'create_recipe',
            params: {
              'title': 'Guiso de lentejas',
              'ingredients': [
                {'name': 'Lentejas', 'quantity': 500, 'unit': 'g'},
                {'name': 'Cebolla', 'quantity': 2, 'unit': 'unidades'},
                {'name': 'Zanahoria', 'quantity': 2, 'unit': 'unidades'},
                {'name': 'Papa', 'quantity': 3, 'unit': 'unidades'},
              ],
              'instructions': [
                'Remojar las lentejas 2 horas',
                'Rehogar cebolla y zanahoria',
                'Agregar lentejas, papa y caldo',
                'Cocinar a fuego lento 45 minutos',
              ],
              'servings': 4,
            },
          ),
        ],
        createdAt: now,
      );
    }

    // Board / link
    if (lower.contains('tablero') || lower.contains('link') || lower.contains('guard')) {
      return ChatMessageModel(
        id: id,
        role: 'assistant',
        content: 'Guardé el link en tu tablero.',
        toolCalls: [
          ChatToolCallModel(
            tool: 'add_board_link',
            params: {
              'boardName': 'Viajes',
              'url': 'https://example.com/destino',
              'title': 'Destino guardado',
            },
          ),
        ],
        createdAt: now,
      );
    }

    // Default conversational response
    return ChatMessageModel(
      id: id,
      role: 'assistant',
      content:
          '¡Hola! Puedo ayudarte a agregar recetas, crear eventos, '
          'registrar gastos, manejar tu lista de compras y más. '
          '¿Qué necesitás?',
      createdAt: now,
    );
  }
}
