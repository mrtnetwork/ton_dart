import 'package:ton_dart/src/tuple/tuple/tuple.dart';
import 'package:ton_dart/src/tuple/tuple/tuple_reader.dart';
import 'package:ton_dart/src/utils/extentions.dart';

class RunMethodResponse {
  final List<TupleItem> items;
  final int exitCode;
  RunMethodResponse({required List<TupleItem> items, required this.exitCode})
      : items = items.mutabl;

  TupleReader reader() => TupleReader(items);
}
