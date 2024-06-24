import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/ton_dart.dart';
import 'transaction.dart';

class TraceResponse with JsonSerialization {
  final TransactionResponse transaction;
  final List<String> interfaces;
  final List<TraceResponse> children;
  final bool? emulated;

  const TraceResponse(
      {required this.transaction,
      required this.interfaces,
      required this.children,
      this.emulated});

  factory TraceResponse.fromJson(Map<String, dynamic> json) {
    return TraceResponse(
      transaction: TransactionResponse.fromJson(json['transaction']),
      interfaces: List<String>.from(json['interfaces']),
      children: List<TraceResponse>.from(
          (json['children'] as List?)?.map((x) => TraceResponse.fromJson(x)) ??
              []),
      emulated: json['emulated'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'transaction': transaction.toJson(),
      'interfaces': interfaces,
      'children': children.map((x) => x.toJson()).toList(),
      'emulated': emulated,
    };
  }

  BigInt get internalStorageFeees {
    return children.fold(
        BigInt.zero,
        (previousValue, element) =>
            element.transaction.storagePhase?.feesCollected ?? BigInt.zero);
  }

  BigInt get internalGasFees {
    return children.fold(
        BigInt.zero,
        (previousValue, element) =>
            element.transaction.computePhase?.gasFees ?? BigInt.zero);
  }

  BigInt get internalActionFees {
    return children.fold(
        BigInt.zero,
        (previousValue, element) =>
            element.transaction.actionPhase?.fwdFees ?? BigInt.zero);
  }

  BigInt get internalMessageFees {
    return internalActionFees + internalGasFees + internalStorageFeees;
  }

  BigInt get externalFees {
    final BigInt storageFee =
        transaction.storagePhase?.feesCollected ?? BigInt.zero;

    /// gas_fee
    final BigInt computeGasFee =
        transaction.computePhase?.gasFees ?? BigInt.zero;

    /// fwd_fee
    final BigInt actionPhase = transaction.actionPhase?.fwdFees ?? BigInt.zero;

    return storageFee + computeGasFee + actionPhase;
  }

  BigInt get totalInternalFees {
    if (children.isEmpty) return BigInt.zero;
    final fee = internalMessageFees;
    return children.fold(fee,
        (previousValue, element) => previousValue + element.totalInternalFees);
  }

  BigInt get totalFee {
    return totalInternalFees + externalFees;
  }
}
