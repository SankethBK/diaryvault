import 'package:dairy_app/core/pages/settings_page.dart';
import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart'
    as di;

import '../test_helpers.dart';

Future<void> main() async {
  setUpAll(() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await di.init();
  });

  testWidgets('Perform a successful guest login/logout', (WidgetTester tester) async {
    await launchGuestSession(tester);

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.power_settings_new_rounded));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));
    /**Waiting for quotes to load**/
    await tester.pumpAndSettle();

    expect(find.byType(AuthPage), findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));
  });
}
