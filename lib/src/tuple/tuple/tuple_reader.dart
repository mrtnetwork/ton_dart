import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/tuple/exception/exception.dart';
import 'tuple.dart';

/// A class for reading and manipulating tuple items from a list.
class TupleReader {
  final List<TupleItem> _items;

  /// Constructor that initializes the reader with a list of tuple items.
  TupleReader(List<TupleItem> items) : _items = List<TupleItem>.from(items);

  /// Creates a clone of the current TupleReader.
  TupleReader clone() => TupleReader(_items);

  /// Returns the number of remaining tuple items.
  int get remaining {
    return _items.length;
  }

  /// Peeks at the next tuple item without removing it from the list.
  /// Throws a TupleException if there are no more items.
  TupleItem peek() {
    if (_items.isEmpty) {
      throw TupleException('EOF');
    }
    return _items[0];
  }

  /// Removes and returns the next tuple item from the list.
  /// Throws a TupleException if there are no more items.
  TupleItem pop() {
    if (_items.isEmpty) {
      throw TupleException('EOF');
    }
    final TupleItem res = _items[0];
    _items.removeAt(0);
    return res;
  }

  /// Skips the specified number of tuple items.
  /// Returns the updated TupleReader.
  TupleReader skip({int num = 1}) {
    for (int i = 0; i < num; i++) {
      pop();
    }
    return this;
  }

  /// Reads a BigInt from the next tuple item.
  /// Throws a TupleException if the item is not an integer.
  BigInt readBigNumber() {
    final TupleItem popped = pop();
    if (popped is! TupleItemInt) {
      throw TupleException('Invalid integer tuple item.',
          details: {'value': popped});
    }
    return popped.value;
  }

  /// Reads a BigInt from the next tuple item and returns it as a hexadecimal string.
  String readBigNumberAsHex() {
    final BigInt value = readBigNumber();
    final List<int> toBytes =
        BigintUtils.toBytes(value, length: BigintUtils.bitlengthInBytes(value));
    return BytesUtils.toHexString(toBytes);
  }

  /// Reads an optional BigInt from the next tuple item.
  /// Returns null if the item is null, otherwise throws an exception if the item is not an integer.
  BigInt? readBigNumberOpt() {
    final TupleItem popped = pop();
    if (popped is TupleItemNull) {
      return null;
    }
    if (popped is! TupleItemInt) {
      throw TupleException('Invalid integer tuple item.',
          details: {'value': popped});
    }
    return popped.value;
  }

  /// Reads an integer from the next tuple item.
  /// Converts the BigInt to an integer.
  int readNumber() {
    return readBigNumber().toInt();
  }

  /// Reads an optional integer from the next tuple item.
  /// Converts the BigInt to an integer if present.
  int? readNumberOpt() {
    final BigInt? r = readBigNumberOpt();
    return r?.toInt();
  }

  /// Reads a boolean value from the next tuple item.
  /// Interprets zero as false and non-zero as true.
  bool readBoolean() {
    final int res = readNumber();
    return res == 0 ? false : true;
  }

  /// Reads an optional boolean value from the next tuple item.
  /// Interprets zero as false, non-zero as true, and returns null if the item is null.
  bool? readBooleanOpt() {
    final int? res = readNumberOpt();
    return res != null ? (res == 0 ? false : true) : null;
  }

  /// Reads an address from the next tuple item, which is expected to be a cell.
  TonAddress readAddress() {
    return readCell().beginParse().loadAddress();
  }

  /// Reads an optional address from the next tuple item.
  /// Returns null if the item is null, otherwise parses the cell to load an address.
  TonAddress? readAddressOpt() {
    final Cell? r = readCellOpt();
    if (r != null) {
      return r.beginParse().loadMaybeAddress();
    } else {
      return null;
    }
  }

  /// Reads a cell from the next tuple item.
  /// Throws a TupleException if the item is not a cell.
  Cell readCell() {
    final TupleItem popped = pop();
    if (popped is TupleItemCell) return popped.cell;
    throw TupleException('Invalid tuple cell.', details: {'value': popped});
  }

