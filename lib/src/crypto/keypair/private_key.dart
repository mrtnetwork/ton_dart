import 'package:blockchain_utils/blockchain_utils.dart';
import 'public_key.dart';

/// The TonPrivateKey class encapsulates the functionality for handling Ed25519 private keys
/// specific to TON (The Open Network). It provides methods to create, serialize, and sign data with the private key.
class TonPrivateKey with SecretState {
  final ED25519PrivateKey privateKey;

  /// Private constructor that initializes the TonPrivateKey with an Ed25519PrivateKey instance.
  const TonPrivateKey(this.privateKey);

  /// Factory constructor that creates a TonPrivateKey instance from a list of bytes.
  /// Throws a [BuError] if the provided bytes do not represent a valid Ed25519 private key.
  factory TonPrivateKey.fromBytes(List<int> keyBytes) {
    try {
      return TonPrivateKey(ED25519PrivateKey.fromBytes(keyBytes));
    } catch (e) {
      throw BuError(
        DefaultErrorType.badPrivateKey,
        'Invalid Ton Private key. Key must be a valid Ed25519 private key.',
        details: {
          'key': BytesUtils.toHexString(keyBytes),
          'error': e.toString(),
        },
      );
    }
  }

  /// Factory constructor that creates a TonPrivateKey instance from a hexadecimal string.
  /// Converts the hex string to bytes and then calls the fromBytes constructor.
  factory TonPrivateKey.fromHex(String keyHex) {
    final bytes = BytesUtils.fromHexString(keyHex);
    try {
      return TonPrivateKey.fromBytes(bytes);
    } finally {
      bytes.forceZero();
    }
  }

  /// Converts the private key to a list of bytes.
  SecretBytes toBytes() {
    return privateKey.toBytes();
  }

  /// Converts the private key to a hexadecimal string.
  String toHex() {
    return privateKey.takeSecretKey().toHex();
  }

  /// Derives the corresponding public key from the private key.
  TonPublicKey toPublicKey() {
    return TonPublicKey(privateKey.publicKey);
  }

  /// Signs a digest (message hash) using the private key and returns the signature.
  BuBytes sign(List<int> digest) {
    final signer = ED25519Signer(privateKey);
    return signer.sign(digest).encoded;
  }

  @override
  void dispose() {
    privateKey.dispose();
  }
}
