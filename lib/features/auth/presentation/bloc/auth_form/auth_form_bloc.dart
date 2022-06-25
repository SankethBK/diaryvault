import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/data/models/user_config_model.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dairy_app/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:dairy_app/features/auth/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/key_value_data_source_template.dart';
import 'package:equatable/equatable.dart';

part 'auth_form_event.dart';
part 'auth_form_state.dart';

final log = printer("AuthFormBloc");

/// [AuthFormBloc] handles both sign up and sign in flow, as both involve same fields
/// It updates [AuthSession]
class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> {
  final AuthSessionBloc _authSessionBloc;
  final SignUpWithEmailAndPassword signUpWithEmailAndPassword;
  final SignInWithEmailAndPassword signInWithEmailAndPassword;
  final IAuthenticationRepository authenticationRepository;
  final IKeyValueDataSource keyValueDataSource;

  bool fingerPrintAuthRunning = false;

  AuthFormBloc({
    required this.signInWithEmailAndPassword,
    required this.signUpWithEmailAndPassword,
    required this.authenticationRepository,
    required this.keyValueDataSource,
    required AuthSessionBloc authSessionBloc,
  })  : _authSessionBloc = authSessionBloc,
        super(const AuthFormInitial(email: '', password: '')) {
    on<StartFingerPrintAuthIfPossible>((event, emit) {
      if (shouldActivateFingerPrint() && !fingerPrintAuthRunning) {
        fingerPrintAuthRunning = true;
        Stream<FingerPrintAuthState> fingerPrintAuthStream =
            authenticationRepository.processFingerPrintAuth();

        late StreamSubscription<FingerPrintAuthState?>
            fingerPrintAuthStreamSubscription;
        fingerPrintAuthStreamSubscription =
            fingerPrintAuthStream.listen((value) async {
          log.d("FingerPrintAuthState stream value = $value");

          if (value == FingerPrintAuthState.success) {
            fingerPrintAuthStreamSubscription.cancel();
            fingerPrintAuthRunning = false;

            // Fingerprint auth successful, starting passwordless sign in

            String? lastLoggedInUser =
                keyValueDataSource.getValue(Global.lastLoggedInUser);
            if (lastLoggedInUser != null) {
              var result = await authenticationRepository.signInDirectly(
                  userId: lastLoggedInUser);

              result.fold((e) {
                log.e(e);
                emit(
                  AuthFormSubmissionFailed(
                    email: state.email,
                    password: state.password,
                    errors: {
                      "general": const ["fingerprint login failed"],
                      "random": [Random().nextInt(100)]
                    },
                  ),
                );
              }, (user) {
                // for fingerprint login, it's never fresh login
                _authSessionBloc
                    .add(UserLoggedIn(user: user, freshLogin: false));

                // no need to update lastLoggedInUser as it was already present and we used sa,e
              });
            } else {
              log.e("lastLoginUser not found");
              emit(
                AuthFormSubmissionFailed(
                  email: state.email,
                  password: state.password,
                  errors: {
                    "general": const ["fingerprint login failed"],
                    "random": [Random().nextInt(100)]
                  },
                ),
              );
            }
          } else if (value == FingerPrintAuthState.platformError) {
            fingerPrintAuthStreamSubscription.cancel();
            fingerPrintAuthRunning = false;
          } else if (value == FingerPrintAuthState.attemptsExceeded) {
            fingerPrintAuthStreamSubscription.cancel();

            emit(
              AuthFormSubmissionFailed(
                email: state.email,
                password: state.password,
                errors: {
                  "general": const [
                    "Too many wrong attempts, please login with password"
                  ],
                  "random": [Random().nextInt(100)]
                },
              ),
            );

            fingerPrintAuthRunning = false;
          } else if (value == FingerPrintAuthState.fail) {
            emit(
              AuthFormSubmissionFailed(
                email: state.email,
                password: state.password,
                errors: {
                  "general": const ["fingerprint not recognized"],
                  "random": [Random().nextInt(100)]
                },
              ),
            );
          }
        });
      }
    });

    on<AuthFormInputsChangedEvent>(
      (event, emit) {
        emit(
          AuthFormInitial(
            email: event.email ?? state.email,
            password: event.password ?? state.password,
          ),
        );
      },
    );

    on<AuthFormSignUpSubmitted>(((event, emit) async {
      emit(AuthFormSubmissionLoading(
          email: state.email, password: state.password));

      var result = await signUpWithEmailAndPassword(
          SignUpParams(email: state.email, password: state.password));

      result.fold((error) {
        Map<String, List> errorMap = {};

        if (error.code == SignUpFailure.UNKNOWN_ERROR) {
          errorMap["general"] = [error.message];
        }
        if (error.code == SignUpFailure.INVALID_EMAIL) {
          errorMap["email"] = [error.message];
        }
        if (error.code == SignUpFailure.EMAIL_ALREADY_EXISTS) {
          errorMap["email"] = [error.message];
        }
        if (error.code == SignUpFailure.INVALID_PASSWORD) {
          errorMap["password"] = [error.message];
        }
        if (error.code == SignUpFailure.NO_INTERNET_CONNECTION) {
          errorMap["general"] = [error.message];
        }

        emit(AuthFormSubmissionFailed(
            email: state.email, password: state.password, errors: errorMap));
      }, (user) async {
        _authSessionBloc.add(UserLoggedIn(user: user));

        // update the last logged in user
        await keyValueDataSource.setValue(Global.lastLoggedInUser, user.id);

        emit(AuthFormSubmissionSuccessful(
            email: state.email, password: state.password));
      });
    }));

    on<AuthFormSignInSubmitted>(((event, emit) async {
      emit(AuthFormSubmissionLoading(
          email: state.email, password: state.password));

      var result = await signInWithEmailAndPassword(
          SignInParams(email: state.email, password: state.password));

      result.fold((error) {
        Map<String, List> errorMap = {};

        if (error.code == SignInFailure.UNKNOWN_ERROR) {
          errorMap["general"] = [error.message];
        }
        if (error.code == SignInFailure.INVALID_EMAIL) {
          errorMap["email"] = [error.message];
        }
        if (error.code == SignInFailure.EMAIL_DOES_NOT_EXISTS) {
          errorMap["email"] = [error.message];
        }
        if (error.code == SignInFailure.WRONG_PASSWORD) {
          errorMap["password"] = [error.message];
        }
        if (error.code == SignInFailure.NO_INTERNET_CONNECTION) {
          errorMap["general"] = [error.message];
        }
        if (error.code == SignInFailure.USER_DISABLED) {
          errorMap["general"] = [error.message];
        }

        emit(AuthFormSubmissionFailed(
            email: state.email, password: state.password, errors: errorMap));
      }, (user) async {
        emit(AuthFormSubmissionSuccessful(
            email: state.email, password: state.password));

        // if current logged in user's id == last logeed in user's is, then freshlogin is false
        _authSessionBloc.add(
          UserLoggedIn(
            user: user,
            freshLogin: (event.lastLoggedInUserId != null &&
                event.lastLoggedInUserId != user.id),
          ),
        );

        // update the last logged in user
        await keyValueDataSource.setValue(Global.lastLoggedInUser, user.id);
      });
    }));
  }

  //* Utils

  /// Checks if UI can use fingerprint auth, based on last logged in user's preferences (if available)
  bool shouldActivateFingerPrint() {
    try {
      log.i("Checking for activating fingerprints");
      // see if lastLoggedInUser is present
      String? lastLoggedInUser =
          keyValueDataSource.getValue(Global.lastLoggedInUser);

      log.d("lastLoggedInUser = $lastLoggedInUser");

      if (lastLoggedInUser == null) {
        return false;
      }

      // See if userConfig is present for last logged in user
      String? userConfigData = keyValueDataSource.getValue(lastLoggedInUser);

      log.d("userConfig = $userConfigData");

      if (userConfigData == null) {
        return false;
      }

      var userConfig = UserConfigModel.fromJson(jsonDecode(userConfigData));

      return userConfig.isFingerPrintAuthPossible == true &&
          userConfig.isFingerPrintLoginEnabled == true;
    } catch (e) {
      log.e(e);
      return false;
    }
  }
}
