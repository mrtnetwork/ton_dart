import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/dictionary.dart';
import 'package:ton_dart/src/models/models/depth_balance_info.dart';
import 'package:ton_dart/src/models/models/shard_account.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/extensions.dart';

class ShardAccountsCodec {
  static final DictionaryValue<ShardAccountRef> codec =
      DictionaryValue(serialize: (p0, p1) {
    p0.store(p1);
  }, parse: (slice) {
    return ShardAccountRef.deserialize(slice);
  });
  static Dictionary<BigInt, ShardAccountRef> dict(
      {Map<BigInt, ShardAccountRef>? accounts}) {
    return Dictionary.fromEnteries(
        key: DictionaryKey.bigUintCodec(256),
        value: ShardAccountsCodec.codec,
        map: accounts ?? {});
  }
}

class ShardAccountRef extends TonSerialization {
  final DepthBalanceInfo depthBalanceInfo;
  final ShardAccount shardAccount;

  const ShardAccountRef(
      {required this.depthBalanceInfo, required this.shardAccount});
  factory ShardAccountRef.deserialize(Slice slice) {
    return ShardAccountRef(
      depthBalanceInfo: DepthBalanceInfo.deserialize(slice),
      shardAccount: ShardAccount.deserialize(slice),
    );
  }
  factory ShardAccountRef.fromJson(Map<String, dynamic> json) {
    return ShardAccountRef(
        depthBalanceInfo: DepthBalanceInfo.fromJson(json['depth_balance_info']),
        shardAccount: ShardAccount.fromJson(json['shard_account']));
  }

  @override
  void store(Builder builder) {
    depthBalanceInfo.store(builder);
    shardAccount.store(builder);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'depth_balance_info': depthBalanceInfo.toJson(),
      'shard_account': shardAccount.toJson()
    };
  }
}

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L261
/// _ (HashmapAugE 256 ShardAccount DepthBalanceInfo) = ShardAccounts;
class ShardAccounts extends TonSerialization {
  final Map<BigInt, ShardAccountRef> accounts;
  ShardAccounts(Map<BigInt, ShardAccountRef> accounts)
      : accounts = accounts.mutabl;
  factory ShardAccounts.deserialize(Slice slice) {
    final dict = ShardAccountsCodec.dict();
    dict.loadFromClice(slice);
    return ShardAccounts(dict.asMap);
  }
  factory ShardAccounts.fromJson(Map<String, dynamic> json) {
    return ShardAccounts((json['accounts'] as Map<String, dynamic>).map(
        (key, value) =>
            MapEntry(BigintUtils.parse(key), ShardAccountRef.fromJson(value))));
  }

  @override
  void store(Builder builder) {
    final dict = ShardAccountsCodec.dict(accounts: accounts);
    builder.storeDict(dict: dict);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'accounts':
          accounts.map((key, value) => MapEntry(key.toString(), value.toJson()))
    };
  }
}
