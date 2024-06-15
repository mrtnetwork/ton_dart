// ignore_for_file: unused_local_variable

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  /// Define password for mnemonic generation
  const String password = "MRTNETWORK";

  /// Generate mnemonic from specified number of words and password
  final mnemonic =
      TonMnemonicGenerator().fromWordsNumber(24, password: password);

  /// Generate seed from mnemonic
  final seed = TonSeedGenerator(mnemonic)
      .generate(password: password, validateTonMnemonic: true);

  /// Derive private key from seed
  final privateKey = TonPrivateKey.fromBytes(seed);

  /// Derive public key from private key
  final publicKey = privateKey.toPublicKey();

  /// Create WalletV4 instance with derived public key
  final wallet = WalletV4(workChain: -1, publicKey: publicKey.toBytes());

  /// Get address from wallet
  final address = wallet.address;
}
