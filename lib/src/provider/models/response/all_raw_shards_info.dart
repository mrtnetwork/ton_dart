import 'package:ton_dart/src/serialization/serialization.dart';
import 'block_raw.dart';

class GetAllRawShardsInfoResponse with JsonSerialization {
  final BlockRawResponse id;
  final String proof;
  final String data;
  const GetAllRawShardsInfoResponse(
      {required this.id, required this.proof, required this.data});
  factory GetAllRawShardsInfoResponse.fromJson(Map<String, dynamic> json) {
    return GetAllRawShardsInfoResponse(
        id: BlockRawResponse.fromJson(json['id']),
        proof: json['proof'],
        data: json['data']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': id.toJson(), 'proof': proof, 'data': data};
  }
}
