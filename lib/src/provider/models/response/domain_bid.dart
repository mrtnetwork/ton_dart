import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'account_address.dart';

class DomainBidResponse with JsonSerialization {
  final bool success;
  final BigInt value;
  final BigInt txTime;
  final String txHash;
  final AccountAddressResponse bidder;

  const DomainBidResponse(
      {required this.success,
      required this.value,
      required this.txTime,
      required this.txHash,
      required this.bidder});

  factory DomainBidResponse.fromJson(Map<String, dynamic> json) {
    return DomainBidResponse(
      success: json['success'],
      value: BigintUtils.parse(json['value']),
      txTime: BigintUtils.parse(json['txTime']),
      txHash: json['txHash'],
      bidder: AccountAddressResponse.fromJson(json['bidder']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'value': value.toString(),
      'txTime': txTime.toString(),
      'txHash': txHash,
      'bidder': bidder.toJson()
    };
  }
}
