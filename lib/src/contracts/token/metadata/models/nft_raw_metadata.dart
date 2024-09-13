import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';

class NFTRawMetadata extends NFTMetadata {
  final Cell content;
  const NFTRawMetadata(this.content);

  @override
  void store(Builder builder) {
    builder.storeRef(content);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"content": content.toBase64()};
  }

  @override
  Cell toContent({bool collectionless = false}) {
    return content;
  }
}
