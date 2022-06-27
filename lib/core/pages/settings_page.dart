import 'package:dairy_app/core/widgets/cancel_button.dart';
import 'package:dairy_app/core/widgets/glass_app_bar.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/widgets/security_settings.dart';
import 'package:dairy_app/features/sync/presentation/widgets/sync_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  static String get route => '/settings';

  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authSessionBloc = BlocProvider.of<AuthSessionBloc>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: GlassAppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Settings"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                onPressed: () async {
                  bool result = await showCustomDialog(
                    context: context,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 15),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text(
                            "Are you sure about logging out?R",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CancelButton(
                                buttonText: "Cancel",
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                              ),
                              const SizedBox(width: 10),
                              SubmitButton(
                                isLoading: false,
                                onSubmitted: () => Navigator.pop(context, true),
                                buttonText: "Logout",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );

                  if (result == true) {
                    authSessionBloc.add(UserLoggedOut());
                  }
                },
                icon: const Icon(Icons.power_settings_new_rounded)),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: AppBar().preferredSize.height +
              MediaQuery.of(context).padding.top +
              10.0,
          left: 10.0,
          right: 10.0,
          bottom: 10.0,
        ),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/digital-art-neon-bubbles.jpg",
            ),
            fit: BoxFit.cover,
            alignment: Alignment(0.725, 0.1),
          ),
        ),
        child: GlassMorphismCover(
          displayShadow: false,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.7),
                  Colors.white.withOpacity(0.5),
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
            ),
            child: Column(children: [
              const SyncSettings(),
              const SizedBox(height: 25.0),
              SecuritySettings()
            ]),
          ),
        ),
      ),
    );
  }
}
