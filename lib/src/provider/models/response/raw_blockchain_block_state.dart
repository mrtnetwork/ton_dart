import 'package:ton_dart/src/serialization/serialization.dart';
import 'block_raw.dart';

class RawBlockchainBlockStateResponse with JsonSerialization {
  final BlockRawResponse id;
  final String rootHash;
  final String fileHash;
  final String data;
  const RawBlockchainBlockStateResponse(
      {required this.id,
      required this.rootHash,
      required this.fileHash,
      required this.data});
  factory RawBlockchainBlockStateResponse.fromJson(Map<String, dynamic> json) {
    return RawBlockchainBlockStateResponse(
        id: BlockRawResponse.fromJson(json["id"]),
        rootHash: json["root_hash"],
        fileHash: json["file_hash"],
        data: json["data"]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id.toJson(),
      "root_hash": rootHash,
      "file_hash": fileHash,
      "data": data
    };
  }
}
