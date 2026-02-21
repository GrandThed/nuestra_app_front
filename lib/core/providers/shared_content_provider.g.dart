// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_content_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the current shared content

@ProviderFor(SharedContentNotifier)
final sharedContentProvider = SharedContentNotifierProvider._();

/// Provider for the current shared content
final class SharedContentNotifierProvider
    extends $NotifierProvider<SharedContentNotifier, SharedContent?> {
  /// Provider for the current shared content
  SharedContentNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sharedContentProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sharedContentNotifierHash();

  @$internal
  @override
  SharedContentNotifier create() => SharedContentNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SharedContent? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SharedContent?>(value),
    );
  }
}

String _$sharedContentNotifierHash() =>
    r'45020c4110e2789cf33b7adf85464795e04fd394';

/// Provider for the current shared content

abstract class _$SharedContentNotifier extends $Notifier<SharedContent?> {
  SharedContent? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SharedContent?, SharedContent?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<SharedContent?, SharedContent?>,
              SharedContent?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
