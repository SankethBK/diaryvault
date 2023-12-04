import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'pin_input_field.dart';
import 'sign_in_form.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/features/auth/presentation/widgets/form_dimensions.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:dairy_app/features/auth/data/repositories/pin_auth_repository.dart';

class PinSignInForm extends StatefulWidget {
  static String get route => '/pin-auth';

  const PinSignInForm({Key? key}) : super(key: key);

  @override
  State<PinSignInForm> createState() => _PinSignInFormState();
}

class _PinSignInFormState extends State<PinSignInForm> {
  late AuthFormBloc bloc;
  final pinAuthRepository = sl<PINAuthRepository>();
  String enteredPin = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<AuthFormBloc>(context);
  }

  void _onPinChanged(String pin) {
    enteredPin = pin;
  }

  String? _getUserHelper() {
    String? userId = pinAuthRepository.getUserId();
    return userId;
  }

  Future<bool> _onSubmitted() async {
    String? userId = _getUserHelper();
    if (userId != null) {
      bool isPinValid = await pinAuthRepository.verifyPIN(userId, enteredPin);
      return isPinValid;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // This will push the route to go to the sign in form
            Navigator.of(context).pushReplacementNamed(SignInForm.route);
          },
        ),
      ),
      body: BlocBuilder<AuthFormBloc, AuthFormState>(
        bloc: bloc,
        builder: (context, state) {
          return GlassMorphismCover(
            borderRadius: BorderRadius.circular(16.0),
            child: FormDimensions(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      S.current.enterPin,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    AuthPinInput(
                      getPinErrors: () => null,
                      onPinChanged: _onPinChanged,
                      autoFocus: true,
                    ),
                    const SizedBox(height: 30),
                    StatefulBuilder(builder: (context, setState) {
                      return SubmitButton(
                        isLoading: state is AuthFormSubmissionLoading,
                        onSubmitted: () async {
                          setState(() {
                            isLoading = true;
                          });
                          bool verifiedPin = await _onSubmitted();
                          String? userId = _getUserHelper();
                          if (verifiedPin == false || userId == null) {
                            showToast(S.current.pinLoginFailed);
                            setState(() => isLoading = false);
                            return;
                          } else if (verifiedPin == true) {
                            setState(() => isLoading = false);
                            bloc.add(AuthFormSignInDirectlySubmitted(
                                userId: userId));
                          }
                        },
                        buttonText: S.current.submit,
                      );
                    })
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
