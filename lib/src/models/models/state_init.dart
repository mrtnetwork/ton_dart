import 'package:blockchain_utils/helper/extensions/extensions.dart';
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
  static Dictionary<BigInt, SimpleLibrary> libraryDict({
    Map<BigInt, SimpleLibrary>? map,
  }) {
    return Dictionary.fromEnteries<BigInt, SimpleLibrary>(
      key: DictionaryKey.bigUintCodec(256),
      value: SimpleLibraryCodecs.codec,
      map: map ?? {},
    );
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
    final TickTock? special = slice.loadBit().onTrue(
      () => TickTock.deserialize(slice),
    );
    final code = slice.loadMaybeRef();
    final data = slice.loadMaybeRef();
    final libraries = _StateInitUtils.libraryDict()..loadFromClice(slice);
    return StateInit(
      splitDepth: splitDepth,
      special: special,
      code: code,
      data: data,
      libraries: libraries.asMap,
    );
  }
  factory StateInit.fromJson(Map<String, dynamic> json) {
    return StateInit(
      splitDepth: json['splitDepth'],
      special: json.valueTo<TickTock?, Map<String, dynamic>>(
        key: "special",
        parse: (v) => TickTock.fromJson(v),
      ),
      code: json.valueTo<Cell?, String>(
        key: "code",
        parse: (v) => Cell.fromBase64(v),
      ),
      data: json.valueTo<Cell?, String>(
        key: "data",
        parse: (v) => Cell.fromBase64(v),
      ),
      libraries: json
          .valueTo<Map<BigInt, SimpleLibrary>?, Map<String, dynamic>>(
            key: "libraries",
            parse:
                (v) => v.map(
                  (key, value) => MapEntry(
                    JsonParser.valueAsBigInt(key),
                    SimpleLibrary.fromJson(
                      JsonParser.valueEnsureAsMap<String, dynamic>(value),
                    ),
                  ),
                ),
          ),
    );
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
    final libraries = this.libraries;
    builder.storeDict(
      dict:
          libraries == null
              ? null
              : _StateInitUtils.libraryDict(map: libraries),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'splitDepth': splitDepth,
      'special': special?.toJson(),
      'code': code?.toBase64(),
      'data': data?.toBase64(),
      'libraries': libraries?.map(
        (key, value) => MapEntry(key.toString(), value.toJson()),
      ),
    };
  }
}
