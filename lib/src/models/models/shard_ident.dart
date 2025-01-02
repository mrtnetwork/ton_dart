import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L384
// shard_ident$00 shard_pfx_bits:(#<= 60)
// workchain_id:int32 shard_prefix:uint64 = ShardIdent;
class ShardIdent extends TonSerialization {
  final int shardPrefixBits;
  final int workchainId;
  final BigInt shardPrefix;
  const ShardIdent({
    required this.shardPrefixBits,
    required this.workchainId,
    required this.shardPrefix,
  });
  factory ShardIdent.deserialize(Slice slice) {
    final shardIdent = slice.loadUint(2);
    if (shardIdent != 0) {
      throw const TonDartPluginException('Invalid ShardIdent slice.');
    }
    return ShardIdent(
      shardPrefixBits: slice.loadUint(6),
      workchainId: slice.loadInt(32),
      shardPrefix: slice.loadUintBig(64),
    );
  }
  factory ShardIdent.fromJson(Map<String, dynamic> json) {
    return ShardIdent(
      shardPrefixBits: json['shard_prefix_bits'],
      workchainId: json['workchain_id'],
      shardPrefix: BigintUtils.parse(json['shard_prefix']),
    );
  }

  @override
  void store(Builder builder) {
    builder.storeUint(0, 2);
    builder.storeUint(shardPrefixBits, 6);
    builder.storeInt(workchainId, 32);
    builder.storeUint(shardPrefix, 64);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'shard_prefix_bits': shardPrefixBits,
      'workchain_id': workchainId,
      'shard_prefix': shardPrefix.toString()
    };
  }
}
