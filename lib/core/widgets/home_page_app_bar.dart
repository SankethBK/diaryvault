import 'package:dairy_app/core/pages/settings_page.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/cancel_button.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomePageAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageAppBar> createState() => _HomePageAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  bool isSearchEnabled = false;

  void openSearchAppBar() {
    setState(() {
      isSearchEnabled = true;
    });
  }

  void closeSearchAppBar() {
    setState(() {
      isSearchEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: LeadingIcon(isSearchEnabled: isSearchEnabled),
      backgroundColor: Colors.transparent,
      title: Title(isSearchEnabled: isSearchEnabled),
      actions: [
        Action(
          isSearchEnabled: isSearchEnabled,
          openSearchAppBar: openSearchAppBar,
          closeSearchAppBar: closeSearchAppBar,
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
}

// LeadingIcon will
// search icon for search page,
// CancelDeleteIcon for deletion page
// settings icon for settings page
class LeadingIcon extends StatelessWidget {
  final bool isSearchEnabled;
  const LeadingIcon({Key? key, required this.isSearchEnabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectableListCubit = BlocProvider.of<SelectableListCubit>(context);
    return BlocBuilder<SelectableListCubit, SelectableListState>(
      builder: (context, state) {
        Widget getSuitableWidget() {
          if (isSearchEnabled) {
            return Icon(
              Icons.search,
              color: Colors.white.withOpacity(1),
            );
          } else if (state is SelectableListEnabled) {
            return CancelDeletion(
              onDeletionCancelled: () =>
                  selectableListCubit.disableSelectableList(),
            );
          } else {
            return IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushNamed(SettingsPage.route);
              },
            );
          }
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: getSuitableWidget(),
        );
      },
    );
  }
}

// Action will be
// close button which cancels search in search appbar
// A row indicating delete count and delete icon in delete appbar
// search icon in normal home page appbar
class Action extends StatelessWidget {
  final bool isSearchEnabled;
  final Function() openSearchAppBar;
  final Function() closeSearchAppBar;

  const Action(
      {Key? key,
      required this.isSearchEnabled,
      required this.openSearchAppBar,
      required this.closeSearchAppBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectableListCubit = BlocProvider.of<SelectableListCubit>(context);
    return BlocBuilder<SelectableListCubit, SelectableListState>(
        builder: (context, state) {
      Widget getSuitableWidget() {
        if (isSearchEnabled) {
          return Padding(
            key: const ValueKey("close icon"),
            padding: const EdgeInsets.only(right: 13.0),
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: closeSearchAppBar,
              color: Colors.white.withOpacity(1),
            ),
          );
        } else if (state is SelectableListEnabled) {
          return Row(
            children: [
              DeletionCount(
                deletionCount: selectableListCubit.state.selectedItems.length,
              ),
              DeleteIcon(
                deletionCount: selectableListCubit.state.selectedItems.length,
                disableSelectedList: selectableListCubit.disableSelectableList,
              ),
            ],
          );
        } else {
          return Padding(
            key: const ValueKey("search icon"),
            padding: const EdgeInsets.only(right: 13.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: openSearchAppBar,
            ),
          );
        }
      }

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: getSuitableWidget(),
      );
    });
  }
}

// Title will be
// TextField for search
// SizedBox.shrink for rest
class Title extends StatelessWidget {
  final bool isSearchEnabled;

  const Title({Key? key, required this.isSearchEnabled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notesFetchCubit = BlocProvider.of<NotesFetchCubit>(context);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isSearchEnabled
          ? TextField(
              autofocus: true,
              style: TextStyle(color: Colors.white.withOpacity(0.8)),
              decoration: InputDecoration(
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.white,
                      ))),
              onChanged: (String value) {
                notesFetchCubit.fetchNotes(searchText: value);
              },
            )
          : const SizedBox(),
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

        return SubmitButton(
            isLoading: false,
            onSubmitted: () {
              if (state is NoteDeleteLoading) {
                return;
              }
              if (state is NoteDummyState) {
                final notesBloc = BlocProvider.of<NotesBloc>(context);
                notesBloc.add(DeleteNote(
                    noteList: selectableListCubit.state.selectedItems));
              }
            },
            buttonText: "Delete");
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
        return CancelButton(
          buttonText: "Cancel",
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
        icon: const Icon(
          Icons.delete,
        ),
        onPressed: () async {
          if (deletionCount == 0) {
            disableSelectedList();
            return;
          }

          bool? result = await showCustomDialog(
              context: context,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 110,
                width: 350,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "You are about to delete $deletionCount  item${deletionCount > 1 ? "s" : ""}",
                        style: const TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const _CancelButton(),
                          const SizedBox(width: 10),
                          _DeleteButton(
                            deleteCount: deletionCount,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ));

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
        style: const TextStyle(fontSize: 22.0),
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
