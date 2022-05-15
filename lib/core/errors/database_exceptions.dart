import 'package:dairy_app/core/errors/custom_exception_template.dart';

class DatabaseInsertionException extends CustomException {
  const DatabaseInsertionException([String? message])
      : super(
          code: -1,
          message: message ?? "something went wrong",
        );
}

class DatabaseQueryException extends CustomException {
  const DatabaseQueryException([String? message])
      : super(
          code: 0,
          message: message ?? "something went wrong",
        );
}

class DatabaseUpdateException extends CustomException {
  const DatabaseUpdateException([String? message])
      : super(code: 1, message: message ?? "something went wrong");
}

class DatabaseDeleteException extends CustomException {
  const DatabaseDeleteException([String? message])
      : super(code: 1, message: message ?? "something went wrong");
}
