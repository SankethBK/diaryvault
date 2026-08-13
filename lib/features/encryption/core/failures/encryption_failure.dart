import '../../../../core/errors/failure_template.dart';

class EncryptionFailure extends Failure {
  static const WRONG_PASSPHRASE = 1;
  static const NOT_SET_UP = 2;
  static const ALREADY_SET_UP = 3;
  static const LOCKED = 4;
  static const META_CORRUPTED = 5;
  static const UNKNOWN_ERROR = -1;

  const EncryptionFailure._({required String message, required int code})
      : super(message: message, code: code);

  factory EncryptionFailure.wrongPassphrase() {
    return const EncryptionFailure._(
        message: "incorrect passphrase or recovery code",
        code: WRONG_PASSPHRASE);
  }

  factory EncryptionFailure.notSetUp() {
    return const EncryptionFailure._(
        message: "encryption is not set up", code: NOT_SET_UP);
  }

  factory EncryptionFailure.alreadySetUp() {
    return const EncryptionFailure._(
        message: "encryption is already set up", code: ALREADY_SET_UP);
  }

  factory EncryptionFailure.locked() {
    return const EncryptionFailure._(
        message: "encryption session is locked", code: LOCKED);
  }

  factory EncryptionFailure.metaCorrupted() {
    return const EncryptionFailure._(
        message: "encryption metadata is corrupted", code: META_CORRUPTED);
  }

  factory EncryptionFailure.unknownError([String? message]) {
    return EncryptionFailure._(
        message: message ?? "something went wrong", code: UNKNOWN_ERROR);
  }
}
