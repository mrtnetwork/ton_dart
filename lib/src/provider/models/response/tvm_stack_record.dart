import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:blockchain_utils/utils/numbers/utils/bigint_utils.dart';
import 'package:blockchain_utils/utils/string/string.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/tuple/tuple.dart';

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
        tuple: List<TvmStackRecordResponse>.from((json['tuple'] as List?)
                ?.map((x) => TvmStackRecordResponse.fromJson(x)) ??
            []));
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

  TupleItem toTuple() {
    switch (type) {
      case TvmStackRecordTypeResponse.cell:
        final toCell = StringUtils.isHexBytes(cell!)
            ? Cell.fromBytes(BytesUtils.fromHexString(cell!))
            : Cell.fromBase64(cell!);
        return TupleItemCell(toCell);
      case TvmStackRecordTypeResponse.nan:
        return const TupleItemNaN();
      case TvmStackRecordTypeResponse.nullType:
        return const TupleItemNull();
      case TvmStackRecordTypeResponse.tuple:
        return TupleItemTuple(tuple.map((e) => e.toTuple()).toList());
      default:
        return TupleItemInt(BigintUtils.parse(num));
    }
  }
}
