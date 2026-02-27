import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:nuestra_app/core/constants/auth_config.dart';
import 'package:nuestra_app/core/errors/exceptions.dart';
import 'package:nuestra_app/core/network/api_interceptor.dart';
import 'package:nuestra_app/features/activity/presentation/providers/activity_notifier.dart';
import 'package:nuestra_app/features/auth/data/repositories/auth_repository.dart';
import 'package:nuestra_app/features/auth/presentation/providers/auth_state.dart';
import 'package:nuestra_app/features/auth/data/models/user_model.dart';
import 'package:nuestra_app/features/boards/presentation/providers/boards_notifier.dart';
import 'package:nuestra_app/features/calendar/presentation/providers/calendar_notifier.dart';
import 'package:nuestra_app/features/chat/presentation/providers/chat_notifier.dart';
import 'package:nuestra_app/features/expenses/presentation/providers/expenses_notifier.dart';
import 'package:nuestra_app/features/home/presentation/providers/home_card_order_notifier.dart';
import 'package:nuestra_app/features/household/presentation/providers/household_notifier.dart';
import 'package:nuestra_app/features/menus/presentation/providers/menus_notifier.dart';
import 'package:nuestra_app/features/recipes/presentation/providers/recipes_notifier.dart';
import 'package:nuestra_app/features/tasks/presentation/providers/tasks_notifier.dart';
import 'package:nuestra_app/features/wishlists/presentation/providers/wishlists_notifier.dart';

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
      final token = await _authRepository.getStoredToken();
      if (token != null && token.isNotEmpty) {
        // Restore token to the in-memory provider immediately so the router
        // knows we are logged in and does NOT redirect to /login (which would
        // trigger initializeGoogleSignIn and a redundant OAuth prompt).
        await _authRepository.storeToken(token);

        // Verify token is still valid
        final user = await _authRepository.getCurrentUser();
        _setCurrentHouseholdFromUser(user);
        state = AuthState.authenticated(user);
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

    // Only attempt silent sign-in if we don't already have a valid session.
    // Otherwise this triggers a redundant Google auth flow on every app restart.
    final hasToken = await _authRepository.hasStoredToken();
    if (!hasToken) {
      googleSignIn.attemptLightweightAuthentication();
    }
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
    } catch (e) {
      debugPrint('Error signing out: $e');
    }

    // Clear all cached data providers
    _invalidateAllProviders();
    state = const AuthState.unauthenticated();
  }

  /// Invalidate all keepAlive providers so no stale data remains after logout
  void _invalidateAllProviders() {
    ref.invalidate(currentHouseholdIdProvider);
    ref.invalidate(householdProvider);
    ref.invalidate(activeInviteProvider);
    ref.invalidate(authTokenProvider);
    ref.invalidate(boardsProvider);
    ref.invalidate(boardDetailProvider);
    ref.invalidate(tagsProvider);
    ref.invalidate(recipesProvider);
    ref.invalidate(recipeDetailProvider);
    ref.invalidate(seasonalVegetablesProvider);
    ref.invalidate(menuPlansProvider);
    ref.invalidate(upcomingMealsProvider);
    ref.invalidate(menuPlanDetailProvider);
    ref.invalidate(currentMenuPlanIdProvider);
    ref.invalidate(mealHistoryProvider);
    ref.invalidate(wishlistsProvider);
    ref.invalidate(purchaseHistoryProvider);
    ref.invalidate(expensesProvider);
    ref.invalidate(expenseSummaryProvider);
    ref.invalidate(recurringExpensesProvider);
    ref.invalidate(budgetProvider);
    ref.invalidate(expenseTrendsProvider);
    ref.invalidate(calendarProvider);
    ref.invalidate(timelineProvider);
    ref.invalidate(chatProvider);
    ref.invalidate(tasksProvider);
    ref.invalidate(activityFeedProvider);
    ref.invalidate(homeCardOrderProvider);
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
