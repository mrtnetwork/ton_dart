import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/wallet/core/version.dart';
import 'package:ton_dart/src/crypto/keypair/private_key.dart';
import 'package:ton_dart/src/models/models/common_message_info.dart';
import 'package:ton_dart/src/models/models/common_message_info_relaxed.dart';
import 'package:ton_dart/src/models/models/currency_collection.dart';
import 'package:ton_dart/src/models/models/message.dart';
import 'package:ton_dart/src/models/models/message_relaxed.dart';
import 'package:ton_dart/src/models/models/send_mode.dart';
import 'package:ton_dart/src/contracts/wallet/core/versioned_wallet.dart';
import 'package:ton_dart/src/contracts/utils/transaction_utils.dart';

class _BuilderUtils {
  static Cell createV4(
      {required int subWalletId,
      required List<MessageRelaxed> messages,
      required int accountSeqno,
      required WalletVersion type,
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
      transaction.storeUint(SendMode.payGasSeparately.mode, 8);
      transaction.storeRef(beginCell().store(message).endCell());
    }
    return transaction.endCell();
  }

  static Cell createV2(
      {required List<MessageRelaxed> messages,
      required int accountSeqno,
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
      transaction.storeUint(SendMode.payGasSeparately.mode, 8);
      transaction.storeRef(beginCell().store(message).endCell());
    }
    return transaction.endCell();
  }

  static Cell createV1(
      {required List<MessageRelaxed> messages, required int accountSeqno}) {
    final transaction = beginCell();
    transaction.storeUint(accountSeqno, 32);
    for (final message in messages) {
      transaction.storeUint(SendMode.payGasSeparately.mode, 8);
      transaction.storeRef(beginCell().store(message).endCell());
    }
    return transaction.endCell();
  }
}

mixin VersionedWalletTransactionImpl on VersonedWalletContract {
  MessageRelaxed createMessageInfo({
    required TonAddress destination,
    required BigInt amount,
    String? memo,
    Cell? body,
    bool bounce = false,
    bool bounced = false,
  }) {
    assert(memo == null || body == null,
        "You have to choose a memo or body for each message.");
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
      body: body ?? TransactioUtils.buildMessageBody(memo),
    );
  }

  Cell _serializeMessage({
    required List<MessageRelaxed> messages,
    required int accountSeqno,
    SendMode sendMode = SendMode.payGasSeparately,
    int? timeOut,
  }) {
    switch (type) {
      case WalletVersion.v4:
      case WalletVersion.v3R1:
      case WalletVersion.v3R2:
        return _BuilderUtils.createV4(
            subWalletId: subWalletId!,
            messages: messages,
            accountSeqno: accountSeqno,
            type: type);
      case WalletVersion.v1R1:
      case WalletVersion.v1R2:
      case WalletVersion.v1R3:
        return _BuilderUtils.createV1(
            messages: messages, accountSeqno: accountSeqno);
      case WalletVersion.v2R1:
      case WalletVersion.v2R2:
        return _BuilderUtils.createV2(
            messages: messages, accountSeqno: accountSeqno, timeout: timeOut);
      default:
        throw UnimplementedError();
    }
  }

  Cell createTransfer(
      {required List<MessageRelaxed> messages,
      required int accountSeqno,
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout}) {
    return _serializeMessage(
        messages: messages,
        accountSeqno: accountSeqno,
        timeOut: timeout,
        sendMode: sendMode);
  }

  Message createAndSignTransfer({
    required List<MessageRelaxed> messages,
    required int accountSeqno,
    required TonPrivateKey privateKey,
    SendMode sendMode = SendMode.payGasSeparately,
    int? timeout,
  }) {
    final message = _serializeMessage(
        messages: messages,
        accountSeqno: accountSeqno,
        timeOut: timeout,
        sendMode: sendMode);
    final body = beginCell()
        .storeBuffer(privateKey.sign(message.hash()))
        .storeSlice(message.beginParse())
        .endCell();
    return Message(
        init: (accountSeqno == 0 ? state : null),
        info:
            CommonMessageInfoExternalIn(dest: address, importFee: BigInt.zero),
        body: body);
  }
}
