import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/tuple/exception/exception.dart';
import 'package:ton_dart/src/tuple/tuple/tuple.dart';

class TupleUtils {
  static TupleItem parseStackItem(Slice cs) {
    final int kind = cs.loadUint(8);
    if (kind == 0) {
      return const TupleItemNull();
    } else if (kind == 1) {
      return TupleItemInt(cs.loadIntBig(64));
    } else if (kind == 2) {
      if (cs.loadUint(7) == 0) {
        return TupleItemInt(cs.loadIntBig(257));
      } else {
        cs.loadBit(); // must eq 1
        return const TupleItemNaN();
      }
    } else if (kind == 3) {
      return TupleItemCell(cs.loadRef());
    } else if (kind == 4) {
      final int startBits = cs.loadUint(10);
      final int endBits = cs.loadUint(10);
      final int startRefs = cs.loadUint(3);
      final int endRefs = cs.loadUint(3);

      // Copy to new cell
      final Slice rs = cs.loadRef().beginParse();
      rs.skip(startBits);
      final BitString dt = rs.loadBits(endBits - startBits);

      final Builder builder = Builder().storeBits(dt);

      // Copy refs if exist
      if (startRefs < endRefs) {
        for (var i = 0; i < startRefs; i++) {
          rs.loadRef();
        }
        for (var i = 0; i < endRefs - startRefs; i++) {
          builder.storeRef(rs.loadRef());
        }
      }

      return TupleItemSlice(builder.endCell());
    } else if (kind == 5) {
      return TupleItemBuilder(cs.loadRef());
    } else if (kind == 7) {
      final int length = cs.loadUint(16);
      final List<TupleItem> items = [];
      if (length > 1) {
        Slice head = cs.loadRef().beginParse();
        Slice tail = cs.loadRef().beginParse();
        items.insert(0, parseStackItem(tail));
        for (var i = 0; i < length - 2; i++) {
          final Slice ohead = head;
          head = ohead.loadRef().beginParse();
          tail = ohead.loadRef().beginParse();
          items.insert(0, parseStackItem(tail));
        }
        items.insert(0, parseStackItem(head));
      } else if (length == 1) {
        items.add(parseStackItem(cs.loadRef().beginParse()));
      }
      return TupleItemTuple(items);
    } else {
      throw TupleException('Unsupported stack item');
    }
  }

  static List<TupleItem> parse(Cell src) {
    final List<TupleItem> res = [];
    Slice cs = src.beginParse();
    final int size = cs.loadUint(24);
    for (var i = 0; i < size; i++) {
      final Cell next = cs.loadRef();
      res.insert(0, parseStackItem(cs));
      cs = next.beginParse();
    }
    return res;
  }

  static TupleItem _parseStackItemAsList(List<dynamic> stacks) {
    if (stacks.isEmpty) {
      throw TupleException('Invali stack list item');
    }
    final type = stacks[0];
    switch (type) {
      case 'num':
        final String stringVal = stacks[1].toString();
        BigInt val;
        if (stringVal.startsWith('-')) {
          val = -BigintUtils.parse(stringVal.substring(1));
        } else {
          val = BigintUtils.parse(stringVal);
        }
        return TupleItemInt(val);
      case 'null':
        return const TupleItemNull();
      case 'cell':
        return TupleItemCell(Cell.fromBase64((stacks[1] as Map)['bytes']));
      case 'slice':
        return TupleItemSlice(Cell.fromBase64((stacks[1] as Map)['bytes']));
      case 'builder':
        return TupleItemBuilder(Cell.fromBase64((stacks[1] as Map)['bytes']));
      default:
        throw TonDartPluginException('Unsuported tuple type.',
            details: {'type': type});
    }
  }

  static List<TupleItem> parseStackItemAsList(List<List> stacks) {
    return stacks.map((e) => _parseStackItemAsList(e)).toList();
  }

//   TupleItem parseStackEntry(s: any){
//     switch (s["@type"]) {
//         case "tvm.stackEntryNumber":
//             return { type: 'int', value: BigInt(s.number.number) };
//         case "tvm.stackEntryCell":
//             return { type: 'cell', cell: Cell.fromBase64(s.cell) };
//         case 'tvm.stackEntryTuple':
//             return { type: 'tuple', items: s.tuple.elements.map(parseStackEntry) };
//         case 'tvm.stackEntryList':
//             return { type: 'list', items: s.list.elements.map(parseStackEntry) };
//         default:
//             throw Error("Unsupported item type: " + s["@type"]);
//     }
// }

// function parseStackItem(s: any): TupleItem {
//     if (s[0] === 'num') {
//         let val = s[1] as string;
//         if (val.startsWith('-')) {
//             return { type: 'int', value: -BigInt(val.slice(1)) };
//         } else {
//             return { type: 'int', value: BigInt(val) };
//         }
//     } else if (s[0] === 'null') {
//         return { type: 'null' };
//     } else if (s[0] === 'cell') {
//         return { type: 'cell', cell: Cell.fromBoc(Buffer.from(s[1].bytes, 'base64'))[0] };
//     } else if (s[0] === 'slice') {
//         return { type: 'slice', cell: Cell.fromBoc(Buffer.from(s[1].bytes, 'base64'))[0] };
//     } else if (s[0] === 'builder') {
//         return { type: 'builder', cell: Cell.fromBoc(Buffer.from(s[1].bytes, 'base64'))[0] };
//     } else if (s[0] === 'tuple' || s[0] === 'list') {
//         // toncenter.com missbehaviour
//         if (s[1].elements.length === 0) {
//             return { type: 'null' };
//         }
//         return {
//             type: s[0],
//             items: s[1].elements.map(parseStackEntry)
//         };
//     } else {
//         throw Error('Unsupported stack item type: ' + s[0])
//     }
// }
}
