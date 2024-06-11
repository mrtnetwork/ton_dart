import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';
import 'auction_bid_action_auction_type.dart';
import 'nft_item.dart';
import 'price.dart';

class AuctionBidActionResponse with JsonSerialization {
  final AuctionBidActionAuctionTypeResponse auctionType;
  final PriceResponse amount;
  final NftItemResponse? nft;
  final AccountAddressResponse bidder;
  final AccountAddressResponse auction;

  const AuctionBidActionResponse(
      {required this.auctionType,
      required this.amount,
      this.nft,
      required this.bidder,
      required this.auction});

  factory AuctionBidActionResponse.fromJson(Map<String, dynamic> json) {
    return AuctionBidActionResponse(
      auctionType:
          AuctionBidActionAuctionTypeResponse.fromName(json['auction_type']),
      amount: PriceResponse.fromJson(json['amount']),
      nft: json['nft'] != null ? NftItemResponse.fromJson(json['nft']) : null,
      bidder: AccountAddressResponse.fromJson(json['bidder']),
      auction: AccountAddressResponse.fromJson(json['auction']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'auction_type': auctionType,
      'amount': amount.toJson(),
      'bidder': bidder.toJson(),
      'auction': auction.toJson(),
      'nft': nft?.toJson()
    };
  }
}
