import 'package:dairy_app/features/notes/core/utils/todo_delta_parser.dart';
import 'package:dairy_app/features/notes/presentation/widgets/todo_reminder_embed_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<QuillController> pumpEditor(WidgetTester tester) async {
    final doc = Document()..insert(0, 'buy groceries');
    final controller = QuillController(
        document: doc, selection: const TextSelection.collapsed(offset: 13));

    // mark the line as an unchecked todo (format includes trailing newline)
    controller.formatText(0, 14, Attribute.unchecked);

    // insert the reminder chip before the trailing newline
    final embed = BlockEmbed.custom(CustomBlockEmbed(
        kTodoReminderEmbedType,
        encodeTodoReminderData(
            id: 'rem-1',
            time: DateTime.now().millisecondsSinceEpoch + 60000)));
    controller.replaceText(13, 0, embed,
        const TextSelection.collapsed(offset: 14));

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: QuillEditor(
          controller: controller,
          scrollController: ScrollController(),
          scrollable: true,
          focusNode: FocusNode(),
          autoFocus: false,
          readOnly: false,
          padding: EdgeInsets.zero,
          expands: false,
          embedBuilders: [TodoReminderEmbedBuilder()],
        ),
      ),
    ));
    return controller;
  }

  testWidgets('typing at the end of a todo line with a reminder chip '
      '(controller-driven)', (tester) async {
    final controller = await pumpEditor(tester);
    for (var i = 0; i < 8; i++) {
      final offset = 14 + i;
      controller.replaceText(offset, 0, 'x',
          TextSelection.collapsed(offset: offset + 1));
      await tester.pump();
    }
  });

  testWidgets('typing at the end of a todo line with a reminder chip '
      '(IME-driven)', (tester) async {
    await pumpEditor(tester);

    // tap the editor to open the IME connection
    await tester.tap(find.byType(QuillEditor));
    await tester.pumpAndSettle();

    expect(tester.testTextInput.hasAnyClients, isTrue,
        reason: 'editor should have an active text input connection');

    // document text as seen by the IME: text + chip (\uFFFC) + newline;
    // caret sits right after the chip, before the newline
    const chip = '￼';
    var current = 'buy groceries$chip\n';
    var caret = 14;

    for (var i = 0; i < 8; i++) {
      current = current.substring(0, caret) + 'x' + current.substring(caret);
      caret += 1;
      tester.testTextInput.updateEditingValue(TextEditingValue(
        text: current,
        selection: TextSelection.collapsed(offset: caret),
      ));
      await tester.pump();
    }
  });

  testWidgets('typing in the middle of a todo line with a trailing '
      'reminder chip (IME-driven)', (tester) async {
    await pumpEditor(tester);

    await tester.tap(find.byType(QuillEditor));
    await tester.pumpAndSettle();

    const chip = '￼';
    var current = 'buy groceries$chip\n';
    var caret = 4; // inside "buy groceries", before the chip

    for (var i = 0; i < 8; i++) {
      current = current.substring(0, caret) + 'x' + current.substring(caret);
      caret += 1;
      tester.testTextInput.updateEditingValue(TextEditingValue(
        text: current,
        selection: TextSelection.collapsed(offset: caret),
      ));
      await tester.pump();
    }
  });

  testWidgets('typing on another line while a reminder chip exists '
      '(IME-driven)', (tester) async {
    final doc = Document()..insert(0, 'hello world\nbuy groceries\n');
    final controller = QuillController(
        document: doc, selection: const TextSelection.collapsed(offset: 0));
    controller.formatText(12, 14, Attribute.unchecked);

    final embed = BlockEmbed.custom(CustomBlockEmbed(
        kTodoReminderEmbedType,
        encodeTodoReminderData(
            id: 'rem-1',
            time: DateTime.now().millisecondsSinceEpoch + 60000)));
    controller.replaceText(25, 0, embed,
        const TextSelection.collapsed(offset: 26));

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: QuillEditor(
          controller: controller,
          scrollController: ScrollController(),
          scrollable: true,
          focusNode: FocusNode(),
          autoFocus: false,
          readOnly: false,
          padding: EdgeInsets.zero,
          expands: false,
          embedBuilders: [TodoReminderEmbedBuilder()],
        ),
      ),
    ));

    await tester.tap(find.byType(QuillEditor));
    await tester.pumpAndSettle();

    const chip = '￼';
    var current = 'hello world\nbuy groceries$chip\n';
    var caret = 5; // on the first line, far from the chip

    for (var i = 0; i < 8; i++) {
      current = current.substring(0, caret) + 'x' + current.substring(caret);
      caret += 1;
      tester.testTextInput.updateEditingValue(TextEditingValue(
        text: current,
        selection: TextSelection.collapsed(offset: caret),
      ));
      await tester.pump();
    }
  });
}
