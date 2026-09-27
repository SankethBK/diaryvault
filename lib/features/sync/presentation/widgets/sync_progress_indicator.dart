import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/features/sync/presentation/bloc/notes_sync/notesync_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SyncProgressIndicator extends StatelessWidget {
  const SyncProgressIndicator({super.key, this.cubit});

  final NoteSyncCubit? cubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inactiveTrackColor = theme
        .extension<SettingsPageThemeExtensions>()!
        .inactiveTrackColor;
    final activeColor = theme
            .extension<SettingsPageThemeExtensions>()!
            .activeColor ??
        theme.colorScheme.primary;
    final textColor = theme
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return BlocBuilder<NoteSyncCubit, NoteSyncState>(
      bloc: cubit,
      buildWhen: (previous, current) =>
          current is NoteSyncOnGoing || previous is NoteSyncOnGoing,
      builder: (context, state) {
        if (state is! NoteSyncOnGoing) return const SizedBox.shrink();
        return Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: state.progress,
                backgroundColor: inactiveTrackColor,
                valueColor: AlwaysStoppedAnimation<Color>(activeColor),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 40,
              child: Text(
                '${(state.progress * 100).toStringAsFixed(0)}%',
                style: theme.textTheme.bodySmall?.copyWith(color: textColor),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        );
      },
    );
  }
}
