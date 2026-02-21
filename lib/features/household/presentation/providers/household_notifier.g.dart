// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the current household ID (persisted)

@ProviderFor(CurrentHouseholdId)
final currentHouseholdIdProvider = CurrentHouseholdIdProvider._();

/// Provider for the current household ID (persisted)
final class CurrentHouseholdIdProvider
    extends $NotifierProvider<CurrentHouseholdId, String?> {
  /// Provider for the current household ID (persisted)
  CurrentHouseholdIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentHouseholdIdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentHouseholdIdHash();

  @$internal
  @override
  CurrentHouseholdId create() => CurrentHouseholdId();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$currentHouseholdIdHash() =>
    r'c93068067a2cad4954aa0951165db78d61df0a7d';

/// Provider for the current household ID (persisted)

abstract class _$CurrentHouseholdId extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier for household operations

@ProviderFor(HouseholdNotifier)
final householdProvider = HouseholdNotifierProvider._();

/// Notifier for household operations
final class HouseholdNotifierProvider
    extends $NotifierProvider<HouseholdNotifier, HouseholdState> {
  /// Notifier for household operations
  HouseholdNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'householdProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$householdNotifierHash();

  @$internal
  @override
  HouseholdNotifier create() => HouseholdNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HouseholdState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HouseholdState>(value),
    );
  }
}

String _$householdNotifierHash() => r'f344357e59030e680daf8a6ed69da6192d8b7be6';

/// Notifier for household operations

abstract class _$HouseholdNotifier extends $Notifier<HouseholdState> {
  HouseholdState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<HouseholdState, HouseholdState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HouseholdState, HouseholdState>,
              HouseholdState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Notifier for active invite state

@ProviderFor(ActiveInviteNotifier)
final activeInviteProvider = ActiveInviteNotifierProvider._();

/// Notifier for active invite state
final class ActiveInviteNotifierProvider
    extends $NotifierProvider<ActiveInviteNotifier, ActiveInviteState> {
  /// Notifier for active invite state
  ActiveInviteNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeInviteProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeInviteNotifierHash();

  @$internal
  @override
  ActiveInviteNotifier create() => ActiveInviteNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ActiveInviteState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ActiveInviteState>(value),
    );
  }
}

String _$activeInviteNotifierHash() =>
    r'875a979b7aae3056f70591c0b51b43ccd8dabb55';

/// Notifier for active invite state

abstract class _$ActiveInviteNotifier extends $Notifier<ActiveInviteState> {
  ActiveInviteState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ActiveInviteState, ActiveInviteState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ActiveInviteState, ActiveInviteState>,
              ActiveInviteState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
