import 'package:dairy_app/core/validators/PasswordValidator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PasswordValidator passwordValidator;

  setUp(() {
    passwordValidator = PasswordValidator();
  });

  group("Password validation test", () {
    test("Password must be more than 6 characters", () {
      expect(passwordValidator("1234abc"), true);
      expect(passwordValidator("14abc"), false);
    });

    test("Password must be less than 20 characters", () {
      expect(passwordValidator("1234512345123451234"), true);
      expect(passwordValidator("123451234512345123456"), false);
    });
  });
}
