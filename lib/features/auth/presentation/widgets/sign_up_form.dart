import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:dairy_app/features/auth/presentation/widgets/form_dimensions.dart';
import 'package:dairy_app/features/auth/presentation/widgets/guest_sign_up.dart';
import 'package:dairy_app/features/auth/presentation/widgets/password_input_field.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_change.dart';
import 'email_input_field.dart';
import 'package:dairy_app/features/auth/data/repositories/pin_auth_repository.dart';
import 'package:dairy_app/features/auth/presentation/widgets/pin_login_form.dart';

class SignUpForm extends StatefulWidget {
  static String get route => '/auth';
  final PINAuthRepository pinAuthRepository;
  final void Function() flipCard;

  const SignUpForm({
    Key? key,
    required this.flipCard,
    required this.pinAuthRepository,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isInitialized = false;
  late AuthFormBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInitialized) {
      bloc = BlocProvider.of<AuthFormBloc>(context);
      bloc.add(ResetAuthForm());
      isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthFormBloc bloc = BlocProvider.of<AuthFormBloc>(context);

    return BlocConsumer<AuthFormBloc, AuthFormState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is AuthFormSubmissionFailed &&
            state.errors.containsKey("general")) {
          showToast(state.errors["general"]![0]);
        }
      },
      builder: (context, state) {
        bool showPinButton =
            widget.pinAuthRepository.shouldredirectToPINAuthScreen();
        String? _getEmailErrors() {
          if (state is AuthFormSubmissionFailed &&
              state.errors.containsKey("email")) {
            return state.errors["email"]![0];
          }
          return null;
        }

        String? _getPasswordErrors() {
          if (state is AuthFormSubmissionFailed &&
              state.errors.containsKey("password")) {
            return state.errors["password"]?[0];
          }
          return null;
        }

        void _onEmailChanged(String email) =>
            bloc.add(AuthFormInputsChangedEvent(email: email));

        void _onPasswordChanged(String password) =>
            bloc.add(AuthFormInputsChangedEvent(password: password));

        void _onSubmitted() => bloc.add(AuthFormSignUpSubmitted());

        return GlassMorphismCover(
          borderRadius: BorderRadius.circular(16.0),
          child: FormDimensions(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    S.current.signUp,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AuthEmailInput(
                        getEmailErrors: _getEmailErrors,
                        onEmailChanged: _onEmailChanged,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthPasswordInput(
                        getPasswordErrors: _getPasswordErrors,
                        onPasswordChanged: _onPasswordChanged,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SubmitButton(
                        isLoading: (state is AuthFormSubmissionLoading),
                        onSubmitted: _onSubmitted,
                        buttonText: S.current.submit,
                      )
                    ],
                  ),
                  Column(
                    children: [
                      if (showPinButton)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(PinSignInForm.route);
                          },
                          child: Text(
                            S.current.enterPin,
                            style: const TextStyle(
                              color: Colors
                                  .white, // Use the same color as in the Text widget
                              fontWeight:
                                  FontWeight.bold, // Apply bold font weight
                            ),
                          ),
                        ),
                      const GuestSignUp(),
                      AuthChangePage(
                        infoText: S.current.alreadyHaveAnAccount,
                        flipPageText: S.current.logIn,
                        flipCard: widget.flipCard,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}