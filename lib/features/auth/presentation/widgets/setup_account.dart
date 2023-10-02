import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/settings_tile.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/auth/presentation/widgets/email_input_field.dart';
import 'package:dairy_app/features/auth/presentation/widgets/password_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetupAccount extends StatefulWidget {
  const SetupAccount({Key? key}) : super(key: key);

  @override
  State<SetupAccount> createState() => _SetupAccountState();
}

class _SetupAccountState extends State<SetupAccount> {
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
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    AuthFormBloc bloc = BlocProvider.of<AuthFormBloc>(context);

    return BlocBuilder<UserConfigCubit, UserConfigState>(
      builder: (context, state) {
        if (state.userConfigModel?.userId == GuestUserDetails.guestUserId) {
          return Material(
            color: Colors.transparent,
            child: SettingsTile(
              onTap: () async {
                await showCustomDialog(
                  context: context,
                  child: BlocConsumer<AuthFormBloc, AuthFormState>(
                    listener: (context, state) {
                      if (state is AuthFormSubmissionFailed &&
                          state.errors.containsKey("general")) {
                        showToast(state.errors["general"]![0]);
                      }

                      if (state is AuthFormSubmissionSuccessful) {
                        showToast("Account setup successful");
                        Navigator.pop(context);
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

                      void _onPasswordChanged(String password) => bloc
                          .add(AuthFormInputsChangedEvent(password: password));

                      void _onSubmitted() =>
                          bloc.add(AuthFormSignUpSubmitted());
                      return Container(
                        width: 300,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Setup your Account",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: mainTextColor,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
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
                                  isLoading:
                                      (state is AuthFormSubmissionLoading),
                                  onSubmitted: _onSubmitted,
                                  buttonText: "Submit",
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
              child: Text(
                "Setup your account",
                style: TextStyle(
                  fontSize: 16.0,
                  color: mainTextColor,
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
