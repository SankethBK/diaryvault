import 'package:dairy_app/core/errors/validation_exceptions.dart';

import '../../../../core/validators/validtor_template.dart';

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
