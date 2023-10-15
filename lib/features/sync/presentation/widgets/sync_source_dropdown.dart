import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/auth/core/exports.dart';

import '../../../auth/presentation/bloc/user_config/user_config_cubit.dart';

class SyncSourceDropdown extends StatelessWidget {
  const SyncSourceDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userConfigCubit = BlocProvider.of<UserConfigCubit>(context);

    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    final dropDownBackgroundColor = Theme.of(context)
        .extension<SettingsPageThemeExtensions>()!
        .dropDownBackgroundColor;

    return Row(
      children: [
        Expanded(
          child: Text(
            AppLocalizations.of(context).chooseTheSyncSource,
            style: TextStyle(
              fontSize: 16.0,
              color: mainTextColor,
            ),
          ),
        ),
        BlocBuilder<UserConfigCubit, UserConfigState>(
          builder: (context, state) {
            return DropdownButton<String>(
              padding: const EdgeInsets.only(bottom: 5.0),
              iconEnabledColor: mainTextColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              focusColor: mainTextColor,
              underline: Container(
                height: 1,
                color: mainTextColor,
              ),
              dropdownColor: dropDownBackgroundColor,
              value: state.userConfigModel?.preferredSyncOption ?? "None",
              onChanged: (value) async {
                // Update the selected value
                await userConfigCubit.setUserConfig(
                    UserConfigConstants.preferredSyncOption, value);
              },
              items: [SyncConstants.googleDrive, SyncConstants.dropbox, "None"]
                  .map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(color: mainTextColor),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
