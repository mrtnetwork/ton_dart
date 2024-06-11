class VersionedWalletAccountPrams {
  final int? subwallet;
  final List<int> publicKey;
  final int seqno;
  const VersionedWalletAccountPrams(
      {required this.subwallet, required this.publicKey, required this.seqno});
}
