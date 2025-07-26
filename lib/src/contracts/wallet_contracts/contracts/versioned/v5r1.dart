import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/utils/serialization_utils.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/types.dart';
import 'package:ton_dart/src/crypto/crypto.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/utils/versioned.dart';

/// This is an extensible wallet specification aimed at replacing V4 and allowing arbitrary extensions.
/// W5 has 25% lower fees, supports gasless transactions (via third party relayers) and implements a flexible extension mechanism.
/// https://github.com/tonkeeper/w5/tree/main
class WalletV5R1 extends VersionedWalletContract<V5VersionedWalletState,
    VersionedV5TransferParams> {
  WalletV5R1({super.stateInit, required super.address, super.chain})
      : super(type: WalletVersion.v5R1);

  factory WalletV5R1.create(
      {required V5R1Context context,
      required List<int> publicKey,
      TonChainId? chain,
      bool bounceableAddress = false}) {
    if (context is V5R1ClientContext) {
      chain = context.chain;
    }
    final state = V5VersionedWalletState(
        publicKey: publicKey, version: WalletVersion.v5R1, context: context);
    return WalletV5R1(
      stateInit: state,
      address: TonAddress.fromState(
          state: state.initialState(),
          workChain: chain?.workchain ?? 0,
          bounceable: bounceableAddress),
    );
  }

  static Future<WalletV5R1> fromAddress(
      {required TonAddress address,
      required TonProvider rpc,
      TonChainId? chain}) async {
    final data =
        await ContractProvider.getActiveState(rpc: rpc, address: address);
    final state = VersionedWalletUtils.buildFromAddress<V5VersionedWalletState>(
        address: address,
        stateData: data.data,
        type: WalletVersion.v5R1,
        chain: chain);
    return WalletV5R1(address: address, stateInit: state, chain: chain);
  }

  factory WalletV5R1.watch(TonAddress address) {
    return WalletV5R1(address: address);
  }

  static List<OutActionSendMsg> messageRelaxedToActions(
      {required List<MessageRelaxed> messages,
      int sendMode = SendModeConst.payGasSeparately}) {
    return messages
        .map((e) => OutActionSendMsg(mode: sendMode, outMessage: e))
        .toList();
  }

  Cell createRequest(
      {required List<OutActionWalletV5> actions,
      WalletV5AuthType type = WalletV5AuthType.external,
      int? accountSeqno,
      int? timeout,
      BigInt? queryId}) {
    if (type == WalletV5AuthType.extension) {
      return createExtensionMessage(actions: actions, queryId: queryId);
    }
    if (accountSeqno == null || state?.context == null) {
      throw TonContractException(
          'accountSeqno and wallet context required for build wallet message v5R1 in $type type.');
    }
    return TonSerializationUtils.serializeV5(
        accountSeqno: accountSeqno,
        actions: OutActionsV5(actions: actions),
        type: type,
        timeout: timeout,
        context: state!.context);
  }

  Cell createExtensionMessage({
    required List<OutActionWalletV5> actions,
    BigInt? queryId,
  }) {
    return beginCell()
        .storeUint32(WalletV5AuthType.extension.tag)
        .storeUint64(queryId ?? 0)
        .store(OutActionsV5(actions: actions))
        .endCell();
  }

  Future<Cell> createAndSignInternalMessage(
      {required TonPrivateKey signer,
      required TonProvider rpc,
      List<MessageRelaxed> messages = const [],
      List<OutActionWalletV5> v5Messages = const [],
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      int? accountSeqno}) async {
    final VersionedWalletState? state = await getContractState(rpc);
    if (state == null && this.state == null) {
      throw const TonContractException(
          'cannot send transaction with watch only wallet');
    }
    final List<OutActionWalletV5> actions = [
      ...messages.map((e) => OutActionSendMsg(mode: sendMode, outMessage: e)),
      ...v5Messages
    ];
    final hasDeploy = actions.whereType<OutActionSendMsg>().any(
        (e) => e.outMessage.info.dest == address && e.outMessage.init != null);
    if (state != null && hasDeploy) {
      throw TonContractException(
          'Account is already active. should not add init state to message with with destination address $address');
    }
    final message = createRequest(
        actions: actions,
        type: WalletV5AuthType.internal,
        accountSeqno: accountSeqno ?? (state?.seqno ?? 0),
        timeout: timeout);
    return beginCell()
        .storeSlice(message.beginParse())
        .storeBuffer(signer.sign(message.hash()))
        .endCell();
  }

  @override
  Future<String> sendTransfer({
    required VersionedV5TransferParams params,
    required TonProvider rpc,
    List<MessageRelaxed> messages = const [],
    List<OutActionWalletV5> v5Messages = const [],
    int sendMode = SendModeConst.payGasSeparately,
    int? timeout,
    OnEstimateFee? onEstimateFee,
    TonTransactionAction action = TonTransactionAction.broadcast,
  }) async {
    final VersionedWalletState? state = await getContractState(rpc);
    if (state == null && this.state == null) {
      throw const TonContractException(
          'cannot send transaction with watch only wallet');
    }
    final List<OutActionWalletV5> actions = [
      ...messages.map((e) => OutActionSendMsg(mode: sendMode, outMessage: e)),
      ...params.messages,
      ...v5Messages
    ];
    final hasDeploy = actions.whereType<OutActionSendMsg>().any(
        (e) => e.outMessage.info.dest == address && e.outMessage.init != null);
    if (state != null && hasDeploy) {
      throw TonContractException(
          'Account is already active. should not add init state to message with with destination address $address');
    }
    final message = createRequest(
        actions: actions,
        type: params.type,
        accountSeqno: (state?.seqno) ?? 0,
        timeout: timeout);
    final body = beginCell()
        .storeSlice(message.beginParse())
        .storeBuffer(params.signer.sign(message.hash()))
        .endCell();

    final ext = Message(
        init: (state == null ? this.state!.initialState() : null),
        info:
            CommonMessageInfoExternalIn(dest: address, importFee: BigInt.zero),
        body: body);
    if (onEstimateFee != null) {
      await onEstimateFee(ext);
    }
    if (action.isBroadcast) return sendMessage(rpc: rpc, exMessage: ext);
    return ext.serialize().toBase64();
  }

  Future<String> sendRemoveExtension({
    required VersionedV5TransferParams params,
    required TonPrivateKey privateKey,
    required TonProvider rpc,
    int sendMode = SendModeConst.payGasSeparately,
    WalletV5AuthType type = WalletV5AuthType.external,
    int? timeout,
    OnEstimateFee? onEstimateFee,
    TonTransactionAction action = TonTransactionAction.broadcast,
  }) async {
    return sendActionRequest(
      actions: [OutActionRemoveExtension(address)],
      params: params,
      rpc: rpc,
      sendMode: sendMode,
      timeout: timeout,
      onEstimateFee: onEstimateFee,
      action: action,
    );
  }

  Future<String> sendActionRequest({
    required VersionedV5TransferParams params,
    required TonProvider rpc,
    List<OutActionWalletV5> actions = const [],
    int sendMode = SendModeConst.payGasSeparately,
    int? timeout,
    OnEstimateFee? onEstimateFee,
    TonTransactionAction action = TonTransactionAction.broadcast,
  }) async {
    if (params.type == WalletV5AuthType.extension) {
      throw const TonContractException(
          'use create request instead sendActionRequest for build message body.');
    }
    if (state == null) {
      throw const TonContractException(
          'cannot create request with watch only wallet.');
    }
    return sendTransfer(
      params: params,
      rpc: rpc,
      messages: const [],
      v5Messages: actions,
      onEstimateFee: onEstimateFee,
      timeout: timeout,
      sendMode: sendMode,
      action: action,
    );
  }

  Future<List<TonAddress>> getExtensions(TonProvider rpc) async {
    final state = await readState(rpc);
    return state.extensionPubKeys;
  }

  Future<bool> setPubKeyEnabled(TonProvider rpc) async {
    final state = await readState(rpc);
    return state.setPubKeyEnabled;
  }
}
