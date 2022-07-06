import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_app_bar.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_save_button.dart';
import 'package:dairy_app/features/notes/presentation/widgets/read_only_editor.dart';
import 'package:dairy_app/features/notes/presentation/widgets/show_notes_close_dialog.dart';
import 'package:dairy_app/features/notes/presentation/widgets/toggle_read_write_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late Image neonImage;

  @override
  void initState() {
    super.initState();
    neonImage = Image.asset("assets/images/digital-art-neon-bubbles.jpg");
  }

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      notesBloc = BlocProvider.of<NotesBloc>(context);
      if (notesBloc.state is NoteDummyState) {
        notesBloc.add(InitializeNote(id: widget.id));
      }
      precacheImage(neonImage.image, context);

      _isInitialized = true;
    }
    _isInitialized = true;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final notesBloc = BlocProvider.of<NotesBloc>(context);

    return WillPopScope(
      onWillPop: () async {
        bool? result = await showCloseDialog(context);

        if (result == true) {
          notesBloc.add(RefreshNote());
          return true;
        }
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: GlassAppBar(
          automaticallyImplyLeading: false,
          actions: const [
            NoteSaveButton(),
            ToggleReadWriteButton(pageName: PageName.NoteReadOnlyPage)
          ],
          leading: NotesCloseButton(onNotesClosed: _routeToHome),
        ),
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
                showToast("feiled to fetch note");
              } else if (state is NotesSavingFailed) {
                showToast("Failed to save note");
              } else if (state is NoteSavedSuccesfully) {
                showToast(state.newNote!
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
                    left: 10, right: 10, top: 0, bottom: 5),
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
                      return ListView(
                        padding: const EdgeInsets.only(top: 10),
                        children: [
                          Text(notesBloc.state.title!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20.0)),
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
                          ReadOnlyEditor(
                            controller: notesBloc.state.controller,
                          )
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
      ),
    );
  }

  void _routeToHome() {
    notesBloc.add(RefreshNote());
    Navigator.of(context).pop();
  }
}
