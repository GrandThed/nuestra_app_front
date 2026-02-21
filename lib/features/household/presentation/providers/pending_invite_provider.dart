import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pending_invite_provider.g.dart';

/// Stores a pending invite code when user needs to log in first.
///
/// Used in the web invitation flow:
/// 1. User opens invite link without being logged in
/// 2. User clicks "Sign in" on join screen
/// 3. Invite code is stored here before navigating to login
/// 4. After login, code is retrieved and user is navigated back to join screen
/// 5. Code is cleared after use
@Riverpod(keepAlive: true)
class PendingInviteCodeNotifier extends _$PendingInviteCodeNotifier {
  @override
  String? build() => null;

  void set(String? code) => state = code;
}
