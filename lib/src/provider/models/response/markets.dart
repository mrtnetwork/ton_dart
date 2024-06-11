import 'package:ton_dart/src/serialization/serialization.dart';

import 'market_ton_rates.dart';

class MarketsResponse with JsonSerialization {
  final List<MarketTonRatesResponse> nftItems;

  const MarketsResponse({required this.nftItems});

  factory MarketsResponse.fromJson(Map<String, dynamic> json) {
    return MarketsResponse(
        nftItems: (json['markets'] as List)
            .map((item) => MarketTonRatesResponse.fromJson(item))
            .toList());
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {'markets': nftItems.map((item) => item.toJson()).toList()};
  }
}
