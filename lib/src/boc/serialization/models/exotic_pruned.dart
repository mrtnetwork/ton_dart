import 'package:blockchain_utils/utils/utils.dart';

class Pruned {
  final List<int> hash;
  final int depth;
  Pruned({required List<int> hash, required this.depth})
      : hash = BytesUtils.toBytes(hash, unmodifiable: true);
}

class ExoticPruned {
  final int mask;
  final List<Pruned> pruned;

  ExoticPruned({required this.mask, required this.pruned});
}
