import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/activity/data/models/activity_model.dart';

/// Provider for activity repository
final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  return ActivityRepository(
    dioClient: ref.watch(dioClientProvider),
  );
});

/// Repository for activity feed operations
class ActivityRepository {
  final DioClient _dioClient;

  ActivityRepository({required DioClient dioClient}) : _dioClient = dioClient;

  /// Get activity feed for a household
  Future<List<ActivityLogModel>> getActivityFeed(
    String householdId, {
    int limit = 20,
    int offset = 0,
  }) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.activity,
      queryParameters: {
        'householdId': householdId,
        'limit': limit.toString(),
        'offset': offset.toString(),
      },
    );

    final activities = response['data']['activities'] as List<dynamic>;
    return activities
        .map((a) => ActivityLogModel.fromJson(a as Map<String, dynamic>))
        .toList();
  }

  /// Get activity digest/summary for a household
  Future<ActivityDigestModel> getDigest(String householdId) async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.activityDigest,
      queryParameters: {
        'householdId': householdId,
      },
    );

    return ActivityDigestModel.fromJson(
      response['data'] as Map<String, dynamic>,
    );
  }
}
