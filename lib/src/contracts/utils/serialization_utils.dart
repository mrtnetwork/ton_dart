import 'package:ton_dart/src/dict/dictionary.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/models/models.dart';

class TonSerializationUtils {
  static Dictionary<BigInt, V> arrayToDict<V>(
      {required List<V> obj,
      required DictionaryKey<BigInt> key,
      required DictionaryValue<V> value}) {
    final dict = Dictionary.empty<BigInt, V>(key: key, value: value);
    for (int i = 0; i < obj.length; i++) {
      dict[BigInt.from(i)] = obj[i];
    }
    return dict;
  }

  static Cell serializeV5({
    required OutActionsV5 actions,
    required WalletV5AuthType type,
    required int accountSeqno,
    required V5R1Context context,
    int? timeout,
  }) {
    if (type == WalletV5AuthType.extension) {
      throw const TonContractException(
          'Please use `createExtensionMessage` for create extension message body.');
    }
    if (type == WalletV5AuthType.external) {
      final List<OutActionWalletV5> fixedMode = [];
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
    final signingMessage = beginCell();
    signingMessage.storeUint32(type.tag);
    signingMessage.store(context);
    timeout ??= (DateTime.now().millisecondsSinceEpoch ~/ 1000) + 60;
    if (accountSeqno == 0) {
      for (int i = 0; i < 32; i++) {
        signingMessage.storeBit(1);
      }
    } else {
      signingMessage.storeUint32(timeout);
    }
    signingMessage.storeUint(accountSeqno, 32);
    signingMessage.store(actions);
    return signingMessage.endCell();
  }

  static Cell sseralizeV5({
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
            'accountSeqno and context required for build wallet message v5.');
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
      final List<OutActionWalletV5> fixedMode = [];
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

  static Cell serializeV2(
      {required List<OutActionSendMsg> messages,
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
      transaction.storeUint(message.mode, 8);
      transaction.storeRef(beginCell().store(message.outMessage).endCell());
    }
    return transaction.endCell();
  }

  static Cell serializeV4(
      {required int subWalletId,
      required List<OutActionSendMsg> messages,
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
      transaction.storeUint(message.mode, 8);
      transaction.storeRef(beginCell().store(message.outMessage).endCell());
    }
    return transaction.endCell();
  }

  static Cell serializeV1({
    required List<OutActionSendMsg> messages,
    required int accountSeqno,
  }) {
    final transaction = beginCell();
    transaction.storeUint(accountSeqno, 32);
    for (final message in messages) {
      transaction.storeUint(message.mode, 8);
      transaction.storeRef(beginCell().store(message.outMessage).endCell());
    }
    return transaction.endCell();
  }

  static Cell serializeMessage(
      {required List<OutActionSendMsg> actions,
      required VersionedWalletState state,
      required int seqno,
      int? timeOut}) {
    if (actions.length > state.version.maxMessageLength) {
      throw TonContractException(
          'Only ${state.version.maxMessageLength} message can transfer with wallet contract version ${state.version.name}');
    }
    switch (state.version) {
      case WalletVersion.v4:
      case WalletVersion.v3R1:
      case WalletVersion.v3R2:
        state as SubWalletVersionedWalletState;
        return TonSerializationUtils.serializeV4(
            subWalletId: state.subwallet,
            messages: actions,
            accountSeqno: seqno,
            type: state.version,
            timeout: timeOut,
        );
      case WalletVersion.v1R1:
      case WalletVersion.v1R2:
      case WalletVersion.v1R3:
        return TonSerializationUtils.serializeV1(
          messages: actions,
          accountSeqno: seqno,
        );
      case WalletVersion.v2R1:
      case WalletVersion.v2R2:
        return TonSerializationUtils.serializeV2(
          messages: actions,
          accountSeqno: seqno,
          timeout: timeOut,
        );
      default:
        throw UnimplementedError();
    }
  }
}
