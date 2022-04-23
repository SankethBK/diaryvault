// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:zefyrka/zefyrka.dart';

class RichTextEditor extends StatelessWidget {
  RichTextEditor({Key? key}) : super(key: key);

  HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return HtmlEditor(
      controller: controller, //required
      htmlEditorOptions: const HtmlEditorOptions(
        hint: "Your text here...",
        //initalText: "text content initial, if any",
      ),

      htmlToolbarOptions: HtmlToolbarOptions(
        defaultToolbarButtons: [
          // StyleButtons(),
          // FontSettingButtons(),
          FontButtons(
            bold: true,
            italic: true,
            underline: true,
            clearAll: false,
            strikethrough: false,
            subscript: false,
            superscript: false,
          ),
          // ColorButtons(),
          // ListButtons(),
          // ParagraphButtons(),
          InsertButtons(
            picture: true,
            video: true,
            link: true,
            hr: true,
            audio: false,
            otherFile: false,
          ),
          OtherButtons(),
        ],
        customToolbarButtons: [
          //your widgets here
          // Button1(),
          // Button2(),
        ],
        // customToolbarInsertionIndices: [2, 5],
      ),
    );
  }
}
