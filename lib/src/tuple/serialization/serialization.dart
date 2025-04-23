import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/tuple/tuple/tuple.dart';

class TupleSerialization {
  static final _int64Min = BigInt.parse('-9223372036854775808');
  static final _int64Max = BigInt.parse('9223372036854775807');

  /// Serializes a [TupleItem] into a [Builder].
  static void serializeItem(TupleItem src, Builder builder) {
    switch (src.type) {
      case TupleItemTypes.nullItem:
        builder.storeUint(0x00, 8);
        break;
      case TupleItemTypes.nanItem:
        builder.storeInt(0x02ff, 16);
        break;
      case TupleItemTypes.intItem:
        final num = src as TupleItemInt;
        if (num.value <= _int64Max && num.value >= _int64Min) {
          builder.storeUint(0x01, 8);
          builder.storeInt(num.value, 64);
        } else {
          builder.storeUint(0x0100, 15);
          builder.storeInt(num.value, 257);
        }
        break;
      case TupleItemTypes.tupleItem:
        final tuple = src as TupleItemTuple;
        Cell? head;
        Cell? tail;
        for (var i = 0; i < tuple.items.length; i++) {
          final s = head;
          head = tail;
          tail = s;

          if (i > 1) {
            head = beginCell().storeRef(tail!).storeRef(head!).endCell();
          }

          final bc = beginCell();
          serializeItem(tuple.items[i], bc);
          tail = bc.endCell();
        }

        builder.storeUint(0x07, 8);
        builder.storeUint(tuple.items.length, 16);
        if (head != null) {
          builder.storeRef(head);
        }
        if (tail != null) {
          builder.storeRef(tail);
        }
        break;
      default:
        final cell = (src as TupleItemCell).cell;
        if (src.type == TupleItemTypes.sliceItem) {
          builder.storeUint(0x04, 8);
          builder.storeUint(0, 10);
          builder.storeUint(cell.bits.length, 10);
          builder.storeUint(0, 3);
          builder.storeUint(cell.refs.length, 3);
          builder.storeRef(cell);
        } else if (src.type == TupleItemTypes.builderItem) {
          builder.storeUint(0x05, 8);
          builder.storeRef(cell);
        } else {
          builder.storeUint(0x03, 8);
          builder.storeRef(cell);
        }
    }
  }

  /// Serializes a list of tuple items recursively, storing references.
  static void serializeTail(List<TupleItem> src, Builder builder) {
    if (src.isNotEmpty) {
      final tail = Builder();
      serializeTail(src.sublist(0, src.length - 1), tail);
      builder.storeRef(tail.endCell());

      serializeItem(src[src.length - 1], builder);
    }
  }

  /// Serializes a list of [TupleItem]s into a [Cell].
  static Cell serialize(List<TupleItem> src) {
    final builder = Builder();
    builder.storeUint(src.length, 24);
    serializeTail(List<TupleItem>.from(src), builder);
    return builder.endCell();
  }
}
