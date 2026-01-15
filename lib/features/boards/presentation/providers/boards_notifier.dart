import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/boards/data/models/board_model.dart';
import 'package:nuestra_app/features/boards/data/repositories/board_repository.dart';
import 'package:nuestra_app/features/boards/presentation/providers/boards_state.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';

part 'boards_notifier.g.dart';

/// Notifier for boards list operations
@Riverpod(keepAlive: true)
class BoardsNotifier extends _$BoardsNotifier {
  late final BoardRepository _repository;

  @override
  BoardsState build() {
    _repository = ref.watch(boardRepositoryProvider);
    return const BoardsState.initial();
  }

  /// Load boards only if not already loaded (for screen init)
  Future<void> loadBoardsIfNeeded() async {
    if (state is BoardsStateInitial || state is BoardsStateError) {
      await loadBoards();
    }
  }

  /// Load all boards for current household
  /// Shows loading only on first load, refreshes silently otherwise
  Future<void> loadBoards({bool forceLoading = false}) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) {
      state = const BoardsState.error('No hay hogar seleccionado');
      return;
    }

    // Only show loading spinner if no data exists yet or forced
    final hasData = state is BoardsStateLoaded;
    if (!hasData || forceLoading) {
      state = const BoardsState.loading();
    }

    try {
      final boards = await _repository.getBoards(householdId);
      state = BoardsState.loaded(boards);
    } on AppException catch (e) {
      // Only show error if we don't have existing data
      if (!hasData) {
        state = BoardsState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = BoardsState.error('Error al cargar tableros: $e');
      }
    }
  }

  /// Create a new board
  Future<BoardModel?> createBoard(String name) async {
    final householdId = ref.read(currentHouseholdIdProvider);
    if (householdId == null) return null;

    try {
      final board = await _repository.createBoard(
        householdId: householdId,
        name: name,
      );

      // Add to current list
      final currentState = state;
      if (currentState is BoardsStateLoaded) {
        state = BoardsState.loaded([board, ...currentState.boards]);
      } else {
        state = BoardsState.loaded([board]);
      }

      return board;
    } on AppException catch (e) {
      debugPrint('Error creating board: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error creating board: $e');
      return null;
    }
  }

  /// Delete a board
  Future<bool> deleteBoard(String id) async {
    try {
      await _repository.deleteBoard(id);

      // Remove from current list
      final currentState = state;
      if (currentState is BoardsStateLoaded) {
        final updatedBoards =
            currentState.boards.where((b) => b.id != id).toList();
        state = BoardsState.loaded(updatedBoards);
      }

      return true;
    } on AppException catch (e) {
      debugPrint('Error deleting board: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Error deleting board: $e');
      return false;
    }
  }

  /// Update board in list (after detail edit)
  void updateBoardInList(BoardModel board) {
    final currentState = state;
    if (currentState is BoardsStateLoaded) {
      final updatedBoards = currentState.boards.map((b) {
        return b.id == board.id ? board : b;
      }).toList();
      state = BoardsState.loaded(updatedBoards);
    }
  }
}

/// Notifier for single board detail operations
@Riverpod(keepAlive: true)
class BoardDetailNotifier extends _$BoardDetailNotifier {
  late final BoardRepository _repository;

  @override
  BoardDetailState build(String boardId) {
    _repository = ref.watch(boardRepositoryProvider);
    return const BoardDetailState.initial();
  }

  /// Load board only if not already loaded
  Future<void> loadBoardIfNeeded() async {
    if (state is BoardDetailStateInitial || state is BoardDetailStateError) {
      await loadBoard();
    }
  }

  /// Load board detail
  /// Shows loading only on first load, refreshes silently otherwise
  Future<void> loadBoard({bool forceLoading = false}) async {
    final hasData = state is BoardDetailStateLoaded;

    if (!hasData || forceLoading) {
      state = const BoardDetailState.loading();
    }

    try {
      final board = await _repository.getBoard(boardId);
      state = BoardDetailState.loaded(board);
    } on AppException catch (e) {
      if (!hasData) {
        state = BoardDetailState.error(e.message);
      }
    } catch (e) {
      if (!hasData) {
        state = BoardDetailState.error('Error al cargar tablero: $e');
      }
    }
  }

  /// Add a link item
  Future<BoardItemModel?> addLinkItem({
    required String url,
    String? title,
    String? description,
  }) async {
    try {
      final item = await _repository.addLinkItem(
        boardId: boardId,
        url: url,
        title: title,
        description: description,
      );

      _addItemToState(item);
      return item;
    } on AppException catch (e) {
      debugPrint('Error adding link: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error adding link: $e');
      return null;
    }
  }

  /// Add a photo item
  Future<BoardItemModel?> addPhotoItem({
    required File photo,
    String? title,
    String? description,
  }) async {
    try {
      final item = await _repository.addPhotoItem(
        boardId: boardId,
        photo: photo,
        title: title,
        description: description,
      );

      _addItemToState(item);
      return item;
    } on AppException catch (e) {
      debugPrint('Error adding photo: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error adding photo: $e');
      return null;
    }
  }

  /// Update an item
  Future<BoardItemModel?> updateItem({
    required String itemId,
    String? title,
    String? description,
    PhotoBackModel? photoBack,
  }) async {
    try {
      final item = await _repository.updateItem(
        boardId: boardId,
        itemId: itemId,
        title: title,
        description: description,
        photoBack: photoBack,
      );

      _updateItemInState(item);
      return item;
    } on AppException catch (e) {
      debugPrint('Error updating item: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error updating item: $e');
      return null;
    }
  }

  /// Delete an item
  Future<bool> deleteItem(String itemId) async {
    try {
      await _repository.deleteItem(boardId: boardId, itemId: itemId);

      _removeItemFromState(itemId);
      return true;
    } on AppException catch (e) {
      debugPrint('Error deleting item: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Error deleting item: $e');
      return false;
    }
  }

  void _addItemToState(BoardItemModel item) {
    final currentState = state;
    if (currentState is BoardDetailStateLoaded) {
      final currentItems = currentState.board.items ?? [];
      final updatedBoard = currentState.board.copyWith(
        items: [item, ...currentItems],
        itemCount: currentItems.length + 1,
      );
      state = BoardDetailState.loaded(updatedBoard);

      // Update boards list
      ref.read(boardsNotifierProvider.notifier).updateBoardInList(updatedBoard);
    }
  }

  void _updateItemInState(BoardItemModel item) {
    final currentState = state;
    if (currentState is BoardDetailStateLoaded) {
      final currentItems = currentState.board.items ?? [];
      final updatedItems = currentItems.map((i) {
        return i.id == item.id ? item : i;
      }).toList();
      final updatedBoard = currentState.board.copyWith(items: updatedItems);
      state = BoardDetailState.loaded(updatedBoard);
    }
  }

  void _removeItemFromState(String itemId) {
    final currentState = state;
    if (currentState is BoardDetailStateLoaded) {
      final currentItems = currentState.board.items ?? [];
      final updatedItems = currentItems.where((i) => i.id != itemId).toList();
      final updatedBoard = currentState.board.copyWith(
        items: updatedItems,
        itemCount: updatedItems.length,
      );
      state = BoardDetailState.loaded(updatedBoard);

      // Update boards list
      ref.read(boardsNotifierProvider.notifier).updateBoardInList(updatedBoard);
    }
  }
}
