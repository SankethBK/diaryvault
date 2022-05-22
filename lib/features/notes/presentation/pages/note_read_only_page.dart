import 'package:dairy_app/core/pages/home_page.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/read_only_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class NotesReadOnlyPage extends StatelessWidget {
  // display open container animation
  static String get routeThroughHome => '/note-read-page-through-home';
  final String? id;

  // display fade transition animaiton
  static String get routeThoughNotesCreate =>
      '/note-read-page-though-note-create-page';

  const NotesReadOnlyPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesBloc = BlocProvider.of<NotesBloc>(context);
    if (notesBloc.state is NoteDummyState) {
      notesBloc.add(InitializeNote(id: id));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: GlassAppBar(context, notesBloc),
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
              _routeToHome(notesBloc, context);
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

  void _routeToHome(NotesBloc notesBloc, BuildContext context) {
    notesBloc.add(RefreshNote());
    Navigator.of(context).pop();
  }

  AppBar GlassAppBar(BuildContext context, NotesBloc bloc) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: BlocBuilder<NotesBloc, NotesState>(
        bloc: bloc,
        builder: (context, state) {
          // We want to show this button when notes in edited
          if (state.safe) {
            return IconButton(
              icon: const Icon(
                Icons.close,
                size: 25,
              ),
              onPressed: () async {
                bool? result = await showDialog<bool>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("You have unsaved changes"),
                        actions: [
                          TextButton(
                            child: const Text('LEAVE'),
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purple,
                              onPrimary: Colors.purple[200],
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              elevation: 4,
                              side: BorderSide(
                                color: Colors.black.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: const Text("STAY",
                                style: TextStyle(color: Colors.white)),
                          )
                        ],
                      );
                    });
                if (result != null && result == true) {
                  _routeToHome(bloc, context);
                }
              },
            );
          }
          return Container();
        },
      ),
      backgroundColor: Colors.transparent,
      actions: [
        BlocBuilder<NotesBloc, NotesState>(
          bloc: bloc,
          builder: (context, state) {
            if (state is NoteUpdatedState) {
              return Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () => bloc.add(SaveNote()),
                ),
              );
            }

            if (state is NoteSaveLoading) {
              return Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: IconButton(
                  icon: const SizedBox(
                    height: 25,
                    width: 25,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () => bloc.add(SaveNote()),
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
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
