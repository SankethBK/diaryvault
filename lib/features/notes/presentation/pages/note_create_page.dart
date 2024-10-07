import 'dart:async';

import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_app_bar.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/notes/presentation/mixins/note_helper_mixin.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_title_input_field.dart';
import 'package:dairy_app/features/notes/presentation/widgets/rich_text_editor.dart';
import 'package:dairy_app/features/notes/presentation/widgets/toggle_read_write_button.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_review/in_app_review.dart';

import '../../../auth/presentation/bloc/user_config/user_config_cubit.dart';
import '../widgets/note_date_time_picker.dart';
import '../widgets/note_save_button.dart';
import '../widgets/notes_close_button.dart';

class NoteCreatePage extends StatefulWidget {
  // display page growing animation
  static String get routeThroughHome => '/note-create-though-home';

  // display fade transition animation
  static String get routeThroughNoteReadOnly =>
      '/note-create-through-note-read-only';

  const NoteCreatePage({Key? key}) : super(key: key);

  @override
  State<NoteCreatePage> createState() => _NoteCreatePageState();
}

class _NoteCreatePageState extends State<NoteCreatePage> with NoteHelperMixin {
  late bool _isInitialized = false;
  late final NotesBloc notesBloc;
  late Image neonImage;
  late double topPadding = 0;
  Timer? _saveTimer;

  final log = printer("NoteCreatePage");

  @override
  void initState() {
    super.initState();
  }

  void _initSaveTimer() {
    final userConfigCubit = BlocProvider.of<UserConfigCubit>(context);
    final isAutoSaveEnabled =
        userConfigCubit.state.userConfigModel?.isAutoSaveEnabled ?? false;

    if (isAutoSaveEnabled) {
      const int saveDelayInSeconds = 10; // delay in seconds
      _saveTimer =
          Timer.periodic(const Duration(seconds: saveDelayInSeconds), (timer) {
        notesBloc.add(AutoSaveNote());
      });
    }
  }

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      notesBloc = BlocProvider.of<NotesBloc>(context);
      _initSaveTimer();
      // it is definitely a new note if we reached this page and the state is still NoteDummyState
      if (notesBloc.state is NoteDummyState) {
        notesBloc.add(const InitializeNote());
      }

      final backgroundImagePath = Theme.of(context)
          .extension<AuthPageThemeExtensions>()!
          .backgroundImage;

      neonImage = Image.asset(backgroundImagePath);

      precacheImage(neonImage.image, context);
      topPadding =
          MediaQuery.of(context).padding.top + AppBar().preferredSize.height;

      _isInitialized = true;
    }

    super.didChangeDependencies();
  }

  Future<void> showReviewPopup() async {
    final InAppReview inAppReview = InAppReview.instance;

    log.d("Checking if in-app review is available");
    try {
      if (await inAppReview.isAvailable()) {
        log.i("In-app review available, requesting review");
        await inAppReview.requestReview();
      } else {
        log.w('In-app review is not available.');
      }
    } catch (e) {
      log.e('Failed to show review popup: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImagePath =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.backgroundImage;

    final fallbackColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .fallbackColor;

    return WillPopScope(
      onWillPop: () => handleWillPop(context, notesBloc),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: GlassAppBar(
          automaticallyImplyLeading: false,
          leading: NotesCloseButton(onNotesClosed: _closeAfterAutoSave),
          actions: const [
            NoteSaveButton(),
            DateTimePicker(),
            ToggleReadWriteButton(pageName: PageName.NoteCreatePage)
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            color: fallbackColor,
            image: DecorationImage(
              image: AssetImage(
                backgroundImagePath,
              ),
              fit: BoxFit.cover,
              // alignment: const Alignment(0.725, 0.1),
            ),
          ),
          padding: EdgeInsets.only(
            top: topPadding,
            left: 10.0,
            right: 10.0,
            // bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: BlocListener<NotesBloc, NotesState>(
            bloc: notesBloc,
            listener: (context, state) async {
              if (state is NoteFetchFailed) {
                showToast(S.current.failedToFetchNote);
              } else if (state is NotesSavingFailed) {
                showToast(S.current.failedToSaveNote);
              } else if (state is NoteSavedSuccesfully) {
                showToast(state.newNote!
                    ? S.current.noteSavedSuccessfully
                    : S.current.noteUpdatedSuccessfully);
                // Call showReviewPopup after saving the note
                log.d("Showing review popup after note save");
                await showReviewPopup();

                // Navigate to home after showing the review dialog
                _routeToHome();
              }
            },
            child: Column(
              children: [
                BlocBuilder<NotesBloc, NotesState>(
                  bloc: notesBloc,
                  buildWhen: (previousState, state) {
                    return previousState.title != state.title;
                  },
                  builder: (context, state) {
                    void _onTitleChanged(String title) {
                      notesBloc.add(UpdateNote(title: title));
                    }

                    if (!state.safe) {
                      return NoteTitleInputField(
                          initialValue: "", onTitleChanged: _onTitleChanged);
                    }
                    return NoteTitleInputField(
                      initialValue: state.title!,
                      onTitleChanged: _onTitleChanged,
                    );
                  },
                ),
                BlocBuilder<NotesBloc, NotesState>(
                  bloc: notesBloc,
                  buildWhen: (previousState, state) {
                    return previousState is NoteDummyState;
                  },
                  builder: (context, state) {
                    return RichTextEditor(
                      controller: state.controller,
                    );
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom == 0
                      ? 10
                      : MediaQuery.of(context).viewInsets.bottom + 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _closeAfterAutoSave() {
    notesBloc.add(FetchNote());
    _routeToHome();
  }

  void _routeToHome() {
    _saveTimer?.cancel();
    notesBloc.add(RefreshNote());
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _saveTimer?.cancel();
    super.dispose();
  }
}
