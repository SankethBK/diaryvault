import '../../../../core/errors/failure_template.dart';

class NotesFailure extends Failure {
  static const UNKNOWN_ERROR = -1;

  const NotesFailure._({required String message, required int code})
      : super(message: message, code: code);

  factory NotesFailure.unknownError([String? message]) {
    return NotesFailure._(
        message: message ?? "something went wrong", code: UNKNOWN_ERROR);
  }
}
