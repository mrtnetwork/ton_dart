import 'package:ton_dart/src/tuple/tuple/tuple.dart';
import 'package:ton_dart/src/tuple/tuple/tuple_reader.dart';
import 'package:ton_dart/src/utils/utils/extentions.dart';

class RunMethodResponse {
  final List<TupleItem> items;
  final int exitCode;
  RunMethodResponse({required List<TupleItem> items, required this.exitCode})
      : items = items.immutable;

  TupleReader reader() => TupleReader(items);
}
