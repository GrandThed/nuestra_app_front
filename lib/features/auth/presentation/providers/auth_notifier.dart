import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/features/auth/data/repositories/auth_repository.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';

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

  /// Sign in with Google
  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();

    try {
      final googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile'],
      );

      final account = await googleSignIn.signIn();
      if (account == null) {
        state = const AuthState.unauthenticated();
        return;
      }

      final auth = await account.authentication;
      final idToken = auth.idToken;

      if (idToken == null) {
        state = const AuthState.error('No se pudo obtener el token de Google');
        return;
      }

      final response = await _authRepository.signInWithGoogle(idToken);
      state = AuthState.authenticated(response.user);
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

  /// Dev login (for testing)
  Future<void> devLogin(String email) async {
    state = const AuthState.loading();

    try {
      final response = await _authRepository.devLogin(email);
      state = AuthState.authenticated(response.user);
    } on AppException catch (e) {
      state = AuthState.error(e.message);
    } catch (e) {
      state = AuthState.error('Error en dev login: $e');
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      // Sign out from Google if signed in
      final googleSignIn = GoogleSignIn();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      await _authRepository.signOut();
      state = const AuthState.unauthenticated();
    } catch (e) {
      debugPrint('Error signing out: $e');
      state = const AuthState.unauthenticated();
    }
  }

  /// Clear error and go back to unauthenticated
  void clearError() {
    state = const AuthState.unauthenticated();
  }
}
