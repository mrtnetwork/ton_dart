import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/metadata/constant/constant.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/contracts/token/nft/types/types.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/helper/ton_helper.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/provider/provider/provider.dart';
import 'item.dart';

class NFTCollectionContract<E extends WalletContractTransferParams>
    extends TonContract<NftCollectionState> {
  final WalletContract<dynamic, E> owner;
  @override
  final TonAddress address;
  @override
  final NftCollectionState? state;

  const NFTCollectionContract(
      {required this.owner, required this.address, this.state});

  factory NFTCollectionContract.create(
      {required WalletContract<dynamic, E> owner,
      required NftCollectionState state}) {
    return NFTCollectionContract(
        owner: owner,
        address: TonAddress.fromState(
            state: state.initialState(), workChain: owner.address.workChain),
        state: state);
  }
  static Future<NFTCollectionContract>
      fromAddress<E extends WalletContractTransferParams>(
          {required WalletContract<dynamic, E> owner,
          required TonAddress address,
          required TonProvider rpc}) async {
    final stateData =
        await ContractProvider.getActiveState(address: address, rpc: rpc);
    final state = NftCollectionState.deserialize(stateData.data!.beginParse());
    return NFTCollectionContract(owner: owner, address: address, state: state);
  }

  Future<String> _sendTransaction(
      {required E params,
      required TonProvider rpc,
      required BigInt amount,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body}) async {
    final active = await isActive(rpc);
    if (!active && state == null) {
      throw const TonContractException(
          "The account is inactive and requires state initialization.");
    }

    final message = TonHelper.internal(
      destination: address,
      amount: amount,
      initState: active ? null : this.state!.initialState(),
      bounced: bounced,
      body: body,
      bounce: bounce ?? address.isBounceable,
    );
    return await owner.sendTransfer(
      messages: [message],
      params: params,
      rpc: rpc,
      timeout: timeout,
      sendMode: sendMode,
    );
  }

  Future<String> deploy(
      {required E params,
      required TonProvider rpc,
      required BigInt amount,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body}) async {
    return _sendTransaction(
        params: params,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: body,
        bounce: bounce,
        bounced: bounced,
        timeout: timeout);
  }

  Future<String> sendOperation(
      {required E params,
      required TonProvider rpc,
      required BigInt amount,
      required NFTCollectionOperation operation,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body}) async {
    if (operation.type == NFTCollectionOperationType.changeContent) {
      throw const TonContractException(
          "The ChangeContent operation is not available in the NFTCollectionContract.");
    }
    return _sendTransaction(
        params: params,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: operation.toBody(),
        bounce: bounce,
        bounced: bounced,
        timeout: timeout);
  }

  Future<NFTCollectionData> getCollectionData(TonProvider rpc) async {
    final data = await getStateStack(rpc: rpc, method: "get_collection_data");
    final reader = data.reader();
    final nexItemIndex = reader.readBigNumber();
    final content = reader.readCell();
    final ownerAddress = reader.readAddress();

    NFTMetadata metadata = NFTRawMetadata(content);
    try {
      final contentSlice = content.beginParse();
      if (contentSlice.loadUint8() ==
          TonMetadataConstant.ftMetadataOffChainTag) {
        metadata = NFTCollectionMetadata(
            collectionMetadataUri: contentSlice.loadStringTail());
      } else {
        metadata = NFTRawMetadata(content);
      }
      // ignore: empty_catches
    } catch (e) {
      metadata = NFTRawMetadata(content);
    }

    return NFTCollectionData(
        nexItemIndex: nexItemIndex,
        content: metadata,
        ownerAddress: ownerAddress);
  }

  Future<TonAddress> getNftAddressByIndex(
      {required BigInt index, required TonProvider rpc}) async {
    final result = await getStateStack(
        rpc: rpc,
        method: "get_nft_address_by_index",
        stack: [
          if (rpc.isTonCenter) ["num", index.toString()] else index.toString()
        ]);
    final reader = result.reader();
    return reader.readAddress();
  }

  Future<NFTItemContract<T>>
      getNFTItemContractByIndex<T extends WalletContractTransferParams>(
          {required BigInt index,
          required TonProvider rpc,
          required WalletContract<ContractState, T> owner}) async {
    final itemAddress = await getNftAddressByIndex(index: index, rpc: rpc);
    final stateData =
        await ContractProvider.getActiveState(rpc: rpc, address: itemAddress);
    return NFTItemContract<T>(
        address: itemAddress,
        owner: owner,
        state: NFTItemState.deserialize(stateData.data!.beginParse()));
  }

  Future<RoyaltyParams> royaltyParams(TonProvider rpc) async {
    final data = await getStateStack(rpc: rpc, method: "royalty_params");
    final reader = data.reader();
    final int royaltyFactor = reader.readNumber();
    final int royaltyBase = reader.readNumber();
    final TonAddress address = reader.readAddress();
    return RoyaltyParams(
        royaltyFactor: royaltyFactor,
        royaltyBase: royaltyBase,
        address: address);
  }

  Future<String> getNftContent(
      {required TonProvider rpc, required NFTItemData nftData}) async {
    if (!nftData.init) {
      throw const TonContractException("The NFT has not been initialized.");
    }
    final data =
        await getStateStack(rpc: rpc, method: "get_nft_content", stack: [
      if (rpc.isTonCenter) ...[
        ["num", nftData.index.toString()],
        ["tvm.Cell", nftData.content!.toBase64()]
      ] else ...[
        nftData.index,
        nftData.content?.toBase64(),
      ]
    ]);
    final reader = data.reader();
    final slice = reader.readCell().beginParse();
    slice.loadUint8();
    return slice.loadStringTail();
  }
}
