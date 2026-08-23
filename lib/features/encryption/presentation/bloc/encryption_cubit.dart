import 'dart:async';

import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/encryption/domain/repositories/encryption_session_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Exposes the encryption session to widgets. State is the session service's
/// state (Disabled / Locked / Unlocked).
class EncryptionCubit extends Cubit<EncryptionSessionState> {
  final IEncryptionSessionService sessionService;
  late final StreamSubscription _subscription;

  EncryptionCubit({required this.sessionService})
      : super(sessionService.currentState) {
    _subscription = sessionService.state.listen(emit);
  }

  /// Returns null on success, or the failure to display.
  Future<EncryptionFailure?> unlock(String passphrase) async {
    final result = await sessionService.unlock(passphrase);
    return result.fold((failure) => failure, (_) => null);
  }

  /// Returns null on success, or the failure to display.
  Future<EncryptionFailure?> unlockWithRecovery(String code) async {
    final result = await sessionService.unlockWithRecovery(code);
    return result.fold((failure) => failure, (_) => null);
  }

  /// Returns the recovery code on success, or the failure.
  Future<Object?> enable(String passphrase) async {
    final result = await sessionService.enable(passphrase);
    return result.fold((failure) => failure, (recoveryCode) => recoveryCode);
  }

  void lock() => sessionService.lock();

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
