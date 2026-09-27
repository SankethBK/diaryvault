import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/features/sync/presentation/bloc/notes_sync/notesync_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dairy_app/generated/l10n.dart';

class SyncNowButton extends StatefulWidget {
  const SyncNowButton({
    Key? key,
    this.cubit,
    this.showFeedback = true,
  }) : super(key: key);

  final NoteSyncCubit? cubit;
  final bool showFeedback;

  @override
  State<SyncNowButton> createState() => _SyncNowButtonState();
}

class _SyncNowButtonState extends State<SyncNowButton>
    with TickerProviderStateMixin {
  late AnimationController _rotationAnimationController;

  @override
  void initState() {
    _rotationAnimationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _rotationAnimationController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m ${duration.inSeconds.remainder(60)}s';
    }
    if (duration.inSeconds > 0) {
      return '${duration.inSeconds}s';
    }
    return '${duration.inMilliseconds}ms';
  }

  @override
  Widget build(BuildContext context) {
    final noteSyncCubit =
        widget.cubit ?? BlocProvider.of<NoteSyncCubit>(context);

    final theme = Theme.of(context);
    final syncButtonColor = theme
        .extension<SettingsPageThemeExtensions>()!
        .syncButtonColor ??
        theme.colorScheme.primary;

    return BlocBuilder<NoteSyncCubit, NoteSyncState>(
      bloc: noteSyncCubit,
      builder: (context, state) {
        if (widget.showFeedback && state is NoteSyncSuccessful) {
          showToast(
              '${S.current.notesSyncSuccessfull} (${_formatDuration(state.elapsed)})');
          if (_rotationAnimationController.isAnimating) {
            _rotationAnimationController.reset();
          }
        } else if (widget.showFeedback && state is NoteSyncFailed) {
          showToast(state.errorMessage);
          if (_rotationAnimationController.isAnimating) {
            _rotationAnimationController.reset();
          }
        } else if (state is NoteSyncOnGoing) {
          if (!_rotationAnimationController.isAnimating) {
            _rotationAnimationController.repeat();
          }
        } else {
          if (_rotationAnimationController.isAnimating) {
            _rotationAnimationController.reset();
          }
        }

        return GestureDetector(
          onTap: () {
            noteSyncCubit.startNoteSync();
          },
          child: Tooltip(
            message: S.current.syncNow,
            child: Semantics(
              button: true,
              label: S.current.syncNow,
              child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withOpacity(0.1),
                  border: Border.all(color: syncButtonColor),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: RotationTransition(
                  turns: Tween(begin: 1.0, end: 0.0)
                      .animate(_rotationAnimationController),
                  child: Icon(
                    Icons.sync,
                    color: syncButtonColor,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
