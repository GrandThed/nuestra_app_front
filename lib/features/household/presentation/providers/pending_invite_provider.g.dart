// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pending_invite_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Stores a pending invite code when user needs to log in first.
///
/// Used in the web invitation flow:
/// 1. User opens invite link without being logged in
/// 2. User clicks "Sign in" on join screen
/// 3. Invite code is stored here before navigating to login
/// 4. After login, code is retrieved and user is navigated back to join screen
/// 5. Code is cleared after use

@ProviderFor(PendingInviteCodeNotifier)
final pendingInviteCodeProvider = PendingInviteCodeNotifierProvider._();

/// Stores a pending invite code when user needs to log in first.
///
/// Used in the web invitation flow:
/// 1. User opens invite link without being logged in
/// 2. User clicks "Sign in" on join screen
/// 3. Invite code is stored here before navigating to login
/// 4. After login, code is retrieved and user is navigated back to join screen
/// 5. Code is cleared after use
final class PendingInviteCodeNotifierProvider
    extends $NotifierProvider<PendingInviteCodeNotifier, String?> {
  /// Stores a pending invite code when user needs to log in first.
  ///
  /// Used in the web invitation flow:
  /// 1. User opens invite link without being logged in
  /// 2. User clicks "Sign in" on join screen
  /// 3. Invite code is stored here before navigating to login
  /// 4. After login, code is retrieved and user is navigated back to join screen
  /// 5. Code is cleared after use
  PendingInviteCodeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingInviteCodeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingInviteCodeNotifierHash();

  @$internal
  @override
  PendingInviteCodeNotifier create() => PendingInviteCodeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$pendingInviteCodeNotifierHash() =>
    r'c22005621184f372affa3d5aaa8c0a426ef54ea5';

/// Stores a pending invite code when user needs to log in first.
///
/// Used in the web invitation flow:
/// 1. User opens invite link without being logged in
/// 2. User clicks "Sign in" on join screen
/// 3. Invite code is stored here before navigating to login
/// 4. After login, code is retrieved and user is navigated back to join screen
/// 5. Code is cleared after use

abstract class _$PendingInviteCodeNotifier extends $Notifier<String?> {
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
