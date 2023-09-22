import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
    Key? key,
    required this.linkColor,
  }) : super(key: key);

  final Color linkColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthSessionBloc, AuthSessionState>(
      builder: (context, state) {
        // Privacy policy should be displayed only during first signup

        if (state is Unauthenticated) {
          final lastLoggedInUserId = state.lastLoggedInUserId;

          return GlassMorphismCover(
            sigmaX: 20,
            sigmaY: 20,
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  width: 1.5,
                  color: Colors.white.withOpacity(0.2),
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    "By continuing, you agree to our",
                    style: TextStyle(
                      fontSize: 16,
                      // fontWeight: FontWeight.bold,
                      color: linkColor,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: linkColor,
                      ),
                    ),
                    onTap: () async {
                      final Uri url = Uri.parse(
                          'https://sankethbk.netlify.app/privacy-policies/dairyaholic');

                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                  )
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// shdjdjeui
