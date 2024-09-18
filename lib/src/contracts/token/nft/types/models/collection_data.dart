import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class NFTCollectionData with JsonSerialization {
  final BigInt nexItemIndex;
  final NFTMetadata content;
  final TonAddress ownerAddress;
  const NFTCollectionData(
      {required this.nexItemIndex,
      required this.content,
      required this.ownerAddress});

  @override
  Map<String, dynamic> toJson() {
    return {
      "next_item_index": nexItemIndex.toString(),
      "content": content.toJson(),
      "owner_address": ownerAddress.toString()
    };
  }
}
