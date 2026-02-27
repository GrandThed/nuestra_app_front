import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/chat/data/models/chat_api_response.dart';
import 'package:nuestra_app/features/chat/data/models/chat_message_model.dart';
import 'package:nuestra_app/features/chat/data/repositories/chat_repository.dart';
import 'package:nuestra_app/features/chat/data/services/chat_tool_executor.dart';
import 'package:nuestra_app/features/chat/presentation/providers/chat_state.dart';
import 'package:nuestra_app/features/boards/presentation/providers/boards_notifier.dart';
import 'package:nuestra_app/features/calendar/presentation/providers/calendar_notifier.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_notifier.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_state.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_notifier.dart';
import 'package:nuestra_app/features/wishlists/presentation/providers/wishlists_notifier.dart';

part 'chat_notifier.g.dart';

const _maxContinueRounds = 2;

@Riverpod(keepAlive: true)
class ChatNotifier extends _$ChatNotifier {
  late final ChatRepository _repository;
  late final ChatToolExecutor _toolExecutor;
  late final DioClient _dioClient;

  @override
  ChatState build() {
    _repository = ref.watch(chatRepositoryProvider);
    _toolExecutor = ref.watch(chatToolExecutorProvider);
    _dioClient = ref.watch(dioClientProvider);
    return const ChatState();
  }

  /// Load chat history from backend (call in screen initState)
  Future<void> loadHistoryIfNeeded() async {
    if (state.messages.isNotEmpty) return;
    await loadHistory();
  }

  /// Load chat history
  Future<void> loadHistory() async {
    try {
      final response = await _repository.getHistory();
      final suggestions = _extractLastSuggestions(response.messages);
      state = state.copyWith(
        messages: response.messages,
        suggestions: suggestions,
      );
    } on AppException catch (_) {
      // Silently fail — chat history is not critical
    }
  }

