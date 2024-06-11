import 'package:blockchain_utils/bip/mnemonic/mnemonic.dart';
import 'package:ton_dart/src/crypto/exception/exception.dart';
import 'package:ton_dart/src/crypto/hd/mnemonic/ton_mnemonic_generator.dart';
import 'ton_entropy_generator.dart';

/// The TomMnemonicValidator class provides methods for validating TON (The Open Network)
/// mnemonic phrases. It ensures the mnemonic meets the required criteria for word count
/// and checks if a passphrase is needed or if it is a basic seed.
class TomMnemonicValidator {
  /// Validates the given mnemonic string, optionally with a passphrase.
  void validate(String mnemonic, {String passphrase = ''}) {
    final mn = Mnemonic.fromString(mnemonic);

    /// Validates the number of words in the mnemonic.
    TonMnemonicGeneratorUtils.validateWordsNum(mn.wordsCount());

    /// Checks if the mnemonic requires a passphrase but one is not provided.
    if (passphrase.isNotEmpty && !TonEntropyGeneratorUtils.isPasswordNeed(mn)) {
      throw KeyException("Invalid Ton mnemonic.");
    }

    /// Generates entropy from the mnemonic and passphrase, then checks if it is a basic seed.
    if (!TonEntropyGeneratorUtils.isBasicSeed(
        TonEntropyGeneratorUtils.generateEnteropy(mn,
            passphrase: passphrase))) {
      throw KeyException("Invalid Ton mnemonic.");
    }
  }

  /// Determines if the given mnemonic string is valid, optionally with a passphrase.
  bool isValid(String mnemonic, {String passphrase = ''}) {
    try {
      validate(mnemonic, passphrase: passphrase);
      return true;
    } catch (e) {
      return false;
    }
  }
}
