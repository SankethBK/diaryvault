import 'package:bloc/bloc.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/data/repositories/authentication_repository.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_form_event.dart';
part 'auth_form_state.dart';

/// [AuthFormBloc] handles both sign up and sign in flow, as both involve same fields
/// It updates [AuthSession]
class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> {
  final AuthenticationRepository _authenticationRepository;
  final AuthSessionBloc _authSessionBloc;

  AuthFormBloc({
    required AuthenticationRepository authenticationRepository,
    required AuthSessionBloc authSessionBloc,
  })  : _authenticationRepository = authenticationRepository,
        _authSessionBloc = authSessionBloc,
        super(const AuthFormInitial(email: '', password: '')) {
    on<AuthFormEvent>((event, emit) {
      on<AuthFormInputsChangedEvent>(
        ((event, emit) {
          emit(AuthFormInitial(
            email: event.email ?? state.email,
            password: event.password ?? state.password,
          ));
        }),
      );

      on<AuthFormSignUpSubmitted>(((event, emit) async {
        emit(AuthFormSubmissionLoading(
            email: state.email, password: state.password));

        var result = await _authenticationRepository.signUpWithEmailAndPassword(
            email: state.email, password: state.password);

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
        }, (user) {
          _authSessionBloc.add(UserLoggedIn(user: user));
          emit(AuthFormSubmissionSuccessful(
              email: state.email, password: state.password));
        });
      }));

      on<AuthFormSignInSubmitted>(((event, emit) async {
        emit(AuthFormSubmissionLoading(
            email: state.email, password: state.password));

        var result = await _authenticationRepository.signInWithEmailAndPassword(
            email: state.email, password: state.password);

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
          if (error.code == SignInFailure.USER_DISABLED) {
            errorMap["general"] = [error.message];
          }

          emit(AuthFormSubmissionFailed(
              email: state.email, password: state.password, errors: errorMap));
        }, (user) {
          _authSessionBloc.add(UserLoggedIn(user: user));
          emit(AuthFormSubmissionSuccessful(
              email: state.email, password: state.password));
        });
      }));
    });
  }
}
