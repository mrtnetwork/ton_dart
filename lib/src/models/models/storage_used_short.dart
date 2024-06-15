import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L225
/// storage_used_short$_ cells:(VarUInteger 7)
/// bits:(VarUInteger 7) = StorageUsedShort;
class StorageUsedShort implements TonSerialization {
  final BigInt cells;
  final BigInt bits;
  const StorageUsedShort({required this.cells, required this.bits});
  factory StorageUsedShort.deserialize(Slice slice) {
    return StorageUsedShort(
      cells: slice.loadVarUintBig(3),
      bits: slice.loadVarUintBig(3),
    );
  }
  factory StorageUsedShort.fromJson(Map<String, dynamic> json) {
    return StorageUsedShort(
      cells: BigintUtils.parse(json["cells"]),
      bits: BigintUtils.parse(json["bits"]),
    );
  }

  @override
  void store(Builder builder) {
    builder.storeVarUint(cells, 3);
    builder.storeVarUint(bits, 3);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "cells": cells.toString(),
      "bits": bits.toString(),
    };
  }
}