  /// Reads an optional cell from the next tuple item.
  /// Returns null if the item is null, otherwise throws an exception if the item is not a cell.
  Cell? readCellOpt() {
    final TupleItem popped = pop();
    if (popped is TupleItemNull) {
      return null;
    }
    if (popped is TupleItemCell) return popped.cell;
    throw TupleException('Invalid tuple cell.', details: {'value': popped});
  }

  /// Reads a tuple from the next tuple item and returns a new TupleReader for the tuple.
  /// Throws a TupleException if the item is not a tuple.
  TupleReader readTuple() {
    final TupleItem popped = pop();
    if (popped is! TupleItemTuple) {
      throw TupleException('Invalid tuple type.', details: {'value': popped});
    }
    return TupleReader(popped.items);
  }

  /// Reads an optional tuple from the next tuple item.
  /// Returns null if the item is null, otherwise returns a new TupleReader for the tuple.
  TupleReader? readTupleOpt() {
    final TupleItem popped = pop();
    if (popped is TupleItemNull) {
      return null;
    }
    if (popped is! TupleItemTuple) {
      throw TupleException('Invalid tuple type.', details: {'value': popped});
    }
    return TupleReader(popped.items);
  }

  /// Reads a Lisp-style list from the given TupleReader.
  /// Each item in the list must be a tuple or null, and the list ends with null.
  static List<TupleItem> readLispListStatics(TupleReader? reader) {
    final List<TupleItem> result = [];
    TupleReader? tail = reader;
    while (tail != null) {
      final TupleItem head = tail.pop();
      if (tail._items.isEmpty ||
          (tail._items[0] is! TupleItemTuple &&
              tail._items[0] is! TupleItemNull)) {
        throw TupleException(
            'Lisp list consists only from (any, tuple) elements and ends with null');
      }
      tail = tail.readTupleOpt();
      result.add(head);
    }
    return result;
  }

  /// Reads a Lisp-style list directly from the current TupleReader.
  /// Returns an empty list if there is only a null item.
  List<TupleItem> readLispListDirect() {
    if (_items.length == 1 && _items[0] is TupleItemNull) {
      return [];
    }
    return TupleReader.readLispListStatics(this);
  }

  /// Reads a Lisp-style list from the next tuple item.
  /// Uses the static method to handle the list reading.
  List<TupleItem> readLispList() {
    return TupleReader.readLispListStatics(readTupleOpt());
  }

  /// Reads a buffer of bytes from the next cell item.
  /// Throws a TupleException if the buffer length or bit alignment is invalid.
  List<int> readBuffer() {
    final Slice s = readCell().beginParse();
    if (s.remainingRefs != 0) {
      throw TupleException('Invalid buffer length.');
    }
    if (s.remainingBits % 8 != 0) {
      throw TupleException('Invalid buffer length.');
    }
    return s.loadBuffer(s.remainingBits ~/ 8);
  }

  /// Reads an optional buffer of bytes from the next cell item.
  /// Returns null if the item is null, otherwise reads the buffer.
  List<int>? readBufferOpt() {
    final TupleItem popped = peek();
    if (popped is TupleItemNull) {
      return null;
    }
    final Slice s = readCell().beginParse();
    if (s.remainingRefs != 0) {
      throw TupleException('Invalid buffer length.');
    }
    if (s.remainingBits % 8 != 0) {
      throw TupleException('Invalid buffer length.');
    }
    return s.loadBuffer(s.remainingBits ~/ 8);
  }

  /// Reads a string from the next cell item.
  String readString() {
    final Slice s = readCell().beginParse();
    return s.loadStringTail();
  }

  /// Reads an optional string from the next cell item.
  /// Returns null if the item is null, otherwise reads the string.
  String? readStringOpt() {
    final TupleItem popped = peek();
    if (popped is TupleItemNull) {
      return null;
    }
    final Slice s = readCell().beginParse();
    return s.loadStringTail();
  }
}
