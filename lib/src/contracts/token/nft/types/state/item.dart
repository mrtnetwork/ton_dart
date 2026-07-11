import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/models/models/state_init.dart';

class NFTItemState extends ContractState {
  final BigInt index;
  final TonAddress? collectionAddress;
  final TonAddress ownerAddress;
  final Cell content;
  const NFTItemState._({
    required this.index,
    this.collectionAddress,
    required this.ownerAddress,
    required this.content,
  });
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
      collectionAddress: collectionAddress,
    );
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
  StateInit initialState({TonWorkChain? workchain}) {
    return StateInit(
      code: TonNftConst.nftItemCode(
        workchain: workchain ?? ownerAddress.workchain,
      ),
      data: initialData(),
    );
  }

  @override
  Cell initialData({TonWorkChain? workchain}) {
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
      'index': index,
      'collectionAddress': collectionAddress?.address,
      'ownerAddress': ownerAddress.address,
      'content': content.toBase64(),
      'metadata': metadata.toJson(),
    };
  }
}
