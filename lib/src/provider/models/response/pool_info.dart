import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'pool_implementation_type.dart';

class PoolInfoResponse with JsonSerialization {
  final String address;
  final String name;
  final BigInt totalAmount;
  final PoolImplementationTypeResponse implementation;
  final double apy;
  final BigInt minStake;
  final BigInt cycleStart;
  final BigInt cycleEnd;
  final bool verified;
  final int currentNominators;
  final int maxNominators;
  final String? liquidJettonMaster;
  final BigInt nominatorsStake;
  final BigInt validatorStake;
  final BigInt? cycleLength;

  const PoolInfoResponse({
    required this.address,
    required this.name,
    required this.totalAmount,
    required this.implementation,
    required this.apy,
    required this.minStake,
    required this.cycleStart,
    required this.cycleEnd,
    required this.verified,
    required this.currentNominators,
    required this.maxNominators,
    this.liquidJettonMaster,
    required this.nominatorsStake,
    required this.validatorStake,
    this.cycleLength,
  });

  factory PoolInfoResponse.fromJson(Map<String, dynamic> json) {
    return PoolInfoResponse(
      address: json['address'],
      name: json['name'],
      totalAmount: BigintUtils.parse(json['total_amount']),
      implementation:
          PoolImplementationTypeResponse.fromName(json['implementation']),
      apy: json['apy'],
      minStake: BigintUtils.parse(json['min_stake']),
      cycleStart: BigintUtils.parse(json['cycle_start']),
      cycleEnd: BigintUtils.parse(json['cycle_end']),
      verified: json['verified'],
      currentNominators: json['current_nominators'],
      maxNominators: json['max_nominators'],
      liquidJettonMaster: json['liquid_jetton_master'],
      nominatorsStake: BigintUtils.parse(json['nominators_stake']),
      validatorStake: BigintUtils.parse(json['validator_stake']),
      cycleLength: BigintUtils.tryParse(json['cycle_length']),
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'name': name,
      'total_amount': totalAmount.toString(),
      'implementation': implementation.value,
      'apy': apy,
      'min_stake': minStake.toString(),
      'cycle_start': cycleStart.toString(),
      'cycle_end': cycleEnd.toString(),
      'verified': verified,
      'current_nominators': currentNominators,
      'max_nominators': maxNominators,
      'nominators_stake': nominatorsStake.toString(),
      'validator_stake': validatorStake.toString(),
      'cycle_length': cycleLength?.toString(),
      'liquid_jetton_master': liquidJettonMaster
    };
  }
}
