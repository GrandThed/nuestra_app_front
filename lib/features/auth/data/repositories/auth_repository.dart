import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nuestra_app/core/constants/api_constants.dart';
import 'package:nuestra_app/core/network/api_interceptor.dart';
import 'package:nuestra_app/core/network/dio_client.dart';
import 'package:nuestra_app/features/auth/data/models/auth_response_model.dart';
import 'package:nuestra_app/features/auth/data/models/user_model.dart';

/// Provider for auth repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    dioClient: ref.watch(dioClientProvider),
    secureStorage: ref.watch(secureStorageProvider),
    ref: ref,
  );
});

/// Repository for authentication operations
class AuthRepository {
  final DioClient _dioClient;
  final FlutterSecureStorage _secureStorage;
  final Ref _ref;

  static const _tokenKey = 'auth_token';

  AuthRepository({
    required DioClient dioClient,
    required FlutterSecureStorage secureStorage,
    required Ref ref,
  })  : _dioClient = dioClient,
        _secureStorage = secureStorage,
        _ref = ref;

  /// Sign in with Google OAuth
  Future<AuthResponseModel> signInWithGoogle(String idToken) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.authGoogle,
      data: {'idToken': idToken},
    );

    final authResponse = AuthResponseModel.fromJson(response['data']);
    await storeToken(authResponse.token);
    return authResponse;
  }

  /// Sign in with Apple OAuth
  Future<AuthResponseModel> signInWithApple(
    String idToken, {
    String? fullName,
  }) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.authApple,
      data: {
        'idToken': idToken,
        if (fullName != null) 'fullName': fullName,
      },
    );

    final authResponse = AuthResponseModel.fromJson(response['data']);
    await storeToken(authResponse.token);
    return authResponse;
  }

  /// Dev login (for testing only)
  Future<AuthResponseModel> devLogin(String email) async {
    final response = await _dioClient.post<Map<String, dynamic>>(
      ApiConstants.authDevLogin,
      data: {'email': email},
    );

    final authResponse = AuthResponseModel.fromJson(response['data']);
    await storeToken(authResponse.token);
    return authResponse;
  }

  /// Get current authenticated user with household info
  Future<UserModel> getCurrentUser() async {
    final response = await _dioClient.get<Map<String, dynamic>>(
      ApiConstants.authMe,
    );

    return UserModel.fromJson(response['data']['user']);
  }

  /// Sign out - clear stored token
  Future<void> signOut() async {
    await _secureStorage.delete(key: _tokenKey);
    _ref.read(authTokenProvider.notifier).state = null;
  }

  /// Get stored token from secure storage
  Future<String?> getStoredToken() async {
    return await _secureStorage.read(key: _tokenKey);
  }

  /// Store token in secure storage and update provider
  Future<void> storeToken(String token) async {
    await _secureStorage.write(key: _tokenKey, value: token);
    _ref.read(authTokenProvider.notifier).state = token;
  }

  /// Check if user has a stored token
  Future<bool> hasStoredToken() async {
    final token = await getStoredToken();
    return token != null && token.isNotEmpty;
  }
}
