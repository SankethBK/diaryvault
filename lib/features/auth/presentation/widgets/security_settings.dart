import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/auth/presentation/widgets/password_enter_popup.dart';
import 'package:dairy_app/features/auth/presentation/widgets/password_reset_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SecuritySettings extends StatelessWidget {
  late IAuthenticationRepository authenticationRepository;
  SecuritySettings({Key? key}) : super(key: key) {
    authenticationRepository = sl<IAuthenticationRepository>();
  }

  @override
  Widget build(BuildContext context) {
    final authSessionBloc = BlocProvider.of<AuthSessionBloc>(context);
    return Container(
      padding: const EdgeInsets.only(top: 5.0),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Security",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 7.0),
          Material(
            color: Colors.transparent,
            child: InkWell(
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                title: const Text("Change password"),
                onTap: () async {
                  //! accessing userId like this is bad, but since it is assured that userId will be always present if user is logged in we are doing it
                  String? result = await passwordLoginPopup(
                    context: context,
                    submitPassword: (password) =>
                        authenticationRepository.verifyPassword(
                            authSessionBloc.state.user!.id, password),
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
                            ));
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
