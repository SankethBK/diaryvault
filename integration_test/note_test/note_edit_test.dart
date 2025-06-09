import 'package:dairy_app/features/notes/presentation/widgets/note_save_button.dart';
import 'package:dairy_app/features/notes/presentation/widgets/toggle_read_write_button.dart';
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

  testWidgets('Edit existing note and verify that changes are saved',
      (WidgetTester tester) async {
    await launchGuestSession(tester);

    await createTestNote(tester: tester, note: noteTitles.books);
    await createTestNote(tester: tester, note: noteTitles.groceries);
    await Future.delayed(const Duration(seconds: 2));

    await tester.tap(finders.groceries);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(ToggleReadWriteButton));
    await tester.pumpAndSettle();
    await tester.enterText(finders.titleField, '');
    await tester.enterText(finders.titleField, 'Picnic Items');
    await tester.tap(find.byType(NoteSaveButton));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    expect(finders.homePage, findsOneWidget);
    expect(find.text('Picnic Items'), findsOneWidget);
    expect(finders.groceries, findsNothing);
  });
}
