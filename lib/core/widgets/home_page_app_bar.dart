import 'package:dairy_app/app/themes/theme_extensions/appbar_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/pages/settings_page.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/cancel_button.dart';
import 'package:dairy_app/core/widgets/date_input_field.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/data/models/user_config_model.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes_fetch/notes_fetch_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/generated/l10n.dart';
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

  @override
  Widget build(BuildContext context) {
    final notesFetchCubit = BlocProvider.of<NotesFetchCubit>(context);
    final appBarGradientStartColor = Theme.of(context)
        .extension<AppbarThemeExtensions>()!
        .appBarGradientStartColor;

    final appBarGradientEndColor = Theme.of(context)
        .extension<AppbarThemeExtensions>()!
        .appBarGradientEndColor;

    void closeSearchAppBar() {
      setState(() {
        isSearchEnabled = false;
      });

      notesFetchCubit.fetchNotes();
    }

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
                appBarGradientStartColor,
                appBarGradientEndColor,
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
    final notesFetchCubit = BlocProvider.of<NotesFetchCubit>(context);

    return Builder(builder: (context) {
      final selectableListState = context.watch<SelectableListCubit>().state;
      final notesFetchCubitState = context.watch<NotesFetchCubit>().state;

      Widget getSuitableWidget() {
        if (isSearchEnabled) {
          return Row(
            children: [
              Padding(
                key: const ValueKey("tag icon"),
                padding: const EdgeInsets.only(right: 5.0),
                child: IconButton(
                  icon: notesFetchCubitState.isTagSearchEnabled
                      ? const Icon(Icons.local_offer)
                      : const Icon(Icons.local_offer_outlined),
                  onPressed: () {
                    notesFetchCubit.toggleTagSearch();
                  },
                  color: Colors.white.withOpacity(1),
                ),
              ),
              Padding(
                key: const ValueKey("close icon"),
                padding: const EdgeInsets.only(right: 13.0),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    // if tag search is enabled, disable it
                    final isTagSearchEnabled =
                        notesFetchCubitState.isTagSearchEnabled;
                    if (isTagSearchEnabled) {
                      notesFetchCubit.toggleTagSearch();
                    }

                    closeSearchAppBar();
                  },
                  color: Colors.white.withOpacity(1),
                ),
              ),
            ],
          );
        } else if (selectableListState is SelectableListEnabled) {
          return Row(
            children: [
              DeletionCount(
                deletionCount: selectableListCubit.state.selectedItems.length,
              ),
              // @Procos12 change: Added export icon segment below
              ExportIcon(
                exportCount: selectableListCubit.state.selectedItems.length,
              ),
              DeleteIcon(
                deletionCount: selectableListCubit.state.selectedItems.length,
                disableSelectedList: selectableListCubit.disableSelectableList,
              ),
            ],
          );
        } else {
          return Row(
            children: [
              Padding(
                key: const ValueKey("search icon"),
                padding: const EdgeInsets.only(right: 5.0),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: openSearchAppBar,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 13.0),
                child: PopupMenuButton<NoteSortType>(
                  key: const ValueKey("sort icon"),
                  icon: const Icon(
                    Icons.sort,
                    color: Colors.white,
                  ),
                  onSelected: (NoteSortType value) async {
                    await notesFetchCubit.setNoteSortType(value);
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<NoteSortType>(
                        value: NoteSortType.sortByLatestFirst,
                        child: Text(
                          S.current.sortByLatestFirst,
                        ),
                      ),
                      PopupMenuItem<NoteSortType>(
                        value: NoteSortType.sortByOldestFirst,
                        child: Text(
                          S.current.sortByOldestFirst,
                        ),
                      ),
                      PopupMenuItem<NoteSortType>(
                        value: NoteSortType.sortByAtoZ,
                        child: Text(
                          S.current.sortByAtoZ,
                        ),
                      ),
                    ];
                  },
                ),
              ),
            ],
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

    final searchBarFillColor = Theme.of(context)
        .extension<AppbarThemeExtensions>()!
        .searchBarFillColor;

    String? searchText;
    DateTime? startDate;
    DateTime? endDate;

    void assignStartDate(DateTime date) {
      startDate = date;
      notesFetchCubit.fetchNotes(
        searchText: searchText,
        startDate: startDate,
        endDate: endDate,
      );
    }

    void assignEndDate(DateTime date) {
      endDate = date;
      endDate = endDate!.add(const Duration(hours: 23, minutes: 59));

      notesFetchCubit.fetchNotes(
        searchText: searchText,
        startDate: startDate,
        endDate: endDate,
      );
    }

    void assignSearchText(String val) {
      searchText = val;
      notesFetchCubit.fetchNotes(
        searchText: searchText,
        startDate: startDate,
        endDate: endDate,
      );
    }

    final mainTextColor =
        Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isSearchEnabled
          ? TextField(
        autofocus: true,
        cursorColor: Colors.white,
        style:
        TextStyle(color: Colors.white.withOpacity(1), fontSize: 16.0),
        decoration: InputDecoration(
          contentPadding:
          const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          hintStyle: const TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.0),
              width: 0.1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17.0),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.0),
              width: 0.1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(17.0),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.0),
              width: 0.1,
            ),
          ),
          filled: true,
          fillColor: searchBarFillColor,
          suffixIcon: IconButton(
            onPressed: () {
              showCustomDialog(
                context: context,
                child: Container(
                  width: 290,
                  padding: const EdgeInsets.only(
                    top: 13,
                    bottom: 13,
                    left: 20,
                    right: 15,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        S.current.dateFilter,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: mainTextColor,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Text(
                              S.current.from,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: mainTextColor,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            child: DateInputField(
                              displayDate: startDate,
                              assignDate: assignStartDate,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Text(
                              S.current.to,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: mainTextColor,
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 4,
                            child: DateInputField(
                              displayDate: endDate,
                              assignDate: assignEndDate,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SubmitButton(
                        isLoading: false,
                        onSubmitted: () => Navigator.of(context).pop(),
                        buttonText: S.current.done,
                      )
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
          ),
        ),
        onChanged: assignSearchText,
      )
          : const SizedBox(),
    );
  }
}

class _DeleteButton extends StatelessWidget {
  final int deleteCount;

  const _DeleteButton({Key? key, required this.deleteCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectableListCubit = BlocProvider.of<SelectableListCubit>(context);

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
            buttonText: S.current.delete);
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
          buttonText: S.current.cancel,
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

// @Procos12: Added code section below for export icon:
class ExportIcon extends StatelessWidget {
  final int exportCount;

  const ExportIcon({
    Key? key,
    required this.exportCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 13.0),
      child: IconButton(
        icon: const Icon(Icons.upload), // Export icon
        onPressed: () async {
          if (exportCount == 0) {
            showToast('No items selected to export');
            return;
          }

          final mainTextColor = Theme.of(context)
              .extension<PopupThemeExtensions>()!
              .mainTextColor;

          // Show the popup dialog for exporting
          await showCustomDialog(
            context: context,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  color: Colors.transparent,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "You are about to export $exportCount item${exportCount > 1 ? "s" : ""}.",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: mainTextColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CancelButton(
                            buttonText: 'Cancel',
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the popup
                              showToast('Export canceled');
                            },
                          ),
                          const SizedBox(width: 10),
                          SubmitButton(
                            isLoading: false,
                            onSubmitted: () {
                              Navigator.of(context).pop(); // Close the popup
                              exportToPDF(); // added empty function for export to PDF
                              // Add export to PDF logic here
                              showToast(
                                  '$exportCount item${exportCount > 1 ? "s" : ""} exported to PDF');
                            },
                            buttonText: 'PDF',
                          ),
                          const SizedBox(width: 10),
                          SubmitButton(
                            isLoading: false,
                            onSubmitted: () {
                              Navigator.of(context).pop(); // Close the popup
                              exportToTextFile(); // added empty function for export to text
                              // Add export to text file logic here
                              showToast(
                                  '$exportCount item${exportCount > 1 ? "s" : ""} exported to Text File');
                            },
                            buttonText: 'Text File',
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
        tooltip: 'Export Selected Notes',
      ),
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

          final mainTextColor = Theme.of(context)
              .extension<PopupThemeExtensions>()!
              .mainTextColor;

          bool? result = await showCustomDialog(
            context: context,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  color: Colors.transparent,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "You are about to delete $deletionCount  item${deletionCount > 1 ? "s" : ""}",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: mainTextColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
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
                );
              },
            ),
          );

          disableSelectedList();

          if (result != null) {
            if (result == true) {
              showToast(
                  "$deletionCount item${deletionCount > 1 ? "s" : ""} deleted");
            } else {
              showToast(S.current.deletionFailed);
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
        style: const TextStyle(fontSize: 18.0),
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
