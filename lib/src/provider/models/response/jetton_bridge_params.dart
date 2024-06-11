import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'jetton_bridge_prices.dart';
import 'oracle.dart';

class JettonBridgeParamsResponse with JsonSerialization {
  final String bridgeAddress;
  final String oraclesAddress;
  final int stateFlags;
  final BigInt? burnBridgeFee;
  final List<OracleResponse> oracles;
  final String? externalChainAddress;
  final JettonBridgePricesResponse? prices;

  const JettonBridgeParamsResponse({
    required this.bridgeAddress,
    required this.oraclesAddress,
    required this.stateFlags,
    this.burnBridgeFee,
    required this.oracles,
    this.externalChainAddress,
    this.prices,
  });

  factory JettonBridgeParamsResponse.fromJson(Map<String, dynamic> json) {
    return JettonBridgeParamsResponse(
      bridgeAddress: json['bridge_address'],
      oraclesAddress: json['oracles_address'],
      stateFlags: json['state_flags'],
      burnBridgeFee: BigintUtils.tryParse(json['burn_bridge_fee']),
      oracles: List<OracleResponse>.from(
          (json['oracles'] as List).map((x) => OracleResponse.fromJson(x))),
      externalChainAddress: json['external_chain_address'],
      prices: json['prices'] != null
          ? JettonBridgePricesResponse.fromJson(json['prices'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'bridge_address': bridgeAddress,
      'oracles_address': oraclesAddress,
      'state_flags': stateFlags,
      'burn_bridge_fee': burnBridgeFee?.toString(),
      'oracles': List<dynamic>.from(oracles.map((x) => x.toJson())),
      'external_chain_address': externalChainAddress,
      'prices': prices?.toJson(),
    };
  }
}
