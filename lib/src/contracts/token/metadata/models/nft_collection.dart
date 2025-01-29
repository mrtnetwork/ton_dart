import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/metadata/constant/constant.dart';
import 'package:ton_dart/src/contracts/token/token.dart';

class NFTCollectionMetadata extends NFTMetadata {
  /// collection base uri like(https:/.../metadata.json)
  final String collectionMetadataUri;

  /// collection base uri like(https:/.../collection/)
  /// if is null we set empty string for that
  final String? collectionBase;
  const NFTCollectionMetadata(
      {required this.collectionMetadataUri, this.collectionBase});

  factory NFTCollectionMetadata.deserialize(Slice slice) {
    final collectionCell = slice.loadRef().beginParse();
    final tag = collectionCell.loadUint8();
    if (tag != TonMetadataConstant.ftMetadataOffChainTag) {
      throw const TonContractException(
          'Invalid nft offchain collection metadata');
    }
    final String collectionMetadataUri = collectionCell.loadStringTail();
    final Slice commonCell = slice.loadRef().beginParse();
    return NFTCollectionMetadata(
        collectionMetadataUri: collectionMetadataUri,
        collectionBase: commonCell.loadStringTail());
  }

  @override
  void store(Builder builder) {
    builder.storeRef(toContent());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'collection': collectionMetadataUri,
      'collection_base': collectionBase
    };
  }

  @override
  Cell toContent({bool collectionless = false}) {
    final collection = beginCell();
    collection.storeUint(TonMetadataConstant.ftMetadataOffChainTag, 8);
    collection.storeStringTail(collectionMetadataUri);
    final content = beginCell().storeRef(collection.endCell());
    final commonCell = beginCell();
    commonCell.storeStringTail(collectionBase ?? '');
    content.storeRef(commonCell.endCell());
    return content.endCell();
  }
}
