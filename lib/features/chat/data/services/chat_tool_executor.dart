import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/chat/data/models/chat_message_model.dart';

/// Provider for ChatToolExecutor
final chatToolExecutorProvider = Provider<ChatToolExecutor>((ref) {
  return ChatToolExecutor(dioClient: ref.watch(dioClientProvider));
});

/// Executes tool calls from the LLM.
///
/// Query tools: executed silently, results sent back to LLM via /continue.
/// Action tools: executed after final response, results shown to user.
class ChatToolExecutor {
  final DioClient _dioClient;

  ChatToolExecutor({required DioClient dioClient}) : _dioClient = dioClient;

  /// Execute a query tool and return the result data.
  /// [householdId] is injected into query params that need it.
  /// Used during the data gathering loop.
  Future<Map<String, dynamic>> executeQuery(
    ChatToolCallModel request, {
    required String householdId,
  }) async {
    try {
      final params = {...request.params, 'householdId': householdId};
      switch (request.tool) {
        case 'search_recipes':
          return await _searchRecipes(params);
        case 'list_calendar_events':
          return await _listCalendarEvents(params);
        case 'list_wishlist_items':
          return await _listWishlistItems(params);
        case 'list_boards':
          return await _listBoards(params);
        case 'get_expense_summary':
          return await _getExpenseSummary(params);
        default:
          return {'error': 'Unknown query tool: ${request.tool}'};
      }
    } catch (e) {
      return {'error': e.toString()};
    }
  }

  /// Execute an action tool (create, add, etc.)
  /// [householdId] is injected into params that need it.
  /// Returns a user-friendly result message.
  Future<ToolExecutionResult> executeAction(
    ChatToolCallModel toolCall, {
    required String householdId,
  }) async {
    // Inject householdId into params for backend endpoints that require it
    final params = {...toolCall.params, 'householdId': householdId};
    final enrichedToolCall = ChatToolCallModel(
      tool: toolCall.tool,
      params: params,
    );
    try {
      switch (enrichedToolCall.tool) {
        case 'create_recipe':
          return await _createRecipe(params);
        case 'add_wishlist_items':
          return await _addWishlistItems(params);
        case 'create_expense':
          return await _createExpense(params);
        case 'create_calendar_event':
          return await _createCalendarEvent(params);
        case 'add_board_link':
          return await _addBoardLink(params);
        case 'add_menu_item':
          return await _addMenuItem(params);
        case 'generate_shopping_list':
          return await _generateShoppingList(params);
        default:
          return ToolExecutionResult.error(
            'Herramienta no soportada: ${enrichedToolCall.tool}',
          );
      }
    } catch (e) {
      return ToolExecutionResult.error('Error: $e');
    }
  }

  // ==================== Query Tools ====================

  Future<Map<String, dynamic>> _searchRecipes(Map<String, dynamic> params) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.recipes,
      queryParameters: {
        'householdId': params['householdId'],
        if (params['query'] != null) 'search': params['query'],
      },
    );
    return response['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> _listCalendarEvents(Map<String, dynamic> params) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.calendarTimeline,
      queryParameters: {
        'householdId': params['householdId'],
        if (params['startDate'] != null) 'from': params['startDate'],
        if (params['endDate'] != null) 'to': params['endDate'],
      },
    );
    return response['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> _listWishlistItems(Map<String, dynamic> params) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.wishlists,
      queryParameters: {
        'householdId': params['householdId'],
        if (params['categoryName'] != null) 'category': params['categoryName'],
      },
    );
    return response['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> _listBoards(Map<String, dynamic> params) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.boards,
      queryParameters: {
        'householdId': params['householdId'],
        if (params['boardName'] != null) 'search': params['boardName'],
      },
    );
    return response['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> _getExpenseSummary(Map<String, dynamic> params) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.expenseSummary,
      queryParameters: {
        'householdId': params['householdId'],
        if (params['month'] != null) 'month': params['month'],
        if (params['year'] != null) 'year': params['year'],
      },
    );
    return response['data'] as Map<String, dynamic>;
  }

  // ==================== Action Tools ====================

  Future<ToolExecutionResult> _createRecipe(Map<String, dynamic> params) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.recipes,
      data: params,
    );
    final recipe = response['data']?['recipe'] as Map<String, dynamic>?;
    return ToolExecutionResult.success(
      'Receta creada: ${recipe?['title'] ?? params['title']}',
      entityId: recipe?['id'] as String?,
    );
  }

  Future<ToolExecutionResult> _addWishlistItems(Map<String, dynamic> params) async {
    final items = params['items'] as List<dynamic>? ?? [];
    await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.wishlistBulk,
      data: {
        'householdId': params['householdId'],
        'categoryName': params['categoryName'],
        'items': items,
      },
    );
    return ToolExecutionResult.success(
      '${items.length} items agregados a ${params['categoryName']}',
    );
  }

  Future<ToolExecutionResult> _createExpense(Map<String, dynamic> params) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.expenses,
      data: params,
    );
    final expense = response['data']?['expense'] as Map<String, dynamic>?;
    return ToolExecutionResult.success(
      'Gasto registrado: ${params['description']} — \$${params['amount']}',
      entityId: expense?['id'] as String?,
    );
  }

  Future<ToolExecutionResult> _createCalendarEvent(Map<String, dynamic> params) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.calendar,
      data: params,
    );
    final event = response['data']?['event'] as Map<String, dynamic>?;
    return ToolExecutionResult.success(
      'Evento creado: ${params['title']}',
      entityId: event?['id'] as String?,
    );
  }

  Future<ToolExecutionResult> _addBoardLink(Map<String, dynamic> params) async {
    // Need to resolve boardName to boardId
    // For now, pass boardName and let the backend handle it
    await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.boards,
      data: params,
    );
    return ToolExecutionResult.success(
      'Link guardado en ${params['boardName']}',
    );
  }

  Future<ToolExecutionResult> _addMenuItem(Map<String, dynamic> params) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.chatAddMenuItem,
      data: params,
    );
    final item = response['data']?['item'] as Map<String, dynamic>?;
    final recipeName = (item?['recipe'] as Map<String, dynamic>?)?['title']
        ?? params['recipeName']
        ?? params['customName'];
    return ToolExecutionResult.success(
      'Comida agregada al menú: $recipeName',
    );
  }

  Future<ToolExecutionResult> _generateShoppingList(Map<String, dynamic> params) async {
    // This requires a menu plan ID — the LLM should provide it
    final menuPlanId = params['menuPlanId'] as String?;
    if (menuPlanId == null) {
      return ToolExecutionResult.error('No se especificó el plan de menú');
    }
    await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.menuGenerateShopping(menuPlanId),
    );
    return ToolExecutionResult.success('Lista de compras generada');
  }
}

/// Result of executing an action tool
class ToolExecutionResult {
  final bool isSuccess;
  final String message;
  final String? entityId;

  const ToolExecutionResult._({
    required this.isSuccess,
    required this.message,
    this.entityId,
  });

  factory ToolExecutionResult.success(String message, {String? entityId}) {
    return ToolExecutionResult._(
      isSuccess: true,
      message: message,
      entityId: entityId,
    );
  }

  factory ToolExecutionResult.error(String message) {
    return ToolExecutionResult._(isSuccess: false, message: message);
  }
}
