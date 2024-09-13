import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/models/models/split_merge_info.dart';
import 'package:ton_dart/src/models/models/transaction.dart';
import 'package:ton_dart/src/models/models/transaction_bounce_phase.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/extentions.dart';
import 'transaction_action_phase.dart';
import 'transaction_compute_phase.dart';
import 'transaction_credit_phase.dart';
import 'transaction_storage_phase.dart';

class TransactionDescriptionType {
  final String name;
  const TransactionDescriptionType._(this.name);

  static const TransactionDescriptionType generic =
      TransactionDescriptionType._("generic");
  static const TransactionDescriptionType storage =
      TransactionDescriptionType._("storage");
  static const TransactionDescriptionType tickTock =
      TransactionDescriptionType._("tickTock");
  static const TransactionDescriptionType splitPrepare =
      TransactionDescriptionType._("splitPrepare");
  static const TransactionDescriptionType splitInstall =
      TransactionDescriptionType._("splitInstall");
  static const TransactionDescriptionType mergeInstall =
      TransactionDescriptionType._("mergeInstall");
  static const TransactionDescriptionType mergePrepare =
      TransactionDescriptionType._("mergePrepare");
  static const List<TransactionDescriptionType> values = [
    mergePrepare,
    mergeInstall,
    splitInstall,
    splitPrepare,
    tickTock,
    storage,
    generic
  ];
  factory TransactionDescriptionType.fromValue(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw TonDartPluginException(
          "Cannot find TransactionDescriptionType from provided name",
          details: {"name": name}),
    );
  }
  @override
  String toString() {
    return "TransactionDescriptionType.$name";
  }
}

///  Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L324
///  trans_ord$0000 credit_first:Bool
///   storage_ph:(Maybe TrStoragePhase)
///   credit_ph:(Maybe TrCreditPhase)
///   compute_ph:TrComputePhase action:(Maybe ^TrActionPhase)
///   aborted:Bool bounce:(Maybe TrBouncePhase)
///   destroyed:Bool
///   = TransactionDescr;

///  trans_storage$0001 storage_ph:TrStoragePhase
///  = TransactionDescr;

///  trans_tick_tock$001 is_tock:Bool storage_ph:TrStoragePhase
///  compute_ph:TrComputePhase action:(Maybe ^TrActionPhase)
///  aborted:Bool destroyed:Bool = TransactionDescr;

///  trans_split_prepare$0100 split_info:SplitMergeInfo
///  storage_ph:(Maybe TrStoragePhase)
///  compute_ph:TrComputePhase action:(Maybe ^TrActionPhase)
///  aborted:Bool destroyed:Bool
///  = TransactionDescr;

///  trans_split_install$0101 split_info:SplitMergeInfo
///  prepare_transaction:^Transaction
///  installed:Bool = TransactionDescr;
abstract class TransactionDescription extends TonSerialization {
  abstract final TransactionDescriptionType type;
  const TransactionDescription();
  factory TransactionDescription.deserialize(Slice slice) {
    final type = slice.loadUint(4);
    switch (type) {
      case 0x00:
        return TransactionDescriptionGeneric.deserialize(slice);
      case 0x01:
        return TransactionDescriptionStorage.deserialize(slice);
      case 0x2:
      case 0x03:
        return TransactionDescriptionTickTock.deserialize(slice, type);
      case 0x04:
        return TransactionDescriptionSplitPrepare.deserialize(slice);
      case 0x05:
        return TransactionDescriptionSplitInstall.deserialize(slice);
      default:
        throw const TonDartPluginException("Unsuported Transaction.");
    }
  }
  factory TransactionDescription.fromJson(Map<String, dynamic> json) {
    final type = TransactionDescriptionType.fromValue(json["type"]);
    switch (type) {
      case TransactionDescriptionType.generic:
        return TransactionDescriptionGeneric.fromJson(json);
      case TransactionDescriptionType.storage:
        return TransactionDescriptionStorage.fromJson(json);
      case TransactionDescriptionType.tickTock:
        return TransactionDescriptionTickTock.fromJson(json);
      case TransactionDescriptionType.splitPrepare:
        return TransactionDescriptionSplitPrepare.fromJson(json);
      case TransactionDescriptionType.splitInstall:
        return TransactionDescriptionSplitInstall.fromJson(json);
      default:
        throw const TonDartPluginException("Unsuported Transaction.");
    }
  }
}

