// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_card_order_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeCardOrderNotifier)
final homeCardOrderProvider = HomeCardOrderNotifierProvider._();

final class HomeCardOrderNotifierProvider
    extends $NotifierProvider<HomeCardOrderNotifier, List<String>> {
  HomeCardOrderNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeCardOrderProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeCardOrderNotifierHash();

  @$internal
  @override
  HomeCardOrderNotifier create() => HomeCardOrderNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$homeCardOrderNotifierHash() =>
    r'605ecc2beb95c6d520cf777591dea74487901bed';

abstract class _$HomeCardOrderNotifier extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
