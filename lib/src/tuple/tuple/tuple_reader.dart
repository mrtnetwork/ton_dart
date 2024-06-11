import 'package:blockchain_utils/binary/utils.dart';
import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/tuple/exception/exception.dart';
import 'tuple.dart';

class TupleReader {
  final List<TupleItem> _items;

  TupleReader(List<TupleItem> items) : _items = List<TupleItem>.from(items);

  int get remaining {
    return _items.length;
  }

  TupleItem peek() {
    if (_items.isEmpty) {
      throw TupleException('EOF');
    }
    return _items[0];
  }

  TupleItem pop() {
    if (_items.isEmpty) {
      throw TupleException('EOF');
    }
    TupleItem res = _items[0];
    _items.removeAt(0);
    return res;
  }

  TupleReader skip({int num = 1}) {
    for (int i = 0; i < num; i++) {
      pop();
    }
    return this;
  }

  BigInt readBigNumber() {
    TupleItem popped = pop();
    if (popped is! TupleItemInt) {
      throw TupleException("Invalid integer tuple item.",
          details: {"value": popped});
    }
    return popped.value;
  }

  String readBigNumberAsHex() {
    final BigInt value = readBigNumber();
    final List<int> toBytes =
        BigintUtils.toBytes(value, length: BigintUtils.bitlengthInBytes(value));
    return BytesUtils.toHexString(toBytes);
  }

  BigInt? readBigNumberOpt() {
    TupleItem popped = pop();
    if (popped is TupleItemNull) {
      return null;
    }
    if (popped is! TupleItemInt) {
      throw TupleException("Invalid integer tuple item.",
          details: {"value": popped});
    }
    return popped.value;
  }

  int readNumber() {
    return readBigNumber().toInt();
  }

  int? readNumberOpt() {
    BigInt? r = readBigNumberOpt();
    return r?.toInt();
  }

  bool readBoolean() {
    int res = readNumber();
    return res == 0 ? false : true;
  }

  bool? readBooleanOpt() {
    int? res = readNumberOpt();
    return res != null ? (res == 0 ? false : true) : null;
  }

  TonAddress readAddress() {
    return readCell().beginParse().loadAddress();
  }

  TonAddress? readAddressOpt() {
    Cell? r = readCellOpt();
    if (r != null) {
      return r.beginParse().loadMaybeAddress();
    } else {
      return null;
    }
  }

  Cell readCell() {
    TupleItem popped = pop();
    if (popped is TupleItemCell) return popped.cell;
    if (popped is TupleItemSlice) return popped.slice;
    if (popped is TupleItemBuilder) return popped.builder;
    throw TupleException("Invalid tuple cell.", details: {"value": popped});
  }

  Cell? readCellOpt() {
    TupleItem popped = pop();
    if (popped is TupleItemNull) {
      return null;
    }
    if (popped is TupleItemCell) return popped.cell;
    if (popped is TupleItemSlice) return popped.slice;
    if (popped is TupleItemBuilder) return popped.builder;
    throw TupleException("Invalid tuple cell.", details: {"value": popped});
  }

  TupleReader readTuple() {
    TupleItem popped = pop();
    if (popped is! TupleItemTuple) {
      throw TupleException("Invalid tuple type.", details: {"value": popped});
    }
    return TupleReader(popped.items);
  }

  TupleReader? readTupleOpt() {
    TupleItem popped = pop();
    if (popped is TupleItemNull) {
      return null;
    }
    if (popped is! TupleItemTuple) {
      throw TupleException("Invalid tuple type.", details: {"value": popped});
    }
    return TupleReader(popped.items);
  }

  static List<TupleItem> readLispListStatics(TupleReader? reader) {
    List<TupleItem> result = [];
    TupleReader? tail = reader;
    while (tail != null) {
      TupleItem head = tail.pop();
      if (tail._items.isEmpty ||
          (tail._items[0] is! TupleItemTuple &&
              tail._items[0] is! TupleItemNull)) {
        throw TupleException(
            "Lisp list consists only from (any, tuple) elements and ends with null");
      }
      tail = tail.readTupleOpt();
      result.add(head);
    }
    return result;
  }

  List<TupleItem> readLispListDirect() {
    if (_items.length == 1 && _items[0] is TupleItemNull) {
      return [];
    }
    return TupleReader.readLispListStatics(this);
  }

  List<TupleItem> readLispList() {
    return TupleReader.readLispListStatics(readTupleOpt());
  }

  List<int> readBuffer() {
    Slice s = readCell().beginParse();
    if (s.remainingRefs != 0) {
      throw TupleException("Invalid buffer length.");
    }
    if (s.remainingBits % 8 != 0) {
      throw TupleException("Invalid buffer length.");
    }
    return s.loadBuffer(s.remainingBits ~/ 8);
  }

  List<int>? readBufferOpt() {
    TupleItem popped = peek();
    if (popped is TupleItemNull) {
      return null;
    }
    Slice s = readCell().beginParse();
    if (s.remainingRefs != 0) {
      throw TupleException("Invalid buffer length.");
    }
    if (s.remainingBits % 8 != 0) {
      throw TupleException("Invalid buffer length.");
    }
    return s.loadBuffer(s.remainingBits ~/ 8);
  }

  String readString() {
    Slice s = readCell().beginParse();
    return s.loadStringTail();
  }

  String? readStringOpt() {
    TupleItem popped = peek();
    if (popped is TupleItemNull) {
      return null;
    }
    Slice s = readCell().beginParse();
    return s.loadStringTail();
  }
}
