import 'package:ton_dart/src/serialization/serialization.dart';

class ContractDeployActionResponse with JsonSerialization {
  final String address;
  final List<String> interfaces;

  const ContractDeployActionResponse({
    required this.address,
    required this.interfaces,
  });

  factory ContractDeployActionResponse.fromJson(Map<String, dynamic> json) {
    return ContractDeployActionResponse(
      address: json['address'],
      interfaces: List<String>.from(json['interfaces']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'address': address, 'interfaces': interfaces};
  }
}