class TransactionDescriptionGeneric extends TransactionDescription {
  final bool creditFirst;
  final TransactionStoragePhase? storagePhase;
  final TransactionCreditPhase? creditPhase;
  final TransactionComputePhase computePhase;
  final TransactionActionPhase? actionPhase;
  final TransactionBouncePhase? bouncePhase;
  final bool aborted;
  final bool destroyed;
  const TransactionDescriptionGeneric(
      {required this.creditFirst,
      required this.storagePhase,
      required this.creditPhase,
      required this.computePhase,
      required this.actionPhase,
      required this.bouncePhase,
      required this.aborted,
      required this.destroyed});
  factory TransactionDescriptionGeneric.deserialize(Slice slice) {
    final creditFirst = slice.loadBit();
    final TransactionStoragePhase? storagePhase = slice
        .loadBit()
        .onTrue(() => TransactionStoragePhase.deserialize(slice));
    final TransactionCreditPhase? creditPhase =
        slice.loadBit().onTrue(() => TransactionCreditPhase.deserialize(slice));
    final TransactionComputePhase computePhase =
        TransactionComputePhase.deserialize(slice);
    final TransactionActionPhase? actionPhase = slice.loadBit().onTrue(
        () => TransactionActionPhase.deserialize(slice.loadRef().beginParse()));
    final aborted = slice.loadBit();
    final TransactionBouncePhase? bouncePhase =
        slice.loadBit().onTrue(() => TransactionBouncePhase.deserialize(slice));
    final destroyed = slice.loadBit();
    return TransactionDescriptionGeneric(
        creditFirst: creditFirst,
        storagePhase: storagePhase,
        creditPhase: creditPhase,
        computePhase: computePhase,
        actionPhase: actionPhase,
        bouncePhase: bouncePhase,
        aborted: aborted,
        destroyed: destroyed);
  }
  factory TransactionDescriptionGeneric.fromJson(Map<String, dynamic> json) {
    return TransactionDescriptionGeneric(
        creditFirst: json["credit_first"],
        storagePhase: (json["storage_phase"] as Object?)
            ?.convertTo<TransactionStoragePhase, Map>(
                (result) => TransactionStoragePhase.fromJson(result.cast())),
        creditPhase: (json["credit_phase"] as Object?)
            ?.convertTo<TransactionCreditPhase, Map>(
                (result) => TransactionCreditPhase.fromJson(result.cast())),
        computePhase: TransactionComputePhase.fromJson(json["compute_phase"]),
        actionPhase: (json["action_phase"] as Object?)
            ?.convertTo<TransactionActionPhase, Map>(
                (result) => TransactionActionPhase.fromJson(result.cast())),
        bouncePhase: (json["bounce_phase"] as Object?)
            ?.convertTo<TransactionBouncePhase, Map>(
                (result) => TransactionBouncePhase.fromJson(result.cast())),
        aborted: json["aborted"],
        destroyed: json["destroyed"]);
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "credit_first": creditFirst,
      "storage_phase": storagePhase?.toJson(),
      "credit_phase": creditPhase?.toJson(),
      "compute_phase": computePhase.toJson(),
      "action_phase": actionPhase?.toJson(),
      "bounce_phase": bouncePhase?.toJson(),
      "aborted": aborted,
      "destroyed": destroyed,
      "type": type.name
    };
  }

  @override
  void store(Builder builder) {
    builder.storeUint(0x00, 4);
    builder.storeBitBolean(creditFirst);
    builder.storeBitBolean(storagePhase != null);
    storagePhase?.store(builder);
    builder.storeBitBolean(creditPhase != null);
    creditPhase?.store(builder);
    computePhase.store(builder);
    builder.storeBitBolean(actionPhase != null);
    if (actionPhase != null) {
      builder.storeRef(beginCell().store(actionPhase!).endCell());
    }
    builder.storeBitBolean(aborted);
    builder.storeBitBolean(bouncePhase != null);
    bouncePhase?.store(builder);
    builder.storeBitBolean(destroyed);
  }

  @override
  TransactionDescriptionType get type => TransactionDescriptionType.generic;
}

