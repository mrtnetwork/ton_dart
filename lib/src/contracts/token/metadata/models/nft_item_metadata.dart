import 'package:ton_dart/src/contracts/token/metadata/constant/constant.dart';
import 'package:ton_dart/ton_dart.dart';

class NFTItemMetadata extends NFTMetadata {
  final String uri;
  const NFTItemMetadata(this.uri);

  @override
  void store(Builder builder, {bool collectionLess = false}) {
    final content = beginCell();
    if (collectionLess) {
      content.storeUint8(TonMetadataConstant.ftMetadataOffChainTag);
    }
    content.storeStringTail(uri);
    builder.storeRef(content.endCell());
  }

  @override
  Map<String, dynamic> toJson() {
    return {"uri": uri};
  }
}
