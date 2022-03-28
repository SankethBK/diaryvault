import 'package:bloc_test/bloc_test.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/data/repositories/authentication_repository.dart';
import 'package:dairy_app/features/auth/domain/entities/logged_in_user.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_form/auth_form_bloc.dart';
import 'package:dairy_app/features/auth/presentation/bloc/auth_session/auth_session_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_form_test.mocks.dart';

@GenerateMocks([AuthSessionBloc, AuthenticationRepository])
void main() {
  late MockAuthenticationRepository authenticationRepository;
  late MockAuthSessionBloc authSessionBloc;
  late AuthFormBloc authFormBloc;
  const String testEmail = "test@email";
  const String testPassword = "testpassword";
  const String testId = "77";
  const LoggedInUser user = LoggedInUser(email: testEmail, id: testId);

  setUp(() {
    authenticationRepository = MockAuthenticationRepository();
    authSessionBloc = MockAuthSessionBloc();
    authFormBloc = AuthFormBloc(
      authenticationRepository: authenticationRepository,
      authSessionBloc: authSessionBloc,
    );
  });

  group("Testing AuthFormBloc", () {
    test("Initial state should be AuthFormState", () {
      expect(
          authFormBloc.state, const AuthFormInitial(email: '', password: ''));
    });

    blocTest<AuthFormBloc, AuthFormState>(
      'emits [AuthFormInitial] when AuthFormInputsChangedEvent is added.',
      build: () => authFormBloc,
      act: (bloc) {
        bloc.add(const AuthFormInputsChangedEvent(
            email: testEmail, password: testPassword));
      },
      expect: () => const <AuthFormState>[
        AuthFormInitial(email: testEmail, password: testPassword)
      ],
    );

    group("Testing signUpWithEmailAndPassword", () {
      blocTest<AuthFormBloc, AuthFormState>(
        'emits [AuthFormSubmissionSuccessful] when AuthFormInputsChangedEvent is added.',
        build: () {
          when(authenticationRepository.signUpWithEmailAndPassword(
                  email: testEmail, password: testPassword))
              .thenAnswer((_) async => const Right(user));
          return authFormBloc;
        },
        act: (bloc) {
          bloc.add(const AuthFormInputsChangedEvent(
              email: testEmail, password: testPassword));
          bloc.add(AuthFormSignUpSubmitted());
        },
        expect: () => const <AuthFormState>[
          AuthFormInitial(email: testEmail, password: testPassword),
          AuthFormSubmissionLoading(email: testEmail, password: testPassword),
          AuthFormSubmissionSuccessful(email: testEmail, password: testPassword)
        ],
      );

      blocTest<AuthFormBloc, AuthFormState>(
        'emits [AuthFormSubmissionFailed(1)] when AuthFormSignUpSubmitted is added.',
        build: () {
          when(authenticationRepository.signUpWithEmailAndPassword(
                  email: testEmail, password: testPassword))
              .thenAnswer(
                  (_) async => Left(SignUpFailure.noInternetConnection()));
          return authFormBloc;
        },
        act: (bloc) {
          bloc.add(const AuthFormInputsChangedEvent(
              email: testEmail, password: testPassword));
          bloc.add(AuthFormSignUpSubmitted());
        },
        expect: () => <AuthFormState>[
          const AuthFormInitial(email: testEmail, password: testPassword),
          const AuthFormSubmissionLoading(
              email: testEmail, password: testPassword),
          AuthFormSubmissionFailed(
              email: testEmail,
              password: testPassword,
              errors: {
                "general": [SignUpFailure.noInternetConnection().message]
              })
        ],
      );

      blocTest<AuthFormBloc, AuthFormState>(
        'emits [AuthFormSubmissionFailed(2)] when AuthFormSignUpSubmitted is added.',
        build: () {
          when(authenticationRepository.signUpWithEmailAndPassword(
                  email: testEmail, password: testPassword))
              .thenAnswer((_) async => Left(SignUpFailure.invalidEmail()));
          return authFormBloc;
        },
        act: (bloc) {
          bloc.add(const AuthFormInputsChangedEvent(
              email: testEmail, password: testPassword));
          bloc.add(AuthFormSignUpSubmitted());
        },
        expect: () => <AuthFormState>[
          const AuthFormInitial(email: testEmail, password: testPassword),
          const AuthFormSubmissionLoading(
              email: testEmail, password: testPassword),
          AuthFormSubmissionFailed(
              email: testEmail,
              password: testPassword,
              errors: {
                "email": [SignUpFailure.invalidEmail().message]
              })
        ],
      );
    });

    group("Testing signInWithEmailAndPassword", () {
      blocTest<AuthFormBloc, AuthFormState>(
        'emits [AuthFormSubmissionSuccessful] when AuthFormSignInSubmitted is added.',
        build: () {
          when(authenticationRepository.signInWithEmailAndPassword(
                  email: testEmail, password: testPassword))
              .thenAnswer((_) async => const Right(user));
          return authFormBloc;
        },
        act: (bloc) {
          bloc.add(const AuthFormInputsChangedEvent(
              email: testEmail, password: testPassword));
          bloc.add(AuthFormSignInSubmitted());
        },
        expect: () => const <AuthFormState>[
          AuthFormInitial(email: testEmail, password: testPassword),
          AuthFormSubmissionLoading(email: testEmail, password: testPassword),
          AuthFormSubmissionSuccessful(email: testEmail, password: testPassword)
        ],
      );

      blocTest<AuthFormBloc, AuthFormState>(
        'emits [AuthFormSubmissionFailed(1)] when AuthFormSignInSubmitted is added.',
        build: () {
          when(authenticationRepository.signInWithEmailAndPassword(
                  email: testEmail, password: testPassword))
              .thenAnswer(
                  (_) async => Left(SignInFailure.noInternetConnection()));
          return authFormBloc;
        },
        act: (bloc) {
          bloc.add(const AuthFormInputsChangedEvent(
              email: testEmail, password: testPassword));
          bloc.add(AuthFormSignInSubmitted());
        },
        expect: () => <AuthFormState>[
          const AuthFormInitial(email: testEmail, password: testPassword),
          const AuthFormSubmissionLoading(
              email: testEmail, password: testPassword),
          AuthFormSubmissionFailed(
              email: testEmail,
              password: testPassword,
              errors: {
                "email": [SignInFailure.noInternetConnection().message]
              })
        ],
      );

      blocTest<AuthFormBloc, AuthFormState>(
        'emits [AuthFormSubmissionFailed(2)] when AuthFormSignInSubmitted is added.',
        build: () {
          when(authenticationRepository.signInWithEmailAndPassword(
                  email: testEmail, password: testPassword))
              .thenAnswer(
                  (_) async => Left(SignInFailure.emailDoesNotExists()));
          return authFormBloc;
        },
        act: (bloc) {
          bloc.add(const AuthFormInputsChangedEvent(
              email: testEmail, password: testPassword));
          bloc.add(AuthFormSignInSubmitted());
        },
        expect: () => <AuthFormState>[
          const AuthFormInitial(email: testEmail, password: testPassword),
          const AuthFormSubmissionLoading(
              email: testEmail, password: testPassword),
          AuthFormSubmissionFailed(
              email: testEmail,
              password: testPassword,
              errors: {
                "email": [SignInFailure.emailDoesNotExists().message]
              })
        ],
      );
    });
  });
}
