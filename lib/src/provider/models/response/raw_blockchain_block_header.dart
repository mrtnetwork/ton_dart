import 'package:ton_dart/src/serialization/serialization.dart';
import 'block_raw.dart';

class RawBlockchainBlockHeaderResponseResponse with JsonSerialization {
  final BlockRawResponse id;
  final int mode;
  final String headerProof;

  const RawBlockchainBlockHeaderResponseResponse(
      {required this.id, required this.mode, required this.headerProof});
  factory RawBlockchainBlockHeaderResponseResponse.fromJson(
      Map<String, dynamic> json) {
    return RawBlockchainBlockHeaderResponseResponse(
        id: BlockRawResponse.fromJson(json['id']),
        headerProof: json['header_proof'],
        mode: json['mode']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': id.toJson(), 'header_proof': headerProof, 'mode': mode};
  }
}
