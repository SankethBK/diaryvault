import 'dart:ui';

import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatelessWidget {
  static String get route => '/auth';
  final void Function() flipCard;

  const SignInForm({
    Key? key,
    required this.flipCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthFormBloc bloc = sl<AuthFormBloc>();
    return BlocConsumer<AuthFormBloc, AuthFormState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is AuthFormSubmissionFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errors["general"]![0]),
            ),
          );
        }
      },
      builder: (context, state) {
        String? _getEmailErrors() {
          if (state is AuthFormSubmissionFailed) {
            return state.errors["email"]?[0];
          }
          return null;
        }

        String? _getpasswordErrors() {
          if (state is AuthFormSubmissionFailed) {
            return state.errors["password"]?[0];
          }
          return null;
        }

        return Center(
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 24,
                spreadRadius: 16,
                color: Colors.black.withOpacity(0.1),
              )
            ]),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 40.0,
                  sigmaY: 40.0,
                ),
                child: Container(
                  height: 400,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16.0),
                    // gradient: LinearGradient(
                    //   colors: [
                    //     Colors.white.withOpacity(0.8),
                    //     Colors.white.withOpacity(0.5),
                    //   ],
                    //   begin: AlignmentDirectional.topStart,
                    //   end: AlignmentDirectional.bottomEnd,
                    // ),
                    border: Border.all(
                      width: 1.5,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        TextField(
                          onChanged: (String email) {
                            bloc.add(AuthFormInputsChangedEvent(email: email));
                          },
                          decoration: InputDecoration(
                            hintText: "email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            fillColor: Colors.white.withOpacity(0.3),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: BorderSide(
                                color: Colors.black.withOpacity(0.6),
                                width: 1,
                              ),
                            ),
                            errorText: _getEmailErrors(),
                            errorStyle:
                                TextStyle(color: Colors.yellow, fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          onChanged: (String password) {
                            bloc.add(
                                AuthFormInputsChangedEvent(password: password));
                          },
                          decoration: InputDecoration(
                            hintText: "password",
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            suffixIcon: InkWell(
                                onTap: () {},
                                child: Icon(
                                    true
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black.withOpacity(0.5))),
                            fillColor: Colors.white.withOpacity(0.3),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide(
                                  color: Colors.black.withOpacity(0.6),
                                  width: 1,
                                )),
                            errorText: _getpasswordErrors(),
                            errorStyle:
                                TextStyle(color: Colors.yellow, fontSize: 14),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: BorderSide.none),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          icon: (state is AuthFormSubmissionLoading)
                              ? const SizedBox(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  width: 20,
                                  height: 20)
                              : const SizedBox.shrink(),
                          onPressed: (state is AuthFormSubmissionLoading)
                              ? null
                              : () {
                                  bloc.add(AuthFormSignInSubmitted());
                                },
                          label: Text(
                            "Submit",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.purple,
                            onPrimary: Colors.pink,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                            elevation: 4,
                            side: BorderSide(
                              color: Colors.black.withOpacity(0.5),
                              width: 1,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Wrap(
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                            GestureDetector(
                              onTap: flipCard,
                              child: Text(
                                " Sign up",
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
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
