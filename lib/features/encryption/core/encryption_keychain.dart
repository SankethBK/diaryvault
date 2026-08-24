import 'dart:convert';

import 'crypto_types.dart';

/// The encryption keychain: everything needed to derive/unlock the master
/// key, containing NO secrets by itself (only salt + AEAD-wrapped key blobs).
///
/// Persisted locally (shared_prefs) for convenience AND replicated onto every
/// encrypted note row, so it travels with cloud sync and a fresh device can
/// unlock with just the passphrase - there is no separate metadata file.
class EncryptionKeychain {
  final KdfParams kdfParams;
  final WrappedKey wrappedMkPass;
  final WrappedKey wrappedMkRecovery;

  const EncryptionKeychain({
    required this.kdfParams,
    required this.wrappedMkPass,
    required this.wrappedMkRecovery,
  });

  Map<String, dynamic> toJson() => {
        "kdf": kdfParams.toJson(),
        "wrapped_mk_pass": wrappedMkPass.toBase64(),
        "wrapped_mk_recovery": wrappedMkRecovery.toBase64(),
      };

  factory EncryptionKeychain.fromJson(Map<String, dynamic> json) =>
      EncryptionKeychain(
        kdfParams: KdfParams.fromJson(json["kdf"]),
        wrappedMkPass: WrappedKey.fromBase64(json["wrapped_mk_pass"]),
        wrappedMkRecovery: WrappedKey.fromBase64(json["wrapped_mk_recovery"]),
      );

  String serialize() => jsonEncode(toJson());

  factory EncryptionKeychain.deserialize(String raw) =>
      EncryptionKeychain.fromJson(jsonDecode(raw));
}
