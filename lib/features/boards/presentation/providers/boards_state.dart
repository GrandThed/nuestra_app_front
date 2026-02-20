import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nuestra_app/features/boards/data/models/board_model.dart';

part 'boards_state.freezed.dart';

/// State for boards list
@freezed
sealed class BoardsState with _$BoardsState {
  const factory BoardsState.initial() = BoardsStateInitial;
  const factory BoardsState.loading() = BoardsStateLoading;
  const factory BoardsState.loaded(List<BoardModel> boards) = BoardsStateLoaded;
  const factory BoardsState.error(String message) = BoardsStateError;
}

/// State for a single board detail
@freezed
sealed class BoardDetailState with _$BoardDetailState {
  const factory BoardDetailState.initial() = BoardDetailStateInitial;
  const factory BoardDetailState.loading() = BoardDetailStateLoading;
  const factory BoardDetailState.loaded(BoardModel board) = BoardDetailStateLoaded;
  const factory BoardDetailState.error(String message) = BoardDetailStateError;
}

/// State for tags
@freezed
sealed class TagsState with _$TagsState {
  const factory TagsState.initial() = TagsStateInitial;
  const factory TagsState.loading() = TagsStateLoading;
  const factory TagsState.loaded(List<TagModel> tags) = TagsStateLoaded;
  const factory TagsState.error(String message) = TagsStateError;
}
