import 'package:ton_dart/src/serialization/serialization.dart';
import 'block_param_limits.dart';

class BlockLimitsResponse with JsonSerialization {
  final BlockParamLimitsResponse bytes;
  final BlockParamLimitsResponse gas;
  final BlockParamLimitsResponse ltDelta;

  const BlockLimitsResponse({
    required this.bytes,
    required this.gas,
    required this.ltDelta,
  });

  factory BlockLimitsResponse.fromJson(Map<String, dynamic> json) {
    return BlockLimitsResponse(
      bytes: BlockParamLimitsResponse.fromJson(json['bytes']),
      gas: BlockParamLimitsResponse.fromJson(json['gas']),
      ltDelta: BlockParamLimitsResponse.fromJson(json['lt_delta']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'bytes': bytes.toJson(),
      'gas': gas.toJson(),
      'lt_delta': ltDelta.toJson(),
    };
  }
}
