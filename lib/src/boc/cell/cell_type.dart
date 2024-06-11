class CellType {
  final String name;
  final int tag;

  const CellType._(this.tag, this.name);
  static const CellType ordinary = CellType._(-1, "Ordinary");
  static const CellType prunedBranch = CellType._(1, "PrunedBranch");
  static const CellType library = CellType._(2, "Library");
  static const CellType merkleProof = CellType._(3, "MerkleProof");
  static const CellType merkleUpdate = CellType._(4, "MerkleUpdate");
  static const List<CellType> values = [
    ordinary,
    prunedBranch,
    library,
    merkleProof,
    merkleUpdate
  ];

  static CellType? fromValue(int? tag) {
    try {
      return values.firstWhere((element) => element.tag == tag);
    } on StateError {
      return null;
    }
  }

  @override
  String toString() {
    return "CellType.$name";
  }
}
