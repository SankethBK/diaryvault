import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/core/widgets/home_page_app_bar.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_save_button.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_title_input_field.dart';
import 'package:dairy_app/app/view/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dairy_app/features/notes/presentation/widgets/toggle_read_write_button.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart'
    as di;



void main() {
  group('Note crud tests', () {
    setUp(() async {
      IntegrationTestWidgetsFlutterBinding.ensureInitialized();
      await dotenv.load();
      await di.init();
    });
    testWidgets('Guest Login and create Note', (WidgetTester tester) async {
      // Your test case code here
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

      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(NoteCreatePage), findsNothing);
    });


    testWidgets('Update Note', (WidgetTester tester) async {

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

      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(NoteCreatePage), findsNothing);
      await tester.tap(find.text('Test Title'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(ToggleReadWriteButton));
      await tester.pumpAndSettle();
      await tester.enterText(
          find.byType(NoteTitleInputField), 'Test Title Updated');
      await tester.pumpAndSettle();
      await tester.tap(find.byType(NoteSaveButton));
      await tester.pumpAndSettle();

      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Test Title'), findsNothing);
      expect(find.text('Test Title Updated'), findsOneWidget);
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(NoteCreatePage), findsNothing);
    });

    testWidgets('Delete Note', (WidgetTester tester) async {
      Your test case code here
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

      await Future.delayed(const Duration(seconds: 1));
      await tester.pumpAndSettle();
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.byType(HomePage), findsOneWidget);
      expect(find.byType(NoteCreatePage), findsNothing);
      await tester.longPress(find.text('Test Title'));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(DeleteIcon));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete'));
      await Future.delayed(const Duration(seconds: 1));
      expect(find.text('Test Title'), findsNothing);
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
