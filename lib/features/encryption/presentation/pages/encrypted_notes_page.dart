import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/utils/background_image.dart';
import 'package:dairy_app/core/widgets/glass_app_bar.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/encryption/presentation/bloc/encrypted_notes_cubit.dart';
import 'package:dairy_app/features/encryption/presentation/bloc/encryption_cubit.dart';
import 'package:dairy_app/features/encryption/presentation/widgets/unlock_dialog.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_create_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_preview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Separate view listing all encrypted notes. Entering requires an unlocked
/// session; leaving the page locks it again, so the passphrase is never
/// re-prompted while browsing but never persists beyond the view either.
class EncryptedNotesPage extends StatefulWidget {
  static String get route => '/encrypted-notes';

  const EncryptedNotesPage({Key? key}) : super(key: key);

  @override
  State<EncryptedNotesPage> createState() => _EncryptedNotesPageState();
}

class _EncryptedNotesPageState extends State<EncryptedNotesPage> {
  late final EncryptedNotesCubit cubit;
  late double topPadding = 0;

  @override
  void initState() {
    super.initState();
    cubit = sl<EncryptedNotesCubit>();
    cubit.fetchNotes();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    topPadding =
        MediaQuery.of(context).padding.top + AppBar().preferredSize.height;
  }

  @override
  void dispose() {
    // Exiting the encrypted notes view locks the session
    sl<EncryptionCubit>().lock();
    super.dispose();
  }

  Future<void> _promptUnlock() async {
    final unlocked = await showUnlockDialog(context);
    if (unlocked == true) {
      cubit.fetchNotes();
    }
  }

  /// A locked note is protected by a different passphrase: prompt for it,
  /// open its keychain for this session, then open the note.
  Future<void> _openLockedNote(NotePreviewModel note) async {
    final unlocked = await showUnlockDialog(
      context,
      title: "This note is protected by a different passphrase",
      actionLabel: "Unlock note",
      onSubmit: (passphrase) => cubit.unlockNote(note.id, passphrase),
    );
    if (unlocked != true || !mounted) return;
    await Navigator.of(context).pushNamed(
      NoteCreatePage.routeThroughHome,
      arguments: {
        "id": note.id,
        "encrypted": true,
      },
    );
    cubit.fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImagePath =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.backgroundImage;
    final backgroundColor = Theme.of(context)
        .extension<AuthPageThemeExtensions>()!
        .backgroundColor;
    final borderColor =
        Theme.of(context).extension<HomePageThemeExtensions>()!.borderColor;
    final backgroundGradientStartColor = Theme.of(context)
        .extension<HomePageThemeExtensions>()!
        .backgroundGradientStartColor;
    final backgroundGradientEndColor = Theme.of(context)
        .extension<HomePageThemeExtensions>()!
        .backgroundGradientEndColor;
    final notePreviewGradientStartColor = Theme.of(context)
        .extension<HomePageThemeExtensions>()!
        .notePreviewUnselectedGradientStartColor;
    final notePreviewGradientEndColor = Theme.of(context)
        .extension<HomePageThemeExtensions>()!
        .notePreviewUnselectedGradientEndColor;
    final sigmaX =
        Theme.of(context).extension<HomePageThemeExtensions>()!.sigmaX;
    final sigmaY =
        Theme.of(context).extension<HomePageThemeExtensions>()!.sigmaY;
    final mainTextColor =
        Theme.of(context).extension<HomePageThemeExtensions>()!.dateColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Encrypted notes"),
        actions: [
          IconButton(
            icon: const Icon(Icons.lock),
            tooltip: "Lock",
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Container(
        decoration: getBackgroundDecoration(
          backgroundImagePath,
          backgroundColor: backgroundColor,
        ),
        padding: EdgeInsets.only(
          top: topPadding,
          left: 5.0,
          right: 5.0,
        ),
        child: GlassMorphismCover(
          sigmaX: sigmaX,
          sigmaY: sigmaY,
          borderRadius: BorderRadius.circular(0.0),
          child: Container(
            padding: const EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
              border: Border.all(width: 1.0, color: borderColor),
              gradient: LinearGradient(
                colors: [
                  backgroundGradientStartColor,
                  backgroundGradientEndColor,
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
            ),
            child: BlocBuilder<EncryptedNotesCubit, EncryptedNotesState>(
              bloc: cubit,
              builder: (context, state) {
                return switch (state) {
                EncryptedNotesLocked() => Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lock_outline,
                            size: 48, color: mainTextColor),
                        const SizedBox(height: 12),
                        Text(
                          "Encrypted notes are locked",
                          style: TextStyle(color: mainTextColor, fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _promptUnlock,
                          icon: const Icon(Icons.lock_open),
                          label: const Text("Unlock"),
                        ),
                      ],
                    ),
                  ),
                EncryptedNotesLoading() =>
                  const Center(child: CircularProgressIndicator()),
                EncryptedNotesFailure(message: final message) => Center(
                    child: Text(
                      message,
                      style: TextStyle(color: mainTextColor),
                    ),
                  ),
                EncryptedNotesLoaded(previews: final previews) =>
                  previews.isEmpty
                      ? Center(
                          child: Text(
                            "No encrypted notes yet",
                            style: TextStyle(color: mainTextColor),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: previews.length,
                          itemBuilder: (context, index) {
                            final note = previews[index];
                            return GestureDetector(
                              onTap: () async {
                                if (note.isLocked) {
                                  await _openLockedNote(note);
                                  return;
                                }
                                await Navigator.of(context).pushNamed(
                                  NoteCreatePage.routeThroughHome,
                                  arguments: {
                                    "id": note.id,
                                    "encrypted": true,
                                  },
                                );
                                cubit.fetchNotes();
                              },
                              child: NoteTile(
                                note: note,
                                first: index == 0,
                                last: index == previews.length - 1,
                                gradientStartColor:
                                    notePreviewGradientStartColor,
                                gradientEndColor: notePreviewGradientEndColor,
                                borderColor: borderColor,
                              ),
                            );
                          },
                        ),
              };
            },
          ),
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "encrypted_notes_fab",
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).pushNamed(
            NoteCreatePage.routeThroughHome,
            arguments: {"encrypted": true},
          );
          cubit.fetchNotes();
        },
      ),
    );
  }
}
