import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

import 'auction.dart';

class AuctionsResponse with JsonSerialization {
  final List<AuctionResponse> data;
  final BigInt total;

  const AuctionsResponse({required this.data, required this.total});

  factory AuctionsResponse.fromJson(Map<String, dynamic> json) {
    return AuctionsResponse(
        data: List<AuctionResponse>.from(
            json['data'].map((x) => AuctionResponse.fromJson(x))),
        total: BigintUtils.parse(json['total']));
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data.map((auction) => auction.toJson()).toList(),
      'total': total.toString(),
    };
  }
}
