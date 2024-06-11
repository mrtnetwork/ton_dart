import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class AuctionResponse with JsonSerialization {
  final String domain;
  final String owner;
  final BigInt price;
  final BigInt bids;
  final BigInt date;

  const AuctionResponse({
    required this.domain,
    required this.owner,
    required this.price,
    required this.bids,
    required this.date,
  });

  factory AuctionResponse.fromJson(Map<String, dynamic> json) {
    return AuctionResponse(
      domain: json['domain'],
      owner: json['owner'],
      price: BigintUtils.parse(json['price']),
      bids: BigintUtils.parse(json['bids']),
      date: BigintUtils.parse(json['date']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'domain': domain,
      'owner': owner,
      'price': price.toString(),
      'bids': bids.toString(),
      'date': date.toString(),
    };
  }
}
