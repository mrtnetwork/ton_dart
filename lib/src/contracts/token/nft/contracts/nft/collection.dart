import 'package:ton_dart/src/address/address/address.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/token/metadata/constant/constant.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/contracts/token/nft/types/types.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/helper/ton_helper.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';

import 'item.dart';
import 'package:ton_dart/src/tuple/tuple.dart';

class NFTCollectionContract<E extends WalletContractTransferParams>
    extends TonContract<NftCollectionState> {
  final WalletContract<dynamic, E> owner;
  @override
  final TonAddress address;
  @override
  final NftCollectionState? state;

  const NFTCollectionContract({
    required this.owner,
    required this.address,
    this.state,
  });

  factory NFTCollectionContract.create({
    required WalletContract<dynamic, E> owner,
    required NftCollectionState state,
  }) {
    return NFTCollectionContract(
      owner: owner,
      address: TonAddress.fromState(
        state: state.initialState(),
        config: TonAddressConfing.friendly(owner.address.workchain),
      ),
      state: state,
    );
  }
  static Future<NFTCollectionContract>
  fromAddress<E extends WalletContractTransferParams>({
    required WalletContract<dynamic, E> owner,
    required TonAddress address,
    required TonQuickClient client,
  }) async {
    final stateData = await ContractProvider.getActiveState(
      address: address,
      client: client,
    );
    final state = NftCollectionState.deserialize(stateData.data!.beginParse());
    return NFTCollectionContract(owner: owner, address: address, state: state);
  }

  Future<String> _sendTransaction({
    required E params,
    required TonQuickClient client,
    required BigInt amount,
    int sendMode = SendModeConst.payGasSeparately,
    int? timeout,
    bool? bounce,
    bool bounced = false,
    Cell? body,
    OnEstimateFee? onEstimateFee,
    TonTransactionAction action = TonTransactionAction.broadcast,
  }) async {
    final active = await isActive(client);
    if (!active && state == null) {
      throw BuError(
        DefaultErrorType.invalidState,
        'The account is inactive and requires state initialization.',
      );
    }

    final message = TonHelper.internal(
      destination: address,
      amount: amount,
      initState: active ? null : state!.initialState(),
      bounced: bounced,
      body: body,
      bounce: bounce ?? address.isBounceable,
    );
    return await owner.sendTransfer(
      messages: [message],
      params: params,
      client: client,
      timeout: timeout,
      sendMode: sendMode,
      action: action,
      onEstimateFee: onEstimateFee,
    );
  }

  Future<String> deploy({
    required E params,
    required TonQuickClient client,
    required BigInt amount,
    int sendMode = SendModeConst.payGasSeparately,
    int? timeout,
    bool? bounce,
    bool bounced = false,
    Cell? body,
  }) async {
    return _sendTransaction(
      params: params,
      client: client,
      amount: amount,
      sendMode: sendMode,
      body: body,
      bounce: bounce,
      bounced: bounced,
      timeout: timeout,
    );
  }

  Future<String> sendOperation({
    required E params,
    required TonQuickClient client,
    required BigInt amount,
    required NFTCollectionOperation operation,
    int sendMode = SendModeConst.payGasSeparately,
    int? timeout,
    bool? bounce,
    bool bounced = false,
    Cell? body,
  }) async {
    if (operation.type == NFTCollectionOperationType.changeContent) {
      throw BuError(
        DefaultErrorType.unsupported,
        'The ChangeContent operation is not available in the NFTCollectionContract.',
      );
    }
    return _sendTransaction(
      params: params,
      client: client,
      amount: amount,
      sendMode: sendMode,
      body: operation.toBody(),
      bounce: bounce,
      bounced: bounced,
      timeout: timeout,
    );
  }

  Future<NFTCollectionData> getCollectionData(TonQuickClient client) async {
    final data = await getStateStack(
      client: client,
      method: 'get_collection_data',
    );
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
          collectionMetadataUri: contentSlice.loadStringTail(),
        );
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
      ownerAddress: ownerAddress,
    );
  }

  Future<TonAddress> getNftAddressByIndex({
    required BigInt index,
    required TonQuickClient client,
  }) async {
    final result = await getStateStack(
      client: client,
      method: 'get_nft_address_by_index',
      stack: [TupleItemInt(index)],
    );
    final reader = result.reader();
    return reader.readAddress();
  }

  Future<NFTItemContract<T>>
  getNFTItemContractByIndex<T extends WalletContractTransferParams>({
    required BigInt index,
    required TonQuickClient client,
    required WalletContract<ContractState, T> owner,
  }) async {
    final itemAddress = await getNftAddressByIndex(
      index: index,
      client: client,
    );
    final stateData = await ContractProvider.getActiveState(
      client: client,
      address: itemAddress,
    );
    return NFTItemContract<T>(
      address: itemAddress,
      owner: owner,
      state: NFTItemState.deserialize(stateData.data!.beginParse()),
    );
  }

  Future<RoyaltyParams> royaltyParams(TonQuickClient client) async {
    final data = await getStateStack(client: client, method: 'royalty_params');
    final reader = data.reader();
    final int royaltyFactor = reader.readNumber();
    final int royaltyBase = reader.readNumber();
    final TonAddress address = reader.readAddress();
    return RoyaltyParams(
      royaltyFactor: royaltyFactor,
      royaltyBase: royaltyBase,
      address: address,
    );
  }

  Future<String> getNftContent({
    required TonQuickClient client,
    required NFTItemData nftData,
  }) async {
    if (!nftData.init) {
      throw BuError(
        DefaultErrorType.invalidState,
        'The NFT has not been initialized.',
      );
    }
    final data = await getStateStack(
      client: client,
      method: 'get_nft_content',
      stack: [TupleItemInt(nftData.index), TupleItemCell(nftData.content!)],
    );
    final reader = data.reader();
    final slice = reader.readCell().beginParse();
    slice.loadUint8();
    return slice.loadStringTail();
  }
}
