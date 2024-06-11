import 'package:ton_dart/src/serialization/serialization.dart';

class TokenRatesResponse with JsonSerialization {
  final Map<String, double>? prices;
  final Map<String, String>? diff24h;
  final Map<String, String>? diff7d;
  final Map<String, String>? diff30d;

  const TokenRatesResponse(
      {this.prices, this.diff24h, this.diff7d, this.diff30d});

  factory TokenRatesResponse.fromJson(Map<String, dynamic> json) {
    return TokenRatesResponse(
      prices: (json['prices'] as Map?)?.cast(),
      diff24h: (json['diff_24h'] as Map?)?.cast(),
      diff7d: (json['diff_7d'] as Map?)?.cast(),
      diff30d: (json['diff_30d'] as Map?)?.cast(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'prices': prices,
      'diff_24h': diff24h,
      'diff_7d': diff7d,
      'diff_30d': diff30d
    };
  }
}
