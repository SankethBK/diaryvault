import 'package:dairy_app/core/errors/validation_exceptions.dart';
import 'package:dairy_app/features/auth/core/validators/email_validator.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/data/models/logged_in_user_model.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dairy_app/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_in_with_email_and_password_test.mocks.dart';

@GenerateMocks([EmailValidator, IAuthenticationRepository])
void main() {
  late MockEmailValidator emailValidator;
  late MockIAuthenticationRepository authenticationRepository;
  late SignInWithEmailAndPassword usecase;
  const String testEmail = "test@email";
  const String testPassword = "testpassword";
  const String testId = "77";
  const LoggedInUserModel user =
      LoggedInUserModel(email: testEmail, id: testId);

  setUp(() {
    emailValidator = MockEmailValidator();
    authenticationRepository = MockIAuthenticationRepository();
    usecase = SignInWithEmailAndPassword(
      emailValidator: emailValidator,
      authenticationRepository: authenticationRepository,
    );
  });

  group("Testing SignInWithEmailAndPassword usecase", () {
    test(
      'should return SignInFailure.inValidEmail when EmailValidator throws InvalidEmailException',
      () async {
        // arrange
        when(emailValidator(any))
            .thenThrow(InvalidEmailException.invalidEmail());

        // act
        final result = await usecase(
            const SignInParams(email: testEmail, password: testPassword));

        // assert
        verify(emailValidator(any));
        expect(result, equals(Left(SignInFailure.invalidEmail())));
      },
    );

    test(
      'should return LoggedinUser when repository returns LoggedInUser',
      () async {
        // arrange
        when(emailValidator(any)).thenReturn(true);
        when(
          authenticationRepository.signInWithEmailAndPassword(
              email: anyNamed("email"), password: anyNamed("password")),
        ).thenAnswer((_) async => const Right(user));

        // act
        var result = await usecase(
            const SignInParams(email: testEmail, password: testPassword));

        // assert
        verify(emailValidator(any));
        verify(
          authenticationRepository.signInWithEmailAndPassword(
              email: anyNamed("email"), password: anyNamed("password")),
        );
        expect(result, const Right(user));
      },
    );
  });
}
