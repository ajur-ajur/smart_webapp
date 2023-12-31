// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:smart_webapp/src/screens/splash.dart';

void main() {
  testWidgets(
    'SplashScreen presence test',
    (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const SplashScreen());

      // Verify the presence of the SplashScreen widget.
      expect(find.byType(SplashScreen), findsOneWidget);

      // Wait for the timer to complete.
      await tester.pumpAndSettle(const Duration(seconds: 3));
    },
  );
}
