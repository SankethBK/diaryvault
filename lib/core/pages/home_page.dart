// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_read_only_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  static String get route => '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NotesFetchCubit notesFetchCubit;
  late final SelectableListCubit selectableListCubit;

  @override
  void initState() {
    notesFetchCubit = sl<NotesFetchCubit>();
    selectableListCubit = sl<SelectableListCubit>();
    super.initState();
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.pinkAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectableListCubit, SelectableListState>(
      bloc: selectableListCubit,
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          appBar: _GlassAppBar(context, selectableListCubit),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/digital-art-neon-bubbles.jpg",
                ),
                fit: BoxFit.cover,
                // alignment: Alignment(0.725, 0.1)
              ),
            ),
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top +
                  AppBar().preferredSize.height,
              left: 5.0,
              right: 5.0,
            ),
            // TODO: nested bloc builers, find a way to remove this
            child: BlocBuilder<NotesFetchCubit, NotesFetchState>(
              bloc: notesFetchCubit,
              builder: (context, state) {
                if (state is NotesFetchDummyState) {
                  notesFetchCubit.fetchNotes();
                  return Center(child: CircularProgressIndicator());
                } else if (state is NotesFetchSuccessful) {
                  return GlassMorphismCover(
                    borderRadius: BorderRadius.circular(0.0),
                    child: Container(
                      padding: const EdgeInsets.all(0.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.8),
                            Colors.white.withOpacity(0.6),
                          ],
                          begin: AlignmentDirectional.topStart,
                          end: AlignmentDirectional.bottomEnd,
                        ),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final note = state.notePreviewList[index];

                          return NotePreviewCard(
                              note: note,
                              selectableListCubit: selectableListCubit);
                        },
                        itemCount: state.notePreviewList.length,
                      ),
                    ),
                  );
                }

                return Container();
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(NoteCreatePage.routeThroughHome);
            },
          ),
        );
      },
    );
  }

  AppBar _GlassAppBar(
      BuildContext context, SelectableListCubit selectableListCubit) {
    if (selectableListCubit.state is SelectableListEnabled) {
      return AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            size: 25,
          ),
          onPressed: () {
            selectableListCubit.disableSelectableList();
          },
        ),
        actions: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: Text(
                  "${selectableListCubit.state.selectedItems.length}",
                  style: TextStyle(fontSize: 22.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                  ),
                  onPressed: () async {
                    if (selectableListCubit.state.selectedItems.isEmpty) {
                      selectableListCubit.disableSelectableList();
                      return;
                    }
                    int numberOfSelectedItems =
                        selectableListCubit.state.selectedItems.length;
                    bool? result = await showDialog<bool?>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                "You are about to delete ${selectableListCubit.state.selectedItems.length}  item${selectableListCubit.state.selectedItems.length > 1 ? "s" : ""}"),
                            actions: [
                              _CancelButton(),
                              _DeleteButton(
                                deleteCount: numberOfSelectedItems,
                                selectableListCubit: selectableListCubit,
                              ),
                            ],
                          );
                        });
                    selectableListCubit.disableSelectableList();

                    showToast("deletion failed");
                    if (result != null) {
                      if (result == true) {
                        showToast(
                            "$numberOfSelectedItems item${numberOfSelectedItems > 1 ? "s" : ""} deleted");
                      } else {
                        showToast("deletion failed");
                      }\
                    }
                  },
                ),
              ),
            ],
          )
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
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {},
      ),
      actions: [
        const Padding(
          padding: EdgeInsets.only(right: 13.0),
          child: Icon(Icons.search),
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
}

class _DeleteButton extends StatelessWidget {
  final int deleteCount;
  final SelectableListCubit selectableListCubit;
  const _DeleteButton(
      {Key? key, required this.deleteCount, required this.selectableListCubit})
      : super(key: key);

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.pinkAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        NotesBloc notesBloc = BlocProvider.of<NotesBloc>(context);
        if (state is NoteDeletionFailed) {
          notesBloc.add(RefreshNote());
          Navigator.pop(context, false);
        } else if (state is NoteDeletionSuccesful) {
          notesBloc.add(RefreshNote());
          Navigator.pop(context, true);
        }

        return ElevatedButton(
          onPressed: () {
            if (state is NoteDeleteLoading) {
              return;
            }
            if (state is NoteDummyState) {
              final notesBloc = BlocProvider.of<NotesBloc>(context);
              notesBloc.add(DeleteNote(
                  noteList: selectableListCubit.state.selectedItems));
            }
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
              color: Colors.white.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: const Text("Delete", style: TextStyle(color: Colors.white)),
        );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            if (state is NoteDeleteLoading) {
              return;
            }
            Navigator.pop(context, null);
          },
        );
      },
    );
  }
}
