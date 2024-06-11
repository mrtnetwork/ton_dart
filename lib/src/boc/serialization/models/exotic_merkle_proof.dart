import 'package:blockchain_utils/binary/binary.dart';

class ExoticMerkleProof {
  final int proofDepth;
  final List<int> proofHash;
  ExoticMerkleProof({required this.proofDepth, required List<int> proofHash})
      : proofHash = BytesUtils.toBytes(proofHash, unmodifiable: true);
}
