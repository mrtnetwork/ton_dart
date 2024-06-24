import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/crypto/keypair/private_key.dart';
import 'package:ton_dart/src/models/models/common_message_info.dart';
import 'package:ton_dart/src/models/models/common_message_info_relaxed.dart';
import 'package:ton_dart/src/models/models/currency_collection.dart';
import 'package:ton_dart/src/models/models/message.dart';
import 'package:ton_dart/src/models/models/message_relaxed.dart';
import 'package:ton_dart/src/models/models/send_mode.dart';
import 'package:ton_dart/src/contracts/wallet/core/versioned_wallet.dart';
import 'package:ton_dart/src/contracts/utils/transaction_utils.dart';

mixin VersionedWalletTransactionImpl on VersonedWalletContract {
  MessageRelaxed createMessageInfo({
    required TonAddress destination,
    required BigInt amount,
    String? memo,
    Cell? body,
    bool? bounce,
    bool bounced = false,
  }) {
    assert(memo == null || body == null,
        "You have to choose a memo or body for each message.");
    return MessageRelaxed(
      info: CommonMessageInfoRelaxedInternal(
          ihrDisabled: true,
          bounce: bounce ?? destination.isBounceable,
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

  Cell createTransfer(
      {required List<MessageRelaxed> messages,
      required int accountSeqno,
      SendMode sendMode = SendMode.payGasSeparately,
      int? subWalletId,
      int? timeout}) {
    final sId = subWalletId ?? this.subWalletId;
    if (type.hasSubwalletId && sId == null) {
      throw TonContractException(
          "cannot create transfer with watch only wallet.");
    }
    return TransactioUtils.serializeMessage(
        messages: messages,
        accountSeqno: accountSeqno,
        type: type,
        sendMode: sendMode,
        subwalletId: sId,
        timeOut: timeout);
  }

  Message createAndSignTransfer(
      {required List<MessageRelaxed> messages,
      required int accountSeqno,
      required TonPrivateKey privateKey,
      SendMode sendMode = SendMode.payGasSeparately,
      int? timeout,
      int? subWalletId}) {
    final sId = subWalletId ?? this.subWalletId;
    if (type.hasSubwalletId && sId == null) {
      throw TonContractException(
          "cannot create transfer with watch only wallet.");
    }
    final message = TransactioUtils.serializeMessage(
        messages: messages,
        accountSeqno: accountSeqno,
        type: type,
        sendMode: sendMode,
        subwalletId: sId,
        timeOut: timeout);
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
