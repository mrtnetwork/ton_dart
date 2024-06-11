import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';
import 'nft_item.dart';
import 'nft_purchase_action_auction_type.dart';
import 'price.dart';

class NftPurchaseActionResponse with JsonSerialization {
  final NftPurchaseActionAuctionTypeResponse auctionType;
  final PriceResponse amount;
  final NftItemResponse nft;
  final AccountAddressResponse seller;
  final AccountAddressResponse buyer;

  const NftPurchaseActionResponse({
    required this.auctionType,
    required this.amount,
    required this.nft,
    required this.seller,
    required this.buyer,
  });

  factory NftPurchaseActionResponse.fromJson(Map<String, dynamic> json) {
    return NftPurchaseActionResponse(
      auctionType:
          NftPurchaseActionAuctionTypeResponse.fromName(json['auction_type']),
      amount: PriceResponse.fromJson(json['amount']),
      nft: NftItemResponse.fromJson(json['nft']),
      seller: AccountAddressResponse.fromJson(json['seller']),
      buyer: AccountAddressResponse.fromJson(json['buyer']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'auction_type': auctionType.value,
      'amount': amount.toJson(),
      'nft': nft.toJson(),
      'seller': seller.toJson(),
      'buyer': buyer.toJson(),
    };
  }
}
