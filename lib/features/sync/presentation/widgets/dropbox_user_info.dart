import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/sync/data/datasources/dropbox_sync_client.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/sync_client_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DropboxUserInfo extends StatefulWidget {
  DropboxUserInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<DropboxUserInfo> createState() => _DropboxUserInfoState();
}

class _DropboxUserInfoState extends State<DropboxUserInfo>
    with WidgetsBindingObserver {
  late ISyncClient oAuthClient;
  late UserConfigCubit userConfigCubit;

  void initialize() async {
    oAuthClient = sl<DropboxSyncClient>();

    userConfigCubit = sl<UserConfigCubit>();

    // to initate the first call, as initial state doesn't has user config
    await userConfigCubit.getUserConfig();
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;
    return SizedBox(
      // height: 240,
      width: 330,
      child: BlocConsumer<UserConfigCubit, UserConfigState>(
        listener: (context, state) {},
        builder: (context, state) {
          final isSignedIn = state.userConfigModel?.dropBoxUserInfo != null;
          final lastSynced = state.userConfigModel?.lastDropboxSync != null;

          return (state.userConfigModel == null)
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/dropbox_logo.png",
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Dropbox",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: mainTextColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 13),
                      if (isSignedIn)
                        Column(
                          children: [
                            Text(
                              "Signed in as",
                              style:
                                  TextStyle(fontSize: 14, color: mainTextColor),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              userConfigCubit
                                  .state.userConfigModel!.dropBoxUserInfo!,
                              style:
                                  TextStyle(fontSize: 14, color: mainTextColor),
                            )
                          ],
                        ),
                      const SizedBox(height: 13),
                      (lastSynced
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Last synced: ",
                                  style: TextStyle(color: mainTextColor),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "${DateFormat.yMd().format(state.userConfigModel!.lastDropboxSync!)}  ${DateFormat.jm().format(state.userConfigModel!.lastDropboxSync!)}",
                                  style: TextStyle(
                                    color: mainTextColor,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Last synced: ",
                                  style: TextStyle(color: mainTextColor),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  "Not available",
                                  style: TextStyle(color: mainTextColor),
                                )
                              ],
                            )),
                      const SizedBox(height: 12),
                      (isSignedIn
                          ? SubmitButton(
                              isLoading: false,
                              onSubmitted: () async {
                                await oAuthClient.signOut();
                              },
                              buttonText: "Log out",
                            )
                          : SubmitButton(
                              isLoading: false,
                              onSubmitted: () async {
                                await oAuthClient.signIn();
                              },
                              buttonText: "Sign in",
                            )),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
