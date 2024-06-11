import 'package:blockchain_utils/numbers/int_utils.dart';
import 'package:ton_dart/src/tuple/tuple.dart';
import 'package:ton_dart/src/tuple/tuple/tuple_reader.dart';

class RunMethodResponse {
  final int gasUsed;
  final List<List<dynamic>> stack;
  RunMethodResponse({required this.gasUsed, required this.stack});
  factory RunMethodResponse.fromJson(Map<String, dynamic> json) {
    return RunMethodResponse(
        gasUsed: IntUtils.parse(json["gas_used"]),
        stack: (json["stack"] as List).cast());
  }

  TupleReader get reader => TupleReader(TupleUtils.parseStackItemAsList(stack));
}
