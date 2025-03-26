import 'package:dairy_app/core/widgets/home_page_app_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart'
    as di;

import 'test_helpers.dart';

Future<void> main() async {
  setUpAll(() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await di.init();
  });

  testWidgets('Delete a note and verify that it no longer exists',
      (WidgetTester tester) async {
    await launchGuestSession(tester);

    await createTestNote(tester: tester, note: noteTitles.groceries);
    await createTestNote(tester: tester, note: noteTitles.books);
    await Future.delayed(const Duration(seconds: 2));

    await tester.longPress(finders.groceries);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DeleteIcon));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 2));

    expect(finders.homePage, findsOneWidget);
    expect(finders.books, findsOneWidget);
    expect(finders.groceries, findsNothing);
  });
}
