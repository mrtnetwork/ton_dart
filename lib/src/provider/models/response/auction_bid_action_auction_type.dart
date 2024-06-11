class AuctionBidActionAuctionTypeResponse {
  final String _value;

  const AuctionBidActionAuctionTypeResponse._(this._value);

  static const AuctionBidActionAuctionTypeResponse dnsTon =
      AuctionBidActionAuctionTypeResponse._("DNS.ton");
  static const AuctionBidActionAuctionTypeResponse dnsTg =
      AuctionBidActionAuctionTypeResponse._("DNS.tg");
  static const AuctionBidActionAuctionTypeResponse numberTg =
      AuctionBidActionAuctionTypeResponse._("NUMBER.tg");
  static const AuctionBidActionAuctionTypeResponse getgems =
      AuctionBidActionAuctionTypeResponse._("getgems");

  static const List<AuctionBidActionAuctionTypeResponse> values = [
    dnsTon,
    dnsTg,
    numberTg,
    getgems,
  ];

  String get value => _value;

  static AuctionBidActionAuctionTypeResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element.value == name,
      orElse: () => throw Exception(
          "No AuctionBidActionAuctionTypeResponse found with the provided name: $name"),
    );
  }
}
