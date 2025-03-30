import 'package:dairy_app/core/dependency_injection/injection_container.dart'
as di;
import 'package:dairy_app/core/widgets/home_page_app_bar.dart';
import 'package:dairy_app/features/auth/data/models/user_config_model.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
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

  testWidgets('Navigate through homepage', (WidgetTester tester) async {
    await launchGuestSession(tester);

    await tester.tap(find.byIcon(Icons.settings));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(finders.settingsPage, findsOneWidget);
    await tester.tap(finders.backButton);
    await tester.pumpAndSettle();

    expect(finders.homePage, findsOneWidget);
    await tester.tap(find.byIcon(Icons.search));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(
        find.descendant(
            of: find.byType(HomePageAppBar),
            matching: find.byType(TextField)),
        findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));

    await tester
        .tap(find.widgetWithIcon(PopupMenuButton<NoteSortType>, Icons.sort));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.byType(PopupMenuItem<NoteSortType>), findsAtLeastNWidgets(3));
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.byType(NoteCreatePage), findsOneWidget);
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    expect(find.text('You have unsaved changes'), findsOneWidget);
    await tester.tap(find.text('Leave'));
    await tester.pumpAndSettle();

    expect(finders.homePage, findsOneWidget);
    await Future.delayed(const Duration(seconds: 1));
  });
}