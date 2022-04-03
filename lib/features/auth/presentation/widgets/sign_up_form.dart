import 'dart:ui';

import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/features/auth/presentation/widgets/glass_form_cover.dart';
import 'package:dairy_app/features/auth/presentation/widgets/password_input_field.dart';
import 'package:dairy_app/features/auth/presentation/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'email_input_field.dart';

class SignUpForm extends StatefulWidget {
  static String get route => '/auth';
  final void Function() flipCard;

  const SignUpForm({Key? key, required this.flipCard}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    AuthFormBloc bloc = sl<AuthFormBloc>();

    return BlocConsumer<AuthFormBloc, AuthFormState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is AuthFormSubmissionFailed &&
            state.errors.containsKey("general")) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errors["general"]![0]),
            ),
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

        void _onSubmitted() => bloc.add(AuthFormSignUpSubmitted());

        return GlassFormCover(
          childWidget: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.07),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Sign up",
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
                        AuthSubmitButton(
                          isLoading: (state is AuthFormSubmissionLoading),
                          onSubmitted: _onSubmitted,
                        )
                      ],
                    ),
                    Wrap(
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        GestureDetector(
                          onTap: widget.flipCard,
                          child: Text(
                            " Log in",
                            style: TextStyle(
                              color: Colors.pink[300],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
