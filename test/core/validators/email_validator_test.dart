import 'package:dairy_app/core/errors/validation_exceptions.dart';
import 'package:dairy_app/features/auth/core/validators/email_validator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late EmailValidator emailValidator;
  setUp(() {
    emailValidator = EmailValidator();
  });

  group("Testing of email validator with different corner cases", () {
    test("Valid emails", () {
      expect(emailValidator("email@example.com"), true);
      expect(emailValidator("firstname.lastname@example.com"), true);
      expect(emailValidator("email@subdomain.example.com"), true);
      expect(emailValidator("firstname+lastname@example.com"), true);
      expect(emailValidator("1234567890@example.com"), true);
      expect(emailValidator("email@example-one.com"), true);
      expect(emailValidator("_______@example.com"), true);
      expect(emailValidator("email@example.name"), true);
      expect(emailValidator("email@example.museum"), true);
      expect(emailValidator("email@example.co.jp"), true);
      expect(emailValidator("firstname-lastname@example.com"), true);
    });

    test("invalid emails", () {
      expect(() => emailValidator("plainaddress"),
          throwsA(isA<InvalidEmailException>()));
      expect(() => emailValidator("#@%^%#\$@#\$@#.com"),
          throwsA(isA<InvalidEmailException>()));
      expect(() => emailValidator("Joe Smith <email@example.com>"),
          throwsA(isA<InvalidEmailException>()));
      expect(() => emailValidator("email.example.com"),
          throwsA(isA<InvalidEmailException>()));
      expect(() => emailValidator(".email@example.com"),
          throwsA(isA<InvalidEmailException>()));
      expect(() => emailValidator("email.@example.com"),
          throwsA(isA<InvalidEmailException>()));
      expect(() => emailValidator("email..email@example.com"),
          throwsA(isA<InvalidEmailException>()));
      expect(() => emailValidator("email@example.com (Joe Smith)"),
          throwsA(isA<InvalidEmailException>()));
      expect(() => emailValidator("email@example"),
          throwsA(isA<InvalidEmailException>()));
      expect(() => emailValidator("email@111.222.333.44444"),
          throwsA(isA<InvalidEmailException>()));
      expect(() => emailValidator("email@example..com"),
          throwsA(isA<InvalidEmailException>()));
      expect(() => emailValidator("Abc..123@example.com"),
          throwsA(isA<InvalidEmailException>()));
    });
  });
}
