import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';

class DomainRenewActionResponse with JsonSerialization {
  final String domain;
  final String contractAddress;
  final AccountAddressResponse renewer;

  const DomainRenewActionResponse(
      {required this.domain,
      required this.contractAddress,
      required this.renewer});

  factory DomainRenewActionResponse.fromJson(Map<String, dynamic> json) {
    return DomainRenewActionResponse(
      domain: json['domain'],
      contractAddress: json['contract_address'],
      renewer: AccountAddressResponse.fromJson(json["renewer"]),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'domain': domain,
      'contract_address': contractAddress,
      'renewer': renewer.toJson()
    };
  }
}
