import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/dict/dictionary.dart';
import 'package:ton_dart/src/models/models/simple_library.dart';
import 'package:ton_dart/src/models/models/tick_tock.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/extensions.dart';

class _StateInitUtils {
  static Dictionary<BigInt, SimpleLibrary> libraryDict(
      {Map<BigInt, SimpleLibrary>? map}) {
    return Dictionary.fromEnteries<BigInt, SimpleLibrary>(
        key: DictionaryKey.bigUintCodec(256),
        value: SimpleLibraryCodecs.codec,
        map: map ?? {});
  }
}

class StateInit extends TonSerialization {
  final int? splitDepth;
  final TickTock? special;
  final Cell? code;
  final Cell? data;
  final Map<BigInt, SimpleLibrary>? libraries;
  StateInit({
    this.splitDepth,
    this.special,
    this.code,
    this.data,
    Map<BigInt, SimpleLibrary>? libraries,
  }) : libraries = libraries?.nullOnEmpty;

  factory StateInit.deserialize(Slice slice) {
    final splitDepth = slice.loadBit().onTrue(() => slice.loadUint(5));
    final TickTock? special =
        slice.loadBit().onTrue(() => TickTock.deserialize(slice));
    final code = slice.loadMaybeRef();
    final data = slice.loadMaybeRef();
    final libraries = _StateInitUtils.libraryDict()..loadFromClice(slice);
    return StateInit(
        splitDepth: splitDepth,
        special: special,
        code: code,
        data: data,
        libraries: libraries.asMap);
  }
  factory StateInit.fromJson(Map<String, dynamic> json) {
    return StateInit(
        splitDepth: json['splitDepth'],
        special: (json['special'] as Object?)
            ?.convertTo<TickTock, Map<String, dynamic>>(
                (p0) => TickTock.fromJson(p0)),
        code: (json['code'] as Object?)
            ?.convertTo<Cell, String>((result) => Cell.fromBase64(result)),
        data: (json['data'] as Object?)
            ?.convertTo<Cell, String>((result) => Cell.fromBase64(result)),
        libraries: (json['libraries'] as Object?)
            ?.convertTo<Map<BigInt, SimpleLibrary>, Map<String, dynamic>>(
                (result) {
          return result.map((key, value) =>
              MapEntry(BigintUtils.parse(key), SimpleLibrary.fromJson(value)));
        }));
  }

  @override
  void store(Builder builder) {
    if (splitDepth != null) {
      builder.storeBitBolean(true);
      builder.storeUint(splitDepth, 5);
    } else {
      builder.storeBitBolean(false);
    }
    if (special != null) {
      builder.storeBitBolean(true);
      special?.store(builder);
    } else {
      builder.storeBitBolean(false);
    }
    builder.storeMaybeRef(cell: code);
    builder.storeMaybeRef(cell: data);
    final dict = libraries?.convertTo<Dictionary<BigInt, SimpleLibrary>,
            Map<BigInt, SimpleLibrary>>(
        (p0) => _StateInitUtils.libraryDict(map: p0));
    builder.storeDict(dict: dict);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'splitDepth': splitDepth,
      'special': special?.toJson(),
      'code': code?.toBase64(),
      'data': data?.toBase64(),
      'libraries': libraries
          ?.map((key, value) => MapEntry(key.toString(), value.toJson()))
    };
  }
}
