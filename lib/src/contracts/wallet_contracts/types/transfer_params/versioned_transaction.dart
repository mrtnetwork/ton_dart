import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/utils/utils.dart';

abstract class VersionedWalletTransaction {}

class VersionedWalletTransactionV1 implements VersionedWalletTransaction {
  final int accountSeqno;
  final List<OutActionSendMsg> outActions;
  VersionedWalletTransactionV1(
      {required this.accountSeqno, required List<OutActionSendMsg> outActions})
      : outActions = outActions.immutable;
  factory VersionedWalletTransactionV1.deserialize(Slice slice) {
    final int accountSeqno = slice.loadUint32();
    final List<OutActionSendMsg> outActions = [];
    while (slice.tryPreLoadUint8() != null) {
      final outAction = OutActionSendMsg(
          mode: slice.loadUint8(),
          outMessage: MessageRelaxed.deserialize(slice.loadRef().beginParse()));
      outActions.add(outAction);
    }
    return VersionedWalletTransactionV1(
        accountSeqno: accountSeqno, outActions: outActions);
  }
}

class VersionedWalletTransactionV2 implements VersionedWalletTransaction {
  final int accountSeqno;
  final int timeout;
  final List<OutActionSendMsg> outActions;
  VersionedWalletTransactionV2({
    required this.accountSeqno,
    required this.timeout,
    required List<OutActionSendMsg> outActions,
  }) : outActions = outActions.immutable;
  factory VersionedWalletTransactionV2.deserialize(Slice slice) {
    final int accountSeqno = slice.loadUint32();
    final int timeout = slice.loadUint32();
    final List<OutActionSendMsg> outActions = [];
    while (slice.tryPreLoadUint8() != null) {
      final outAction = OutActionSendMsg(
          mode: slice.loadUint8(),
          outMessage: MessageRelaxed.deserialize(slice.loadRef().beginParse()));
      outActions.add(outAction);
    }
    return VersionedWalletTransactionV2(
        accountSeqno: accountSeqno, timeout: timeout, outActions: outActions);
  }
}

class VersionedWalletTransactionV3 implements VersionedWalletTransaction {
  final int subWalletId;
  final int accountSeqno;
  final int timeout;
  final List<OutActionSendMsg> outActions;
  VersionedWalletTransactionV3({
    required this.accountSeqno,
    required this.timeout,
    required this.subWalletId,
    required List<OutActionSendMsg> outActions,
  }) : outActions = outActions.immutable;
  factory VersionedWalletTransactionV3.deserialize(Slice slice) {
    final int subwalletId = slice.loadUint32();
    final int timeout = slice.loadUint32();
    final int accountSeqno = slice.loadUint32();
    final List<OutActionSendMsg> outActions = [];
    while (slice.tryPreLoadUint8() != null) {
      final outAction = OutActionSendMsg(
          mode: slice.loadUint8(),
          outMessage: MessageRelaxed.deserialize(slice.loadRef().beginParse()));
      outActions.add(outAction);
    }
    return VersionedWalletTransactionV3(
        accountSeqno: accountSeqno,
        timeout: timeout,
        outActions: outActions,
        subWalletId: subwalletId);
  }
}

class VersionedWalletTransactionV4 implements VersionedWalletTransaction {
  final int subWalletId;
  final int accountSeqno;
  final int timeout;
  final List<OutActionSendMsg> outActions;
  VersionedWalletTransactionV4({
    required this.accountSeqno,
    required this.timeout,
    required this.subWalletId,
    required List<OutActionSendMsg> outActions,
  }) : outActions = outActions.immutable;
  factory VersionedWalletTransactionV4.deserialize(Slice slice) {
    final int subwalletId = slice.loadUint32();
    final int timeout = slice.loadUint32();
    final int accountSeqno = slice.loadUint32();
    slice.skip(8);
    final List<OutActionSendMsg> outActions = [];
    while (slice.tryPreLoadUint8() != null) {
      final outAction = OutActionSendMsg(
          mode: slice.loadUint8(),
          outMessage: MessageRelaxed.deserialize(slice.loadRef().beginParse()));
      outActions.add(outAction);
    }
    return VersionedWalletTransactionV4(
        accountSeqno: accountSeqno,
        timeout: timeout,
        outActions: outActions,
        subWalletId: subwalletId);
  }
}

