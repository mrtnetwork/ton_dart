class HighloadWalletV3AccountParams {
  final List<int> publicKey;
  final int timeout;
  final int subWalletId;
  const HighloadWalletV3AccountParams(
      {required this.publicKey,
      required this.timeout,
      required this.subWalletId});
}
