import 'package:dairy_app/features/notes/presentation/widgets/note_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart'
    as di;

import '../test_helpers.dart';

void main() {
  setUpAll(() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await di.init();
  });

  testWidgets('Sort notes and verify the correct order',
      (WidgetTester tester) async {
    await launchGuestSession(tester);

    await createTestNote(tester: tester, note: noteTitles.books);
    await createTestNote(tester: tester, note: noteTitles.groceries);
    await Future.delayed(const Duration(seconds: 1));
    expect(finders.books, findsOneWidget);
    expect(finders.groceries, findsOneWidget);

    final noteCardFinder = find.descendant(
        of: find.byType(NotePreviewCard),
        matching: find.byType(Text))
        .evaluate();

    await tester.tap(finders.sortIcon);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(find.text('Sort by Oldest First'));
    await tester.pumpAndSettle();
    assert((noteCardFinder.first.widget as Text).data
        == 'Welcome to DiaryVault');

    await tester.tap(finders.sortIcon);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(find.text('Sort by A-Z'));
    await tester.pumpAndSettle();
    assert((noteCardFinder.first.widget as Text).data
        == noteTitles.books);

    await tester.tap(finders.sortIcon);
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(find.text('Sort by Latest First'));
    await tester.pumpAndSettle();
    assert((noteCardFinder.first.widget as Text).data
        == noteTitles.groceries);

    //debugPrint('Current top note: ${(noteCardFinder.first.widget as Text).data}');
  });
}

