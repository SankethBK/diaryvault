import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/presentation/widgets/email_input_field.dart';
import 'package:dairy_app/features/auth/presentation/widgets/password_input_field.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/features/sync/data/datasources/nextcloud_sync_client.dart';
import 'package:dairy_app/features/sync/presentation/widgets/url_input.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NextCloudLoginForm extends StatefulWidget {
  const NextCloudLoginForm({super.key});

  @override
  State<NextCloudLoginForm> createState() => _NextCloudLoginFormState();
}

class _NextCloudLoginFormState extends State<NextCloudLoginForm> {
  String webDAVURL = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final linkColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.linkColor;

    return Container(
      width: 300,
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          URLInput(
              getErrors: () {
                return null;
              },
              onChaged: (String newVal) {
                webDAVURL = newVal;
              },
              hintText: S.current.webdavURL),
          const SizedBox(height: 15),
          AuthEmailInput(
            getEmailErrors: () {
              return null;
            },
            onEmailChanged: (String newVal) {
              email = newVal;
            },
          ),
          const SizedBox(height: 15),
          AuthPasswordInput(
            getPasswordErrors: () {
              return null;
            },
            onPasswordChanged: (String newVal) {
              password = newVal;
            },
          ),
          const SizedBox(height: 25),
          InkWell(
            child: Text(
              S.current.moreInfo,
              style: TextStyle(
                // fontSize: 16,
                fontWeight: FontWeight.bold,
                color: linkColor,
              ),
            ),
            onTap: () async {
              final Uri url = Uri.parse(
                  'https://diaryvault.netlify.app/nextcloud-sync-setup');

              if (!await launchUrl(url)) {
                throw Exception('Could not launch $url');
              }
            },
          ),
          const SizedBox(height: 5),
          SubmitButton(
            isLoading: false,
            onSubmitted: () async {
              try {
                await sl<NextCloudSyncClient>()
                    .addLoginDetails(webDAVURL, email, password);

                await sl<NextCloudSyncClient>().signIn();

                showToast("Configuration seems to be valid");
              } on Exception catch (e) {
                showToast(e.toString().replaceAll("Exception: ", ""));
              }
            },
            buttonText: S.current.logIn,
          ),
        ],
      ),
    );
  }
}
