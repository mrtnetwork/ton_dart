import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/contracts/wallet/core/version.dart';
import 'package:ton_dart/src/crypto/keypair/private_key.dart';
import 'package:ton_dart/src/models/models/message_relaxed.dart';
import 'package:ton_dart/src/models/models/send_mode.dart';
import 'package:ton_dart/src/provider/models/response/ton_center_address_info.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/wallet/utils/utils.dart';
import 'package:ton_dart/src/contracts/wallet/transaction/transaction_impl.dart';
import 'package:ton_dart/src/contracts/wallet/models/versioned_wallet_account_params.dart';

mixin VerionedProviderImpl on VersionedWalletTransactionImpl {
  static Future<TonCenterFullAccountStateResponse> getStateStatic(
      {required TonApiProvider rpc, required TonAddress address}) async {
    final state =
        await rpc.request(TonCenterGetAddressInformation(address.toString()));
    return state;
  }

  static Future<VersionedWalletAccountPrams> readState(
      {required TonApiProvider rpc,
      required TonAddress address,
      required WalletVersion type}) async {
    final state =
        await rpc.request(TonCenterGetAddressInformation(address.toString()));
    if (!state.state.isActive) {
      throw const MessageException("Account does not actiive.");
    }
    return VersionedWalletUtils.readState(stateData: state.data, type: type);
  }

  Future<int> getSeqno(TonApiProvider rpc) async {
    final state = await getState(rpc: rpc);
    if (!state.state.isActive) return 0;
    final readState =
        VersionedWalletUtils.readState(stateData: state.data, type: type);
    return readState.seqno;
  }

  Future<BigInt> getBalance(TonApiProvider rpc) async {
    final state = await getState(rpc: rpc);
    return state.balance;
  }

  Future<String> getPublicKey(TonApiProvider rpc) async {
    final state = await getState(rpc: rpc);
    final readState =
        VersionedWalletUtils.readState(stateData: state.data, type: type);
    return BytesUtils.toHexString(readState.publicKey);
  }

  @override
  Future<String> sendTransfer(
      {required List<MessageRelaxed> messages,
      required TonPrivateKey privateKey,
      required TonApiProvider rpc,
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
