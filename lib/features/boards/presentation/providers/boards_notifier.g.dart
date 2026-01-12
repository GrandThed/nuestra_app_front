// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boards_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$boardsNotifierHash() => r'ff9a587bc82da5c0ab1279eac05520e1213f474d';

/// Notifier for boards list operations
///
/// Copied from [BoardsNotifier].
@ProviderFor(BoardsNotifier)
final boardsNotifierProvider =
    NotifierProvider<BoardsNotifier, BoardsState>.internal(
      BoardsNotifier.new,
      name: r'boardsNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$boardsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$BoardsNotifier = Notifier<BoardsState>;
String _$boardDetailNotifierHash() =>
    r'80e14d7fdee486ccef3e5994396c1d7139fb2fcc';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$BoardDetailNotifier
    extends BuildlessAutoDisposeNotifier<BoardDetailState> {
  late final String boardId;

  BoardDetailState build(String boardId);
}

/// Notifier for single board detail operations
///
/// Copied from [BoardDetailNotifier].
@ProviderFor(BoardDetailNotifier)
const boardDetailNotifierProvider = BoardDetailNotifierFamily();

/// Notifier for single board detail operations
///
/// Copied from [BoardDetailNotifier].
class BoardDetailNotifierFamily extends Family<BoardDetailState> {
  /// Notifier for single board detail operations
  ///
  /// Copied from [BoardDetailNotifier].
  const BoardDetailNotifierFamily();

  /// Notifier for single board detail operations
  ///
  /// Copied from [BoardDetailNotifier].
  BoardDetailNotifierProvider call(String boardId) {
    return BoardDetailNotifierProvider(boardId);
  }

  @override
  BoardDetailNotifierProvider getProviderOverride(
    covariant BoardDetailNotifierProvider provider,
  ) {
    return call(provider.boardId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'boardDetailNotifierProvider';
}

/// Notifier for single board detail operations
///
/// Copied from [BoardDetailNotifier].
class BoardDetailNotifierProvider
    extends
        AutoDisposeNotifierProviderImpl<BoardDetailNotifier, BoardDetailState> {
  /// Notifier for single board detail operations
  ///
  /// Copied from [BoardDetailNotifier].
  BoardDetailNotifierProvider(String boardId)
    : this._internal(
        () => BoardDetailNotifier()..boardId = boardId,
        from: boardDetailNotifierProvider,
        name: r'boardDetailNotifierProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$boardDetailNotifierHash,
        dependencies: BoardDetailNotifierFamily._dependencies,
        allTransitiveDependencies:
            BoardDetailNotifierFamily._allTransitiveDependencies,
        boardId: boardId,
      );

  BoardDetailNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.boardId,
  }) : super.internal();

  final String boardId;

  @override
  BoardDetailState runNotifierBuild(covariant BoardDetailNotifier notifier) {
    return notifier.build(boardId);
  }

  @override
  Override overrideWith(BoardDetailNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: BoardDetailNotifierProvider._internal(
        () => create()..boardId = boardId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        boardId: boardId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<BoardDetailNotifier, BoardDetailState>
  createElement() {
    return _BoardDetailNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BoardDetailNotifierProvider && other.boardId == boardId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, boardId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin BoardDetailNotifierRef
    on AutoDisposeNotifierProviderRef<BoardDetailState> {
  /// The parameter `boardId` of this provider.
  String get boardId;
}

class _BoardDetailNotifierProviderElement
    extends
        AutoDisposeNotifierProviderElement<
          BoardDetailNotifier,
          BoardDetailState
        >
    with BoardDetailNotifierRef {
  _BoardDetailNotifierProviderElement(super.provider);

  @override
  String get boardId => (origin as BoardDetailNotifierProvider).boardId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
