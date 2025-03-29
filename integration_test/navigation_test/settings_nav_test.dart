import 'package:dairy_app/core/dependency_injection/injection_container.dart'
    as di;
import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/core/pages/settings_details.dart';
import 'package:dairy_app/core/widgets/settings_tile.dart';
import 'package:dairy_app/core/widgets/theme_dropdown.dart';
import 'package:dairy_app/features/auth/presentation/widgets/security_settings.dart';
import 'package:dairy_app/features/notes/presentation/widgets/daily_reminders.dart';
import 'package:dairy_app/features/notes/presentation/widgets/export_notes.dart';
import 'package:dairy_app/features/sync/presentation/widgets/sync_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test_helpers.dart';

Future<void> main() async {
  setUpAll(() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await di.init();
  });

  testWidgets('Navigate to settings', (WidgetTester tester) async {
    await launchGuestSession(tester);
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();

    expect(finders.settingsPage, findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(find.byIcon(Icons.power_settings_new_rounded));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.descendant(
        of: find.byType(Container),
        matching: find.text('Are you sure about logging out?')),
        findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(finders.settingsPage, findsOneWidget);
    await tester.tap(find.text('Setup your Account'));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.descendant(
        of: find.byType(SettingsTile),
        matching: find.text('Setup your Account')),
        findsOneWidget);
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    expect(finders.settingsPage, findsOneWidget);
    await tester.tap(find.text('Cloud Backup'));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.descendant(
        of: find.byType(SettingsDetailPage),
        matching: find.byType(SyncSettings)),
        findsOneWidget);
    await tester.tap(finders.backButton);
    await tester.pumpAndSettle();

    expect(finders.settingsPage, findsOneWidget);
    await tester.tap(find.text('Security'));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.descendant(
        of: find.byType(SettingsDetailPage),
        matching: find.byType(SecuritySettings)),
        findsOneWidget);
    await tester.tap(finders.backButton);
    await tester.pumpAndSettle();

    expect(finders.settingsPage, findsOneWidget);
    await tester.tap(find.text('Reminders'));
    await tester.pumpAndSettle();
    expect(find.descendant(
        of: find.byType(SettingsDetailPage),
        matching: find.byType(DailyReminders)),
        findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(finders.backButton);
    await tester.pumpAndSettle();

    expect(finders.settingsPage, findsOneWidget);
    await tester.tap(find.text('Customize Theme, Fonts and Language'));
    await tester.pumpAndSettle();
    expect(find.descendant(
        of: find.byType(SettingsDetailPage),
        matching: find.byType(ThemeDropdown)),
        findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(finders.backButton);
    await tester.pumpAndSettle();

    expect(finders.settingsPage, findsOneWidget);
    await tester.tap(find.text('Import and Export Notes'));
    await tester.pumpAndSettle();
    expect(find.descendant(
        of: find.byType(SettingsDetailPage),
        matching: find.byType(ExportNotes)),
        findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(finders.backButton);
    await tester.pumpAndSettle();

    expect(finders.settingsPage, findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(finders.backButton);
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));
  });
}
