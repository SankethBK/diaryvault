import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_save_button.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_title_input_field.dart';
import 'package:dairy_app/app/view/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart'
    as di;

Future<void> main() async {
  setUpAll(() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
    await di.init();
  });

  testWidgets(
      'Guest login integration test,'
      'click on sign up button to move reveal guest login button'
      'click the guest login button to enter HomePage'
      'Click on the floating action button to move to NoteCreatePage'
      'Enter some text in the title field'
      'Enter some text in the body field'
      'Click on the save button to save the note'
      'Click on the back button to move back to HomePage'
      'Check if the note is saved in the HomePage',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue as guest'));
    await tester.pumpAndSettle();
    expect(find.byType(HomePage), findsOneWidget);
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(NoteTitleInputField), 'Test Title');
    await tester.pumpAndSettle();

    expect(find.byType(QuillEditor), findsOneWidget);

    expect(
        find.descendant(
          of: find.byType(QuillEditor),
          matching: find.byType(TextFieldTapRegion),
        ),
        findsOneWidget);

    await tester.tap(find.byType(NoteSaveButton));
    await tester.pumpAndSettle();

    await Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();
    expect(find.text('Test Title'), findsOneWidget);
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.byType(NoteCreatePage), findsNothing);
  });
}
