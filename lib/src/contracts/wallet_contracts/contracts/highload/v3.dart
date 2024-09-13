import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/transfer_params/highload.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/state/highload.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/constant/constants/highload.dart';
import 'package:ton_dart/src/crypto/keypair/private_key.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/provider/highload.dart';

class HighloadWalletV3 extends HighloadWallets<HighloadWalletV3State>
    with HighloadWalletV3ProviderImpl<HighloadWalletV3State> {
  HighloadWalletV3(
      {required TonAddress address, HighloadWalletV3State? stateInit})
      : super(stateInit: stateInit, address: address);

  factory HighloadWalletV3.create(
      {required TonChain chain,
      required List<int> publicKey,
      int? subWalletId,
      int timeout = HighloadWalletConst.defaultTimeout}) {
    subWalletId ??=
        HighloadWalletConst.defaultHighLoadSubWallet + chain.workchain;
    final stateInit = HighloadWalletV3State(
        publicKey: publicKey, timeout: timeout, subWalletId: subWalletId);
    final state = stateInit.initialState();
    return HighloadWalletV3(
        address: TonAddress.fromState(state: state, workChain: chain.workchain),
        stateInit: stateInit);
  }
  static Future<HighloadWalletV3> fromAddress(
      {required TonAddress address, required TonProvider rpc}) async {
    final st2 =
        await ContractProvider.getActiveState(rpc: rpc, address: address);
    final state = HighloadWalletV3State.deserialize(st2.data!.beginParse());
    final walletAddress = TonAddress.fromState(
        state: state.initialState(), workChain: address.workChain);
    if (walletAddress != address) {
      throw TonContractException("Incorrect state address.", details: {
        "excepted": walletAddress.toRawAddress(),
        "address": address.toRawAddress(),
        "workChain": address.workChain
      });
    }
    return HighloadWalletV3(address: address, stateInit: state);
  }

  Cell createInternalTransferBody(
      {required List<OutAction> acctions, required BigInt queryId}) {
    final Cell actionsCell;
    if (acctions.length > 254) {
      throw const TonContractException(
          "Max allowed action count is 254. Use packActions instead.");
    }
    final actionsBuilder = beginCell();
    final out = OutActionUtils.storeOutList(acctions);
    actionsBuilder.storeSlice(out);
    actionsCell = actionsBuilder.endCell();
    return beginCell()
        .storeUint(HighloadWalletConst.transferOp, 32)
        .storeUint(queryId, 64)
        .storeRef(actionsCell)
        .endCell();
  }

  MessageRelaxed createInternalTransfer(
      {required List<OutAction> messages,
      required BigInt value,
      required BigInt queryId,
      bool? bounce,
      bool bounced = false}) {
    return MessageRelaxed(
        info: CommonMessageInfoRelaxedInternal(
          ihrDisabled: true,
          bounce: bounce ?? address.isBounceable,
          bounced: bounced,
          dest: address,
          value: CurrencyCollection(coins: value),
          ihrFee: BigInt.zero,
          forwardFee: BigInt.zero,
          createdLt: BigInt.zero,
          createdAt: 0,
        ),
        body: createInternalTransferBody(acctions: messages, queryId: queryId));
  }

  static Message createExternalMessage({
    required TonPrivateKey signer,
    required MessageRelaxed message,
    required BigInt queryId,
    required int subWalletId,
    required int timeout,
    required TonAddress account,
    StateInit? state,
    SendMode mode = SendMode.carryAllRemainingBalance,
    int? createAt,
  }) {
    createAt ??= (DateTime.now().millisecondsSinceEpoch ~/ 1000) - 10;
    final Cell messageCell = beginCell().store(message).endCell();
    final messageInner = beginCell()
        .storeUint(subWalletId, 32)
        .storeRef(messageCell)
        .storeUint(mode.mode, 8)
        .storeUint(queryId, 23)
        .storeUint(createAt, HighloadWalletConst.highLoadTimeStampSize)
        .storeUint(timeout, HighloadWalletConst.highLoadTimeOutSize)
        .endCell();

    final body = beginCell()
        .storeBuffer(signer.sign(messageInner.hash()))
        .storeRef(messageInner)
        .endCell();
    final extMessage = Message(
        init: state,
        info:
            CommonMessageInfoExternalIn(dest: account, importFee: BigInt.zero),
        body: body);
    return extMessage;
  }

  MessageRelaxed packedAction(
      {required List<OutAction> messages,
      required BigInt value,
      required BigInt queryId,
      bool? bounce,
      bool bounced = false}) {
    List<OutAction> batch = [];
    if (messages.length > 254) {
      batch = messages.sublist(0, 253);
      batch.add(OutActionSendMsg(
          mode: value > BigInt.zero
              ? SendMode.payGasSeparately.mode
              : SendMode.carryAllRemainingBalance.mode,
          outMessage: packedAction(
              messages: messages.sublist(253),
              value: value,
              queryId: queryId)));
    } else {
      batch = messages;
    }
    return createInternalTransfer(
        messages: batch,
        value: value,
        queryId: queryId,
        bounce: bounce,
        bounced: bounced);
  }

  Message createAndSignExternalMessage(
      {required TonPrivateKey signer,
      required MessageRelaxed message,
      required BigInt queryId,
      SendMode mode = SendMode.carryAllRemainingBalance,
      int? createAt,
      StateInit? initState}) {
    return createExternalMessage(
        signer: signer,
        message: message,
        queryId: queryId,
        subWalletId: state!.subWalletId,
        timeout: state!.timeout,
        account: address,
        createAt: createAt,
        mode: mode,
        state: initState);
  }

  Future<String> sendBatchTransaction(
      {required TonPrivateKey signer,
      required List<OutActionSendMsg> messages,
      required BigInt queryId,
      required TonProvider rpc,
      required BigInt value,
      SendMode mode = SendMode.carryAllRemainingBalance,
      int? createAt}) async {
    final active = await isActive(rpc);
    if (!active && state == null) {
      throw const TonContractException(
          "Cannot Send Batch Transaction with watch only wallet");
    }
    final extMessage = createAndSignExternalMessage(
        signer: signer,
        message:
            packedAction(messages: messages, value: value, queryId: queryId),
        queryId: queryId,
        createAt: createAt,
        mode: mode,
        initState: active ? null : state!.initialState());
    return sendMessage(rpc: rpc, exMessage: extMessage);
  }

  @override
  Future<String> sendTransfer(
      {required HighloadTransferParams params,
      List<MessageRelaxed> messages = const [],
      required TonProvider rpc,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      OnEstimateFee? onEstimateFee}) {
    final actions = messages
        .map((e) => OutActionSendMsg(outMessage: e, mode: sendMode))
        .toList();
    return sendBatchTransaction(
        signer: params.signer,
        messages: [...params.messages, ...actions],
        queryId: params.queryId,
        rpc: rpc,
        value: params.value ?? BigInt.zero);
  }
}
