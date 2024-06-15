import 'package:blockchain_utils/utils/numbers/utils/int_utils.dart';
import 'package:ton_dart/src/tuple/tuple.dart';

class RunMethodResponse {
  final int? gasUsed;
  final int exitCode;
  final List<List<dynamic>> stack;
  RunMethodResponse(
      {required this.gasUsed, required this.stack, required this.exitCode});
  factory RunMethodResponse.fromJson(Map<String, dynamic> json) {
    return RunMethodResponse(
        gasUsed: IntUtils.tryParse(json["gas_used"]),
        stack: (json["stack"] as List).cast(),
        exitCode: json["exit_code"]);
  }
  List<TupleItem> get items => TupleUtils.parseStackItemAsList(stack);
}
