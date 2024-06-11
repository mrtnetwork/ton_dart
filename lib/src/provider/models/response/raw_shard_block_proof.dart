import 'package:ton_dart/src/serialization/serialization.dart';
import 'block_raw.dart';

class RawhardBlockProofLinksItemResponse with JsonSerialization {
  final BlockRawResponse id;
  final String proof;
  const RawhardBlockProofLinksItemResponse(
      {required this.id, required this.proof});
  factory RawhardBlockProofLinksItemResponse.fromJson(
      Map<String, dynamic> json) {
    return RawhardBlockProofLinksItemResponse(
        id: BlockRawResponse.fromJson(json["id"]), proof: json["proof"]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"id": id.toJson(), "proof": proof};
  }
}

class RawShardBlockProofResponse with JsonSerialization {
  final BlockRawResponse masterchainId;
  final List<RawhardBlockProofLinksItemResponse> links;

  const RawShardBlockProofResponse(
      {required this.masterchainId, required this.links});
  factory RawShardBlockProofResponse.fromJson(Map<String, dynamic> json) {
    return RawShardBlockProofResponse(
      masterchainId: BlockRawResponse.fromJson(json["masterchain_id"]),
      links: (json["links"] as List)
          .map((e) => RawhardBlockProofLinksItemResponse.fromJson(e))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "masterchain_id": masterchainId,
      "links": links.map((e) => e.toJson()).toList()
    };
  }
}
