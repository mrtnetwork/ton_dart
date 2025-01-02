import 'package:blockchain_utils/utils/numbers/utils/bigint_utils.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class NFTMintParams extends TonSerialization {
  final TonAddress ownerAddress;
  final Cell content;
  final BigInt initAmount;
  final BigInt itemIndex;

  factory NFTMintParams.deserialize(Slice slice, {BigInt? index}) {
    final BigInt itemIndex = index ?? slice.loadUint64();
    final BigInt initAmount = slice.loadCoins();
    final collectionData = slice.loadRef().beginParse();
    final TonAddress ownerAddress = collectionData.loadAddress();
    return NFTMintParams(
        ownerAddress: ownerAddress,
        content: collectionData.loadRef(),
        initAmount: initAmount,
        itemIndex: itemIndex);
  }

  factory NFTMintParams.fromJson(Map<String, dynamic> json) {
    return NFTMintParams(
        ownerAddress: TonAddress(json['ownerAddress']),
        content: Cell.fromBase64(json['content']),
        initAmount: BigintUtils.parse(json['initAmount']),
        itemIndex: BigintUtils.parse(json['itemIndex']));
  }
  NFTMintParams copyWith(
      {TonAddress? ownerAddress,
      Cell? content,
      BigInt? initAmount,
      BigInt? itemIndex}) {
    return NFTMintParams(
        ownerAddress: ownerAddress ?? this.ownerAddress,
        content: content ?? this.content,
        initAmount: initAmount ?? this.initAmount,
        itemIndex: itemIndex ?? this.itemIndex);
  }

  NFTMintParams(
      {required this.ownerAddress,
      required this.content,
      required this.initAmount,
      required this.itemIndex});

  @override
  void store(Builder builder) {
    builder.storeUint64(itemIndex);
    builder.storeCoins(initAmount);
    final content = beginCell();
    content.storeAddress(ownerAddress);
    content.storeRef(this.content);
    builder.storeRef(content.endCell());
  }

  NFTMetadata get metadata => NFTMetadata.deserialize(content.beginParse());

  @override
  Map<String, dynamic> toJson() {
    return {
      'metadata': metadata.toJson(),
      'content': content.toBase64(),
      'initAmount': initAmount.toString(),
      'ownerAddress': ownerAddress.toRawAddress(),
      'itemIndex': itemIndex.toString()
    };
  }
}
