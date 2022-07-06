import 'package:bloc/bloc.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/data/repositories/fingerprint_auth_repo.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dairy_app/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:dairy_app/features/auth/domain/usecases/sign_up_with_email_and_password.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/key_value_data_source_template.dart';
import 'package:dartz/dartz.dart';
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
  final FingerPrintAuthRepository fingerPrintAuthRepository;

  AuthFormBloc({
    required this.signInWithEmailAndPassword,
    required this.signUpWithEmailAndPassword,
    required this.authenticationRepository,
    required this.keyValueDataSource,
    required this.fingerPrintAuthRepository,
    required AuthSessionBloc authSessionBloc,
  })  : _authSessionBloc = authSessionBloc,
        super(const AuthFormInitial(email: '', password: '')) {
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

        // Cancel the fingerprint auth, in case it's running
        fingerPrintAuthRepository.cancel();

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

        // Cancel the fingerprint auth, in case it's running
        fingerPrintAuthRepository.cancel();

        log.d(
            "last logged in user id = ${event.lastLoggedInUserId}, current user id = ${user.id}");

        // update the last logged in user
        await keyValueDataSource.setValue(Global.lastLoggedInUser, user.id);

        // if current logged in user's id == last logeed in user's is, then freshlogin is false
        _authSessionBloc.add(
          UserLoggedIn(
            user: user,
            freshLogin: event.lastLoggedInUserId != user.id,
          ),
        );
      });
    }));

    on<ResetAuthForm>((event, emit) {
      emit(const AuthFormInitial(email: "", password: ""));
    });
  }

  //* Utils

  Future<Either<ForgotPasswordFailure, bool>> submitForgotPasswordEmail(
      String forgotPasswordEmail) async {
    return await authenticationRepository
        .submitForgotPasswordEmail(forgotPasswordEmail);
  }
}
