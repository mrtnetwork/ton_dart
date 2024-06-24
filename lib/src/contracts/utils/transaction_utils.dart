import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/models/models.dart';

class TransactioUtils {
  static MessageRelaxed internal({
    required TonAddress destination,
    required BigInt amount,
    Cell? body,
    StateInit? initState,
    bool bounce = false,
    bool bounced = false,
  }) {
    return MessageRelaxed(
        info: CommonMessageInfoRelaxedInternal(
            ihrDisabled: true,
            bounce: bounce,
            bounced: bounced,
            dest: destination,
            value: CurrencyCollection(coins: amount),
            ihrFee: BigInt.zero,
            forwardFee: BigInt.zero,
            createdLt: BigInt.zero,
            createdAt: 0),
        body: body ?? Cell.empty,
        init: initState);
  }

  static Cell buildMessageBody(String? memo) {
    if (memo != null) {
      return beginCell().storeUint(0, 32).storeStringTail(memo).endCell();
    }
    return Cell.empty;
  }

  static Cell createV4(
      {required int subWalletId,
      required List<MessageRelaxed> messages,
      required int accountSeqno,
      required WalletVersion type,
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout}) {
    final transaction = beginCell();
    transaction.storeUint(subWalletId, 32);
    if (accountSeqno == 0) {
      for (int i = 0; i < 32; i++) {
        transaction.storeBit(1);
      }
    } else {
      timeout ??= (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 60;
      transaction.storeUint(timeout, 32);
    }
    transaction.storeUint(accountSeqno, 32);
    if (type == WalletVersion.v4) {
      transaction.storeUint(0, 8);
    }

    for (final message in messages) {
      transaction.storeUint(sendMode.mode, 8);
      transaction.storeRef(beginCell().store(message).endCell());
    }
    return transaction.endCell();
  }

  static Cell createV2(
      {required List<MessageRelaxed> messages,
      required int accountSeqno,
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout}) {
    final transaction = beginCell();
    transaction.storeUint(accountSeqno, 32);
    if (accountSeqno == 0) {
      for (int i = 0; i < 32; i++) {
        transaction.storeBit(1);
      }
    } else {
      timeout ??= (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 60;
      transaction.storeUint(timeout, 32);
    }
    for (final message in messages) {
      transaction.storeUint(sendMode.mode, 8);
      transaction.storeRef(beginCell().store(message).endCell());
    }
    return transaction.endCell();
  }

  static Cell createV1({
    required List<MessageRelaxed> messages,
    required int accountSeqno,
    SendMode sendMode = SendMode.payGasSeparately,
  }) {
    final transaction = beginCell();
    transaction.storeUint(accountSeqno, 32);
    for (final message in messages) {
      transaction.storeUint(sendMode.mode, 8);
      transaction.storeRef(beginCell().store(message).endCell());
    }
    return transaction.endCell();
  }

  static Cell serializeMessage({
    required List<MessageRelaxed> messages,
    required int accountSeqno,
    required WalletVersion type,
    SendMode sendMode = SendMode.payGasSeparately,
    int? timeOut,
    int? subwalletId,
  }) {
    switch (type) {
      case WalletVersion.v4:
      case WalletVersion.v3R1:
      case WalletVersion.v3R2:
        return createV4(
            subWalletId: subwalletId!,
            messages: messages,
            accountSeqno: accountSeqno,
            type: type,
            sendMode: sendMode);
      case WalletVersion.v1R1:
      case WalletVersion.v1R2:
      case WalletVersion.v1R3:
        return createV1(
            messages: messages, accountSeqno: accountSeqno, sendMode: sendMode);
      case WalletVersion.v2R1:
      case WalletVersion.v2R2:
        return createV2(
            messages: messages,
            accountSeqno: accountSeqno,
            timeout: timeOut,
            sendMode: sendMode);
      default:
        throw UnimplementedError();
    }
  }
}
