// ignore_for_file: prefer_const_constructors

import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/core/animations/flip_card_animation.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/auth/data/repositories/fingerprint_auth_repo.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/widgets/fingerprint_button.dart';
import 'package:dairy_app/features/auth/presentation/widgets/privacy_policy.dart';
import 'package:dairy_app/features/auth/presentation/widgets/quit_app_dialog.dart';
import 'package:dairy_app/features/auth/presentation/widgets/sign_in_form.dart';
import 'package:dairy_app/features/auth/presentation/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  // user id of last logged in user to determine if it is a fresh login or not
  final String? lastLoggedInUserId;
  late final FingerPrintAuthRepository fingerPrintAuthRepository;

  AuthPage({Key? key, this.lastLoggedInUserId}) : super(key: key) {
    fingerPrintAuthRepository = sl<FingerPrintAuthRepository>();
  }
  static String get route => '/auth';

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late Image neonImage;
  late bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInitialized) {
      final backgroundImagePath = Theme.of(context)
          .extension<AuthPageThemeExtensions>()!
          .backgroundImage;

      neonImage = Image.asset(backgroundImagePath);
      precacheImage(neonImage.image, context);

      final currentAuthState = BlocProvider.of<AuthSessionBloc>(context).state;

      if (currentAuthState is Unauthenticated) {
        widget.fingerPrintAuthRepository.startFingerPrintAuthIfNeeded();
      }

      _isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImagePath =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.backgroundImage;

    final linkColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.linkColor;

    final infoTextColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.infoTextColor;
    return WillPopScope(
      onWillPop: () async {
        bool res = await quitAppDialog(context);
        if (res == true) {
          SystemNavigator.pop();
        }

        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    backgroundImagePath,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlipCardAnimation(
                        frontWidget: (void Function() flipCard) {
                          return SignUpForm(
                            flipCard: flipCard,
                          );
                        },
                        rearWidget: (void Function() flipCard) {
                          return SignInForm(
                            flipCard: flipCard,
                            lastLoggedInUserId: widget.lastLoggedInUserId,
                          );
                        },
                      ),
                      const SizedBox(height: 40),
                      if (MediaQuery.of(context).viewInsets.bottom == 0)
                        FingerprintButton(),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              child: Center(
                child: PrivacyPolicy(linkColor: linkColor),
              ),
              bottom: 20,
              right: 0,
              left: 0,
            ),
            Positioned(
              top: 20,
              left: 20,
              child: Navigator.of(context).canPop()
                  ? GlassMorphismCover(
                      borderRadius: BorderRadius.circular(50),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: infoTextColor,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
