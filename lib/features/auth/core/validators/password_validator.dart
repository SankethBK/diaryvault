import 'package:dairy_app/core/constants/exports.dart';

class PasswordValidator implements Validator<String> {
  @override
  bool call(String password) {
    if (password.length < 6) {
      throw InvalidPasswordException.shortPassword();
    }
    if (password.length > 20) {
      throw InvalidPasswordException.longPassword();
    }

    return true;
  }
}
