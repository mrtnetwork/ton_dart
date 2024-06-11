import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class ConfigProposalSetupResponse with JsonSerialization {
  final int minTotRounds;
  final int maxTotRounds;
  final int minWins;
  final int maxLosses;
  final BigInt minStoreSec;
  final BigInt maxStoreSec;
  final BigInt bitPrice;
  final BigInt cellPrice;

  const ConfigProposalSetupResponse({
    required this.minTotRounds,
    required this.maxTotRounds,
    required this.minWins,
    required this.maxLosses,
    required this.minStoreSec,
    required this.maxStoreSec,
    required this.bitPrice,
    required this.cellPrice,
  });

  factory ConfigProposalSetupResponse.fromJson(Map<String, dynamic> json) {
    return ConfigProposalSetupResponse(
      minTotRounds: json['min_tot_rounds'],
      maxTotRounds: json['max_tot_rounds'],
      minWins: json['min_wins'],
      maxLosses: json['max_losses'],
      minStoreSec: BigintUtils.parse(json['min_store_sec']),
      maxStoreSec: BigintUtils.parse(json['max_store_sec']),
      bitPrice: BigintUtils.parse(json['bit_price']),
      cellPrice: BigintUtils.parse(json['cell_price']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'min_tot_rounds': minTotRounds,
      'max_tot_rounds': maxTotRounds,
      'min_wins': minWins,
      'max_losses': maxLosses,
      'min_store_sec': minStoreSec.toString(),
      'max_store_sec': maxStoreSec.toString(),
      'bit_price': bitPrice.toString(),
      'cell_price': cellPrice.toString(),
    };
  }
}
