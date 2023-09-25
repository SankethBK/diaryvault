import 'package:dairy_app/core/errors/failure_template.dart';

class SyncFailure extends Failure {
  static const UNKNOWN_ERROR = -1;
  static const NO_INTERNET_CONNECTION = 0;
  static const CONNECTION_FAILED = 1;
  static const OTHER_DEVICE_SYNCING = 2;
  static const NO_SYNC_SOURCE_SELECTED = 3;
  static const UNATHENTICATED_CLIENT = 4;

  const SyncFailure._({required String message, required int code})
      : super(message: message, code: code);

  factory SyncFailure.unknownError([String? message]) {
    return SyncFailure._(
        message: message ?? "note sync failed", code: UNKNOWN_ERROR);
  }

  factory SyncFailure.noInternetConnection([String? message]) {
    return SyncFailure._(
        message: message ?? "no internet connection",
        code: NO_INTERNET_CONNECTION);
  }

  factory SyncFailure.connectionFailed([String? message]) {
    return SyncFailure._(
        message: message ?? "faied to establish connection",
        code: CONNECTION_FAILED);
  }

  factory SyncFailure.anotherDeviceIsSyncing([String? message]) {
    return SyncFailure._(
        message: message ??
            "Looks like another device us syncing, please try again after sometime",
        code: OTHER_DEVICE_SYNCING);
  }

  factory SyncFailure.noSyncSourceSelected([String? message]) {
    return SyncFailure._(
        message: message ?? "Please choose a sync source",
        code: NO_SYNC_SOURCE_SELECTED);
  }

  factory SyncFailure.stopSync([String? message]) {
    return SyncFailure._(
        message: message ?? "Stopping sync as client is unauthenticated",
        code: UNATHENTICATED_CLIENT);
  }
}
