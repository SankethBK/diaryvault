import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/sync/data/datasources/google_oauth_client.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/oauth_client_templdate.dart';
import 'package:flutter/material.dart';

class CloudUserInfo extends StatefulWidget {
  final String imagePath;
  final String cloudSourceName;

  CloudUserInfo({
    Key? key,
    required this.imagePath,
    required this.cloudSourceName,
  }) : super(key: key) {}

  @override
  State<CloudUserInfo> createState() => _CloudUserInfoState();
}

class _CloudUserInfoState extends State<CloudUserInfo> {
  late IOAuthClient oAuthClient;
  bool isSignedIn = false;
  bool isInitialized = false;
  String? signedInUserInfo;

  Future<void> initialize() async {
    if (widget.cloudSourceName == "google_drive") {
      oAuthClient = sl<GoogleOAuthClient>();
    }

    isSignedIn = await oAuthClient.initialieClient();

    if (isSignedIn) {
      signedInUserInfo = await oAuthClient.getSignedInUserInfo();
    }

    setState(() {
      isInitialized = true;
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 330,
      child: (isInitialized == false)
          ? const CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        widget.imagePath,
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.cloudSourceName == "google_drive"
                            ? "Google Drive"
                            : "Dropbox",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  if (isSignedIn)
                    Text(
                      "signed in as $signedInUserInfo",
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  const SizedBox(height: 10),
                  (isSignedIn
                      ? SubmitButton(
                          isLoading: false,
                          onSubmitted: () {},
                          buttonText: "Log out")
                      : SubmitButton(
                          isLoading: false,
                          onSubmitted: () {},
                          buttonText: "Sign in")),
                  const SizedBox(height: 10),
                  SwitchListTile(
                      title: const Text("Select as sync source"),
                      value: true,
                      onChanged: (_) {})
                ],
              ),
            ),
    );
  }
}
