import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'storage_used_short.dart';

class TransactionBouncePhaseType {
  final String name;
  const TransactionBouncePhaseType._(this.name);

  static const TransactionBouncePhaseType negativeFounds =
      TransactionBouncePhaseType._('negativeFounds');
  static const TransactionBouncePhaseType noFounds =
      TransactionBouncePhaseType._('noFounds');
  static const TransactionBouncePhaseType ok =
      TransactionBouncePhaseType._('ok');
  static const List<TransactionBouncePhaseType> values = [
    negativeFounds,
    noFounds,
    ok
  ];
  factory TransactionBouncePhaseType.fromValue(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw TonDartPluginException(
          'Cannot find TransactionBouncePhaseType from provided name',
          details: {'name': name}),
    );
  }
  @override
  String toString() {
    return 'TransactionBouncePhaseType.$name';
  }
}

abstract class TransactionBouncePhase extends TonSerialization {
  const TransactionBouncePhase();
  abstract final TransactionBouncePhaseType type;
  factory TransactionBouncePhase.deserialize(Slice slice) {
    if (slice.loadBit()) {
      return TransactionBounceOk.deserialize(slice);
    }
    if (slice.loadBit()) {
      return TransactionBounceNoFunds.deserialize(slice);
    }
    return TransactionBounceNegativeFunds();
  }
  factory TransactionBouncePhase.fromJson(Map<String, dynamic> json) {
    final type = TransactionBouncePhaseType.fromValue(json['type']);
    switch (type) {
      case TransactionBouncePhaseType.ok:
        return TransactionBounceOk.fromJson(json);
      case TransactionBouncePhaseType.noFounds:
        return TransactionBounceNoFunds.fromJson(json);
      default:
        return TransactionBounceNegativeFunds();
    }
  }
}

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L318
/// tr_phase_bounce_negfunds$00 = TrBouncePhase;
/// tr_phase_bounce_nofunds$01 msg_size:StorageUsedShort req_fwd_fees:Grams = TrBouncePhase;
/// tr_phase_bounce_ok$1 msg_size:StorageUsedShort msg_fees:Grams fwd_fees:Grams = TrBouncePhase;
class TransactionBounceNegativeFunds extends TransactionBouncePhase {
  @override
  void store(Builder builder) {
    builder.storeBitBolean(false);
    builder.storeBitBolean(false);
  }

  @override
  TransactionBouncePhaseType get type =>
      TransactionBouncePhaseType.negativeFounds;

  @override
  Map<String, dynamic> toJson() {
    return {'type': type.name};
  }
}

class TransactionBounceOk extends TransactionBouncePhase {
  final StorageUsedShort messageSize;
  final BigInt messageFees;
  final BigInt forwardFees;

  const TransactionBounceOk(
      {required this.messageSize,
      required this.messageFees,
      required this.forwardFees});
  factory TransactionBounceOk.deserialize(Slice slice) {
    return TransactionBounceOk(
        messageSize: StorageUsedShort.deserialize(slice),
        messageFees: slice.loadCoins(),
        forwardFees: slice.loadCoins());
  }
  factory TransactionBounceOk.fromJson(Map<String, dynamic> json) {
    return TransactionBounceOk(
        messageSize: StorageUsedShort.fromJson(json['message_size']),
        messageFees: BigintUtils.parse(json['message_fee']),
        forwardFees: BigintUtils.parse(json['forward_fees']));
  }
  @override
  void store(Builder builder) {
    builder.storeBitBolean(true);
    messageSize.store(builder);
    builder.storeCoins(messageFees);
    builder.storeCoins(forwardFees);
  }

  @override
  TransactionBouncePhaseType get type => TransactionBouncePhaseType.ok;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'message_size': messageSize.toJson(),
      'message_fee': messageFees.toString(),
      'forward_fees': forwardFees.toString()
    };
  }
}

class TransactionBounceNoFunds extends TransactionBouncePhase {
  final StorageUsedShort messageSize;
  final BigInt requiredForwardFees;

  const TransactionBounceNoFunds(
      {required this.messageSize, required this.requiredForwardFees});
  factory TransactionBounceNoFunds.deserialize(Slice slice) {
    return TransactionBounceNoFunds(
        messageSize: StorageUsedShort.deserialize(slice),
        requiredForwardFees: slice.loadCoins());
  }
  factory TransactionBounceNoFunds.fromJson(Map<String, dynamic> json) {
    return TransactionBounceNoFunds(
        messageSize: StorageUsedShort.fromJson(json['message_size']),
        requiredForwardFees: BigintUtils.parse(json['required_forward_fees']));
  }
  @override
  void store(Builder builder) {
    builder.storeBitBolean(false);
    builder.storeBitBolean(true);
    messageSize.store(builder);
    builder.storeCoins(requiredForwardFees);
  }

  @override
  TransactionBouncePhaseType get type => TransactionBouncePhaseType.noFounds;

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.name,
      'message_size': messageSize.toJson(),
      'required_forward_fees': requiredForwardFees.toString()
    };
  }
}
