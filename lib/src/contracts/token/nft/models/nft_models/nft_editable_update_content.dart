import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/ton_dart.dart';

class UpdateEditableNFTContent extends TonSerialization {
  final RoyaltyParams royaltyParams;
  final NFTMetadata content;
  const UpdateEditableNFTContent(
      {required this.content, required this.royaltyParams});

  @override
  void store(Builder builder) {
    builder.store(content);
    builder.store(royaltyParams);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "royalty_params": royaltyParams.toJson(),
      "content": content.toJson()
    };
  }
}