abstract class VersionedWalletTransactionV5
    implements VersionedWalletTransaction {
  abstract final WalletV5AuthType type;
}

class VersionedWalletTransactionV5Extension
    implements VersionedWalletTransactionV5 {
  final BigInt queryId;
  final List<OutActionWalletV5> outActions;
  VersionedWalletTransactionV5Extension(
      {required this.queryId, required List<OutActionWalletV5> outActions})
      : outActions = outActions.immutable;
  factory VersionedWalletTransactionV5Extension.deserialize(Slice slice) {
    final tag = slice.loadUint32();
    if (tag != WalletV5AuthType.external.tag) {
      throw const TonContractException(
          'Incorrect Wallet Version V5 Extension body');
    }
    final queryId = slice.loadUint64();
    final outActions = OutActionsV5.deserialize(slice);
    return VersionedWalletTransactionV5Extension(
        queryId: queryId, outActions: outActions.actions);
  }

  @override
  WalletV5AuthType get type => WalletV5AuthType.extension;
}

class VersionedWalletTransactionV5Internal
    implements VersionedWalletTransactionV5 {
  final int timeout;
  final int accountSeqno;
  final List<OutActionWalletV5> outActions;
  final V5R1Context context;
  VersionedWalletTransactionV5Internal(
      {required this.timeout,
      required this.accountSeqno,
      required List<OutActionWalletV5> outActions,
      required this.context})
      : outActions = outActions.immutable;
  factory VersionedWalletTransactionV5Internal.deserialize(
      {required Slice slice, required TonChain chain}) {
    final tag = slice.loadUint32();
    if (tag != WalletV5AuthType.internal.tag) {
      throw const TonContractException(
          'Incorrect Wallet Version V5 Internal body');
    }
    final context = VersionedWalletUtils.loadV5Context(
        contextBytes: slice.loadBuffer(4), chain: chain);
    final int timeOut = slice.loadUint32();
    final int accountSeqno = slice.loadUint32();
    final outActions = OutActionsV5.deserialize(slice);
    return VersionedWalletTransactionV5Internal(
        timeout: timeOut,
        accountSeqno: accountSeqno,
        outActions: outActions.actions,
        context: context);
  }

  @override
  WalletV5AuthType get type => WalletV5AuthType.internal;
}

class VersionedWalletTransactionV5External
    implements VersionedWalletTransactionV5 {
  final int timeout;
  final int accountSeqno;
  final List<OutActionWalletV5> outActions;
  final V5R1Context context;
  VersionedWalletTransactionV5External(
      {required this.timeout,
      required this.accountSeqno,
      required List<OutActionWalletV5> outActions,
      required this.context})
      : outActions = outActions.immutable;
  factory VersionedWalletTransactionV5External.deserialize(
      {required Slice slice, required TonChain chain}) {
    final tag = slice.loadUint32();
    if (tag != WalletV5AuthType.external.tag) {
      throw const TonContractException(
          'Incorrect Wallet Version V5 External body');
    }
    final context = VersionedWalletUtils.loadV5Context(
        contextBytes: slice.loadBuffer(4), chain: chain);
    final int timeOut = slice.loadUint32();
    final int accountSeqno = slice.loadUint32();
    final outActions = OutActionsV5.deserialize(slice);
    return VersionedWalletTransactionV5External(
        timeout: timeOut,
        accountSeqno: accountSeqno,
        outActions: outActions.actions,
        context: context);
  }

  @override
  WalletV5AuthType get type => WalletV5AuthType.internal;
}
