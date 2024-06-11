import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/boc/serialization/models/level_mask.dart';
import 'package:ton_dart/src/boc/cell/cell_type.dart';

class ResolvedCellResult {
  final CellType type;
  final List<List<int>> hashes;
  final List<int> depths;
  final LevelMask mask;
  ResolvedCellResult(
      {required this.type,
      required List<List<int>> hashes,
      required List<int> depths,
      required this.mask})
      : hashes = List<List<int>>.unmodifiable(
            hashes.map((e) => BytesUtils.toBytes(e, unmodifiable: true))),
        depths = List<int>.unmodifiable(depths);
}
