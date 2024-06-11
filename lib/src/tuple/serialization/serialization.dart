import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/tuple/exception/exception.dart';
import 'package:ton_dart/src/tuple/tuple/tuple.dart';

class TupleSerialization {
  static final _int64Min = BigInt.parse('-9223372036854775808');
  static final _int64Max = BigInt.parse('9223372036854775807');
  static void serializeItem(TupleItem src, Builder builder) {
    if (src.type == TupleItemTypes.nullItem) {
      builder.storeUint(0x00, 8);
    } else if (src is TupleItemInt) {
      if (src.value <= _int64Max && src.value >= _int64Min) {
        builder.storeUint(0x01, 8);
        builder.storeInt(src.value, 64);
      } else {
        builder.storeUint(0x0100, 15);
        builder.storeInt(src.value, 257);
      }
    } else if (src is TupleItemNaN) {
      builder.storeInt(0x02ff, 16);
    } else if (src is TupleItemCell) {
      builder.storeUint(0x03, 8);
      builder.storeRef(src.cell);
    } else if (src is TupleItemSlice) {
      builder.storeUint(0x04, 8);
      builder.storeUint(0, 10);
      builder.storeUint(src.slice.bits.length, 10);
      builder.storeUint(0, 3);
      builder.storeUint(src.slice.refs.length, 3);
      builder.storeRef(src.slice);
    } else if (src is TupleItemBuilder) {
      builder.storeUint(0x05, 8);
      builder.storeRef(src.builder);
    } else if (src is TupleItemTuple) {
      Cell? head;
      Cell? tail;
      for (var i = 0; i < src.items.length; i++) {
        var s = head;
        head = tail;
        tail = s;

        if (i > 1) {
          head = beginCell().storeRef(tail!).storeRef(head!).endCell();
        }

        var bc = beginCell();
        serializeItem(src.items[i], bc);
        tail = bc.endCell();
      }

      builder.storeUint(0x07, 8);
      builder.storeUint(src.items.length, 16);
      if (head != null) {
        builder.storeRef(head);
      }
      if (tail != null) {
        builder.storeRef(tail);
      }
    } else {
      throw TupleException("Invalid tuple type.", details: {"value": src});
    }
  }

  static void serializeTail(List<TupleItem> src, Builder builder) {
    if (src.isNotEmpty) {
      var tail = Builder();
      serializeTail(src.sublist(0, src.length - 1), tail);
      builder.storeRef(tail.endCell());

      serializeItem(src[src.length - 1], builder);
    }
  }

  static Cell serialize(List<TupleItem> src) {
    var builder = Builder();
    builder.storeUint(src.length, 24);
    serializeTail(List<TupleItem>.from(src), builder);
    return builder.endCell();
  }
}
