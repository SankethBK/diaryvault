import 'package:dairy_app/core/errors/validation_exceptions.dart';
import 'package:dairy_app/core/validators/EmailValidator.dart';
import 'package:dairy_app/core/validators/PasswordValidator.dart';
import 'package:dairy_app/core/validators/validtor_template.dart';
import 'package:dairy_app/features/auth/core/failures/failures.dart';
import 'package:dairy_app/features/auth/domain/repositories/authentication_repository.dart';
import 'package:dairy_app/features/auth/domain/usecases/signUpWithEmailAndPassword.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'signUpWithEmailAndPassword_test.mocks.dart';

@GenerateMocks([EmailValidator, PasswordValidator, AuthenticationRepository])
void main() {
  late MockEmailValidator emailValidator;
  late MockPasswordValidator passwordValidator;
  late MockAuthenticationRepository authenticationRepository;
  late SignupWithEmailAndPassword usecase;
  final String testEmail = "test@email";
  final String testPassword = "testpassword";

  setUp(() {
    emailValidator = MockEmailValidator();
    passwordValidator = MockPasswordValidator();
    authenticationRepository = MockAuthenticationRepository();
    usecase = SignupWithEmailAndPassword(
      emailValidator: emailValidator,
      passwordValidator: passwordValidator,
      authenticationRepository: authenticationRepository,
    );
  });

  group("Testing SignupWithEmailAndPassword usecase", () {
    test(
      'should return SignUpFailure.invalidEmail() when email validator throws InvalidEmailException',
      () async {
        // arrange
        when(emailValidator(any))
            .thenThrow(InvalidEmailException.invalidEmail());

        // act
        final result =
            await usecase(Params(email: testEmail, password: testPassword));

        // assert
        verify(emailValidator(testEmail));
        expect(result, equals(Left(SignUpFailure.invalidEmail())));
      },
    );

    test(
      'should return SignUpFailure.invalidPassword when passwordValidator throws InvalidPasswordException [Short Password]',
      () async {
        // arrange
        when(emailValidator(any)).thenReturn(true);
        final passwordException = InvalidPasswordException.shortPassword();
        when(passwordValidator(any)).thenThrow(passwordException);

        // act
        final result =
            await usecase(Params(email: testEmail, password: testPassword));

        // assert
        verify(passwordValidator(testPassword));
        expect(result,
            Left(SignUpFailure.invalidPassword(passwordException.message)));
      },
    );

    test(
      'should return SignUpFailure.invalidPassword when passwordValidator throws InvalidPasswordException [Long Password]',
      () async {
        // arrange
        when(emailValidator(any)).thenReturn(true);
        final passwordException = InvalidPasswordException.longPassword();
        when(passwordValidator(any)).thenThrow(passwordException);

        // act
        final result =
            await usecase(Params(email: testEmail, password: testPassword));

        // assert
        verify(passwordValidator(testPassword));
        expect(result,
            Left(SignUpFailure.invalidPassword(passwordException.message)));
      },
    );
  });
}
