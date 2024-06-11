import 'package:ton_dart/src/serialization/serialization.dart';

class BlockchainRawAccountLibrariesItemResponse with JsonSerialization {
  final bool isPublic;
  final String root;

  const BlockchainRawAccountLibrariesItemResponse(
      {required this.isPublic, required this.root});

  factory BlockchainRawAccountLibrariesItemResponse.fromJson(
      Map<String, dynamic> json) {
    return BlockchainRawAccountLibrariesItemResponse(
        isPublic: json['public'], root: json['root']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'public': isPublic, 'root': root};
  }
}
