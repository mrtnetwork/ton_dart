import 'package:ton_dart/src/contracts/exception/exception.dart';

/// Represents a TON (The Open Network) blockchain network and its associated parameters.
///
/// This class is used to define and work with different TON chains, such as the mainnet and testnet.
class TonChain {
  final int workchain;
  final int id;
  const TonChain._(this.workchain, this.id);
  static const TonChain mainnet = TonChain._(0, -239);
  static const TonChain testnet = TonChain._(-1, -3);
  static const List<TonChain> values = [mainnet, testnet];
  static TonChain fromWorkchain(int? workchain) {
    return values.firstWhere(
      (e) => e.workchain == workchain,
      orElse: () => throw const TonContractException("Invalid workchain."),
    );
  }

  @override
  operator ==(other) {
    if (other is! TonChain) return false;
    return workchain == other.workchain && id == other.id;
  }

  @override
  int get hashCode => workchain.hashCode ^ id.hashCode;
}
