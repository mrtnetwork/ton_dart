import 'dart:convert';

import 'package:blockchain_utils/utils/utils.dart';
import 'package:test/test.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/boc/serialization/utils/utils.dart';
import 'package:ton_dart/src/dict/dictionary.dart';

import 'config_test_vector.dart';

Builder storeBits(Builder builder, String src) {
  for (var s in src.runes) {
    if (s == 48) {
      builder.storeBit(0);
    } else {
      builder.storeBit(1);
    }
  }
  return builder;
}

void main() async {
  group("dict", () => _test());
}

void _test() {
  test('should parse and serialize dict from example', () {
    final root = storeBits(beginCell(), '11001000')
        .storeRef(storeBits(beginCell(), '011000')
            .storeRef(
                storeBits(beginCell(), '1010011010000000010101001').asCell())
            .storeRef(
                storeBits(beginCell(), '1010000010000000100100001').asCell())
            .asCell())
        .storeRef(
            storeBits(beginCell(), '1011111011111101111100100001').asCell())
        .endCell();
    final parse = root.beginParse();

    // Unpack
    final dict = Dictionary.loadDirect(
        DictionaryKey.uintCodec(16), DictionaryValue.uintCodec(16), parse);
    // return;
    expect(dict[13], 169);
    expect(dict[17], 289);
    expect(dict[239], 57121);

    // Empty
    final fromEmpty = Dictionary.empty<int, int>();
    fromEmpty[13] = 169;
    fromEmpty[17] = 289;
    fromEmpty[239] = 57121;

    // Pack
    final packed = beginCell().storeDictDirect<int, int>(dict).endCell();

    final packed2 = beginCell()
        .storeDictDirect(fromEmpty,
            key: DictionaryKey.uintCodec(16),
            value: DictionaryValue.uintCodec(16))
        .endCell();

    // Compare
    expect(packed, root);
    expect(packed2, root);
  });
  test('should parse config', () {
    final cell = Cell.fromBoc(base64Decode(configTestVector))[0];
    final configs = cell.beginParse().loadDictDirect(
        DictionaryKey.intCodec(32), DictionaryValue.cellCodec());
    final List<int> ids = [
      0,
      1,
      2,
      4,
      7,
      8,
      9,
      10,
      11,
      12,
      14,
      15,
      16,
      17,
      18,
      20,
      21,
      22,
      23,
      24,
      25,
      28,
      29,
      31,
      32,
      34,
      71,
      72,
      -999,
      -71
    ];
    final keys = configs.keys;
    for (final i in ids) {
      expect(keys.contains(i), true);
      expect(configs[i] != null, true);
      expect(configs.containsKey(i), true);
    }
  });
  test('should parse bridge config', () {
    final cell = Cell.fromBoc(base64Decode(configTestVector))[0];
    final configs = cell.beginParse().loadDictDirect(
        DictionaryKey.intCodec(32), DictionaryValue.cellCodec());
    for (final i in [71, 72]) {
      final r = configs[i]!;
      final config = r.beginParse();
      config.loadBuffer(32);
      config.loadBuffer(32);
      config.loadDict(
          DictionaryKey.bigUintCodec(256), DictionaryValue.bytesCodec(32));
      config.loadBuffer(32);
    }
  });

  test('should correctly serialize BitString keys and values', () {
    int keyLen = 9; // Not 8 bit aligned
    final DictionaryKey<BitString> keys = DictionaryKey.bitStringCodec(keyLen);
    final DictionaryValue<BitString> values =
        DictionaryValue.bitStringCodec(72);
    final testKey = BitString("Test".codeUnits, 0, keyLen);
    final testVal = BitString("BitString".codeUnits, 0, 72);
    final testDict = Dictionary.empty(key: keys, value: values);

    testDict[testKey] = testVal;
    expect(testDict[testKey], testVal);

    final serialized = beginCell().storeDictDirect(testDict).endCell();
    final dictDs = Dictionary.loadDirect(keys, values, serialized.beginParse());
    expect(dictDs[testKey], testVal);
  });

  test('should generate merkle proofs', () {
    final d = Dictionary.empty(
        key: DictionaryKey.uintCodec(8), value: DictionaryValue.uintCodec(32));
    d[1] = 11;
    d[2] = 22;
    d[3] = 33;
    d[4] = 44;
    d[5] = 55;

    for (int k = 1; k <= 5; k++) {
      final proof = d.generateMerkleProof(k);
      Cell.fromBoc(proof.toBoc());
      expect(
          CellUtils.exoticMerkleProof(proof.bits, proof.refs).proofHash,
          BytesUtils.fromHexString(
              "ee41b86bd71f8224ebd01848b4daf4cd46d3bfb3e119d8b865ce7c2802511de3"));
    }
  });

  test('should generate merkle updates', () {
    final d = Dictionary.empty(
        key: DictionaryKey.uintCodec(8), value: DictionaryValue.uintCodec(32));
    d[1] = 11;
    d[2] = 22;
    d[3] = 33;
    d[4] = 44;
    d[5] = 55;

    for (int k = 1; k <= 5; k++) {
      final update = d.generateMerkleUpdate(k, d[k]! * 2);
      Cell.fromBoc(update.toBoc());
      expect(
          CellUtils.exoticMerkleUpdate(update.bits, update.refs).proof1,
          BytesUtils.fromHexString(
              "ee41b86bd71f8224ebd01848b4daf4cd46d3bfb3e119d8b865ce7c2802511de3"));
      d[k] = (d[k]! / 2).floor();
    }
  });
  test('should parse dictionary with empty values', () {
    final cell = Cell.fromBoc(BytesUtils.fromHexString(
        "b5ee9c72010101010024000043a0000000000000000000000000000000000000000000000000000000000000000f70"))[0];
    final testDict = Dictionary.loadDirect(DictionaryKey.bigUintCodec(256),
        DictionaryValue.bitStringCodec(0), cell.beginParse());
    expect(testDict.keys.first, BigInt.from(123));
    expect(testDict[BigInt.from(123)]?.length, 0);
  });
}
