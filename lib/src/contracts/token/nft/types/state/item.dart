import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/models/models/state_init.dart';

class NFTItemState extends ContractState {
  final BigInt index;
  final TonAddress? collectionAddress;
  final TonAddress ownerAddress;
  final Cell content;
  const NFTItemState._(
      {required this.index,
      this.collectionAddress,
      required this.ownerAddress,
      required this.content});
  factory NFTItemState({
    required BigInt index,
    TonAddress? collectionAddress,
    required NFTItemMetadata metadata,
    required TonAddress ownerAddress,
  }) {
    return NFTItemState._(
        index: index,
        ownerAddress: ownerAddress,
        content: metadata.toContent(collectionless: collectionAddress == null),
        collectionAddress: collectionAddress);
  }
  factory NFTItemState.deserialize(Slice slice) {
    return NFTItemState._(
      index: slice.loadUint64(),
      collectionAddress: slice.loadMaybeAddress(),
      ownerAddress: slice.loadAddress(),
      content: slice.loadRef(),
    );
  }

  @override
  StateInit initialState() {
    return StateInit(
        code: TonNftConst.nftItemCode(ownerAddress.workChain),
        data: initialData());
  }

  @override
  Cell initialData() {
    final builder = beginCell();
    builder.storeUint64(index);
    builder.storeAddress(collectionAddress);
    builder.storeAddress(ownerAddress);
    builder.storeRef(content);
    return builder.endCell();
  }

  NFTItemMetadata get metadata =>
      NFTItemMetadata.deserialize(content.beginParse());

  Map<String, dynamic> toJson() {
    return {
      "index": index,
      "collectionAddress": collectionAddress?.toFriendlyAddress(),
      "ownerAddress": ownerAddress.toFriendlyAddress(),
      "content": content.toBase64(),
      "metadata": metadata.toJson()
    };
  }
}

// import 'package:ton_dart/src/address/address/address.dart';
// import 'package:ton_dart/src/boc/bit/builder.dart';
// import 'package:ton_dart/src/boc/boc.dart';
// import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
// import 'package:ton_dart/src/serialization/serialization.dart';

// class NFTItemState extends TonSerialization {
//   final BigInt index;
//   final TonAddress? collectionAddress;
//   final TonAddress ownerAddress;
//   final Cell content;
//   const NFTItemState(
//       {required this.index,
//       this.collectionAddress,
//       required this.ownerAddress,
//       required this.content});

//   // @override
//   // void store(Builder builder) {
// builder.storeUint64(index);
// builder.storeAddress(collectionAddress);
// builder.storeAddress(ownerAddress);
// content.store(builder, collectionLess: collectionAddress == null);
//   // }

//   // @override
//   // Map<String, dynamic> toJson() {
//   //   return {
//   //     "index": index.toString(),
//   //     "collection_address": collectionAddress?.toFriendlyAddress(),
//   //     "owner_address": ownerAddress?.toFriendlyAddress(),
//   //     "content": content.toJson()
//   //   };
//   // }
// }
