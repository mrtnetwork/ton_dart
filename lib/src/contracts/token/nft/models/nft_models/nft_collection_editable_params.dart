import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/contracts/token/nft/constant/constant.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class NftCollectionParams extends TonSerialization {
  final RoyaltyParams royaltyParams;
  final TonAddress ownerAddress;
  final NFTMetadata content;
  final Cell? nftItemCode;
  final BigInt? nextItemIndex;
  NftCollectionParams(
      {required this.royaltyParams,
      required this.ownerAddress,
      required this.content,
      this.nftItemCode,
      this.nextItemIndex});

  @override
  void store(Builder builder, {int? workchain}) {
    builder.storeAddress(ownerAddress);
    builder.storeUint64(nextItemIndex ?? BigInt.zero);
    content.store(builder);
    builder.storeRef(nftItemCode ??
        TomNftConst.nftItemCode(workchain ?? ownerAddress.workChain));
    builder.store(royaltyParams);
  }

  @override
  Cell serialize({int? workchain}) {
    final builder = beginCell();
    store(builder, workchain: workchain);
    return builder.endCell();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "royalty_params": royaltyParams.toJson(),
      "owner_address": ownerAddress.toFriendlyAddress(),
      "content": content.toJson(),
      "nft_item_code": nftItemCode?.toBase64(),
      "next_item_index": nextItemIndex.toString()
    };
  }
}
