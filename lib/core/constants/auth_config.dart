/// Authentication configuration
///
/// To configure Google Sign-In:
/// 1. Go to Google Cloud Console (https://console.cloud.google.com)
/// 2. Create or select a project
/// 3. Go to APIs & Services > Credentials
/// 4. Create OAuth 2.0 Client IDs:
///    - Web application (for serverClientId - used by backend)
///    - Android (with your SHA-1 fingerprint)
/// 5. Replace the values below with your actual client IDs
///
/// To get your debug SHA-1 fingerprint, run:
/// cd android && ./gradlew signingReport
///
/// Or on Windows:
/// cd android && gradlew signingReport
class AuthConfig {
  AuthConfig._();

  /// Web Client ID from Google Cloud Console
  /// This is used as serverClientId to get the idToken
  /// The backend validates this token against the same client ID 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A
  static const String googleWebClientId =
      '257947572060-228libdsee14cj2k9sh04cne69a9cv95.apps.googleusercontent.com';

  /// Android Client ID from Google Cloud Console (optional, for reference)
  /// The Android SDK uses the SHA-1 fingerprint registered in the console
  static const String googleAndroidClientId =
      '257947572060-2verf6peli4vcsiph1dsoin9t1c7fa44.apps.googleusercontent.com';

  /// iOS Client ID from Google Cloud Console
  static const String googleIOSClientId =
      'YOUR_IOS_CLIENT_ID.apps.googleusercontent.com';
}
