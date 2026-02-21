// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boards_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Notifier for boards list operations

@ProviderFor(BoardsNotifier)
final boardsProvider = BoardsNotifierProvider._();

/// Notifier for boards list operations
final class BoardsNotifierProvider
    extends $NotifierProvider<BoardsNotifier, BoardsState> {
  /// Notifier for boards list operations
  BoardsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'boardsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$boardsNotifierHash();

  @$internal
  @override
  BoardsNotifier create() => BoardsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BoardsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BoardsState>(value),
    );
  }
}

String _$boardsNotifierHash() => r'88f4387543812da0c1433320ffafd10f18f6197d';

/// Notifier for boards list operations

abstract class _$BoardsNotifier extends $Notifier<BoardsState> {
  BoardsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<BoardsState, BoardsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BoardsState, BoardsState>,
              BoardsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier for single board detail operations

@ProviderFor(BoardDetailNotifier)
final boardDetailProvider = BoardDetailNotifierFamily._();

/// Notifier for single board detail operations
final class BoardDetailNotifierProvider
    extends $NotifierProvider<BoardDetailNotifier, BoardDetailState> {
  /// Notifier for single board detail operations
  BoardDetailNotifierProvider._({
    required BoardDetailNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'boardDetailProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$boardDetailNotifierHash();

  @override
  String toString() {
    return r'boardDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BoardDetailNotifier create() => BoardDetailNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BoardDetailState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BoardDetailState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BoardDetailNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$boardDetailNotifierHash() =>
    r'3131aba0355e7944e02c40768a0eeead9a50ef79';

/// Notifier for single board detail operations

final class BoardDetailNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          BoardDetailNotifier,
          BoardDetailState,
          BoardDetailState,
          BoardDetailState,
          String
        > {
  BoardDetailNotifierFamily._()
    : super(
        retry: null,
        name: r'boardDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Notifier for single board detail operations

  BoardDetailNotifierProvider call(String boardId) =>
      BoardDetailNotifierProvider._(argument: boardId, from: this);

  @override
  String toString() => r'boardDetailProvider';
}

/// Notifier for single board detail operations

abstract class _$BoardDetailNotifier extends $Notifier<BoardDetailState> {
  late final _$args = ref.$arg as String;
  String get boardId => _$args;

  BoardDetailState build(String boardId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<BoardDetailState, BoardDetailState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<BoardDetailState, BoardDetailState>,
              BoardDetailState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

/// Notifier for household tags

@ProviderFor(TagsNotifier)
final tagsProvider = TagsNotifierProvider._();

/// Notifier for household tags
final class TagsNotifierProvider
    extends $NotifierProvider<TagsNotifier, TagsState> {
  /// Notifier for household tags
  TagsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagsNotifierHash();

  @$internal
  @override
  TagsNotifier create() => TagsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TagsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TagsState>(value),
    );
  }
}

String _$tagsNotifierHash() => r'd0106826c7e2eafb708a4787e096c4356d05cd69';

/// Notifier for household tags

abstract class _$TagsNotifier extends $Notifier<TagsState> {
  TagsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TagsState, TagsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TagsState, TagsState>,
              TagsState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
