// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'household_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$currentHouseholdIdHash() =>
    r'c93068067a2cad4954aa0951165db78d61df0a7d';

/// Provider for the current household ID (persisted)
///
/// Copied from [CurrentHouseholdId].
@ProviderFor(CurrentHouseholdId)
final currentHouseholdIdProvider =
    NotifierProvider<CurrentHouseholdId, String?>.internal(
      CurrentHouseholdId.new,
      name: r'currentHouseholdIdProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$currentHouseholdIdHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CurrentHouseholdId = Notifier<String?>;
String _$householdNotifierHash() => r'365476c2856396976aa26cacc58d079da3613647';

/// Notifier for household operations
///
/// Copied from [HouseholdNotifier].
@ProviderFor(HouseholdNotifier)
final householdNotifierProvider =
    NotifierProvider<HouseholdNotifier, HouseholdState>.internal(
      HouseholdNotifier.new,
      name: r'householdNotifierProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$householdNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$HouseholdNotifier = Notifier<HouseholdState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
