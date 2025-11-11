import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class RawBlockchainConfigResponse with JsonSerialization {
  final Map<String, dynamic> config;

  const RawBlockchainConfigResponse({required this.config});

  factory RawBlockchainConfigResponse.fromJson(Map<String, dynamic> json) {
    return RawBlockchainConfigResponse(
      config: json.valueEnsureAsMap<String, dynamic>("config"),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'config': config};
  }
}
