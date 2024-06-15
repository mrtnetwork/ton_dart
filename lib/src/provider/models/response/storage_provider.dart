import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

class StorageProviderResponse with JsonSerialization {
  final String address;
  final bool acceptNewContracts;
  final BigInt ratePerMBDay;
  final BigInt maxSpan;
  final BigInt minimalFileSize;
  final BigInt maximalFileSize;

  const StorageProviderResponse({
    required this.address,
    required this.acceptNewContracts,
    required this.ratePerMBDay,
    required this.maxSpan,
    required this.minimalFileSize,
    required this.maximalFileSize,
  });

  factory StorageProviderResponse.fromJson(Map<String, dynamic> json) {
    return StorageProviderResponse(
      address: json['address'],
      acceptNewContracts: json['accept_new_contracts'],
      ratePerMBDay: BigintUtils.parse(json['rate_per_mb_day']),
      maxSpan: BigintUtils.parse(json['max_span']),
      minimalFileSize: BigintUtils.parse(json['minimal_file_size']),
      maximalFileSize: BigintUtils.parse(json['maximal_file_size']),
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() => {
        'address': address,
        'accept_new_contracts': acceptNewContracts,
        'rate_per_mb_day': ratePerMBDay.toString(),
        'max_span': maxSpan.toString(),
        'minimal_file_size': minimalFileSize.toString(),
        'maximal_file_size': maximalFileSize.toString(),
      };
}
