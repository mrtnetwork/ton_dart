import 'package:ton_dart/src/contracts/exception/exception.dart';

/// Represents a TON (The Open Network) blockchain network and its associated parameters.
///
/// This class is used to define and work with different TON chains, such as the mainnet and testnet.
class TonChainId {
  /// workchain
  final int workchain;

  /// global chain id
  final int id;
  const TonChainId._(this.workchain, this.id);
  static const TonChainId mainnet = TonChainId._(0, -239);
  static const TonChainId testnet = TonChainId._(-1, -3);
  static const List<TonChainId> values = [mainnet, testnet];

  /// pick chain from workchain
  static TonChainId fromWorkchain(int? workchain) {
    return values.firstWhere(
      (e) => e.workchain == workchain,
      orElse: () => throw const TonContractException('Invalid workchain.'),
    );
  }

  @override
  bool operator ==(other) {
    if (other is! TonChainId) return false;
    return workchain == other.workchain && id == other.id;
  }

  @override
  int get hashCode => workchain.hashCode ^ id.hashCode;
}
