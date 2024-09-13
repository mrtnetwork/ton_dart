import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/exception/exception.dart';
import 'package:ton_dart/src/dict/utils/utils.dart';
import 'package:ton_dart/src/utils/utils/math.dart';

class _Node<T> {
  late _Edge<T> left;
  late _Edge<T> right;

  _Node.fork(this.left, this.right) : isLeaf = false;
  _Node.leaf(this.value) : isLeaf = true;
  bool isLeaf;
  late final T value;

  Map<String, dynamic> toJson() {
    if (isLeaf) {
      return {"value": value, "type": "leaf"};
    }
    return {
      "left": left.toJson(),
      "right": right.toJson(),
      "type": "fork",
    };
  }
}

class _Edge<T> {
  final String label;
  final _Node<T> node;

  _Edge(this.label, this.node);
  Map<String, dynamic> toJson() {
    return {"label": label, "node": node.toJson()};
  }
}

class _DictSerializationUtils {
  static String pad(String src, int size) {
    while (src.length < size) {
      src = '0$src';
    }
    return src;
  }

  static Tuple<Map<String, T>, Map<String, T>> forkMap<T>(
      Map<String, T> src, int prefixLen) {
    if (src.isEmpty) {
      throw DictException("Internal inconsistency");
    }
    final left = <String, T>{};
    final right = <String, T>{};
    for (final entry in src.entries) {
      final k = entry.key;
      final d = entry.value;
      if (k[prefixLen] == '0') {
        left[k] = d;
      } else {
        right[k] = d;
      }
    }
    if (left.isEmpty) {
      throw DictException("Internal inconsistency. Left emtpy.");
    }
    if (right.isEmpty) {
      throw DictException("Internal inconsistency. Right emtpy.");
    }
    return Tuple(left, right);
  }

  static _Node<T> buildNode<T>(Map<String, T> src, int prefixLen) {
    if (src.isEmpty) {
      throw DictException("Internal inconsistency");
    }
    if (src.length == 1) {
      return _Node.leaf(src.values.first);
    }
    final fork = forkMap(src, prefixLen);
    final left = buildEdge<T>(fork.item1, prefixLen + 1);
    final right = buildEdge<T>(fork.item2, prefixLen + 1);
    return _Node.fork(left, right);
  }

  static _Edge<T> buildEdge<T>(Map<String, T> src, [int prefixLen = 0]) {
    if (src.isEmpty) {
      throw DictException("Internal inconsistency");
    }
    final label =
        DictionaryUtils.findCommonPrefix(src.keys.toList(), prefixLen);
    final node = buildNode<T>(src, label.length + prefixLen);
    return _Edge(label, node);
  }

  static _Edge<T> buildTree<T>(Map<BigInt, T> src, int keyLength) {
    final Map<String, T> converted = {};
    src.forEach((k, v) {
      final padded = pad(k.toRadixString(2), keyLength);
      converted[padded] = v;
    });
    return buildEdge(converted);
  }

  static String writeLabelShort(String src, Builder to) {
    // Header
    to.storeBit(0);

    // Unary length
    for (int i = 0; i < src.length; i++) {
      to.storeBit(1);
    }
    to.storeBit(0);

    // Value
    if (src.isNotEmpty) {
      to.storeUint(BigInt.parse(src, radix: 2), src.length);
    }
    return src;
  }

  static int labelShortLength(String src) {
    return 1 + src.length + 1 + src.length;
  }

  static String writeLabelLong(String src, int keyLength, Builder to) {
    // Header
    to.storeBit(1);
    to.storeBit(0);

    // Length
    final length = MathUtils.log2(keyLength + 1);
    to.storeUint(src.length, length);

    // Value
    if (src.isNotEmpty) {
      to.storeUint(BigInt.parse(src, radix: 2), src.length);
    }
    return src;
  }

  static int labelLongLength(String src, int keyLength) {
    final len = MathUtils.log2(keyLength + 1);
    return 1 + 1 + len + src.length;
  }

  static void writeLabelSame(
      bool value, int length, int keyLength, Builder to) {
    // Header
    to.storeBit(1);
    to.storeBit(1);

    // Value
    to.storeBit(value ? 1 : 0);
    final lenLen = MathUtils.log2(keyLength + 1);
    to.storeUint(length, lenLen);
  }

  static int labelSameLength(int keyLength) {
    final len = MathUtils.log2(keyLength + 1);
    return 1 + 1 + 1 + len.ceil();
  }

  static bool isSame(String src) {
    if (src.isEmpty || src.length == 1) {
      return true;
    }
    for (int i = 1; i < src.length; i++) {
      if (src[i] != src[0]) {
        return false;
      }
    }
    return true;
  }

  static int detectLabelType(String src, int keyLength) {
    int kind = 0;
    int kindLength = labelShortLength(src);
    final longLength = labelLongLength(src, keyLength);
    if (longLength < kindLength) {
      kindLength = longLength;
      kind = 1;
    }

    if (isSame(src)) {
      final sameLength = labelSameLength(keyLength);
      if (sameLength < kindLength) {
        kindLength = sameLength;
        kind = 2;
      }
    }

    return kind;
  }

  static void writeLabel(String src, int keyLength, Builder to) {
    final type = detectLabelType(src, keyLength);
    switch (type) {
      case 0:
        writeLabelShort(src, to);
        break;
      case 1:
        writeLabelLong(src, keyLength, to);
        break;
      default:
        writeLabelSame(src[0] == '1', src.length, keyLength, to);
        break;
    }
  }

  static void writeNode<T>(_Node<T> src, int keyLength,
      void Function(T, Builder) serializer, Builder to) {
    if (src.isLeaf) {
      serializer(src.value, to);
    }
    if (!src.isLeaf) {
      final leftCell = beginCell();
      final rightCell = beginCell();
      writeEdge(src.left, keyLength - 1, serializer, leftCell);
      writeEdge(src.right, keyLength - 1, serializer, rightCell);
      to.storeRef(leftCell.endCell());
      to.storeRef(rightCell.endCell());
    }
  }

  static void writeEdge<T>(_Edge<T> src, int keyLength,
      void Function(T, Builder) serializer, Builder to) {
    writeLabel(src.label, keyLength, to);
    writeNode(src.node, keyLength - src.label.length, serializer, to);
  }
}

class DictSerialization {
  static void serialize<T>(Map<BigInt, T> src, int keyLength,
      void Function(T, Builder) serializer, Builder to) {
    final tree = _DictSerializationUtils.buildTree<T>(src, keyLength);
    _DictSerializationUtils.writeEdge(tree, keyLength, serializer, to);
  }
}
