import 'package:dairy_app/features/auth/presentation/widgets/glass_form_cover.dart';
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
            GlassFormCover(
              borderRadius: BorderRadius.circular(10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "title",
                  // prefixIcon: Icon(
                  //   Icons.email,
                  //   color: Colors.black.withOpacity(0.5),
                  // ),
                  fillColor: Colors.white.withOpacity(0.7),
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(0.6),
                      width: 1,
                    ),
                  ),
                  // errorText: getEmailErrors(),
                  errorStyle: TextStyle(
                    color: Colors.pink[200],
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none),
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                // onChanged: onEmailChanged,
              ),
            ),
            const SizedBox(height: 10),
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
