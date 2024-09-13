/// The `CellType` class represents different types of cells with a unique tag and name.
/// This is used to define the types of cells in a system such as Merkle proofs, pruned branches, etc.
class CellType {
  /// The name of the cell type.
  final String name;

  /// The unique tag that identifies the cell type.
  final int tag;

  /// Private constructor to create a `CellType` with a specific [tag] and [name].
  const CellType._(this.tag, this.name);

  /// Represents an ordinary cell type with a tag of `-1`.
  static const CellType ordinary = CellType._(-1, "Ordinary");

  /// Represents a pruned branch cell type with a tag of `1`.
  static const CellType prunedBranch = CellType._(1, "PrunedBranch");

  /// Represents a library cell type with a tag of `2`.
  static const CellType library = CellType._(2, "Library");

  /// Represents a Merkle proof cell type with a tag of `3`.
  static const CellType merkleProof = CellType._(3, "MerkleProof");

  /// Represents a Merkle update cell type with a tag of `4`.
  static const CellType merkleUpdate = CellType._(4, "MerkleUpdate");

  /// A list containing all available cell types.
  static const List<CellType> values = [
    ordinary,
    prunedBranch,
    library,
    merkleProof,
    merkleUpdate
  ];

  /// Returns the corresponding `CellType` based on the provided [tag].
  /// If no matching tag is found, returns `null`.
  static CellType? fromValue(int? tag) {
    try {
      return values.firstWhere((element) => element.tag == tag);
    } on StateError {
      return null;
    }
  }

  /// Returns a string representation of the `CellType`.
  @override
  String toString() {
    return "CellType.$name";
  }
}
