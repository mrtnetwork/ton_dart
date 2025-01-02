import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class StorageUsed extends TonSerialization {
  final BigInt cells;
  final BigInt bits;
  final BigInt publicCells;
  const StorageUsed(
      {required this.cells, required this.bits, required this.publicCells});
  factory StorageUsed.deserialize(Slice slice) {
    return StorageUsed(
      cells: slice.loadVarUintBig(3),
      bits: slice.loadVarUintBig(3),
      publicCells: slice.loadVarUintBig(3),
    );
  }
  factory StorageUsed.fromJson(Map<String, dynamic> json) {
    return StorageUsed(
      cells: BigintUtils.parse(json['cells']),
      bits: BigintUtils.parse(json['bits']),
      publicCells: BigintUtils.parse(json['public_cells']),
    );
  }

  @override
  void store(Builder builder) {
    builder.storeVarUint(cells, 3);
    builder.storeVarUint(bits, 3);
    builder.storeVarUint(publicCells, 3);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'cells': cells.toString(),
      'bits': bits.toString(),
      'public_cells': publicCells.toString()
    };
  }
}
