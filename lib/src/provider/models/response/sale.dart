import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';
import 'price.dart';

class SaleResponse with JsonSerialization {
  final String address;
  final AccountAddressResponse market;
  final AccountAddressResponse? owner;
  final PriceResponse price;

  const SaleResponse(
      {required this.address,
      required this.market,
      this.owner,
      required this.price});

  factory SaleResponse.fromJson(Map<String, dynamic> json) {
    return SaleResponse(
      address: json['address'],
      market: AccountAddressResponse.fromJson(json['market']),
      owner: json['owner'] != null
          ? AccountAddressResponse.fromJson(json['owner'])
          : null,
      price: PriceResponse.fromJson(json['price']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'market': market.toJson(),
      'price': price.toJson(),
      'owner': owner?.toJson()
    };
  }
}
