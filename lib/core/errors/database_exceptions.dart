import 'package:dairy_app/core/errors/custom_exception_template.dart';

class DatabaseInsertionException extends CustomException {
  const DatabaseInsertionException()
      : super(
          code: -1,
          message: "something went wrong, could not sign up user",
        );
}
