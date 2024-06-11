import 'package:ton_dart/src/serialization/serialization.dart';

class InitStateRawResponse with JsonSerialization {
  final int workchain;
  final String rootHash;
  final String fileHash;

  const InitStateRawResponse({
    required this.workchain,
    required this.rootHash,
    required this.fileHash,
  });

  factory InitStateRawResponse.fromJson(Map<String, dynamic> json) {
    return InitStateRawResponse(
        workchain: json['workchain'],
        rootHash: json['root_hash'],
        fileHash: json['file_hash']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'workchain': workchain,
      'root_hash': rootHash,
      'file_hash': fileHash,
    };
  }
}
