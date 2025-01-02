import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/dictionary/dictionary.dart';
import 'package:ton_dart/src/dict/dictionary/key.dart';
import 'package:ton_dart/src/dict/exception/exception.dart';
import 'package:ton_dart/src/utils/utils/math.dart';

class DictionaryUtils {
  static String findCommonPrefix(List<String> src, [int startPos = 0]) {
    // Corner cases
    if (src.isEmpty) {
      return '';
    }

    String r = src[0].substring(startPos);

    for (int i = 1; i < src.length; i++) {
      final s = src[i];
      while (!s.startsWith(r, startPos)) {
        r = r.substring(0, r.length - 1);

        if (r.isEmpty) {
          return r;
        }
      }
    }

    return r;
  }

  static String serializeInternalKey(dynamic value) {
    if (value is int) {
      if (!value.isFinite) {
        throw DictException('Invalid key type. not a safe integer.');
      }
      return 'n:${value.toString()}';
    } else if (value is BigInt) {
      return 'b:${value.toString()}';
    } else if (value is TonBaseAddress) {
      return 'a:${value.toString()}';
    } else if (value is List<int>) {
      return 'f:${BytesUtils.toHexString(value)}';
    } else if (value is BitString) {
      return 'B:${value.toString()}';
    } else {
      throw DictException('Invalid key type.',
          details: {'key': value, 'type': value.runtimeType.toString()});
    }
  }

  static T deserializeInternalKey<T>(String value) {
    final decode = _deserializeInternalKey(value);
    if (decode is! T) {
      throw DictException('Invalid key type.', details: {
        'value': decode,
        'excepted': '$T',
        'key': decode.runtimeType.toString()
      });
    }
    return decode;
  }

  static dynamic _deserializeInternalKey(String value) {
    final k = value.substring(0, 2);
    final v = value.substring(2);
    switch (k) {
      case 'n:':
        return int.parse(v);
      case 'b:':
        return BigInt.parse(v);
      case 'a:':
        return TonAddress(v);
      case 'f:':
        return BytesUtils.fromHexString(v);
      case 'B:':
        final lastDash = v.endsWith('_');
        final isPadded = lastDash || v.length % 2 != 0;
        if (isPadded) {
          final charLen = lastDash ? v.length - 1 : v.length;
          String padded = '${v.substring(0, charLen)}0'; // Padding
          if (!lastDash && (charLen & 1) != 0) {
            // Four bit nibmle without padding
            return BitString(BytesUtils.fromHexString(padded), 0, charLen << 2);
          } else {
            if (padded.length.isOdd) {
              padded = padded.substring(0, padded.length - 1);
            }
            return BocUtils.paddedBufferToBits(
                BytesUtils.fromHexString(padded));
          }
        } else {
          return BitString(BytesUtils.fromHexString(v), 0, v.length << 2);
        }
      default:
        throw DictException('Invalid key type.',
            details: {'key': k, 'type': k.runtimeType.toString()});
    }
  }

  static int readUnaryLength(Slice slice) {
    int res = 0;
    while (slice.loadBit()) {
      res++;
    }
    return res;
  }

  static Cell convertToPrunedBranch(Cell c) {
    return beginCell()
        .storeUint(1, 8)
        .storeUint(1, 8)
        .storeBuffer(c.hash(level: 0))
        .storeUint(c.depth(level: 0), 16)
        .endCell(exotic: true);
  }

  static Cell convertToMerkleProof(Cell c) {
    return beginCell()
        .storeUint(3, 8)
        .storeBuffer(c.hash(level: 0))
        .storeUint(c.depth(level: 0), 16)
        .storeRef(c)
        .endCell(exotic: true);
  }

