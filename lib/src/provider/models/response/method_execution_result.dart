import 'package:ton_dart/src/serialization/serialization.dart';
import 'tvm_stack_record.dart';

class MethodExecutionResultResponse with JsonSerialization {
  final bool success;
  final int exitCode;
  final List<TvmStackRecordResponse> stack;
  final String decoded;

  const MethodExecutionResultResponse({
    required this.success,
    required this.exitCode,
    required this.stack,
    required this.decoded,
  });

  factory MethodExecutionResultResponse.fromJson(Map<String, dynamic> json) {
    return MethodExecutionResultResponse(
        success: json['success'],
        exitCode: json['exit_code'],
        stack: List<TvmStackRecordResponse>.from((json['stack'] as List)
            .map((x) => TvmStackRecordResponse.fromJson(x))),
        decoded: json['decoded']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'exit_code': exitCode,
      'stack': stack.map((x) => x.toJson()).toList(),
      'decoded': decoded,
    };
  }
}
