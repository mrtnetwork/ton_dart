import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/nft/types/types.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/helper/ton_helper.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'collection.dart';

class NFTCollectionEditableContract<E extends WalletContractTransferParams>
    extends NFTCollectionContract<E> {
  const NFTCollectionEditableContract(
      {required WalletContract<dynamic, E> owner,
      required TonAddress address,
      NftEditableCollectionState? state})
      : super(
          owner: owner,
          address: address,
          state: state,
        );

  factory NFTCollectionEditableContract.create({
    required WalletContract<dynamic, E> owner,
    required NftEditableCollectionState state,
  }) {
    return NFTCollectionEditableContract(
        owner: owner,
        address: TonAddress.fromState(
            state: state.initialState(), workChain: owner.address.workChain),
        state: state);
  }
  static Future<NFTCollectionEditableContract>
      fromAddress<E extends WalletContractTransferParams>(
          {required WalletContract<dynamic, E> owner,
          required TonAddress address,
          required TonProvider rpc}) async {
    final stateData =
        await ContractProvider.getActiveState(rpc: rpc, address: address);
    final state =
        NftEditableCollectionState.deserialize(stateData.data!.beginParse());
    return NFTCollectionEditableContract(
        owner: owner, address: address, state: state);
  }

  Future<String> _sendTransaction({
    required E params,
    required TonProvider rpc,
    required BigInt amount,
    int sendMode = SendModeConst.payGasSeparately,
    int? timeout,
    bool? bounce,
    bool bounced = false,
    Cell? body,
  }) async {
    final active = await isActive(rpc);
    if (!active && state == null) {
      throw const TonContractException(
          "The account is inactive and requires state initialization.");
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
        rpc: rpc,
        timeout: timeout,
        sendMode: sendMode);
  }

  @override
  Future<String> sendOperation(
      {required E params,
      required TonProvider rpc,
      required BigInt amount,
      required NFTCollectionOperation operation,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body}) {
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
}
