import 'package:ton_dart/src/contracts/token/metadata/constant/constant.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/ton_dart.dart';

class NFTItemData with JsonSerialization {
  final bool init;
  final BigInt index;
  final TonAddress? collectionAddress;
  final TonAddress? ownerAddress;
  final Cell? content;

  const NFTItemData(
      {required this.init,
      required this.index,
      this.collectionAddress,
      this.ownerAddress,
      this.content});

  String? parseUri() {
    if (!init) return null;
    final contentSlice = content!.beginParse();
    String? nftUri;
    try {
      /// collection-less metadata
      if (collectionAddress == null) {
        if (contentSlice.preloadUint(8) ==
            TonMetadataConstant.ftMetadataOffChainTag) {
          contentSlice.loadUint8();
          nftUri = contentSlice.loadStringTail();
        }
      } else {
        nftUri = contentSlice.loadStringTail();
      }
    } catch (e) {
      return null;
    }
    return nftUri;
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "init": init,
      "index": index.toString(),
      "collection_address": collectionAddress?.toFriendlyAddress(),
      "owner_address": ownerAddress?.toFriendlyAddress(),
      "content": content?.toBase64()
    };
  }
}
