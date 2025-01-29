import 'package:blockchain_utils/utils/utils.dart';
import 'package:blockchain_utils/bip/ecc/bip_ecc.dart';
import 'package:ton_dart/src/crypto/exception/exception.dart';

import 'public_key.dart';
import 'signer_verifier.dart';

/// The TonPrivateKey class encapsulates the functionality for handling Ed25519 private keys
/// specific to TON (The Open Network). It provides methods to create, serialize, and sign data with the private key.
class TonPrivateKey {
  final Ed25519PrivateKey _privateKey;

  /// Private constructor that initializes the TonPrivateKey with an Ed25519PrivateKey instance.
  const TonPrivateKey._(this._privateKey);

  /// Factory constructor that creates a TonPrivateKey instance from a list of bytes.
  /// Throws a KeyException if the provided bytes do not represent a valid Ed25519 private key.
  factory TonPrivateKey.fromBytes(List<int> keyBytes) {
    try {
      return TonPrivateKey._(Ed25519PrivateKey.fromBytes(
          keyBytes.sublist(0, Ed25519KeysConst.privKeyByteLen)));
    } catch (e) {
      throw KeyException(
          'Invalid Ton Private key. Key must be a valid Ed25519 private key.',
          details: {
            'key': BytesUtils.toHexString(keyBytes),
            'error': e.toString()
          });
    }
  }

  /// Factory constructor that creates a TonPrivateKey instance from a hexadecimal string.
  /// Converts the hex string to bytes and then calls the fromBytes constructor.
  factory TonPrivateKey(String keyHex) {
    return TonPrivateKey.fromBytes(BytesUtils.fromHexString(keyHex));
  }

  /// Converts the private key to a list of bytes.
  List<int> toBytes() {
    return _privateKey.raw;
  }

  /// Converts the private key to a hexadecimal string.
  String toHex() {
    return _privateKey.toHex();
  }

  /// Derives the corresponding public key from the private key.
  TonPublicKey toPublicKey() {
    return TonPublicKey.fromBytes(_privateKey.publicKey.compressed);
  }

  /// Signs a digest (message hash) using the private key and returns the signature.
  List<int> sign(List<int> digest) {
    final signer = TonSigner.fromKeyBytes(toBytes());
    return signer.sign(digest);
  }
}
