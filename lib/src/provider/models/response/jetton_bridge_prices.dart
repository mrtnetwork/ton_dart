import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class JettonBridgePricesResponse with JsonSerialization {
  final BigInt bridgeBurnFee;
  final BigInt bridgeMintFee;
  final BigInt walletMinTonsForStorage;
  final BigInt walletGasConsumption;
  final BigInt minterMinTonsForStorage;
  final BigInt discoverGasConsumption;

  const JettonBridgePricesResponse({
    required this.bridgeBurnFee,
    required this.bridgeMintFee,
    required this.walletMinTonsForStorage,
    required this.walletGasConsumption,
    required this.minterMinTonsForStorage,
    required this.discoverGasConsumption,
  });

  factory JettonBridgePricesResponse.fromJson(Map<String, dynamic> json) {
    return JettonBridgePricesResponse(
      bridgeBurnFee: BigintUtils.parse(json['bridge_burn_fee']),
      bridgeMintFee: BigintUtils.parse(json['bridge_mint_fee']),
      walletMinTonsForStorage:
          BigintUtils.parse(json['wallet_min_tons_for_storage']),
      walletGasConsumption: BigintUtils.parse(json['wallet_gas_consumption']),
      minterMinTonsForStorage:
          BigintUtils.parse(json['minter_min_tons_for_storage']),
      discoverGasConsumption:
          BigintUtils.parse(json['discover_gas_consumption']),
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'bridge_burn_fee': bridgeBurnFee.toString(),
      'bridge_mint_fee': bridgeMintFee.toString(),
      'wallet_min_tons_for_storage': walletMinTonsForStorage.toString(),
      'wallet_gas_consumption': walletGasConsumption.toString(),
      'minter_min_tons_for_storage': minterMinTonsForStorage.toString(),
      'discover_gas_consumption': discoverGasConsumption.toString(),
    };
  }
}
