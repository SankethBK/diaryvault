// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/glass_app_bar.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/utils.dart';

class HomePage extends StatefulWidget {
  static String get route => '/';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isInitialized = false;
  late final NotesFetchCubit notesFetchCubit;
  late final SelectableListCubit selectableListCubit;

  @override
  void initState() {
    notesFetchCubit = sl<NotesFetchCubit>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      selectableListCubit = BlocProvider.of<SelectableListCubit>(context);
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectableListCubit, SelectableListState>(
      bloc: selectableListCubit,
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          appBar: glassAppBar(context, selectableListCubit),
          body: Container(
            decoration: const BoxDecoration(
              // color: Colors.black,
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
                        border: Border.all(width: 1.0, color: Colors.white),
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
                              first: index == 0,
                              last: index == state.notePreviewList.length - 1,
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

  GlassAppBar glassAppBar(
      BuildContext context, SelectableListCubit selectableListCubit) {
    if (selectableListCubit.state is SelectableListEnabled) {
      return notesDeletionAppBar(selectableListCubit);
    }
    return homePageAppBar();
  }

  GlassAppBar homePageAppBar() {
    return GlassAppBar(
      automaticallyImplyLeading: false,
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
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final int deleteCount;
  late SelectableListCubit selectableListCubit;
  _DeleteButton({Key? key, required this.deleteCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    selectableListCubit = BlocProvider.of<SelectableListCubit>(context);
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

GlassAppBar notesDeletionAppBar(SelectableListCubit selectableListCubit) {
  return GlassAppBar(
    automaticallyImplyLeading: false,
    leading: CancelDeletion(
        onDeletionCancelled: () => selectableListCubit.disableSelectableList()),
    actions: [
      Row(
        children: [
          DeletionCount(
            deletionCount: selectableListCubit.state.selectedItems.length,
          ),
          DeleteIcon(
            deletionCount: selectableListCubit.state.selectedItems.length,
            disableSelectedList: selectableListCubit.disableSelectableList,
          ),
        ],
      )
    ],
  );
}

class DeleteIcon extends StatelessWidget {
  final int deletionCount;
  final Function() disableSelectedList;

  const DeleteIcon(
      {Key? key,
      required this.deletionCount,
      required this.disableSelectedList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 13.0),
      child: IconButton(
        icon: Icon(
          Icons.delete,
        ),
        onPressed: () async {
          if (deletionCount == 0) {
            disableSelectedList();
            return;
          }

          bool? result = await showDialog<bool?>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                      "You are about to delete $deletionCount  item${deletionCount > 1 ? "s" : ""}"),
                  actions: [
                    _CancelButton(),
                    _DeleteButton(
                      deleteCount: deletionCount,
                    ),
                  ],
                );
              });
          disableSelectedList();

          if (result != null) {
            if (result == true) {
              showToast(
                  "$deletionCount item${deletionCount > 1 ? "s" : ""} deleted");
            } else {
              showToast("deletion failed");
            }
          }
        },
      ),
    );
  }
}

class DeletionCount extends StatelessWidget {
  final int deletionCount;
  const DeletionCount({Key? key, required this.deletionCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 13.0),
      child: Text(
        "$deletionCount",
        style: TextStyle(fontSize: 22.0),
      ),
    );
  }
}

class CancelDeletion extends StatelessWidget {
  const CancelDeletion({
    Key? key,
    required this.onDeletionCancelled,
  }) : super(key: key);

  final Function() onDeletionCancelled;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.close,
        size: 25,
      ),
      onPressed: onDeletionCancelled,
    );
  }
}
