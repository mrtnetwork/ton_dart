import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L339
/// split_merge_info$_ cur_shard_pfx_len:(## 6)
///   acc_split_depth:(## 6) this_addr:bits256 sibling_addr:bits256
///   = SplitMergeInfo;
class SplitMergeInfo extends TonSerialization {
  final int currentShardPrefixLength;
  final int accountSplitDepth;
  final BigInt thisAddress;
  final BigInt siblingAddress;
  const SplitMergeInfo(
      {required this.currentShardPrefixLength,
      required this.accountSplitDepth,
      required this.thisAddress,
      required this.siblingAddress});
  factory SplitMergeInfo.fromJson(Map<String, dynamic> json) {
    return SplitMergeInfo(
        currentShardPrefixLength: json["current_shard_prefix_length"],
        accountSplitDepth: json["account_split_depth"],
        thisAddress: BigintUtils.parse(json["this_address"]),
        siblingAddress: BigintUtils.parse(json["sibling_address"]));
  }
  factory SplitMergeInfo.deserialize(Slice slice) {
    return SplitMergeInfo(
      currentShardPrefixLength: slice.loadUint(6),
      accountSplitDepth: slice.loadUint(6),
      thisAddress: slice.loadUintBig(256),
      siblingAddress: slice.loadUintBig(256),
    );
  }

  @override
  void store(Builder builder) {
    builder.storeUint(currentShardPrefixLength, 6);
    builder.storeUint(accountSplitDepth, 6);
    builder.storeUint(thisAddress, 256);
    builder.storeUint(siblingAddress, 256);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "current_shard_prefix_length": currentShardPrefixLength,
      "account_split_depth": accountSplitDepth,
      "this_address": thisAddress.toString(),
      "sibling_address": siblingAddress.toString()
    };
  }
}
