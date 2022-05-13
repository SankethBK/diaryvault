import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/notes/presentation/widgets/date_input_field.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_title_input_field.dart';
import 'package:dairy_app/features/notes/presentation/widgets/rich_text_editor.dart';
import 'package:dairy_app/features/notes/presentation/widgets/time_input_field.dart';
import 'package:flutter/material.dart';

import '../widgets/note_create_title.dart';

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
    // print(MediaQuery.of(context).viewInsets.bottom);
    return Scaffold(
      // backgroundColor: Colors.pinkAccent,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("My Dairy"),
      ),
      body: Container(
        // height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          // color: Colors.red,r
          image: DecorationImage(
            image: AssetImage(
              "assets/images/digital-art-neon-bubbles.jpg",
            ),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.only(
          top: 15.0,
          left: 10.0,
          right: 10.0,
          // bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            GlassMorphismCover(
              borderRadius: BorderRadius.circular(10.0),
              child: NoteCreateTitle(),
            ),
            const SizedBox(height: 10),
            RichTextEditor(),
            SizedBox(
              height: MediaQuery.of(context).viewInsets.bottom,
            )
          ],
        ),
      ),
    );
  }
}
