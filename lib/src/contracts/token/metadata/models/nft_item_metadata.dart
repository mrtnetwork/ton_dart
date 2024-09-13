import 'package:ton_dart/src/contracts/token/metadata/constant/constant.dart';
import 'package:ton_dart/ton_dart.dart';

class NFTItemMetadata extends NFTMetadata {
  final String uri;
  const NFTItemMetadata(this.uri);
  factory NFTItemMetadata.deserialize(Slice slice) {
    if (slice.remainingBits == 0) {
      return const NFTItemMetadata("");
    }
    final tag = slice.preloadUint(8);
    if (tag != TonMetadataConstant.ftMetadataOffChainTag) {
      return NFTItemMetadata(slice.loadStringTail());
    }
    slice.loadUint8();
    return NFTItemMetadata(slice.loadStringTail());
  }

  @override
  void store(Builder builder, {bool collectionLess = false}) {
    builder.storeRef(toContent(collectionless: collectionLess));
  }

  @override
  Map<String, dynamic> toJson() {
    return {"uri": uri};
  }

  @override
  Cell toContent({bool collectionless = false}) {
    final content = beginCell();
    if (collectionless) {
      content.storeUint8(TonMetadataConstant.ftMetadataOffChainTag);
    }
    content.storeStringTail(uri);
    return content.endCell();
  }
}
