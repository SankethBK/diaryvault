import 'dart:convert';

import 'crypto_types.dart';

/// One key slot: a copy of the master key wrapped with a KEK derived from a
/// passphrase or recovery code. LUKS-style slots let the passphrase change
/// (or the recovery code exist) without re-encrypting any note content.
class KeySlot {
  final KdfParams kdfParams;
  final WrappedKey wrappedMasterKey;

  const KeySlot({required this.kdfParams, required this.wrappedMasterKey});

  Map<String, dynamic> toJson() => {
        "kdf": kdfParams.toJson(),
        "wrapped_master_key": wrappedMasterKey.toBase64(),
      };

  factory KeySlot.fromJson(Map<String, dynamic> json) => KeySlot(
        kdfParams: KdfParams.fromJson(json["kdf"]),
        wrappedMasterKey: WrappedKey.fromBase64(json["wrapped_master_key"]),
      );
}

/// Contents of encryption_meta.json. Stored in the cloud sync folder (and
/// cached locally) - deliberately NOT tied to any user identity: anyone with
/// access to the sync folder and the correct passphrase can unlock.
class EncryptionMeta {
  static const int currentVersion = 1;

  /// Known plaintext encrypted with the master key; used to distinguish
  /// "wrong passphrase" from "corrupt data" without storing a password hash
  static const String keyCheckPlaintext = "diaryvault-key-check";

  final int version;
  final KeySlot passphraseSlot;
  final KeySlot? recoverySlot;

  /// base64 AEAD payload of [keyCheckPlaintext] under the master key
  final String keyCheck;

  const EncryptionMeta({
    required this.version,
    required this.passphraseSlot,
    this.recoverySlot,
    required this.keyCheck,
  });

  String serialize() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => {
        "version": version,
        "slots": {
          "passphrase": passphraseSlot.toJson(),
          if (recoverySlot != null) "recovery": recoverySlot!.toJson(),
        },
        "key_check": keyCheck,
      };

  factory EncryptionMeta.fromJson(Map<String, dynamic> json) {
    final slots = json["slots"] as Map<String, dynamic>;
    return EncryptionMeta(
      version: json["version"],
      passphraseSlot: KeySlot.fromJson(slots["passphrase"]),
      recoverySlot:
          slots["recovery"] != null ? KeySlot.fromJson(slots["recovery"]) : null,
      keyCheck: json["key_check"],
    );
  }

  factory EncryptionMeta.deserialize(String raw) =>
      EncryptionMeta.fromJson(jsonDecode(raw));
}
