import 'package:ton_dart/src/serialization/serialization.dart';
import 'market_ton_rates.dart';

class MarketsRatesResponse with JsonSerialization {
  final List<MarketTonRatesResponse> markets;

  const MarketsRatesResponse({required this.markets});

  factory MarketsRatesResponse.fromJson(Map<String, dynamic> json) {
    return MarketsRatesResponse(
        markets: (json['markets'] as List)
            .map((i) => MarketTonRatesResponse.fromJson(i))
            .toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {"markets": markets.map((v) => v.toJson()).toList()};
  }
}
