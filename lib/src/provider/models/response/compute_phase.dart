import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'compute_skip_reason.dart';

class ComputePhaseResponse with JsonSerialization {
  final bool skipped;
  final ComputeSkipReasonResponse? skipReason;
  final bool? success;
  final BigInt? gasFees;
  final BigInt? gasUsed;
  final int? vmSteps;
  final int? exitCode;
  final String? exitCodeDescription;

  const ComputePhaseResponse({
    required this.skipped,
    this.skipReason,
    this.success,
    this.gasFees,
    this.gasUsed,
    this.vmSteps,
    this.exitCode,
    this.exitCodeDescription,
  });

  factory ComputePhaseResponse.fromJson(Map<String, dynamic> json) {
    return ComputePhaseResponse(
        skipped: json['skipped'],
        skipReason: json['skip_reason'] != null
            ? ComputeSkipReasonResponse.fromName(json['skip_reason'])
            : null,
        success: json['success'],
        gasFees: BigintUtils.tryParse(json['gas_fees']),
        gasUsed: BigintUtils.tryParse(json['gas_used']),
        vmSteps: json['vm_steps'],
        exitCode: json['exit_code'],
        exitCodeDescription: json['exit_code_description']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'skipped': skipped,
      'skip_reason': skipReason?.value,
      'success': success,
      'gas_fees': gasFees?.toString(),
      'gas_used': gasUsed?.toString(),
      'vm_steps': vmSteps,
      'exit_code': exitCode,
      'exit_code_description': exitCodeDescription,
    };
  }
}
