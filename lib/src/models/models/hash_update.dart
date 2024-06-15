import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class _HashUpdateConst {
  static const int prefix = 0x72;
}

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L273/
/// update_hashes#72 {X:Type} old_hash:bits256 new_hash:bits256
///  = HASH_UPDATE X;
class HashUpdate extends TonSerialization {
  final List<int> oldHash;
  final List<int> newHash;
  HashUpdate({required List<int> oldHash, required List<int> newHash})
      : oldHash = BytesUtils.toBytes(oldHash, unmodifiable: true),
        newHash = BytesUtils.toBytes(newHash, unmodifiable: true);
  factory HashUpdate.deserialize(Slice slice) {
    final prefix = slice.loadUint(8);
    if (prefix != _HashUpdateConst.prefix) {
      throw TonDartPluginException("Invalid HashUpdate prefix.",
          details: {"excepted": _HashUpdateConst.prefix, "prefix": prefix});
    }
    return HashUpdate(
        oldHash: slice.loadBuffer(32), newHash: slice.loadBuffer(32));
  }
  factory HashUpdate.fromJson(Map<String, dynamic> json) {
    return HashUpdate(
      oldHash: BytesUtils.fromHexString(json["old_hash"]),
      newHash: BytesUtils.fromHexString(json["new_hash"]),
    );
  }

  @override
  void store(Builder builder) {
    builder.storeUint(_HashUpdateConst.prefix, 8);
    builder.storeBuffer(oldHash);
    builder.storeBuffer(newHash);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "old_hash": BytesUtils.toHexString(oldHash),
      "new_hash": BytesUtils.toHexString(newHash)
    };
  }
}
