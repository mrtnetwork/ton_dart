import 'package:ton_dart/src/serialization/serialization.dart';
import 'oracle.dart';

class OracleBridgeParamsResponse with JsonSerialization {
  final String bridgeAddr;
  final String oracleMultisigAddress;
  final String externalChainAddress;
  final List<OracleResponse> oracles;

  const OracleBridgeParamsResponse(
      {required this.bridgeAddr,
      required this.oracleMultisigAddress,
      required this.externalChainAddress,
      required this.oracles});

  factory OracleBridgeParamsResponse.fromJson(Map<String, dynamic> json) {
    return OracleBridgeParamsResponse(
      bridgeAddr: json['bridge_addr'],
      oracleMultisigAddress: json['oracle_multisig_address'],
      externalChainAddress: json['external_chain_address'],
      oracles: List<OracleResponse>.from(
          (json['oracles'] as List).map((x) => OracleResponse.fromJson(x))),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'bridge_addr': bridgeAddr,
      'oracle_multisig_address': oracleMultisigAddress,
      'external_chain_address': externalChainAddress,
      'oracles': List<dynamic>.from(oracles.map((x) => x.toJson()))
    };
  }
}
