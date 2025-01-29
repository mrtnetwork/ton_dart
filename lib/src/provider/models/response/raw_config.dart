import 'package:ton_dart/src/serialization/serialization.dart';
import 'block_raw.dart';

class RawConfigResponse with JsonSerialization {
  final int mode;
  final BlockRawResponse id;
  final String stateProof;
  final String configProof;
  const RawConfigResponse(
      {required this.mode,
      required this.id,
      required this.stateProof,
      required this.configProof});
  factory RawConfigResponse.fromJson(Map<String, dynamic> json) {
    return RawConfigResponse(
        mode: json['mode'],
        id: BlockRawResponse.fromJson(json['id']),
        stateProof: json['state_proof'],
        configProof: json['config_proof']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id.toJson(),
      'mode': mode,
      'config_proof': configProof,
      'state_proof': stateProof
    };
  }
}
