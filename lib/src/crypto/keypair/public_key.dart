import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/bip/ecc/keys/ed25519_keys.dart';
import 'package:ton_dart/src/crypto/exception/exception.dart';

import 'signer_verifier.dart';

/// The TonPublicKey class encapsulates the functionality for handling Ed25519 public keys
/// specific to TON (The Open Network). It provides methods to create, serialize, and verify signatures with the public key.
class TonPublicKey {
  final Ed25519PublicKey _publickKey;

  /// Private constructor that initializes the TonPublicKey with an Ed25519PublicKey instance.
  const TonPublicKey._(this._publickKey);

  /// Factory constructor that creates a TonPublicKey instance from a list of bytes.
  /// Throws a KeyException if the provided bytes do not represent a valid Ed25519 public key.
  factory TonPublicKey.fromBytes(List<int> keyBytes) {
    try {
      return TonPublicKey._(Ed25519PublicKey.fromBytes(keyBytes));
    } catch (e) {
      throw KeyException(
          'Invalid Ton Public key. Public key must be a valid Ed25519 key.',
          details: {
            'key': BytesUtils.toHexString(keyBytes),
            'error': e.toString()
          });
    }
  }

  /// Factory constructor that creates a TonPublicKey instance from a hexadecimal string.
  /// Converts the hex string to bytes and then calls the fromBytes constructor.
  factory TonPublicKey(String keyHex) {
    return TonPublicKey.fromBytes(BytesUtils.fromHexString(keyHex));
  }

  /// Converts the public key to a list of bytes (excluding the leading format byte).
  List<int> toBytes() {
    return _publickKey.compressed.sublist(1);
  }

  /// Converts the public key to a hexadecimal string.
  String toHex() {
    return BytesUtils.toHexString(toBytes());
  }

  /// Verifies a message's signature using the public key.
  bool verify(List<int> message, List<int> signature) {
    final verifier = TonVerifier.fromKeyBytes(_publickKey.compressed);
    return verifier.verify(message, signature);
  }
}
