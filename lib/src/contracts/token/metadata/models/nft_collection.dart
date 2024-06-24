import 'package:ton_dart/src/contracts/token/metadata/constant/constant.dart';
import 'package:ton_dart/ton_dart.dart';

class NFTCollectionMetadata extends NFTMetadata {
  /// collection base uri like(https:/.../metadata.json)
  final String collectionMetadataUri;

  /// collection base uri like(https:/.../collection/)
  /// if is null we set empty string for that
  final String? collectionBase;
  const NFTCollectionMetadata(
      {required this.collectionMetadataUri, this.collectionBase});

  /// <b
  ///   collection_json offchain-token-data ref, // Storing common ref
  ///   <b collection_base $>B B, b> ref,
  /// b> ref, // content cell
  @override
  void store(Builder builder) {
    final collentionCell = beginCell();
    collentionCell.storeUint(TonMetadataConstant.ftMetadataOffChainTag, 8);
    collentionCell.storeStringTail(collectionMetadataUri);
    final content = beginCell().storeRef(collentionCell.endCell());
    final commonCell = beginCell();
    commonCell.storeStringTail(collectionBase ?? "");
    content.storeRef(commonCell.endCell());
    builder.storeRef(content.endCell());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "coolection_content": collectionMetadataUri,
      "common_content": collectionBase
    };
  }
}
