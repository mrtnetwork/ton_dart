import 'package:blockchain_utils/exception/exception/blockchain_utils.dart';
import 'package:blockchain_utils/utils/equatable/equatable.dart';

/// Represents a TON (The Open Network) blockchain network and its associated parameters.
///
/// This class is used to define and work with different TON chains, such as the mainnet and testnet.
enum TonChainId {
  mainnet(-239),
  testnet(-3);

  final int id;
  const TonChainId(this.id);
  bool get isTestnet => this == testnet;
  factory TonChainId.fromId(int? id) => values.firstWhere(
    (e) => e.id == id,
    orElse: () => throw ItemNotFoundException(value: id),
  );
}

class TonWorkChain with Equality {
  final int id;
  const TonWorkChain(this.id);
  static const TonWorkChain masterchain = TonWorkChain(-1);
  static const TonWorkChain basechain = TonWorkChain(0);
  bool get isMasterchain => id == -1;
  bool get isBasechain => !isMasterchain;

  @override
  List<dynamic> get variables => [id];

  @override
  String toString() {
    return "TonWorkChain($id)";
  }
}
