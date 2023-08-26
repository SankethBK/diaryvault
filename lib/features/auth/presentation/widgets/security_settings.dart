import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/auth/presentation/widgets/email_change_popup.dart';
import 'package:dairy_app/features/auth/presentation/widgets/password_enter_popup.dart';
import 'package:dairy_app/features/auth/presentation/widgets/password_reset_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SecuritySettings extends StatelessWidget {
  late IAuthenticationRepository authenticationRepository;
  SecuritySettings({Key? key}) : super(key: key) {
    authenticationRepository = sl<IAuthenticationRepository>();
  }

  @override
  Widget build(BuildContext context) {
    final authSessionBloc = BlocProvider.of<AuthSessionBloc>(context);
    final userConfigCubit = BlocProvider.of<UserConfigCubit>(context);

    return Container(
      padding: const EdgeInsets.only(top: 5.0),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Security",
            style: GoogleFonts.lato(
              textStyle: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          Material(
            color: Colors.transparent,
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: const [
                    Text("Change password", style: TextStyle(fontSize: 16.0)),
                  ],
                ),
              ),
              onTap: () async {
                //! accessing userId like this is bad, but since it is assured that userId will be always present if user is logged in we are doing it
                String? result = await passwordLoginPopup(
                  context: context,
                  submitPassword: (password) => authenticationRepository
                      .verifyPassword(authSessionBloc.state.user!.id, password),
                );

                // old password will be retrieved from previous dialog
                if (result != null) {
                  passwordResetPopup(
                    context: context,
                    submitPassword: (newPassword) =>
                        authenticationRepository.updatePassword(
                      authSessionBloc.state.user!.email,
                      result,
                      newPassword,
                    ),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 10.0),
          Material(
            color: Colors.transparent,
            child: InkWell(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  children: [
                    Text("Change email", style: TextStyle(fontSize: 16.0)),
                  ],
                ),
              ),
              onTap: () async {
                //! accessing userId like this is bad, but since it is assured that userId will be always present if user is logged in we are doing it
                String? result = await passwordLoginPopup(
                  context: context,
                  submitPassword: (password) => authenticationRepository
                      .verifyPassword(authSessionBloc.state.user!.id, password),
                );

                // old password will be retrieved from previous dialog
                var emailChanged;
                if (result != null) {
                  emailChanged = await emailChangePopup(
                    context,
                    (newEmail) => authenticationRepository.updateEmail(
                      oldEmail: authSessionBloc.state.user!.email,
                      password: result,
                      newEmail: newEmail,
                    ),
                  );
                }

                if (emailChanged == true) {
                  authSessionBloc.add(UserLoggedOut());
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<UserConfigCubit, UserConfigState>(
            builder: (context, state) {
              var isFingerPrintLoginEnabledValue =
                  state.userConfigModel!.isFingerPrintLoginEnabled;
              return SwitchListTile(
                activeColor: Colors.pinkAccent,
                contentPadding: const EdgeInsets.all(0.0),
                title: const Text("Enable fingerprint login"),
                subtitle: const Text(
                    "Fingerprint auth should be enabled in device settings"),
                value: isFingerPrintLoginEnabledValue ?? false,
                onChanged: (value) async {
                  try {
                    await authenticationRepository.isFingerprintAuthPossible();
                    userConfigCubit.setUserConfig(
                      UserConfigConstants.isFingerPrintLoginEnabled,
                      value,
                    );
                  } on Exception catch (e) {
                    showToast(e.toString().replaceAll("Exception: ", ""));
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
