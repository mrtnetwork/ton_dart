import 'package:ton_dart/src/boc/cell/cell.dart';

class CellTopoloigicalSort {
  final Cell cell;
  final List<int> refs;
  CellTopoloigicalSort({required this.cell, required List<int> refs})
      : refs = List<int>.unmodifiable(refs);
}
