import 'package:ton_dart/src/boc/boc.dart';
import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/contracts/core/core/transfer_params.dart';
import 'package:ton_dart/src/contracts/utils/serialization_utils.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/state/versioned.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/transfer_params/versioned.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/utils/versioned.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';

mixin VerionedProviderImpl<
  C extends VersionedWalletState,
  TRANSFERPARAMS extends WalletContractTransferParams
>
    on WalletContract<C, TRANSFERPARAMS> {
  WalletVersion get type;
  Future<int> getSeqno(TonQuickClient client) async {
    try {
      final state = await readState(client);
      return state.seqno;
    } on BuError catch (e) {
      if (e == TonContractErrors.stateIsInactive) {
        return 0;
      }
      rethrow;
    }
  }

  Future<BigInt> getBalance(TonQuickClient client) async {
    final state = await getState(client: client);
    return state.balance;
  }

  Future<String> getPublicKey(TonQuickClient client) async {
    final state = await readState(client);
    return state.publicKey.toHex();
  }

  Future<C> readState(TonQuickClient client) async {
    final state = await getState(client: client);
    final stateData = VersionedWalletUtils.readState(
      stateData: state.data,
      type: type,
      workchain: workchain,
      chainId: chainId,
    );

    if (stateData is! C) {
      throw BuError(DefaultErrorType.castFailed, 
        'Incorrect state data.',
        details: {'expected': '$C', 'got': '${stateData.runtimeType}'},
      );
    }
    return stateData;
  }

  Future<C?> getContractState(TonQuickClient client) async {
    final state = await getState(client: client);
    if (!state.state.isActive) return null;
    final stateData = VersionedWalletUtils.readState(
      stateData: state.data,
      type: type,
      workchain: workchain,
      chainId: chainId,
    );
    if (stateData is! C) {
      throw BuError(DefaultErrorType.castFailed, 
        'Incorrect state data.',
        details: {'expected': '$C', 'got': '${stateData.runtimeType}'},
      );
    }
    return stateData;
  }

  @override
  Future<String> sendTransfer({
    required TRANSFERPARAMS params,
    required TonQuickClient client,
    List<MessageRelaxed> messages = const [],
    int sendMode = SendModeConst.payGasSeparately,
    int? timeout,
    OnEstimateFee? onEstimateFee,
    TonTransactionAction action = TonTransactionAction.broadcast,
  }) async {
    if (params is! VersionedTransferParams) {
      throw BuError(DefaultErrorType.castFailed, 
        'Invalid transaction params',
        details: {
          'expected': 'VersionedTransferParams',
          'got': '${params.runtimeType}',
        },
      );
    }
    final VersionedWalletState? state = await getContractState(client);
    if (this.state == null && state == null) {
      throw BuError(DefaultErrorType.invalidState, 
        'cannot send transaction with watch only wallet',
      );
    }
    final List<OutActionSendMsg> actions = [
      ...messages.map((e) => OutActionSendMsg(mode: sendMode, outMessage: e)),
      ...params.messages,
    ];

    final message = TonSerializationUtils.serializeMessage(
      actions: actions,
      state: state ?? this.state!,
      seqno: state?.seqno ?? 0,
      timeout: timeout,
    );
    final body =
        beginCell()
            .storeBuffer(params.privateKey.sign(message.hash()))
            .storeSlice(message.beginParse())
            .endCell();
    final ext = Message(
      init: (state == null ? this.state!.initialState() : null),
      info: CommonMessageInfoExternalIn(dest: address, importFee: BigInt.zero),
      body: body,
    );
    if (onEstimateFee != null) {
      await onEstimateFee(ext);
    }
    if (action.isBroadcast) return sendMessage(client: client, exMessage: ext);
    return ext.serialize().toBase64();
  }

  Future<String> deploy({
    required TRANSFERPARAMS params,
    required TonQuickClient client,
    int sendMode = SendModeConst.payGasSeparately,
    int? timeout,
    bool? bounce,
    bool bounced = false,
    Cell? body,
  }) async {
    return sendTransfer(params: params, client: client, messages: []);
  }
}
