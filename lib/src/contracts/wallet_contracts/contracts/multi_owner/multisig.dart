import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/constant/constants/mutli_owner.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/contracts/multi_owner/order.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/types.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/utils/multi_owner.dart';
import 'package:ton_dart/src/dict/dictionary.dart';
import 'package:ton_dart/src/helper/ton_helper.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';

class MultiOwnerContract<E extends WalletContractTransferParams>
    extends WalletContract<MultiOwnerWalletState, MultiOwnerTransferParams<E>> {
  final WalletContract<ContractState, E> owner;

  MultiOwnerContract({
    required TonAddress address,
    required this.owner,
    MultiOwnerWalletState? stateInit,
  }) : super(
            address: address,
            state: stateInit,
            chain: TonChain.fromWorkchain(address.workChain));
  MultiOwnerContract<T>
      changeOwnerWallet<T extends WalletContractTransferParams>(
          WalletContract<ContractState, T> owner) {
    return MultiOwnerContract(address: address, owner: owner, stateInit: state);
  }

  factory MultiOwnerContract.create(
      {required TonChain chain,
      required WalletContract<ContractState, E> owner,
      required int threshold,
      required List<TonAddress> signers,
      required List<TonAddress> proposers,
      required bool allowArbitrarySeqno}) {
    final stateInit = MultiOwnerWalletState(
        threshold: threshold,
        allowArbitrarySeqno: allowArbitrarySeqno,
        proposers: proposers,
        signers: signers);
    final state = stateInit.initialState(chain: chain);
    return MultiOwnerContract(
        address: TonAddress.fromState(
            state: state, workChain: chain.workchain, bounceable: false),
        stateInit: stateInit,
        owner: owner);
  }
  static Future<MultiOwnerContract> fromAddress({
    required TonChain chain,
    required WalletContract<ContractState, MultiOwnerTransferParams> owner,
    required TonAddress address,
    required TonProvider provider,
  }) async {
    final stateData =
        await ContractProvider.getActiveState(rpc: provider, address: address);
    final state =
        MultiOwnerWalletState.deserialize(stateData.data!.beginParse());
    return MultiOwnerContract(address: address, stateInit: state, owner: owner);
  }

  Cell initMessageBody() {
    return beginCell().storeUint32(0).storeUint64(0).endCell();
  }

  Future<String> _sendTransaction(
      {required E params,
      required TonProvider rpc,
      required BigInt amount,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body,
      StateInit? state,
      OnEstimateFee? onEstimateFee}) async {
    return await owner.sendTransfer(
        params: params,
        messages: [
          TonHelper.internal(
            destination: address,
            amount: amount,
            initState: state,
            bounced: bounced,
            body: body,
            bounce: bounce ?? address.isBounceable,
          )
        ],
        rpc: rpc,
        timeout: timeout,
        sendMode: sendMode,
        onEstimateFee: onEstimateFee);
  }

  Future<String> deploy(
      {required E params,
      required TonProvider rpc,
      required BigInt amount,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      OnEstimateFee? onEstimateFee}) async {
    final active = await isActive(rpc);
    if (active) {
      throw const TonContractException("Account is already active.");
    }
    if (state == null) {
      throw const TonContractException("cannot deploy with watch only wallet.");
    }
    return _sendTransaction(
        params: params,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: initMessageBody(),
        bounce: bounce,
        bounced: bounced,
        state: state!.initialState(chain: owner.chain),
        timeout: timeout,
        onEstimateFee: onEstimateFee);
  }

  Cell packTransferRequest(
      {required OutActionSendMsg message,
      int sendMode = SendModeConst.payGasSeparately}) {
    final messageRef = beginCell().store(message).endCell();
    return beginCell()
        .storeUint32(MultiOwnerContractConst.sendTransferOperation)
        .storeUint(sendMode, 8)
        .storeRef(messageRef)
        .endCell();
  }

  Cell packUpdateRequest(
      {required int threshold,
      required List<TonAddress> signers,
      required List<TonAddress> proposers}) {
    return beginCell()
        .storeUint32(MultiOwnerContractConst.updateTransferOperation)
        .storeUint8(threshold)
        .storeRef(beginCell()
            .storeDictDirect(MultiOwnerContractUtils.signersToDict(signers))
            .endCell())
        .storeDict(dict: MultiOwnerContractUtils.signersToDict(proposers))
        .endCell();
  }

  Cell packOrder(List<OutActionMultiSig> actions) {
    final orderDict = Dictionary.empty(
        key: DictionaryKey.uintCodec(8), value: DictionaryValue.cellCodec());
    if (actions.length > 255) {
      throw const TonContractException(
          "For action chains above 255, use packLarge method");
    } else {
      // pack transfers to the order_body cell
      for (int i = 0; i < actions.length; i++) {
        final action = actions[i];
        orderDict[i] = beginCell().store(action).endCell();
      }
      return beginCell().storeDictDirect(orderDict).endCell();
    }
  }

  Cell packLarge(
      {required List<OutActionMultiSig> actions,
      required TonAddress address,
      required BigInt amount}) {
    Cell? tailChunk;
    int chunkCount = (actions.length / 254).ceil();
    int actionProcessed = 0;
    int lastSz = actions.length % 254;
    while (chunkCount > 0) {
      chunkCount--;
      int chunkSize;
      if (lastSz > 0) {
        chunkSize = lastSz;
        lastSz = 0;
      } else {
        chunkSize = 254;
      }

      // Processing chunks from tail to head to evade recursion
      final chunk = actions.sublist(
          -(chunkSize + actionProcessed), actions.length - actionProcessed);

      if (tailChunk == null) {
        tailChunk = packOrder(chunk);
      } else {
        tailChunk = packOrder([
          ...chunk,
          OutActionMultiSigSendMsg(
              mode: SendModeConst.payGasSeparately,
              outMessage: TonHelper.internal(
                  destination: address,
                  amount: amount,
                  body: beginCell()
                      .storeUint32(
                          MultiOwnerContractConst.executeInternalOperantion)
                      .storeUint64(0)
                      .storeRef(tailChunk)
                      .endCell()))
        ]);
      }

      actionProcessed += chunkSize;
    }

    if (tailChunk == null) {
      throw const TonContractException(
          "Something went wrong during large order pack");
    }

    return tailChunk;
  }

  Cell newOrderMessage(
      {required Cell actions,
      required BigInt expirationDate,
      required bool isSigner,
      required int addrIdx,
      BigInt? orderId,
      BigInt? queryId}) {
    final msgBody = beginCell()
        .storeUint32(MultiOwnerContractConst.newOrderOperation)
        .storeUint64(queryId ?? BigInt.zero)
        .storeUint256(orderId ?? MultiOwnerContractConst.defaultOrderId)
        .storeBitBolean(isSigner)
        .storeUint8(addrIdx)
        .storeUint(expirationDate, 48);
    return msgBody.storeRef(actions).endCell();
  }

  Future<String> sendNewOrder(
      {required TonProvider rpc,
      required E params,
      required BigInt expirationDate,
      required BigInt amount,
      required List<OutActionMultiSig> messages,
      BigInt? orderId,
      BigInt? queryId}) async {
    final active = await isActive(rpc);
    if (state == null) {
      throw const TonContractException(
          "Cannot create new order with watch only wallet");
    }
    int addrIdx = state!.signers.indexOf(owner.address);
    bool isSigner;
    if (addrIdx >= 0) {
      isSigner = true;
    } else {
      addrIdx = state!.proposers.indexOf(owner.address);
      if (addrIdx < 0) {
        throw const TonContractException(
            "the owner is not a signer or proposer.");
      }
      isSigner = false;
    }
    Cell actionCell;
    if (messages.length > 255) {
      actionCell = packLarge(
          actions: messages,
          address: address,
          amount: TonHelper.toNano("0.01"));
    } else {
      actionCell = packOrder(messages);
    }
    final body = newOrderMessage(
      actions: actionCell,
      expirationDate: expirationDate,
      isSigner: isSigner,
      addrIdx: addrIdx,
      orderId: orderId,
      queryId: queryId,
    );

    return _sendTransaction(
        params: params,
        rpc: rpc,
        amount: amount,
        body: body,
        state: active ? null : state!.initialState(chain: owner.chain));
  }

  Future<MultiOwnerWalletState> getStateData(TonProvider rpc) async {
    final state =
        await ContractProvider.getActiveState(rpc: rpc, address: address);
    return MultiOwnerWalletState.deserialize(state.data!.beginParse());
  }

  Future<TonAddress> orderAddress(
      {required TonProvider rpc, required BigInt seqno}) async {
    final call =
        await getStateStack(rpc: rpc, method: "get_order_address", stack: [
      if (rpc.isTonCenter) ...[
        ["num", seqno.toString()]
      ] else
        seqno.toString()
    ]);
    return call.reader().readAddress();
  }

  Future<OrderContract<T>>
      getOrderContract<T extends WalletContractTransferParams>(
          {required TonProvider rpc,
          required BigInt seqno,
          required WalletContract<ContractState, T> signerWallet}) async {
    final call =
        await getStateStack(rpc: rpc, method: "get_order_address", stack: [
      if (rpc.isTonCenter) ...[
        ["num", seqno.toString()]
      ] else
        seqno.toString()
    ]);
    final orderAddress = call.reader().readAddress();
    final orderState =
        await ContractProvider.getActiveState(rpc: rpc, address: orderAddress);
    final state = OrderContractState.deserialize(orderState.data!.beginParse());
    return OrderContract(
        address: orderAddress, owner: signerWallet, state: state);
  }

  @override
  Future<String> sendTransfer(
      {required MultiOwnerTransferParams<E> params,
      List<MessageRelaxed> messages = const [],
      required TonProvider rpc,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      OnEstimateFee? onEstimateFee}) {
    final actions = messages
        .map((e) => OutActionMultiSigSendMsg(outMessage: e, mode: sendMode))
        .toList();
    return sendNewOrder(
        rpc: rpc,
        params: params.params,
        amount: params.amount,
        expirationDate: params.expirationDate,
        messages: [...params.messages, ...actions],
        orderId: params.orderId,
        queryId: params.queryId);
  }
}
