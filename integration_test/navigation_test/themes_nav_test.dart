import 'package:dairy_app/core/dependency_injection/injection_container.dart'
    as di;
import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/core/pages/settings_page.dart';
import 'package:dairy_app/core/widgets/font_dropdown.dart';
import 'package:dairy_app/core/widgets/language_dropdown.dart';
import 'package:dairy_app/core/widgets/theme_dropdown.dart';
import 'package:dairy_app/core/widgets/voice_dropdown.dart';
import 'package:dairy_app/features/auth/presentation/bloc/font/font_cubit.dart';
import 'package:dairy_app/features/auth/presentation/bloc/theme/theme_cubit.dart';
import 'package:dairy_app/features/notes/presentation/widgets/toolbar_position_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test_helpers.dart';

void main() {
  setUpAll(() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await di.init();
  });

  testWidgets('Navigate through theme settings', (WidgetTester tester) async {
    await launchGuestSession(tester);
    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));

    expect(finders.settingsPage, findsOneWidget);
    await tester.tap(find.text('Customize Theme, Fonts and Language'));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));

    expect(
        find.descendant(
            of: finders.detailsPage, matching: find.byType(ThemeDropdown)),
        findsOneWidget);
    await tester.tap(find.descendant(
        of: find.byType(ThemeDropdown), matching: finders.dropDownButton));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.byType(PopupMenuItem<Themes>), findsAtLeastNWidgets(5));
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    await tester.tap(find.descendant(
        of: find.byType(FontDropdown), matching: finders.dropDownButton));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.byType(PopupMenuItem<FontFamily>), findsAtLeastNWidgets(5));
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    await tester.tap(find.descendant(
        of: find.byType(LanguageDropDown), matching: finders.dropDownButton));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.byType(PopupMenuItem<Locale>), findsAtLeastNWidgets(10));
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    await tester.tap(find.descendant(
        of: find.byType(VoiceDropdown), matching: finders.dropDownButton));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.byType(PopupMenuItem<Map>), findsAtLeastNWidgets(10));
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    await tester.tap(find.descendant(
        of: find.byType(ToolbarPositionDropdown),
        matching: finders.dropDownButton));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.byType(PopupMenuItem<String>), findsAtLeastNWidgets(2));
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));

    await tester.tap(finders.backButton);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.byType(SettingsPage), findsOneWidget);
    await tester.tap(finders.backButton);
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));
  });
}
