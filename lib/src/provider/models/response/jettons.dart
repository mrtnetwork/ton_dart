import 'package:ton_dart/src/serialization/serialization.dart';
import 'jetton_info.dart';

class JettonsResponse with JsonSerialization {
  final List<JettonInfoResponse> nftItems;

  const JettonsResponse({required this.nftItems});

  factory JettonsResponse.fromJson(Map<String, dynamic> json) {
    return JettonsResponse(
        nftItems: (json['jettons'] as List)
            .map((item) => JettonInfoResponse.fromJson(item))
            .toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {'jettons': nftItems.map((item) => item.toJson()).toList()};
  }
}
