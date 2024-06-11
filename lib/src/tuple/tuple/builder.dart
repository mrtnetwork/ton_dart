import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'tuple.dart';

class TupleBuilder {
  final List<TupleItem> _tuple = [];
  bool _isNull(Object? v) {
    if (v == null) {
      _tuple.add(const TupleItemNull());
    }
    return v == null;
  }

  void writeNumber(BigInt? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemInt(v!));
  }

  void writeBoolean(bool? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemInt(v! ? -BigInt.one : BigInt.zero));
  }

  void writeBuffer(List<int>? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemSlice(beginCell().storeBuffer(v!).endCell()));
  }

  void writeString(String? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemSlice(beginCell().storeStringTail(v!).endCell()));
  }

  void writeCell(Cell? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemCell(v!));
  }

  void writeSlice(Cell? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemSlice(v!));
  }

  void writeBuilder(Cell? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemBuilder(v!));
  }

  void writeTuple(List<TupleItem>? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemTuple(v!));
  }

  void writeAddress(TonBaseAddress? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemSlice(beginCell().storeAddress(v!).endCell()));
  }

  List<TupleItem> build() {
    return List.from(_tuple);
  }
}
