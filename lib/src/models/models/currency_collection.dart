import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/dictionary.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/extensions.dart';

class CurrencyCollection extends TonSerialization {
  final Map<int, BigInt>? other;
  final BigInt coins;
  CurrencyCollection({Map<int, BigInt>? other, required this.coins})
      : other = other?.nullOnEmpty;
  factory CurrencyCollection.deserialize(Slice slice) {
    final BigInt coins = slice.loadCoins();
    final other = slice.loadDict(
        DictionaryKey.uintCodec(32), DictionaryValue.bigVarUintCodec(5));
    return CurrencyCollection(coins: coins, other: other.asMap);
  }
  factory CurrencyCollection.fromJson(Map<String, dynamic> json) {
    return CurrencyCollection(
      other: (json["other"] as Object?)?.convertTo<Map<int, BigInt>, Map>((p0) {
        final Map<int, String> result = p0.cast();
        return result.map<int, BigInt>(
            (key, value) => MapEntry(key, BigintUtils.parse(value)));
      }),
      coins: BigintUtils.parse(json["coins"]),
    );
  }
  @override
  void store(Builder builder) {
    builder.storeCoins(coins);
    if (other?.isEmpty ?? true) {
      builder.storeBit(0);
    } else {
      final dict = Dictionary.fromEnteries<int, BigInt>(
          key: DictionaryKey.uintCodec(32),
          value: DictionaryValue.bigVarUintCodec(5),
          map: other!);
      builder.storeDict(dict: dict);
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "other": other?.map((key, value) => MapEntry(key, value.toString())),
      "coins": coins.toString()
    };
  }
}
