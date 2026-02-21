import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/constants/auth_config.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/auth/data/repositories/auth_repository.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/auth/data/models/user_model.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';

part 'auth_notifier.g.dart';

@Riverpod(keepAlive: true)
class AuthNotifier extends _$AuthNotifier {
  late final AuthRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    // Check auth status on initialization
    _checkAuthStatus();
    return const AuthState.initial();
  }

  /// Check if user is already authenticated
  Future<void> _checkAuthStatus() async {
    try {
      final hasToken = await _authRepository.hasStoredToken();
      if (hasToken) {
        // Restore token to provider
        final token = await _authRepository.getStoredToken();
        if (token != null) {
          await _authRepository.storeToken(token);
          // Verify token is still valid
          final user = await _authRepository.getCurrentUser();
          _setCurrentHouseholdFromUser(user);
          state = AuthState.authenticated(user);
        } else {
          state = const AuthState.unauthenticated();
        }
      } else {
        state = const AuthState.unauthenticated();
      }
    } catch (e) {
      // Token invalid or expired
      await _authRepository.signOut();
      state = const AuthState.unauthenticated();
    }
  }

  /// Set the current household ID from user's households
  void _setCurrentHouseholdFromUser(UserModel user) {
    final households = user.households;
    if (households != null && households.isNotEmpty) {
      ref.read(currentHouseholdIdProvider.notifier).setHouseholdId(households.first.id);
    }
  }

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();

    try {
      final googleSignIn = GoogleSignIn.instance;

      // Initialize with appropriate client IDs
      await googleSignIn.initialize(
        clientId: kIsWeb ? AuthConfig.googleWebClientId : null,
        serverClientId: kIsWeb ? null : AuthConfig.googleWebClientId,
      );

      // Authenticate (replaces signIn() in v7)
      final GoogleSignInAccount account;
      try {
        account = await googleSignIn.authenticate(
          scopeHint: ['email', 'profile'],
        );
      } on GoogleSignInException catch (e) {
        if (e.code == GoogleSignInExceptionCode.canceled) {
          state = const AuthState.unauthenticated();
          return;
        }
        rethrow;
      }

      final auth = account.authentication;
      final idToken = auth.idToken;

      debugPrint('Google auth - idToken: ${idToken != null ? "present" : "null"}');

      if (idToken == null) {
        state = const AuthState.error('No se pudo obtener el token de Google');
        return;
      }

      await _authRepository.signInWithGoogle(
        idToken: idToken,
      );
      // Fetch full user data with households
      final user = await _authRepository.getCurrentUser();
      _setCurrentHouseholdFromUser(user);
      state = AuthState.authenticated(user);
    } on AppException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = AuthState.error('Error al iniciar sesión con Google: $e');
    }
  }

  /// Sign in with Apple (iOS only)
  Future<void> signInWithApple() async {
    state = const AuthState.loading();

    try {
      // Apple Sign In implementation will be added when configuring iOS
      // For now, show not implemented
      state = const AuthState.error('Apple Sign In no configurado aún');
    } on AppException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = AuthState.error('Error al iniciar sesión con Apple: $e');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      // Sign out from Google
      await GoogleSignIn.instance.signOut();

      await _authRepository.signOut();
      ref.read(currentHouseholdIdProvider.notifier).setHouseholdId(null);
      state = const AuthState.unauthenticated();
    } catch (e) {
      debugPrint('Error signing out: $e');
      ref.read(currentHouseholdIdProvider.notifier).setHouseholdId(null);
      state = const AuthState.unauthenticated();
    }
  }

  /// Clear error and go back to unauthenticated
  void clearError() {
    state = const AuthState.unauthenticated();
  }

  /// Refresh user data (e.g., after creating/joining a household)
  Future<void> refreshUser() async {
    try {
      final user = await _authRepository.getCurrentUser();
      state = AuthState.authenticated(user);
    } catch (e) {
      debugPrint('Error refreshing user: $e');
      // Don't change state on error, keep current auth state
    }
  }
}
