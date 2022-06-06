import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_save_button.dart';
import 'package:dairy_app/features/notes/presentation/widgets/read_only_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../widgets/notes_close_button.dart';

class NotesReadOnlyPage extends StatefulWidget {
  // display open container animation
  static String get routeThroughHome => '/note-read-page-through-home';
  final String? id;

  // display fade transition animaiton
  static String get routeThoughNotesCreate =>
      '/note-read-page-though-note-create-page';

  const NotesReadOnlyPage({Key? key, required this.id}) : super(key: key);

  @override
  State<NotesReadOnlyPage> createState() => _NotesReadOnlyPageState();
}

class _NotesReadOnlyPageState extends State<NotesReadOnlyPage> {
  late bool _isInitialized = false;
  late final NotesBloc notesBloc;

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      notesBloc = BlocProvider.of<NotesBloc>(context);
      if (notesBloc.state is NoteDummyState) {
        notesBloc.add(InitializeNote(id: widget.id));
      }

      _isInitialized = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final notesBloc = BlocProvider.of<NotesBloc>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: glassAppBar(),
      body: Container(
        padding: EdgeInsets.only(
            top: AppBar().preferredSize.height +
                MediaQuery.of(context).padding.top +
                10.0,
            left: 10.0,
            right: 10.0,
            bottom: 10.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assets/images/digital-art-neon-bubbles.jpg",
              ),
              fit: BoxFit.cover,
              alignment: Alignment(0.725, 0.1)),
        ),
        child: BlocListener<NotesBloc, NotesState>(
          bloc: notesBloc,
          listener: (context, state) {
            if (state is NoteFetchFailed) {
              _showToast("feiled to fetch note");
            } else if (state is NotesSavingFailed) {
              _showToast("Failed to save note");
            } else if (state is NoteSavedSuccesfully) {
              _showToast(state.newNote!
                  ? "Note saved successfully"
                  : "Note updated successfully");
              _routeToHome();
            }
          },
          child: GlassMorphismCover(
            displayShadow: false,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 10, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.7),
                    Colors.white.withOpacity(0.5),
                  ],
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                ),
              ),
              child: BlocBuilder<NotesBloc, NotesState>(
                bloc: notesBloc,
                builder: (context, state) {
                  if (state.safe) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(notesBloc.state.title!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0)),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat.yMMMEd()
                                  .format(notesBloc.state.createdAt!),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 103, 101, 101),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text(
                              DateFormat.jm()
                                  .format(notesBloc.state.createdAt!),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 103, 101, 101),
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ReadOnlyEditor(controller: notesBloc.state.controller)
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _routeToHome() {
    notesBloc.add(RefreshNote());
    Navigator.of(context).pop();
  }

  AppBar glassAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: BlocBuilder<NotesBloc, NotesState>(
        bloc: notesBloc,
        builder: (context, state) {
          // We want to show this button only after notes is initialized

          if (state.safe) {
            return NotesCloseButton(onNotesClosed: _routeToHome);
          }
          return Container();
        },
      ),
      backgroundColor: Colors.transparent,
      actions: [
        const NoteSaveButton(),
        Padding(
          padding: const EdgeInsets.only(right: 13.0),
          child: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.of(context)
                .popAndPushNamed(NoteCreatePage.routeThroughNoteReadOnly),
          ),
        ),
      ],
      flexibleSpace: GlassMorphismCover(
        borderRadius: BorderRadius.circular(0.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.2),
              ],
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.pinkAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

//  [{"insert":"Hett\n"},{"insert":{"image":"/data/user/0/com.example.dairy_app/app_flutter/image_picker6900039974025442164.jpg"}},{"insert":"\n"}]

//  [{"insert":"Fgt\n"},{"insert":{"image":"/data/user/0/com.example.dairy_app/app_flutter/image_picker8779980758292679059.jpg"}},{"insert":"\n"}]

/*
[{insert: Dndn}, {insert: dndnd, attributes: {underline: true}}, {insert: dndnd, attributes: {underline: true, italic: true}}, {insert: dndnd, attributes: {underline: true, italic: true, bold: true}}, {insert: 
DD}, {insert: dd, attributes: {bold: true}}, {insert: dnnd, attributes: {italic: true}}, {insert: 


}]

*/