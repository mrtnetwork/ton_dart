import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class BlockParamLimitsResponse with JsonSerialization {
  final BigInt underload;
  final BigInt softLimit;
  final BigInt hardLimit;

  const BlockParamLimitsResponse(
      {required this.underload,
      required this.softLimit,
      required this.hardLimit});

  factory BlockParamLimitsResponse.fromJson(Map<String, dynamic> json) {
    return BlockParamLimitsResponse(
      underload: BigintUtils.parse(json['underload']),
      softLimit: BigintUtils.parse(json['soft_limit']),
      hardLimit: BigintUtils.parse(json['hard_limit']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'underload': underload.toString(),
      'soft_limit': softLimit.toString(),
      'hard_limit': hardLimit.toString(),
    };
  }
}
