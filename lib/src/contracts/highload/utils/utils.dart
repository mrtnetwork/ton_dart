import 'package:blockchain_utils/bip/ecc/bip_ecc.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/crypto/keypair/private_key.dart';
import 'package:ton_dart/src/contracts/highload/constant/constant.dart';
import 'package:ton_dart/src/contracts/highload/models/v3_account_params.dart';
import 'package:ton_dart/src/models/models.dart';

class HighloadWalletUtils {
  static StateInit buildV3(
      {required List<int> publicKey,
      required int subWalletId,
      required int timeout}) {
    final code = buildV3Code();
    final data = buildV3Data(
        publicKey: publicKey, subWalletId: subWalletId, timeout: timeout);
    return StateInit(code: code, data: data);
  }

  static HighloadWalletV3AccountParams readV3State(String? state) {
    try {
      final Slice slice = Cell.fromBase64(state!).beginParse();
      return HighloadWalletV3AccountParams(
          publicKey: slice.loadBuffer(32),
          subWalletId: slice.loadUint(32),
          timeout: slice
              .skip(1 + 1 + HightloadWalletConst.highLoadTimeStampSize)
              .loadUint(HightloadWalletConst.highLoadTimeOutSize));
    } catch (e) {
      throw TonContractException("Invalid HighloadWalletV3 account data.",
          details: {"state": state});
    }
  }

  static Cell buildV3Code() {
    return Cell.fromBase64(HightloadWalletConst.hightloadWallet3State);
  }

  static Cell buildV3Data({
    required List<int> publicKey,
    required int subWalletId,
    required int timeout,
  }) {
    final pubkey = Ed25519PublicKey.fromBytes(publicKey);
    return beginCell()
        .storeBuffer(pubkey.compressed.sublist(1))
        .storeUint(subWalletId, 32)
        .storeUint(0, 1 + 1 + HightloadWalletConst.highLoadTimeStampSize)
        .storeUint(timeout, HightloadWalletConst.highLoadTimeOutSize)
        .endCell();
  }

  static Cell createInternalTransferBody(
      {required List<OutAction> acctions, required BigInt queryId}) {
    final Cell actionsCell;
    if (acctions.length > 254) {
      throw TonContractException(
          "Max allowed action count is 254. Use packActions instead.");
    }
    final actionsBuilder = beginCell();
    final out = OutActionUtils.storeOutList(acctions);
    actionsBuilder.storeSlice(out);
    actionsCell = actionsBuilder.endCell();
    return beginCell()
        .storeUint(HightloadWalletConst.transferOp, 32)
        .storeUint(queryId, 64)
        .storeRef(actionsCell)
        .endCell();
  }

  static MessageRelaxed createInternalTransfer(
      {required List<OutAction> messages,
      required BigInt value,
      required BigInt queryId,
      required TonAddress account,
      bool bounce = false}) {
    return MessageRelaxed(
        info: CommonMessageInfoRelaxedInternal(
          ihrDisabled: true,
          bounce: bounce,
          bounced: false,
          dest: account,
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
        .storeUint(createAt, HightloadWalletConst.highLoadTimeStampSize)
        .storeUint(timeout, HightloadWalletConst.highLoadTimeOutSize)
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

  static MessageRelaxed packedAction(
      {required List<OutAction> messages,
      required BigInt value,
      required BigInt queryId,
      required TonAddress account,
      bool bounce = false}) {
    List<OutAction> batch = [];
    if (messages.length > 254) {
      batch = messages.sublist(0, 253);
      batch.add(OutActionSendMsg(
          mode: value > BigInt.zero
              ? SendMode.payGasSeparately
              : SendMode.carryAllRemainingBalance,
          outMessage: packedAction(
              messages: messages.sublist(253),
              value: value,
              queryId: queryId,
              account: account)));
    } else {
      batch = messages;
    }
    return createInternalTransfer(
        messages: batch,
        value: value,
        queryId: queryId,
        account: account,
        bounce: bounce);
  }
}