class TransactionDescriptionStorage extends TransactionDescription {
  final TransactionStoragePhase storagePhase;

  const TransactionDescriptionStorage({required this.storagePhase});
  factory TransactionDescriptionStorage.fromJson(Map<String, dynamic> json) {
    return TransactionDescriptionStorage(
      storagePhase: TransactionStoragePhase.fromJson(json["storage_phase"]),
    );
  }
  factory TransactionDescriptionStorage.deserialize(Slice slice) {
    return TransactionDescriptionStorage(
        storagePhase: TransactionStoragePhase.deserialize(slice));
  }
  @override
  Map<String, dynamic> toJson() {
    return {"storage_phase": storagePhase.toJson(), "type": type.name};
  }

  @override
  void store(Builder builder) {
    builder.storeUint(0x01, 4);
    storagePhase.store(builder);
  }

  @override
  TransactionDescriptionType get type => TransactionDescriptionType.storage;
}

class TransactionDescriptionTickTock extends TransactionDescription {
  final bool isTock;

  final TransactionStoragePhase storagePhase;
  final TransactionComputePhase computePhase;
  final TransactionActionPhase? actionPhase;
  final bool aborted;
  final bool destroyed;

  const TransactionDescriptionTickTock({
    required this.storagePhase,
    required this.isTock,
    required this.computePhase,
    required this.actionPhase,
    required this.aborted,
    required this.destroyed,
  });
  factory TransactionDescriptionTickTock.deserialize(Slice slice, int type) {
    final bool isTock = type == 0x03;
    final TransactionStoragePhase storagePhase =
        TransactionStoragePhase.deserialize(slice);
    final TransactionComputePhase computePhase =
        TransactionComputePhase.deserialize(slice);
    final TransactionActionPhase? actionPhase = slice.loadBit().onTrue(
        () => TransactionActionPhase.deserialize(slice.loadRef().beginParse()));
    final aborted = slice.loadBit();
    final destroyed = slice.loadBit();
    return TransactionDescriptionTickTock(
        storagePhase: storagePhase,
        isTock: isTock,
        computePhase: computePhase,
        actionPhase: actionPhase,
        aborted: aborted,
        destroyed: destroyed);
  }
  factory TransactionDescriptionTickTock.fromJson(Map<String, dynamic> json) {
    return TransactionDescriptionTickTock(
        storagePhase: TransactionStoragePhase.fromJson(json["storage_phase"]),
        computePhase: TransactionComputePhase.fromJson(json["compute_phase"]),
        actionPhase: (json["action_phase"] as Object?)
            ?.convertTo<TransactionActionPhase, Map>(
                (result) => TransactionActionPhase.fromJson(result.cast())),
        aborted: json["aborted"],
        destroyed: json["destroyed"],
        isTock: json["is_tock"]);
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "is_tock": isTock,
      "storage_phase": storagePhase.toJson(),
      "compute_phase": computePhase.toJson(),
      "action_phase": actionPhase?.toJson(),
      "aborted": aborted,
      "destroyed": destroyed,
      "type": type.name
    };
  }

  @override
  void store(Builder builder) {
    builder.storeUint(isTock ? 0x03 : 0x02, 4);
    storagePhase.store(builder);
    computePhase.store(builder);

    if (actionPhase != null) {
      builder.storeBitBolean(true);
      builder.storeRef(beginCell().store(actionPhase!).endCell());
    } else {
      builder.storeBitBolean(false);
    }
    builder.storeBitBolean(aborted);
    builder.storeBitBolean(destroyed);
  }

  @override
  TransactionDescriptionType get type => TransactionDescriptionType.tickTock;
}

class TransactionDescriptionSplitPrepare extends TransactionDescription {
  final SplitMergeInfo splitInfo;

  final TransactionStoragePhase? storagePhase;
  final TransactionComputePhase computePhase;
  final TransactionActionPhase? actionPhase;
  final bool aborted;
  final bool destroyed;

