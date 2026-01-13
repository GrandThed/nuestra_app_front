import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/household/data/models/household_model.dart';

/// Provider for household repository
final householdRepositoryProvider = Provider<HouseholdRepository>((ref) {
  return HouseholdRepository(
    dioClient: ref.watch(dioClientProvider),
  );
});

/// Repository for household operations
class HouseholdRepository {
  final DioClient _dioClient;

  HouseholdRepository({required DioClient dioClient}) : _dioClient = dioClient;

  /// Create a new household
  Future<HouseholdModel> createHousehold({
    required String name,
    required String hemisphere,
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.households,
      data: {
        'name': name,
        'hemisphere': hemisphere,
      },
    );

    return HouseholdModel.fromJson(response['data']['household']);
  }

  /// Get a household by ID
  Future<HouseholdModel> getHousehold(String id) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.household(id),
    );

    return HouseholdModel.fromJson(response['data']['household']);
  }

  /// Generate an invite code for a household
  Future<HouseholdInviteModel> generateInvite({
    required String householdId,
    int expiresInDays = 7,
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.householdInvite(householdId),
      data: {'expiresInDays': expiresInDays},
    );

    return HouseholdInviteModel.fromJson(response['data']);
  }

  /// Join a household using an invite code
  Future<HouseholdModel> joinHousehold(String inviteCode) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.householdJoin,
      data: {'inviteCode': inviteCode},
    );

    return HouseholdModel.fromJson(response['data']['household']);
  }

  /// Update a member's income
  Future<void> updateMemberIncome({
    required String householdId,
    required String userId,
    required double income,
  }) async {
    await _dioClient.patch<Map<String, dynamic>>(
      ApiConstants.householdMember(householdId, userId),
      data: {'income': income},
    );
  }

  /// Leave a household (for non-owners)
  Future<void> leaveHousehold({
    required String householdId,
    required String userId,
  }) async {
    await _dioClient.delete<Map<String, dynamic>>(
      ApiConstants.householdMember(householdId, userId),
    );
  }
}
