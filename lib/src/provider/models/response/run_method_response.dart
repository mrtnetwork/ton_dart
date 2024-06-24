import 'package:blockchain_utils/utils/numbers/utils/int_utils.dart';
import 'package:ton_dart/src/tuple/tuple.dart';

class TonCenterRunMethodResponse {
  final int? gasUsed;
  final int exitCode;
  final List<List<dynamic>> stack;
  TonCenterRunMethodResponse(
      {required this.gasUsed, required this.stack, required this.exitCode});
  factory TonCenterRunMethodResponse.fromJson(Map<String, dynamic> json) {
    return TonCenterRunMethodResponse(
        gasUsed: IntUtils.tryParse(json["gas_used"]),
        stack: (json["stack"] as List).cast(),
        exitCode: json["exit_code"]);
  }
  List<TupleItem> get items => TupleUtils.parseStackItemAsList(stack);
}
