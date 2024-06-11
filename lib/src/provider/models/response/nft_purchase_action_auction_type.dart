class NftPurchaseActionAuctionTypeResponse {
  final String _value;

  const NftPurchaseActionAuctionTypeResponse._(this._value);

  static const NftPurchaseActionAuctionTypeResponse dnsTon =
      NftPurchaseActionAuctionTypeResponse._("DNS.ton");
  static const NftPurchaseActionAuctionTypeResponse dnsTg =
      NftPurchaseActionAuctionTypeResponse._("DNS.tg");
  static const NftPurchaseActionAuctionTypeResponse numberTg =
      NftPurchaseActionAuctionTypeResponse._("NUMBER.tg");
  static const NftPurchaseActionAuctionTypeResponse getgems =
      NftPurchaseActionAuctionTypeResponse._("getgems");

  static const List<NftPurchaseActionAuctionTypeResponse> values = [
    dnsTon,
    dnsTg,
    numberTg,
    getgems,
  ];

  String get value => _value;

  static NftPurchaseActionAuctionTypeResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element.value == name,
      orElse: () => throw Exception(
          "No NftPurchaseActionAuctionTypeResponse found with the provided name: $name"),
    );
  }
}
