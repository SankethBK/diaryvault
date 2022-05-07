import 'package:dairy_app/features/notes/presentation/widgets/date_input_field.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_title_input_field.dart';
import 'package:dairy_app/features/notes/presentation/widgets/rich_text_editor.dart';
import 'package:dairy_app/features/notes/presentation/widgets/time_input_field.dart';
import 'package:flutter/material.dart';

class NoteCreatePage extends StatefulWidget {
  static String get route => '/note-create';

  const NoteCreatePage({Key? key}) : super(key: key);

  @override
  State<NoteCreatePage> createState() => _NoteCreatePageState();
}

class _NoteCreatePageState extends State<NoteCreatePage> {
  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.height);
    print(MediaQuery.of(context).viewInsets.bottom);
    return Scaffold(
      // backgroundColor: Colors.pinkAccent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("My Dairy"),
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        // color: Colors.red,
        padding: EdgeInsets.only(
          top: 15.0,
          left: 10.0,
          right: 10.0,
          // bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              NoteTitleInputField(),
              // const SizedBox(height: 10),
              // Row(
              //   children: const [
              //     Flexible(
              //       flex: 4,
              //       child: DateInputField(),
              //     ),
              //     SizedBox(width: 7),
              //     Flexible(
              //       flex: 3,
              //       child: TimeInputField(),
              //     )
              //   ],
              // ),
              // const SizedBox(height: 10),
              RichTextEditor2(),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }
}
