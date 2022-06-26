import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:dairy_app/features/auth/presentation/widgets/email_input_field.dart';
import 'package:dairy_app/features/auth/presentation/widgets/form_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_change.dart';
import 'password_input_field.dart';

class SignInForm extends StatefulWidget {
  static String get route => '/auth';
  final void Function() flipCard;
  final String? lastLoggedInUserId;

  const SignInForm({
    Key? key,
    required this.flipCard,
    this.lastLoggedInUserId,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  bool inItialized = false;

  late AuthFormBloc bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!inItialized) {
      bloc = BlocProvider.of<AuthFormBloc>(context);
      // bloc.add(StartFingerPrintAuthIfPossible());
      inItialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthFormBloc, AuthFormState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is AuthFormSubmissionFailed &&
            state.errors.containsKey("general")) {
          showToast(
            state.errors["general"]![0],
          );
        }
      },
      builder: (context, state) {
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

        void _onSubmitted() => bloc.add(AuthFormSignInSubmitted(
            lastLoggedInUserId: widget.lastLoggedInUserId));

        return GlassMorphismCover(
          borderRadius: BorderRadius.circular(16.0),
          child: FormDimensions(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Log In",
                    style: TextStyle(
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
                        buttonText: "Submit",
                      )
                    ],
                  ),
                  AuthChangePage(
                    infoText: "Don't have an account?",
                    flipPageText: "Sign up",
                    flipCard: widget.flipCard,
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