  /// Send a message to the assistant.
  /// [imagePaths] are local file paths — they'll be uploaded first.
  Future<void> sendMessage(
    String text, {
    List<String> imageUrls = const [],
  }) async {
    // Upload local images first
    final uploadedUrls = await _uploadImages(imageUrls);

    // Add user message optimistically
    final userMessage = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: 'user',
      content: text,
      imageUrls: uploadedUrls,
      createdAt: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage],
      isSending: true,
      suggestions: [],
    );

    try {
      var response = await _repository.sendMessage(
        text,
        imageUrls: uploadedUrls,
      );

      // Handle data gathering loop (max rounds)
      var round = 0;
      while (response is ChatApiResponseDataRequest &&
          round < _maxContinueRounds) {
        round++;

        // Show gathering indicator
        state = state.copyWith(isGatheringData: true);

        // Execute query tools and collect results
        final results = await _executeQueryRequests(response.requests);

        // Send results back to LLM
        response = await _repository.continueWithData(results);
      }

      // Handle final response
      if (response is ChatApiResponseResponse) {
        final assistantMessage = ChatMessageModel(
          id: response.messageId,
          role: 'assistant',
          content: response.reply,
          toolCalls: response.toolCalls,
          suggestions: response.suggestions,
          createdAt: DateTime.now(),
        );

        state = state.copyWith(
          messages: [...state.messages, assistantMessage],
          isSending: false,
          isGatheringData: false,
          suggestions: response.suggestions,
        );
      } else {
        // Fallback: max rounds exceeded
        state = state.copyWith(
          isSending: false,
          isGatheringData: false,
        );
      }
    } on AppException catch (e) {
      _addErrorMessage('Error: ${e.message}');
    } catch (e) {
      _addErrorMessage(
        'Hubo un error al comunicarse con el asistente. Intenta de nuevo.',
      );
    }
  }

  /// Clear all chat history
  Future<void> clearHistory() async {
    try {
      await _repository.clearHistory();
    } catch (_) {
      // Clear locally even if API fails
    }
    state = const ChatState();
  }

  /// Upload local image files and return their server URLs.
  Future<List<String>> _uploadImages(List<String> localPaths) async {
    if (localPaths.isEmpty) return [];

    final urls = <String>[];
    for (final path in localPaths) {
      try {
        final formData = FormData.fromMap({
          'image': await MultipartFile.fromFile(
            path,
            filename: path.split('/').last,
          ),
        });

        final response = await _dioClient.dio.post<Map<String, dynamic>>(
          '${ApiConstants.baseUrl}${ApiConstants.upload}/image',
          data: formData,
        );

        final data = response.data;
        if (data != null && data['success'] == true) {
          final fileData = data['data']?['file'] as Map<String, dynamic>?;
          final url = fileData?['url'] as String?;
          if (url != null) urls.add(url);
        }
      } catch (_) {
        // Skip failed uploads
      }
    }

    return urls;
  }

  /// Execute query tool requests from a data_request response.
  Future<List<Map<String, dynamic>>> _executeQueryRequests(
    List<ChatToolCallModel> requests,
  ) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return [];

    final results = <Map<String, dynamic>>[];

    for (final request in requests) {
      try {
        final result = await _toolExecutor.executeQuery(
          request,
          householdId: householdId,
        );
        results.add({
          'tool': request.tool,
          'result': result,
        });
      } catch (e) {
        results.add({
          'tool': request.tool,
          'result': <String, dynamic>{'error': e.toString()},
        });
      }
    }

    return results;
  }

  /// Add an error message as an assistant bubble
  void _addErrorMessage(String text) {
    final errorMessage = ChatMessageModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      role: 'assistant',
      content: text,
      createdAt: DateTime.now(),
    );

    state = state.copyWith(
      messages: [...state.messages, errorMessage],
      isSending: false,
      isGatheringData: false,
    );
  }

  /// Execute a single action tool call (triggered by user confirmation).
  /// [messageId] and [toolIndex] identify which tool call to execute.
  Future<void> executeToolCall(String messageId, int toolIndex) async {
    final key = '${messageId}_$toolIndex';

    // Find the message and tool call
    final message = state.messages.where((m) => m.id == messageId).firstOrNull;
    if (message == null || toolIndex >= message.toolCalls.length) {
      print('[ChatNotifier] executeToolCall FAILED: message=$messageId not found or toolIndex=$toolIndex out of range. Messages: ${state.messages.map((m) => m.id).toList()}');
      state = state.copyWith(
        toolExecutionStatuses: {...state.toolExecutionStatuses, key: ToolExecutionStatus.error},
        toolExecutionResults: {...state.toolExecutionResults, key: 'No se encontró la acción'},
      );
      return;
    }

    final toolCall = message.toolCalls[toolIndex];

    // Get householdId
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      print('[ChatNotifier] executeToolCall FAILED: householdId is null');
      state = state.copyWith(
        toolExecutionStatuses: {...state.toolExecutionStatuses, key: ToolExecutionStatus.error},
        toolExecutionResults: {...state.toolExecutionResults, key: 'Hogar no disponible'},
      );
      return;
    }

    // Mark as executing
    state = state.copyWith(
      toolExecutionStatuses: {
        ...state.toolExecutionStatuses,
        key: ToolExecutionStatus.executing,
      },
    );

    try {
      final result = await _toolExecutor.executeAction(toolCall, householdId: householdId);
      state = state.copyWith(
        toolExecutionStatuses: {
          ...state.toolExecutionStatuses,
          key: result.isSuccess
              ? ToolExecutionStatus.success
              : ToolExecutionStatus.error,
        },
        toolExecutionResults: {
          ...state.toolExecutionResults,
          key: result.message,
        },
      );

      // Refresh the related feature provider so UI updates immediately
      if (result.isSuccess) {
        _refreshRelatedProvider(toolCall.tool);
      }
    } catch (e) {
      state = state.copyWith(
        toolExecutionStatuses: {
          ...state.toolExecutionStatuses,
          key: ToolExecutionStatus.error,
        },
        toolExecutionResults: {
          ...state.toolExecutionResults,
          key: 'Error inesperado: $e',
        },
      );
    }
  }

  /// Refresh the feature provider affected by a tool action so the UI
  /// reflects the change without requiring a manual reload.
  void _refreshRelatedProvider(String toolName) {
    switch (toolName) {
      case 'create_recipe':
        ref.read(recipesProvider.notifier).loadRecipes();
        break;
      case 'add_wishlist_items':
        ref.read(wishlistsProvider.notifier).loadWishlists();
        break;
      case 'create_expense':
        ref.read(expensesProvider.notifier).loadExpenses();
        ref.read(expenseSummaryProvider.notifier).loadSummary();
        break;
      case 'create_calendar_event':
        ref.read(calendarProvider.notifier).loadEvents();
        break;
      case 'add_board_link':
        ref.read(boardsProvider.notifier).loadBoards();
        break;
      case 'add_menu_item':
      case 'generate_shopping_list':
        ref.read(menuPlansProvider.notifier).loadMenuPlans();
        // Reload upcoming meals for the currently loaded week
        final mealsState = ref.read(upcomingMealsProvider);
        if (mealsState is UpcomingMealsStateLoaded) {
          ref.read(upcomingMealsProvider.notifier).loadWeek(mealsState.weekStart);
        }
        if (toolName == 'generate_shopping_list') {
          ref.read(wishlistsProvider.notifier).loadWishlists();
        }
        break;
    }
  }

  /// Extract suggestions from the last assistant message in history
  List<String> _extractLastSuggestions(List<ChatMessageModel> messages) {
    for (var i = messages.length - 1; i >= 0; i--) {
      if (messages[i].role == 'assistant' &&
          messages[i].suggestions.isNotEmpty) {
        return messages[i].suggestions;
      }
    }
    return [];
  }
}
