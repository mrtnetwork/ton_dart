import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/contracts/utils/parser.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/extensions.dart';

class VersionedWalletV5OperaionType extends ContractOperationType {
  const VersionedWalletV5OperaionType._(
      {required String name, required int operation})
      : super(name: name, operation: operation);
  static const VersionedWalletV5OperaionType internal =
      VersionedWalletV5OperaionType._(name: "Internal", operation: 0x73696e74);
  static const VersionedWalletV5OperaionType extension =
      VersionedWalletV5OperaionType._(name: "Extension", operation: 0x6578746e);

  static const List<VersionedWalletV5OperaionType> values = [
    internal,
    extension
  ];
  factory VersionedWalletV5OperaionType.fromOperation(int? operation) {
    return values.firstWhere((e) => e.operation == operation,
        orElse: () =>
            throw TonContractExceptionConst.invalidOperationId(tag: operation));
  }
}

abstract class VersionedWalletV5Operaion extends TonSerialization
    implements ContractOperation {
  @override
  Cell contractCode(TonChain chain) {
    return WalletVersion.v5R1.getCode();
  }

  Cell toBody() => beginCell().store(this).endCell();
  @override
  final VersionedWalletV5OperaionType type;
  const VersionedWalletV5Operaion({required this.type});
  @override
  String get contractName => "Wallet V5R1";
  factory VersionedWalletV5Operaion.deserialize(
      {required Slice slice, required TonChain chain}) {
    final type =
        VersionedWalletV5OperaionType.fromOperation(slice.tryPreloadUint32());
    switch (type) {
      case VersionedWalletV5OperaionType.extension:
        return VersionedWalletV5Extension.deserialize(slice);
      default:
        return VersionedWalletV5Internal.deserialize(
            slice: slice, chain: chain);
    }
  }
}

class VersionedWalletV5Extension extends VersionedWalletV5Operaion {
  final List<OutActionWalletV5> actions;
  final BigInt queryId;

  VersionedWalletV5Extension(
      {required List<OutActionWalletV5> actions, BigInt? queryId})
      : actions = actions.immutable,
        queryId = queryId ?? BigInt.zero,
        super(type: VersionedWalletV5OperaionType.extension);
  factory VersionedWalletV5Extension.deserialize(Slice slice) {
    slice.loadUint32();
    return VersionedWalletV5Extension(
      queryId: slice.loadUint64(),
      actions: OutActionsV5.deserialize(slice).actions,
    );
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.store(OutActionsV5(actions: actions));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "queryId": queryId.toString(),
      "actions": actions.map((e) => e.toJson()).toList()
    };
  }
}

class VersionedWalletV5InternalMessage extends TonSerialization {
  final int accountSeqno;
  final V5R1Context walletId;
  final List<OutActionWalletV5> actions;
  final int timeout;
  VersionedWalletV5InternalMessage(
      {required this.accountSeqno,
      required this.walletId,
      required List<OutActionWalletV5> actions,
      required this.timeout})
      : actions = actions.immutable;
  factory VersionedWalletV5InternalMessage.deserialize(
      {required Slice slice, required TonChain chain}) {
    return TonModelParser.parseBoc(
        parse: () {
          slice.loadUint32();
          return VersionedWalletV5InternalMessage(
            walletId: VersionedWalletUtils.loadV5Context(
                contextBytes: slice.loadBuffer(4), chain: chain),
            timeout: slice.loadUint32(),
            accountSeqno: slice.loadUint32(),
            actions: OutActionsV5.deserialize(slice).actions,
          );
        },
        name: "Wallet V5R1");
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(VersionedWalletV5OperaionType.internal);
    builder.store(walletId);
    if (accountSeqno == 0) {
      for (int i = 0; i < 32; i++) {
        builder.storeBit(1);
      }
    } else {
      builder.storeUint32(timeout);
    }
    builder.storeUint(accountSeqno, 32);
    builder.store(OutActionsV5(actions: actions));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "accountSeqno": accountSeqno,
      "walletId": walletId.toJson(),
      "actions": actions.map((e) => e.toJson()).toList(),
      "timeout": timeout
    };
  }
}

class VersionedWalletV5Internal extends VersionedWalletV5Operaion {
  final VersionedWalletV5InternalMessage message;
  final List<int> signature;
  VersionedWalletV5Internal(
      {required this.message, required List<int> signature})
      : signature = BytesUtils.toBytes(signature, unmodifiable: true),
        super(type: VersionedWalletV5OperaionType.internal);
  factory VersionedWalletV5Internal.deserialize(
      {required Slice slice, required TonChain chain}) {
    return TonModelParser.parseBoc(
        parse: () {
          return VersionedWalletV5Internal(
            message: VersionedWalletV5InternalMessage.deserialize(
                slice: slice, chain: chain),
            signature: slice.loadBuffer(64),
          );
        },
        name: "Wallet V5R1");
  }

  @override
  void store(Builder builder) {
    builder.store(message);
    builder.storeBuffer(signature);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "message": message.toJson(),
      "signature": BytesUtils.toHexString(signature)
    };
  }
}
