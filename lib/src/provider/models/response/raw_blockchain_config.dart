import 'package:ton_dart/src/serialization/serialization.dart';

class RawBlockchainConfigResponse with JsonSerialization {
  final Map<String, String> config;

  const RawBlockchainConfigResponse({required this.config});

  factory RawBlockchainConfigResponse.fromJson(Map<String, dynamic> json) {
    return RawBlockchainConfigResponse(
      config: (json['config'] as Map).cast(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'config': config};
  }
}
