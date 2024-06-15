import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

class ActionPhaseResponse with JsonSerialization {
  final bool success;
  final int resultCode;
  final int totalActions;
  final int skippedActions;
  final BigInt fwdFees;
  final BigInt totalFees;
  final String? resultCodeDescription;

  const ActionPhaseResponse({
    required this.success,
    required this.resultCode,
    required this.totalActions,
    required this.skippedActions,
    required this.fwdFees,
    required this.totalFees,
    this.resultCodeDescription,
  });

  factory ActionPhaseResponse.fromJson(Map<String, dynamic> json) {
    return ActionPhaseResponse(
      success: json['success'],
      resultCode: json['result_code'],
      totalActions: json['total_actions'],
      skippedActions: json['skipped_actions'],
      fwdFees: BigintUtils.parse(json['fwd_fees']),
      totalFees: BigintUtils.parse(json['total_fees']),
      resultCodeDescription: json['result_code_description'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result_code': resultCode,
      'total_actions': totalActions,
      'skipped_actions': skippedActions,
      'fwd_fees': fwdFees.toString(),
      'total_fees': totalFees.toString(),
      'result_code_description': resultCodeDescription,
    };
  }
}
