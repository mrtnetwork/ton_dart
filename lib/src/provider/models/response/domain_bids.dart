import 'package:ton_dart/src/serialization/serialization.dart';
import 'domain_bid.dart';

class DomainBidsResponse with JsonSerialization {
  final List<DomainBidResponse> data;

  const DomainBidsResponse({
    required this.data,
  });

  factory DomainBidsResponse.fromJson(Map<String, dynamic> json) {
    return DomainBidsResponse(
        data: (json['data'] as List<dynamic>)
            .map((item) => DomainBidResponse.fromJson(item))
            .toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {'data': data.map((bid) => bid.toJson()).toList()};
  }
}
