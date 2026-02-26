import 'dart:async';

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
  StreamSubscription<GoogleSignInAuthenticationEvent>? _authEventsSub;
  bool _googleInitialized = false;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    ref.onDispose(() {
      _authEventsSub?.cancel();
    });
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

  /// Initialize Google Sign-In and listen to auth events (needed for web).
  /// Call this from the login screen's initState.
  Future<void> initializeGoogleSignIn() async {
    if (_googleInitialized) return;
    _googleInitialized = true;

    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize(
      clientId: kIsWeb ? AuthConfig.googleWebClientId : null,
      serverClientId: kIsWeb ? null : AuthConfig.googleWebClientId,
    );

    // Listen to auth events (fired by renderButton on web)
    _authEventsSub?.cancel();
    _authEventsSub = googleSignIn.authenticationEvents.listen(
      _handleGoogleAuthEvent,
      onError: _handleGoogleAuthError,
    );

    // Try silent sign-in if user was previously authenticated
    googleSignIn.attemptLightweightAuthentication();
  }

  Future<void> _handleGoogleAuthEvent(
    GoogleSignInAuthenticationEvent event,
  ) async {
    switch (event) {
      case GoogleSignInAuthenticationEventSignIn():
        await _processGoogleAccount(event.user);
      case GoogleSignInAuthenticationEventSignOut():
        break;
    }
  }

  void _handleGoogleAuthError(Object error) {
    if (error is GoogleSignInException &&
        error.code == GoogleSignInExceptionCode.canceled) {
      state = const AuthState.unauthenticated();
      return;
    }
    state = AuthState.error('Error al iniciar sesión con Google: $error');
  }

  /// Process a GoogleSignInAccount (shared by both mobile authenticate and web events)
  Future<void> _processGoogleAccount(GoogleSignInAccount account) async {
    state = const AuthState.loading();

    try {
      final auth = account.authentication;
      final idToken = auth.idToken;

      debugPrint('Google auth - idToken: ${idToken != null ? "present" : "null"}');

      if (idToken == null) {
        state = const AuthState.error('No se pudo obtener el token de Google');
        return;
      }

      await _authRepository.signInWithGoogle(idToken: idToken);
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

  /// Sign in with Google (mobile only — on web, renderButton triggers auth events)
  Future<void> signInWithGoogle() async {
    state = const AuthState.loading();

    try {
      final googleSignIn = GoogleSignIn.instance;

      if (!_googleInitialized) {
        await initializeGoogleSignIn();
      }

      // authenticate() only works on mobile, not web
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

      await _processGoogleAccount(account);
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

  /// Update the authenticated user's households list locally (no API call).
  /// Used after create/delete/join/leave household to synchronously update
  /// the router's view of whether the user has a household.
  void setUserHouseholds(List<HouseholdMembershipModel> households) {
    final currentState = state;
    if (currentState is AuthStateAuthenticated) {
      state = AuthState.authenticated(
        currentState.user.copyWith(households: households),
      );
    }
  }
}
