import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'acc_status_change.dart';

class StoragePhaseResponse with JsonSerialization {
  final BigInt feesCollected;
  final BigInt? feesDue;
  final AccStatusChangeResponse statusChange;

  const StoragePhaseResponse({
    required this.feesCollected,
    this.feesDue,
    required this.statusChange,
  });

  factory StoragePhaseResponse.fromJson(Map<String, dynamic> json) {
    return StoragePhaseResponse(
      feesCollected: BigintUtils.parse(json['fees_collected']),
      feesDue: BigintUtils.tryParse(json['fees_due']),
      statusChange: AccStatusChangeResponse.fromName(json['status_change']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'fees_collected': feesCollected.toString(),
      'fees_due': feesDue?.toString(),
      'status_change': statusChange.value,
    };
  }
}
