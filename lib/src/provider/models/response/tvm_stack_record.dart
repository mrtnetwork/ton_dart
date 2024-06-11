import 'package:ton_dart/src/serialization/serialization.dart';
import 'tvm_stack_record_type.dart';

class TvmStackRecordResponse with JsonSerialization {
  final TvmStackRecordTypeResponse type;
  final String? cell;
  final String? slice;
  final String? num;
  final List<TvmStackRecordResponse> tuple;

  const TvmStackRecordResponse(
      {required this.type,
      this.cell,
      this.slice,
      this.num,
      required this.tuple});

  factory TvmStackRecordResponse.fromJson(Map<String, dynamic> json) {
    return TvmStackRecordResponse(
        type: TvmStackRecordTypeResponse.fromName(json['type']),
        cell: json['cell'],
        slice: json['slice'],
        num: json['num'],
        tuple: List<TvmStackRecordResponse>.from((json['tuple'] as List)
            .map((x) => TvmStackRecordResponse.fromJson(x))));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.value,
      'cell': cell,
      'slice': slice,
      'num': num,
      'tuple': tuple.map((x) => x.toJson()).toList(),
    };
  }
}
