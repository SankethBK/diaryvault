import 'dart:async';

import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/encryption/domain/repositories/key_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Exposes the encryption session to widgets. State is the key manager's
/// session state (NotSetUp / Locked / Unlocked).
class EncryptionCubit extends Cubit<EncryptionSessionState> {
  final IKeyManager keyManager;
  late final StreamSubscription _subscription;

  EncryptionCubit({required this.keyManager})
      : super(keyManager.currentState) {
    _subscription = keyManager.state.listen(emit);
  }

  /// Returns null on success, or the failure to display.
  Future<EncryptionFailure?> unlock(String passphrase) async {
    final result = await keyManager.unlock(passphrase);
    return result.fold((failure) => failure, (_) => null);
  }

  /// Returns null on success, or the failure to display.
  Future<EncryptionFailure?> unlockWithRecovery(String code) async {
    final result = await keyManager.unlockWithRecovery(code);
    return result.fold((failure) => failure, (_) => null);
  }

  /// Returns the recovery code on success (to display once), or the failure.
  Future<Object?> setup(String passphrase) async {
    final result = await keyManager.setupWithPassphrase(passphrase);
    return result.fold((failure) => failure, (recoveryCode) => recoveryCode);
  }

  void lock() => keyManager.lock();

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
