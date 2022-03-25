import 'validtor_template.dart';

class PasswordValidator implements Validator<String> {
  @override
  bool call(String password) {
    return password.length >= 6 && password.length <= 20;
  }
}
