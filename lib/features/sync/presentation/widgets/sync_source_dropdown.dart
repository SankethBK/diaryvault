import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dairy_app/generated/l10n.dart';

class SyncSourceDropdown extends StatelessWidget {
  const SyncSourceDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userConfigCubit = BlocProvider.of<UserConfigCubit>(context);

    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return Row(
      children: [
        Expanded(
          child: Text(
            S.current.chooseTheSyncSource,
            style: TextStyle(
              fontSize: 16.0,
              color: mainTextColor,
            ),
          ),
        ),
        BlocBuilder<UserConfigCubit, UserConfigState>(
          builder: (context, state) {
            return PopupMenuButton<String>(
              padding: const EdgeInsets.only(bottom: 5.0),
              onSelected: (value) async {
                // Update the selected value
                await userConfigCubit.setUserConfig(
                    UserConfigConstants.preferredSyncOption, value);
              },
              itemBuilder: (context) => [
                SyncConstants.googleDrive,
                SyncConstants.dropbox,
                SyncConstants.nextCloud,
                "None"
              ].map((item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(color: mainTextColor),
                  ),
                );
              }).toList(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    state.userConfigModel?.preferredSyncOption ?? "None",
                    style: TextStyle(
                      color: mainTextColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: mainTextColor,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
