class GetBlockchainAccountTransactionsSortOrder {
  final String name;
  const GetBlockchainAccountTransactionsSortOrder._(this.name);
  static const GetBlockchainAccountTransactionsSortOrder desc =
      GetBlockchainAccountTransactionsSortOrder._("desc");
  static const GetBlockchainAccountTransactionsSortOrder asc =
      GetBlockchainAccountTransactionsSortOrder._("asc");
}
