import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class NFTItemParams extends TonSerialization {
  final BigInt index;
  final TonAddress? collectionAddress;
  final TonAddress? ownerAddress;
  final NFTItemMetadata content;
  const NFTItemParams(
      {required this.index,
      this.collectionAddress,
      required this.ownerAddress,
      required this.content});

  @override
  void store(Builder builder) {
    builder.storeUint64(index);
    builder.storeAddress(collectionAddress);
    builder.storeAddress(ownerAddress);
    content.store(builder, collectionLess: collectionAddress == null);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "index": index.toString(),
      "collection_address": collectionAddress?.toFriendlyAddress(),
      "owner_address": ownerAddress?.toFriendlyAddress(),
      "content": content.toJson()
    };
  }
}
