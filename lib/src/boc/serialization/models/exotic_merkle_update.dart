import 'package:blockchain_utils/utils/utils.dart';

class ExoticMerkleUpdate {
  final int depth1;
  final int depth2;
  final List<int> proof1;
  final List<int> proof2;
  ExoticMerkleUpdate(
      {required this.depth1,
      required this.depth2,
      required List<int> proof1,
      required List<int> proof2})
      : proof1 = BytesUtils.toBytes(proof1, unmodifiable: true),
        proof2 = BytesUtils.toBytes(proof2, unmodifiable: true);
}
