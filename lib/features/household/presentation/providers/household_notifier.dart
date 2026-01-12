import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:nuestra_app/features/household/data/models/household_model.dart';
import 'package:nuestra_app/features/household/data/repositories/household_repository.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_state.dart';

part 'household_notifier.g.dart';

/// Provider for the current household ID (persisted)
@Riverpod(keepAlive: true)
class CurrentHouseholdId extends _$CurrentHouseholdId {
  @override
  String? build() {
    return null;
  }

  void setHouseholdId(String? id) {
    state = id;
  }
}

/// Notifier for household operations
@Riverpod(keepAlive: true)
class HouseholdNotifier extends _$HouseholdNotifier {
  late final HouseholdRepository _repository;

  @override
  HouseholdState build() {
    _repository = ref.watch(householdRepositoryProvider);
    return const HouseholdState.initial();
  }

  /// Create a new household
  Future<HouseholdModel?> createHousehold({
    required String name,
    required String hemisphere,
  }) async {
    state = const HouseholdState.loading();

    try {
      final household = await _repository.createHousehold(
        name: name,
        hemisphere: hemisphere,
      );

      // Set as current household
      ref.read(currentHouseholdIdProvider.notifier).setHouseholdId(household.id);

      // Refresh auth state so router knows user has a household
      await ref.read(authNotifierProvider.notifier).refreshUser();

      state = HouseholdState.loaded(household);
      return household;
    } on AppException catch (e) {
      state = HouseholdState.error(e.message);
      return null;
    } catch (e) {
      state = HouseholdState.error('Error al crear el hogar: $e');
      return null;
    }
  }

  /// Join an existing household
  Future<HouseholdModel?> joinHousehold(String inviteCode) async {
    state = const HouseholdState.loading();

    try {
      final household = await _repository.joinHousehold(inviteCode);

      // Set as current household
      ref.read(currentHouseholdIdProvider.notifier).setHouseholdId(household.id);

      // Refresh auth state so router knows user has a household
      await ref.read(authNotifierProvider.notifier).refreshUser();

      state = HouseholdState.loaded(household);
      return household;
    } on AppException catch (e) {
      state = HouseholdState.error(e.message);
      return null;
    } catch (e) {
      state = HouseholdState.error('Error al unirse al hogar: $e');
      return null;
    }
  }

  /// Load a household by ID
  Future<void> loadHousehold(String id) async {
    state = const HouseholdState.loading();

    try {
      final household = await _repository.getHousehold(id);
      state = HouseholdState.loaded(household);
    } on AppException catch (e) {
      state = HouseholdState.error(e.message);
    } catch (e) {
      state = HouseholdState.error('Error al cargar el hogar: $e');
    }
  }

  /// Generate an invite code
  Future<HouseholdInviteModel?> generateInvite({
    required String householdId,
    int expiresInDays = 7,
  }) async {
    try {
      return await _repository.generateInvite(
        householdId: householdId,
        expiresInDays: expiresInDays,
      );
    } on AppException catch (e) {
      debugPrint('Error generating invite: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Error generating invite: $e');
      return null;
    }
  }

  /// Update member income
  Future<bool> updateMemberIncome({
    required String householdId,
    required String userId,
    required double income,
  }) async {
    try {
      await _repository.updateMemberIncome(
        householdId: householdId,
        userId: userId,
        income: income,
      );
      // Reload household to get updated data
      await loadHousehold(householdId);
      return true;
    } on AppException catch (e) {
      debugPrint('Error updating income: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Error updating income: $e');
      return false;
    }
  }

  /// Leave household
  Future<bool> leaveHousehold({
    required String householdId,
    required String userId,
  }) async {
    try {
      await _repository.leaveHousehold(
        householdId: householdId,
        userId: userId,
      );
      ref.read(currentHouseholdIdProvider.notifier).setHouseholdId(null);
      state = const HouseholdState.initial();
      return true;
    } on AppException catch (e) {
      debugPrint('Error leaving household: ${e.message}');
      return false;
    } catch (e) {
      debugPrint('Error leaving household: $e');
      return false;
    }
  }

  /// Clear error state
  void clearError() {
    state = const HouseholdState.initial();
  }
}
