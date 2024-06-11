import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/highload/core/core.dart';
import 'package:ton_dart/src/contracts/highload/models/v3_account_params.dart';
import 'package:ton_dart/src/crypto/keypair/private_key.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/highload/constant/constant.dart';
import 'package:ton_dart/src/contracts/highload/provider/v3.dart';
import 'package:ton_dart/src/contracts/highload/utils/utils.dart';

class HighloadWalletV3 extends HighloadWallets
    with HighloadWalletV3ProviderImpl {
  @override
  final int workChain;

  @override
  final StateInit state;

  @override
  final TonAddress address;

  @override
  final int subWalletId;

  final int timeout;

  const HighloadWalletV3._(
      {required this.workChain,
      required this.state,
      required this.address,
      required this.subWalletId,
      required this.timeout});

  factory HighloadWalletV3(
      {required int workChain,
      required List<int> publicKey,
      int? subWalletId,
      int timeout = HightloadWalletConst.defaultTimeout}) {
    subWalletId ??= HightloadWalletConst.defaultHighLoadSubWallet + workChain;
    final state = HighloadWalletUtils.buildV3(
        publicKey: publicKey, subWalletId: subWalletId, timeout: timeout);
    return HighloadWalletV3._(
        state: state,
        workChain: workChain,
        address: TonAddress.fromState(state: state, workChain: workChain),
        subWalletId: subWalletId,
        timeout: timeout);
  }
  static Future<HighloadWalletV3> fromAddress(
      {required TonAddress address, required TonApiProvider rpc}) async {
    final st2 =
        await rpc.request(TonCenterGetAddressInformation(address.toString()));
    final state = HighloadWalletUtils.readV3State(st2.data);
    final wallet = HighloadWalletV3(
        workChain: address.workChain,
        publicKey: state.publicKey,
        timeout: state.timeout,
        subWalletId: state.subWalletId);
    if (wallet.address.toRawAddress() != address.toRawAddress()) {
      throw TonContractException("Incorrect state address.", details: {
        "excepted": wallet.address.toString(),
        "address": address.toString(),
        "workChain": wallet.address.workChain
      });
    }
    return wallet;
  }

  @override
  Cell code(int workchain) {
    return HighloadWalletUtils.buildV3Code();
  }

  @override
  Cell data(HighloadWalletV3AccountParams params) {
    return HighloadWalletUtils.buildV3Data(
        publicKey: params.publicKey,
        subWalletId: params.subWalletId,
        timeout: params.timeout);
  }

  MessageRelaxed packedAction(
      {required List<OutAction> messages,
      required BigInt value,
      required BigInt queryId,
      bool bounce = false}) {
    return HighloadWalletUtils.packedAction(
        messages: messages,
        value: value,
        queryId: queryId,
        account: address,
        bounce: bounce);
  }

  static Cell createInternalTransferBody(
      {required List<OutAction> acctions, required BigInt queryId}) {
    return HighloadWalletUtils.createInternalTransferBody(
        acctions: acctions, queryId: queryId);
  }

  MessageRelaxed createInternalTransfer(
      {required List<OutAction> messages,
      required BigInt value,
      required BigInt queryId,
      bool bounce = false}) {
    return HighloadWalletUtils.createInternalTransfer(
        messages: messages, value: value, queryId: queryId, account: address);
  }

  Message createAndSignExternalMessage(
      {required TonPrivateKey signer,
      required MessageRelaxed message,
      required BigInt queryId,
      SendMode mode = SendMode.carryAllRemainingBalance,
      int? createAt,
      AccountStatus status = AccountStatus.active}) {
    return HighloadWalletUtils.createExternalMessage(
        signer: signer,
        message: message,
        queryId: queryId,
        subWalletId: subWalletId,
        timeout: timeout,
        account: address,
        createAt: createAt,
        mode: mode,
        state: status.isActive ? null : state);
  }

  Future<String> sendBatchTransaction(
      {required TonPrivateKey signer,
      required List<OutActionSendMsg> messages,
      required BigInt queryId,
      required TonApiProvider rpc,
      required BigInt value,
      SendMode mode = SendMode.carryAllRemainingBalance,
      int? createAt,
      AccountStatus status = AccountStatus.active}) async {
    final extMessage = createAndSignExternalMessage(
        signer: signer,
        message:
            packedAction(messages: messages, value: value, queryId: queryId),
        queryId: queryId,
        createAt: createAt,
        mode: mode,
        status: status);
    return sendMessage(rpc: rpc, exMessage: extMessage);
  }
}