  const TransactionDescriptionSplitPrepare({
    required this.splitInfo,
    required this.storagePhase,
    required this.computePhase,
    required this.actionPhase,
    required this.aborted,
    required this.destroyed,
  });
  factory TransactionDescriptionSplitPrepare.deserialize(Slice slice) {
    final splitInfo = SplitMergeInfo.deserialize(slice);
    final TransactionStoragePhase? storagePhase = slice
        .loadBit()
        .onTrue(() => TransactionStoragePhase.deserialize(slice));
    final TransactionComputePhase computePhase =
        TransactionComputePhase.deserialize(slice);
    final TransactionActionPhase? actionPhase = slice.loadBit().onTrue(
        () => TransactionActionPhase.deserialize(slice.loadRef().beginParse()));

    final aborted = slice.loadBit();
    final destroyed = slice.loadBit();
    return TransactionDescriptionSplitPrepare(
        splitInfo: splitInfo,
        storagePhase: storagePhase,
        computePhase: computePhase,
        actionPhase: actionPhase,
        aborted: aborted,
        destroyed: destroyed);
  }
  factory TransactionDescriptionSplitPrepare.fromJson(
      Map<String, dynamic> json) {
    return TransactionDescriptionSplitPrepare(
        splitInfo: SplitMergeInfo.fromJson(json["split_info"]),
        storagePhase: (json["storage_phase"] as Object?)
            ?.convertTo<TransactionStoragePhase, Map>(
                (result) => TransactionStoragePhase.fromJson(result.cast())),
        computePhase: TransactionComputePhase.fromJson(json["compute_phase"]),
        actionPhase: (json["action_phase"] as Object?)
            ?.convertTo<TransactionActionPhase, Map>(
                (result) => TransactionActionPhase.fromJson(result.cast())),
        aborted: json["aborted"],
        destroyed: json["destroyed"]);
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "split_info": splitInfo.toJson(),
      "storage_phase": storagePhase?.toJson(),
      "compute_phase": computePhase.toJson(),
      "action_phase": actionPhase?.toJson(),
      "aborted": aborted,
      "destroyed": destroyed,
      "type": type.name
    };
  }

  @override
  void store(Builder builder) {
    builder.storeUint(0x04, 4);
    splitInfo.store(builder);
    builder.storeBitBolean(storagePhase != null);
    storagePhase?.store(builder);
    computePhase.store(builder);
    builder.storeBitBolean(actionPhase != null);
    actionPhase?.store(builder);
    builder.storeBitBolean(aborted);
    builder.storeBitBolean(destroyed);
  }

  @override
  TransactionDescriptionType get type =>
      TransactionDescriptionType.splitPrepare;
}

class TransactionDescriptionSplitInstall extends TransactionDescription {
  final SplitMergeInfo splitInfo;
  final TonTransaction prepareTransaction;
  final bool installed;

  const TransactionDescriptionSplitInstall({
    required this.splitInfo,
    required this.prepareTransaction,
    required this.installed,
  });
  factory TransactionDescriptionSplitInstall.deserialize(Slice slice) {
    final splitInfo = SplitMergeInfo.deserialize(slice);
    final prepareTransaction =
        TonTransaction.deserialize(slice.loadRef().beginParse());
    final installed = slice.loadBit();
    return TransactionDescriptionSplitInstall(
        splitInfo: splitInfo,
        prepareTransaction: prepareTransaction,
        installed: installed);
  }
  factory TransactionDescriptionSplitInstall.fromJson(
      Map<String, dynamic> json) {
    return TransactionDescriptionSplitInstall(
        splitInfo: SplitMergeInfo.fromJson(json["split_info"]),
        prepareTransaction:
            TonTransaction.fromJson(json["prepare_transaction"]),
        installed: json["installed"]);
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      "split_info": splitInfo.toJson(),
      "prepare_transaction": prepareTransaction.toJson(),
      "installed": installed,
      "type": type.name
    };
  }

  @override
  void store(Builder builder) {
    builder.storeUint(0x05, 4);
    splitInfo.store(builder);
    builder.storeRef(beginCell().store(prepareTransaction).endCell());
    builder.storeBitBolean(installed);
  }

  @override
  TransactionDescriptionType get type =>
      TransactionDescriptionType.splitInstall;
}
