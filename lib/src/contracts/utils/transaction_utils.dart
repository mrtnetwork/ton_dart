import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/models/models.dart';

class TransactioUtils {
  static MessageRelaxed internal(
      {required TonAddress destination,
      required BigInt amount,
      Cell? body,
      StateInit? initState,
      String? memo,
      bool bounce = false,
      bool bounced = false}) {
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
      int sendMode = SendModeConst.payGasSeparately,
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
      transaction.storeUint(sendMode, 8);
      transaction.storeRef(beginCell().store(message).endCell());
    }
    return transaction.endCell();
  }

  static Cell createV2(
      {required List<MessageRelaxed> messages,
      required int accountSeqno,
      int sendMode = SendModeConst.payGasSeparately,
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
      transaction.storeUint(sendMode, 8);
      transaction.storeRef(beginCell().store(message).endCell());
    }
    return transaction.endCell();
  }

  static Cell createV1({
    required List<MessageRelaxed> messages,
    required int accountSeqno,
    int sendMode = SendModeConst.payGasSeparately,
  }) {
    final transaction = beginCell();
    transaction.storeUint(accountSeqno, 32);
    for (final message in messages) {
      transaction.storeUint(sendMode, 8);
      transaction.storeRef(beginCell().store(message).endCell());
    }
    return transaction.endCell();
  }

  static Cell createV5({
    required OutActionsV5 actions,
    required WalletV5AuthType type,
    int? accountSeqno,
    V5R1Context? context,
    int? timeout,
    BigInt? queryId,
  }) {
    if (type != WalletV5AuthType.extension) {
      if (accountSeqno == null || context == null) {
        throw const TonContractException(
            "accountSeqno and context required for build wallet message v5.");
      }
    }
    if (type == WalletV5AuthType.extension) {
      return beginCell()
          .storeUint32(type.tag)
          .storeUint64(queryId ?? 0)
          .store(actions)
          .endCell();
    }
    if (type == WalletV5AuthType.external) {
      List<OutActionWalletV5> fixedMode = [];
      for (final i in actions.actions) {
        if (i.type != OutActionType.sendMsg) {
          fixedMode.add(i);
          continue;
        }
        final sendMessage = (i as OutActionSendMsg)
            .copyWith(mode: i.mode | SendMode.ignoreErrors.mode);
        fixedMode.add(sendMessage);
      }
      actions = OutActionsV5(actions: fixedMode);
    }
    final signingMessage = beginCell().storeUint32(type.tag).store(context!);
    timeout ??= (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 60;
    if (accountSeqno == 0) {
      for (int i = 0; i < 32; i++) {
        signingMessage.storeBit(1);
      }
    } else {
      signingMessage.storeUint32(timeout);
    }
    signingMessage.storeUint(accountSeqno, 32).store(actions);
    return signingMessage.endCell();
  }

  static Cell serializeMessage(
      {required List<MessageRelaxed> messages,
      required int accountSeqno,
      required ContractState type,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeOut}) {
    type as VersionedWalletState;
    switch (type.version) {
      case WalletVersion.v4:
      case WalletVersion.v3R1:
      case WalletVersion.v3R2:
        final subwalletState = type as SubWalletVersionedWalletState;
        return createV4(
            subWalletId: subwalletState.subwallet,
            messages: messages,
            accountSeqno: accountSeqno,
            type: type.version,
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

class WalletV5AuthType {
  final String name;
  final int tag;
  const WalletV5AuthType._({required this.name, required this.tag});
  static const WalletV5AuthType extension =
      WalletV5AuthType._(name: "Extension", tag: 0x6578746e);
  static const WalletV5AuthType external =
      WalletV5AuthType._(name: "External", tag: 0x7369676e);
  static const WalletV5AuthType internal =
      WalletV5AuthType._(name: "Internal", tag: 0x73696e74);
}
