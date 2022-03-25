import 'package:dairy_app/core/validators/EmailValidator.dart';
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
      expect(emailValidator("plainaddress"), false);
      expect(emailValidator("#@%^%#\$@#\$@#.com"), false);
      expect(emailValidator("Joe Smith <email@example.com>"), false);
      expect(emailValidator("email.example.com"), false);
      expect(emailValidator(".email@example.com"), false);
      expect(emailValidator("email.@example.com"), false);
      expect(emailValidator("email..email@example.com"), false);
      expect(emailValidator("email@example.com (Joe Smith)"), false);
      expect(emailValidator("email@example"), false);
      expect(emailValidator("email@111.222.333.44444"), false);
      expect(emailValidator("email@example..com"), false);
      expect(emailValidator("Abc..123@example.com"), false);
    });
  });
}
