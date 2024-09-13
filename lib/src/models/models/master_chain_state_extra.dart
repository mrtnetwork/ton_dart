import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/dictionary.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/models/models/currency_collection.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/extentions.dart';

class _MasterchainStateExtraUtils {
  static Dictionary<int, Cell> dict({Map<int, String>? config}) {
    return Dictionary.fromEnteries(
        key: DictionaryKey.intCodec(32),
        value: DictionaryValue.cellCodec(),
        map: config
                ?.map((key, value) => MapEntry(key, Cell.fromBase64(value))) ??
            {});
  }
}

class _MasterChainStateExtraConst {
  static const int magic = 0xcc26;
}

/// Source: https://github.com/ton-foundation/ton/blob/ae5c0720143e231c32c3d2034cfe4e533a16d969/crypto/block/block.tlb#L509
/// _ config_addr:bits256 config:^(Hashmap 32 ^Cell)
///  = ConfigParams;
/// Source: https://github.com/ton-foundation/ton/blob/ae5c0720143e231c32c3d2034cfe4e533a16d969/crypto/block/block.tlb#L534
/// masterchain_state_extra#cc26
///  shard_hashes:ShardHashes
///  config:ConfigParams
///  ^[ flags:(## 16) { flags <= 1 }
///     validator_info:ValidatorInfo
///     prev_blocks:OldMcBlocksInfo
///     after_key_block:Bool
///     last_key_block:(Maybe ExtBlkRef)
///     block_create_stats:(flags . 0)?BlockCreateStats ]
///  global_balance:CurrencyCollection
/// = McStateExtra;
class MasterchainStateExtra extends TonSerialization {
  final BigInt configAddress;
  final Map<int, Cell> config;
  final CurrencyCollection globalBalance;
  MasterchainStateExtra(
      {required this.configAddress,
      required Map<int, Cell> config,
      required this.globalBalance})
      : config = config.mutabl;
  factory MasterchainStateExtra.deserialize(Slice slice) {
    // Check magic
    if (slice.loadUint(16) != _MasterChainStateExtraConst.magic) {
      throw const TonDartPluginException(
          "Invalid MasterchainStateExtra slice data");
    }

    // Skip shard_hashes
    if (slice.loadBit()) {
      slice.loadRef();
    }

    // Read config
    final configAddress = slice.loadUintBig(256);
    final config = _MasterchainStateExtraUtils.dict();
    config.loadFromClice(slice);

    return MasterchainStateExtra(
        configAddress: configAddress,
        config: config.asMap,
        globalBalance: CurrencyCollection.deserialize(slice));
  }
  factory MasterchainStateExtra.fromJson(Map<String, dynamic> json) {
    return MasterchainStateExtra(
        configAddress: BigintUtils.parse(json["config_address"]),
        config: (json["config_address"] as Map)
            .map((key, value) => MapEntry(key, Cell.fromBase64(value))),
        globalBalance: CurrencyCollection.fromJson(json["global_balance"]));
  }

  @override
  void store(Builder builder) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "config_address": configAddress.toString(),
      "config": config.map((key, value) => MapEntry(key, value.toBase64())),
      "global_balance": globalBalance.toJson()
    };
  }
}
