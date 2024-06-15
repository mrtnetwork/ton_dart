import 'package:blockchain_utils/blockchain_utils.dart';
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

  @override
  Future<String> sendTransfer(
      {required List<MessageRelaxed> messages,
      required TonPrivateKey privateKey,
      required TonProvider rpc,
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout}) async {
    final accountSeqno = await getSeqno(rpc);
    final boc = createAndSignTransfer(
        messages: messages,
        accountSeqno: accountSeqno,
        sendMode: sendMode,
        timeout: timeout,
        privateKey: privateKey);
    return sendMessage(rpc: rpc, exMessage: boc);
  }
}
