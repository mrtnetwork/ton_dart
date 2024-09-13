import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'tuple.dart';

/// A class for building a list of tuple items.
class TupleBuilder {
  final List<TupleItem> _tuple = [];

  /// Checks if the provided value is null and adds a TupleItemNull if true.
  /// Returns true if the value is null.
  bool _isNull(Object? v) {
    if (v == null) {
      _tuple.add(const TupleItemNull());
    }
    return v == null;
  }

  /// Adds a BigInt value to the tuple list.
  /// If the value is null, it adds a TupleItemNull instead.
  void writeNumber(BigInt? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemInt(v!));
  }

  /// Adds a boolean value to the tuple list.
  /// If the value is null, it adds a TupleItemNull instead.
  /// Converts true to -1 and false to 0.
  void writeBoolean(bool? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemInt(v! ? -BigInt.one : BigInt.zero));
  }

  /// Adds a buffer (list of bytes) to the tuple list.
  /// If the value is null, it adds a TupleItemNull instead.
  /// Encodes the buffer into a cell and stores it as a TupleItemSlice.
  void writeBuffer(List<int>? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemSlice(beginCell().storeBuffer(v!).endCell()));
  }

  /// Adds a string value to the tuple list.
  /// If the value is null, it adds a TupleItemNull instead.
  /// Encodes the string into a cell and stores it as a TupleItemSlice.
  void writeString(String? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemSlice(beginCell().storeStringTail(v!).endCell()));
  }

  /// Adds a cell to the tuple list.
  /// If the value is null, it adds a TupleItemNull instead.
  void writeCell(Cell? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemCell(v!));
  }

  /// Adds a slice to the tuple list.
  /// If the value is null, it adds a TupleItemNull instead.
  void writeSlice(Cell? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemSlice(v!));
  }

  /// Adds a builder (cell) to the tuple list.
  /// If the value is null, it adds a TupleItemNull instead.
  void writeBuilder(Cell? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemBuilder(v!));
  }

  /// Adds a list of tuple items to the tuple list.
  /// If the value is null, it adds a TupleItemNull instead.
  void writeTuple(List<TupleItem>? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemTuple(v!));
  }

  /// Adds an address to the tuple list.
  /// If the value is null, it adds a TupleItemNull instead.
  /// Encodes the address into a cell and stores it as a TupleItemSlice.
  void writeAddress(TonBaseAddress? v) {
    if (_isNull(v)) return;
    _tuple.add(TupleItemSlice(beginCell().storeAddress(v!).endCell()));
  }

  /// Returns the final list of tuple items.
  /// Creates a new list from the internal _tuple list.
  List<TupleItem> build() {
    return List.from(_tuple);
  }
}
