import 'package:blockchain_utils/blockchain_utils.dart';

/// The TonPublicKey class encapsulates the functionality for handling Ed25519 public keys
/// specific to TON (The Open Network). It provides methods to create, serialize, and verify signatures with the public key.
class TonPublicKey {
  final ED25519PublicKey publickKey;

  /// Private constructor that initializes the TonPublicKey with an Ed25519PublicKey instance.
  const TonPublicKey(this.publickKey);

  /// Factory constructor that creates a TonPublicKey instance from a list of bytes.
  /// Throws a [BuError] if the provided bytes do not represent a valid Ed25519 public key.
  factory TonPublicKey.fromBytes(List<int> keyBytes) {
    try {
      return TonPublicKey(ED25519PublicKey.fromBytes(keyBytes));
    } catch (e) {
      throw BuError(
        DefaultErrorType.badPublicKey,
        'Invalid Ton Public key. Public key must be a valid Ed25519 key.',
        details: {
          'key': BytesUtils.toHexString(keyBytes),
          'error': e.toString(),
        },
      );
    }
  }

  /// Factory constructor that creates a TonPublicKey instance from a hexadecimal string.
  /// Converts the hex string to bytes and then calls the fromBytes constructor.
  factory TonPublicKey.fromHex(String keyHex) {
    return TonPublicKey.fromBytes(BytesUtils.fromHexString(keyHex));
  }

  /// Converts the public key to a list of bytes (excluding the leading format byte).
  BuBytes toBytes() {
    return publickKey.toBytes();
  }

  /// Converts the public key to a hexadecimal string.
  String toHex() {
    return toBytes().toHex();
  }

  /// Verifies a message's signature using the public key.
  bool verify(List<int> message, List<int> signature) {
    final verifier = ED25519Verifier(publickKey);
    return verifier.verify(message, ED25519Signature.fromBytes(signature));
  }
}
