import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToolbarPositionDropdown extends StatelessWidget {
  const ToolbarPositionDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userConfigCubit = context.watch<UserConfigCubit>();
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return Row(
      children: [
        Text(
          S.current.toolbarPosition,
          style: TextStyle(
            fontSize: 16.0,
            color: mainTextColor,
          ),
        ),
        const Spacer(),
        PopupMenuButton<String>(
          padding: const EdgeInsets.only(bottom: 0.0),
          onSelected: (value) async {
            userConfigCubit.setUserConfig(
                UserConfigConstants.toolbarPosition, value);
          },
          itemBuilder: (context) => ["Top", "Bottom"].map((toolbarPosition) {
            return PopupMenuItem<String>(
              value: toolbarPosition,
              child: Text(
                toolbarPosition,
                style: TextStyle(color: mainTextColor),
              ),
            );
          }).toList(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                userConfigCubit.state.userConfigModel?.toolbarPosition ?? 'Top',
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
        ),
      ],
    );
  }
}
