import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nuestra_app/app.dart';

void main() {
  testWidgets('App renders login screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: App(),
      ),
    );

    // Wait for the app to settle
    await tester.pumpAndSettle();

    // Verify the app renders (login screen should show sign in options)
    expect(find.text('Household Hub'), findsOneWidget);
  });
}
