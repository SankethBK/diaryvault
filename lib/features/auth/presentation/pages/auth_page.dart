// ignore_for_file: prefer_const_constructors

import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/auth/core/exports.dart';
import 'package:dairy_app/features/auth/data/repositories/fingerprint_auth_repo.dart';

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
        widget.fingerPrintAuthRepository.startFingerPrintAuthIfNeeded(context);
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
                              lastLoggedInUserId: widget.lastLoggedInUserId);
                        },
                      ),
                      const SizedBox(height: 40),
                      if (widget.fingerPrintAuthRepository
                              .shouldActivateFingerPrint() &&
                          MediaQuery.of(context).viewInsets.bottom == 0)
                        Icon(
                          Icons.fingerprint,
                          size: 50,
                          color: Colors.white.withOpacity(0.5),
                        ),
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
          ],
        ),
      ),
    );
  }
}
