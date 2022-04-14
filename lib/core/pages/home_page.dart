import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class HomePage extends StatelessWidget {
  static String get route => '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    quill.QuillController _controller = quill.QuillController.basic();

    return Scaffold(
      appBar: AppBar(title: Text("Dairy")),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(NoteCreatePage.route);
        },
      ),
    );
  }
}
