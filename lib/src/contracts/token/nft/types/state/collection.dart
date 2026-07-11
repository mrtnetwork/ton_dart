import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/models/models/state_init.dart';

class NftCollectionState extends ContractState {
  final RoyaltyParams royaltyParams;
  final TonAddress ownerAddress;
  final Cell content;
  final Cell nftItemCode;
  final BigInt nextItemIndex;
  NFTMetadata get metadata => NFTMetadata.deserialize(content.beginParse());

  Map<String, dynamic> toJson() {
    return {
      'royaltyParams': royaltyParams.toJson(),
      'ownerAddress': ownerAddress.address,
      'content': content.toBase64(),
      'nftItemCode': nftItemCode.toBase64(),
      'nextItemIndex': nextItemIndex,
      'metadata': metadata.toJson(),
    };
  }

  NftCollectionState._({
    required this.royaltyParams,
    required this.ownerAddress,
    required this.content,
    required this.nftItemCode,
    required this.nextItemIndex,
  });
  factory NftCollectionState({
    required RoyaltyParams royaltyParams,
    required TonAddress ownerAddress,
    required NFTMetadata metadata,
    Cell? nftItemCode,
    BigInt? nextItemIndex,
  }) {
    return NftCollectionState._(
      royaltyParams: royaltyParams,
      ownerAddress: ownerAddress,
      content: metadata.toContent(),
      nextItemIndex: nextItemIndex ?? BigInt.zero,
      nftItemCode:
          nftItemCode ??
          TonNftConst.nftItemCode(workchain: ownerAddress.workchain),
    );
  }
  factory NftCollectionState.deserialize(Slice slice) {
    return NftCollectionState._(
      ownerAddress: slice.loadAddress(),
      nextItemIndex: slice.loadUint64(),
      content: slice.loadRef(),
      nftItemCode: slice.loadRef(),
      royaltyParams: RoyaltyParams.deserialize(slice.loadRef().beginParse()),
    );
  }

  @override
  StateInit initialState({TonWorkChain? workchain}) {
    return StateInit(
      code: TonNftConst.nftCollectionCode(
        workchain: workchain ?? ownerAddress.workchain,
      ),
      data: initialData(),
    );
  }

  @override
  Cell initialData({TonWorkChain? workchain}) {
    final builder = beginCell();
    builder.storeAddress(ownerAddress);
    builder.storeUint64(nextItemIndex);
    builder.storeRef(content);
    builder.storeRef(nftItemCode);
    builder.store(royaltyParams);
    return builder.endCell();
  }
}

class NftEditableCollectionState extends NftCollectionState {
  NftEditableCollectionState._({
    required super.royaltyParams,
    required super.ownerAddress,
    required super.content,
    required super.nftItemCode,
    required super.nextItemIndex,
  }) : super._();
  factory NftEditableCollectionState({
    required RoyaltyParams royaltyParams,
    required TonAddress ownerAddress,
    required NFTMetadata metadata,
    Cell? nftItemCode,
    BigInt? nextItemIndex,
  }) {
    return NftEditableCollectionState._(
      royaltyParams: royaltyParams,
      ownerAddress: ownerAddress,
      content: metadata.toContent(),
      nextItemIndex: nextItemIndex ?? BigInt.zero,
      nftItemCode:
          nftItemCode ??
          TonNftConst.nftItemCode(workchain: ownerAddress.workchain),
    );
  }
  factory NftEditableCollectionState.deserialize(Slice slice) {
    return NftEditableCollectionState._(
      ownerAddress: slice.loadAddress(),
      nextItemIndex: slice.loadUint64(),
      content: slice.loadRef(),
      nftItemCode: slice.loadRef(),
      royaltyParams: RoyaltyParams.deserialize(slice.loadRef().beginParse()),
    );
  }

  @override
  StateInit initialState({TonWorkChain? workchain}) {
    return StateInit(
      code: TonNftConst.nftEditableCollectionCode(
        workchain: workchain ?? ownerAddress.workchain,
      ),
      data: initialData(),
    );
  }
}
