import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/core/pages/welcome_page.dart';
import 'package:dairy_app/core/widgets/home_page_app_bar.dart';
import 'package:dairy_app/features/auth/presentation/pages/auth_page.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_save_button.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_title_input_field.dart';
import 'package:dairy_app/app/view/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart'
    as di;

Future<void> main() async {
  setUpAll(() async {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    await di.init();
  });

  testWidgets(
      'Run login and create note'
      'long press the note'
      'delete the note and check if the note is deleted',
      (WidgetTester tester) async {
    await tester.pumpWidget(const App());
    await tester.pumpAndSettle();

    expect(find.byType(WelcomePage), findsOneWidget);
    await Future.delayed(const Duration(seconds: 2)); /**Waiting if(mounted) of initState() in WelcomePage**/
    await tester.pumpAndSettle();
    expect(find.byType(AuthPage), findsOneWidget);

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
}
