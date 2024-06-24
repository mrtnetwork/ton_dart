import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/utils/transaction_utils.dart';
import 'package:ton_dart/src/contracts/wallet/core/versioned_wallet.dart';
import 'package:ton_dart/src/contracts/wallet/models/versioned_wallet_account_params.dart';
import 'package:ton_dart/src/crypto/keypair/private_key.dart';
import 'package:ton_dart/src/models/models/message_relaxed.dart';
import 'package:ton_dart/src/models/models/send_mode.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/wallet/utils/utils.dart';
import 'package:ton_dart/src/contracts/wallet/transaction/transaction_impl.dart';

mixin VerionedProviderImpl on VersionedWalletTransactionImpl {
  Future<int> getSeqno(TonProvider rpc) async {
    final state = await getState(rpc: rpc);
    if (!state.state.isActive) return 0;
    final readState =
        VersionedWalletUtils.readState(stateData: state.data, type: type);
    return readState.seqno;
  }

  Future<BigInt> getBalance(TonProvider rpc) async {
    final state = await getState(rpc: rpc);
    return state.balance;
  }

  Future<String> getPublicKey(TonProvider rpc) async {
    final state = await getState(rpc: rpc);
    final readState =
        VersionedWalletUtils.readState(stateData: state.data, type: type);
    return BytesUtils.toHexString(readState.publicKey);
  }

  Future<VersionedWalletAccountPrams> readState(TonProvider rpc) async {
    final state = await getState(rpc: rpc);
    return VersionedWalletUtils.readState(stateData: state.data, type: type);
  }

  @override
  Future<String> sendTransfer(
      {required List<MessageRelaxed> messages,
      required TonPrivateKey privateKey,
      required TonProvider rpc,
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      OnEstimateFee? onEstimateFee}) async {
    final stateData = await readState(rpc);

    final exMessage = createAndSignTransfer(
        messages: messages,
        accountSeqno: stateData.seqno,
        sendMode: sendMode,
        timeout: timeout,
        privateKey: privateKey,
        subWalletId:
            type.hasSubwalletId ? (subWalletId ?? stateData.subwallet) : null);
    if (onEstimateFee != null) {
      await onEstimateFee(exMessage);
    }
    return sendMessage(rpc: rpc, exMessage: exMessage);
  }

  Future<String> deploy(
      {required TonPrivateKey ownerPrivateKey,
      required TonProvider rpc,
      required BigInt amount,
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body}) async {
    final stateData = await readState(rpc);

    if (stateData.seqno != 0) {
      throw TonContractException("Account is already active.");
    }
    if (state == null) {
      throw TonContractException(
          "For deploy minter please use create constructor to build state");
    }
    final boc = createAndSignTransfer(
        messages: [
          TransactioUtils.internal(
              destination: address,
              amount: amount,
              initState: state,
              bounced: bounced,
              body: body,
              bounce: bounce ?? address.isBounceable)
        ],
        accountSeqno: stateData.seqno,
        sendMode: sendMode,
        timeout: timeout,
        privateKey: ownerPrivateKey,
        subWalletId:
            type.hasSubwalletId ? (subWalletId ?? stateData.subwallet) : null);
    return sendMessage(rpc: rpc, exMessage: boc);
  }
}
