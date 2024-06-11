import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

class MarketTonRatesResponse with JsonSerialization {
  final String market;
  final double usdPrice;
  final BigInt lastDateUpdate;

  const MarketTonRatesResponse(
      {required this.market,
      required this.usdPrice,
      required this.lastDateUpdate});

  factory MarketTonRatesResponse.fromJson(Map<String, dynamic> json) {
    return MarketTonRatesResponse(
      market: json['market'],
      usdPrice: json['usd_price'],
      lastDateUpdate: BigintUtils.parse(json['last_date_update']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'market': market,
        'usd_price': usdPrice,
        'last_date_update': lastDateUpdate.toString()
      };
}
