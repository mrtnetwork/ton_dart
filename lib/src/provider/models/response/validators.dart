import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'validator.dart';

class ValidatorsResponse with JsonSerialization {
  final BigInt electAt;
  final BigInt electClose;
  final BigInt minStake;
  final BigInt totalStake;
  final List<ValidatorResponse> validators;

  const ValidatorsResponse({
    required this.electAt,
    required this.electClose,
    required this.minStake,
    required this.totalStake,
    required this.validators,
  });

  factory ValidatorsResponse.fromJson(Map<String, dynamic> json) {
    return ValidatorsResponse(
      electAt: BigintUtils.parse(json['elect_at']),
      electClose: BigintUtils.parse(json['elect_close']),
      minStake: BigintUtils.parse(json['min_stake']),
      totalStake: BigintUtils.parse(json['total_stake']),
      validators: List<ValidatorResponse>.from((json['validators'] as List)
          .map((x) => ValidatorResponse.fromJson(x))),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'elect_at': electAt.toString(),
      'elect_close': electClose.toString(),
      'min_stake': minStake.toString(),
      'total_stake': totalStake.toString(),
      'validators': List<dynamic>.from(validators.map((x) => x.toJson())),
    };
  }
}