  static Cell doGenerateMerkleProof(
      String prefix, Slice slice, int n, String key) {
    // Reading label
    final Cell originalCell = slice.asCell();

    final lb0 = slice.loadBit() ? 1 : 0;
    int prefixLength = 0;
    String pp = prefix;

    if (lb0 == 0) {
      // Short label detected

      // Read
      prefixLength = readUnaryLength(slice);

      // Read prefix
      for (int i = 0; i < prefixLength; i++) {
        pp += slice.loadBit() ? '1' : '0';
      }
    } else {
      final lb1 = slice.loadBit() ? 1 : 0;
      if (lb1 == 0) {
        // Long label detected
        prefixLength = slice.loadUint(MathUtils.log2(n + 1));
        for (int i = 0; i < prefixLength; i++) {
          pp += slice.loadBit() ? '1' : '0';
        }
      } else {
        // Same label detected
        final bit = slice.loadBit() ? '1' : '0';
        prefixLength = slice.loadUint(MathUtils.log2(n + 1));
        for (int i = 0; i < prefixLength; i++) {
          pp += bit;
        }
      }
    }

    if (n - prefixLength == 0) {
      return originalCell;
    } else {
      final sl = originalCell.beginParse();
      Cell left = sl.loadRef();
      Cell right = sl.loadRef();
      // NOTE: Left and right branches are implicitly contain prefixes '0' and '1'
      if (!left.isExotic) {
        if ('${pp}0' == key.substring(0, pp.length + 1)) {
          left = doGenerateMerkleProof(
              '${pp}0', left.beginParse(), n - prefixLength - 1, key);
        } else {
          left = convertToPrunedBranch(left);
        }
      }
      if (!right.isExotic) {
        if ('${pp}1' == key.substring(0, pp.length + 1)) {
          right = doGenerateMerkleProof(
              '${pp}1', right.beginParse(), n - prefixLength - 1, key);
        } else {
          right = convertToPrunedBranch(right);
        }
      }

      return beginCell()
          .storeSlice(sl)
          .storeRef(left)
          .storeRef(right)
          .endCell();
    }
  }

  static Cell generateMerkleProof<K extends Object, V>(
      Dictionary<K, V> dict, K key, DictionaryKey<K> keyObject) {
    final s = beginCell().storeDictDirect(dict).endCell().beginParse();
    return convertToMerkleProof(doGenerateMerkleProof(
        '',
        s,
        keyObject.bits,
        keyObject
            .serialize(key)
            .toRadixString(2)
            .padLeft(keyObject.bits, '0')));
  }

  static Cell convertToMerkleUpdate(Cell c1, Cell c2) {
    return beginCell()
        .storeUint(4, 8)
        .storeBuffer(c1.hash(level: 0))
        .storeBuffer(c2.hash(level: 0))
        .storeUint(c1.depth(level: 0), 16)
        .storeUint(c2.depth(level: 0), 16)
        .storeRef(c1)
        .storeRef(c2)
        .endCell(exotic: true);
  }

  static Cell generateMerkleUpdate<K extends Object, V>(
    Dictionary<K, V> dict,
    K key,
    DictionaryKey<K> keyObject,
    V newValue,
  ) {
    final oldProof = generateMerkleProof<K, V>(dict, key, keyObject).refs[0];
    dict[key] = newValue;
    final newProof = generateMerkleProof<K, V>(dict, key, keyObject).refs[0];
    return convertToMerkleUpdate(oldProof, newProof);
  }

  static void doParse<V>(String prefix, Slice slice, int n, Map<BigInt, V> res,
      V Function(Slice) extractor) {
    // Reading label
    final bool lb0 = slice.loadBit();
    int prefixLength = 0;
    String pp = prefix;
    if (!lb0) {
      // Short label detected

      // Read
      prefixLength = readUnaryLength(slice);

      // Read prefix
      for (int i = 0; i < prefixLength; i++) {
        pp += slice.loadBit() ? '1' : '0';
      }
    } else {
      final int lb1 = slice.loadBit() ? 1 : 0;
      if (lb1 == 0) {
        // Long label detected
        prefixLength = slice.loadUint(MathUtils.log2(n + 1));
        for (int i = 0; i < prefixLength; i++) {
          pp += slice.loadBit() ? '1' : '0';
        }
      } else {
        // Same label detected
        final String bit = slice.loadBit() ? '1' : '0';
        prefixLength = slice.loadUint(MathUtils.log2(n + 1));
        for (int i = 0; i < prefixLength; i++) {
          pp += bit;
        }
      }
    }
    if (n - prefixLength == 0) {
      res[BigInt.parse(pp, radix: 2)] = extractor(slice);
    } else {
      final Cell left = slice.loadRef();
      final Cell right = slice.loadRef();
      if (!left.isExotic) {
        doParse(
            '${pp}0', left.beginParse(), n - prefixLength - 1, res, extractor);
      }
      if (!right.isExotic) {
        doParse(
            '${pp}1', right.beginParse(), n - prefixLength - 1, res, extractor);
      }
    }
  }

  static Map<BigInt, V> parseDict<V>(
      Slice? sc, int keySize, V Function(Slice) extractor) {
    final Map<BigInt, V> res = {};
    if (sc != null) {
      doParse('', sc, keySize, res, extractor);
    }
    return res;
  }
}
