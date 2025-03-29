import 'dart:core';

import 'package:dairy_app/app/view/app.dart';
import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/core/pages/settings_details.dart';
import 'package:dairy_app/core/pages/settings_page.dart';
import 'package:dairy_app/core/pages/welcome_page.dart';
import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_save_button.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_title_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const noteTitles = (
  groceries: 'Groceries needed for family picnic ',
  books: 'Books I finished reading this year'
);

final finders = (
  groceries: find.text(noteTitles.groceries),
  books: find.text(noteTitles.books),
  titleField: find.byType(NoteTitleInputField),
  homePage: find.byType(HomePage),
  settingsPage: find.byType(SettingsPage),
  detailsPage: find.byType(SettingsDetailPage),
  dropDownButton: find.byIcon(Icons.keyboard_arrow_down),
  backButton: find.byIcon(Icons.arrow_back),
);

Future<void> launchGuestSession(WidgetTester tester) async {
  await tester.pumpWidget(const App());
  await tester.pumpAndSettle();
  expect(find.byType(WelcomePage), findsOneWidget);
  await Future.delayed(const Duration(seconds: 2));
  /**Waiting for "mounted" in initState() of WelcomePage**/

  await tester.pumpAndSettle();
  expect(find.byType(AuthPage), findsOneWidget);
  await Future.delayed(const Duration(seconds: 1));
  await tester.tap(find.text('Continue as guest'));
  await tester.pumpAndSettle();
  expect(finders.homePage, findsOneWidget);
  await tester.pumpAndSettle();
  await Future.delayed(const Duration(seconds: 1));
}

Future<void> createTestNote(
    {required WidgetTester tester, required String note}) async {
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
  expect(find.byType(NoteCreatePage), findsOneWidget);
  await tester.enterText(finders.titleField, note);
  await tester.tap(find.byType(NoteSaveButton));
  await tester.pumpAndSettle();

  expect(finders.homePage, findsOneWidget);
  expect(find.text(note), findsOneWidget);
}
