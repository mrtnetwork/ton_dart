import 'package:ton_dart/src/serialization/serialization.dart';

/// Unified transaction status across providers.
enum TonTxStatus {
  /// The transaction reached the chain.
  included,

  /// The transaction (or one of its actions) failed.
  failed,

  /// No information (e.g. trace without matching actions).
  unknown,
}

/// One emulated message (root or nested) with the fees it consumed.
class TonEmulatedMessageInfo with JsonSerialization {
  final String? destination;
  final BigInt actionPhase;
  final BigInt gasFee;
  final BigInt storageFee;
  final bool success;
  final String? resultDescription;
  final List<TonEmulatedMessageInfo> internalMessages;

  const TonEmulatedMessageInfo({
    this.destination,
    required this.actionPhase,
    required this.gasFee,
    required this.storageFee,
    required this.success,
    this.resultDescription,
    this.internalMessages = const [],
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'destination': destination,
      'action_phase': actionPhase.toString(),
      'gas_fee': gasFee.toString(),
      'storage_fee': storageFee.toString(),
      'success': success,
      'result_description': resultDescription,
      'internal_messages': internalMessages.map((e) => e.toJson()).toList(),
    };
  }
}

/// Unified fee estimation result across providers.
class TonFeeEstimation with JsonSerialization {
  final BigInt actionPhase;
  final BigInt storageFee;
  final BigInt gasFee;
  final bool success;
  final String? resultDescription;

  /// Nested emulated messages (tonApi only; empty for tonCenter).
  final List<TonEmulatedMessageInfo> internalMessages;

  const TonFeeEstimation({
    required this.actionPhase,
    required this.storageFee,
    required this.gasFee,
    required this.success,
    this.resultDescription,
    this.internalMessages = const [],
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'action_phase': actionPhase.toString(),
      'storage_fee': storageFee.toString(),
      'gas_fee': gasFee.toString(),
      'success': success,
      'result_description': resultDescription,
      'internal_messages': internalMessages.map((e) => e.toJson()).toList(),
    };
  }
}

/// Unified jetton balance entry across providers.
class TonJettonBalance with JsonSerialization {
  /// Jetton master address.
  final String minter;

  /// Owner address (when known).
  final String? owner;

  /// Jetton wallet address.
  final String wallet;
  final BigInt balance;
  final String? name;
  final String? symbol;
  final int? decimals;
  final String? image;

  const TonJettonBalance({
    required this.minter,
    this.owner,
    required this.wallet,
    required this.balance,
    this.name,
    this.symbol,
    this.decimals,
    this.image,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'minter': minter,
      'owner': owner,
      'wallet': wallet,
      'balance': balance.toString(),
      'name': name,
      'symbol': symbol,
      'decimals': decimals,
      'image': image,
    };
  }
}
