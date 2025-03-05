import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core/transfer_params.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/utils/serialization_utils.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/transfer_params/versioned.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/state/versioned.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/utils/versioned.dart';

mixin VerionedProviderImpl<C extends VersionedWalletState,
        TRANSFERPARAMS extends WalletContractTransferParams>
    on WalletContract<C, TRANSFERPARAMS> {
  WalletVersion get type;
  Future<int> getSeqno(TonProvider rpc) async {
    try {
      final state = await readState(rpc);
      return state.seqno;
    } on TonContractException catch (e) {
      if (e == TonContractExceptionConst.stateIsInactive) {
        return 0;
      }
      rethrow;
    }
  }

  Future<BigInt> getBalance(TonProvider rpc) async {
    final state = await getState(rpc: rpc);
    return state.balance;
  }

  Future<String> getPublicKey(TonProvider rpc) async {
    final state = await readState(rpc);
    return state.publicKey.toHex();
  }

  Future<C> readState(TonProvider rpc) async {
    final state = await getState(rpc: rpc);
    final stateData = VersionedWalletUtils.readState(
        stateData: state.data, type: type, chain: chain);
    if (stateData is! C) {
      throw TonContractException('Incorrect state data.',
          details: {'expected': '$C', 'got': '${stateData.runtimeType}'});
    }
    return stateData;
  }

  Future<C?> getContractState(TonProvider rpc) async {
    final state = await getState(rpc: rpc);
    if (!state.state.isActive) return null;
    final stateData = VersionedWalletUtils.readState(
        stateData: state.data, type: type, chain: chain);
    if (stateData is! C) {
      throw TonContractException('Incorrect state data.',
          details: {'expected': '$C', 'got': '${stateData.runtimeType}'});
    }
    return stateData;
  }

  @override
  Future<String> sendTransfer(
      {required TRANSFERPARAMS params,
      required TonProvider rpc,
      List<MessageRelaxed> messages = const [],
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      OnEstimateFee? onEstimateFee, bool sendToBlockchain = true}) async {
    if (params is! VersionedTransferParams) {
      throw TonContractException('Invalid transaction params', details: {
        'expected': 'VersionedTransferParams',
        'got': '${params.runtimeType}'
      });
    }
    final VersionedWalletState? state = await getContractState(rpc);
    if (this.state == null && state == null) {
      throw const TonContractException(
          'cannot send transaction with watch only wallet');
    }
    final List<OutActionSendMsg> actions = [
      ...messages.map((e) => OutActionSendMsg(mode: sendMode, outMessage: e)),
      ...params.messages
    ];

    final message = TonSerializationUtils.serializeMessage(
        actions: actions,
        state: state ?? this.state!,
        seqno: state?.seqno ?? 0,
        timeOut: timeout);
    final body = beginCell()
        .storeBuffer(params.privateKey.sign(message.hash()))
        .storeSlice(message.beginParse())
        .endCell();
    final ext = Message(
        init: (state == null ? this.state!.initialState() : null),
        info:
            CommonMessageInfoExternalIn(dest: address, importFee: BigInt.zero),
        body: body);
    if (onEstimateFee != null) {
      await onEstimateFee(ext);
    }
    if (sendToBlockchain) return sendMessage(rpc: rpc, exMessage: ext);
    return ext.serialize().toBase64();
  }

  Future<String> deploy(
      {required TRANSFERPARAMS params,
      required TonProvider rpc,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body}) async {
    return sendTransfer(params: params, rpc: rpc, messages: []);
  }
}
