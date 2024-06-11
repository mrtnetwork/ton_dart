import 'package:ton_dart/src/serialization/serialization.dart';
import 'wallet_dns.dart';

class DnsRecordResponse with JsonSerialization {
  final WalletDNSResponse? wallet;
  final String? nextResolver;
  final List<String> sites;
  final String? storage;

  const DnsRecordResponse({
    required this.wallet,
    required this.nextResolver,
    required this.sites,
    required this.storage,
  });

  factory DnsRecordResponse.fromJson(Map<String, dynamic> json) {
    return DnsRecordResponse(
      wallet: json['wallet'] == null
          ? null
          : WalletDNSResponse.fromJson(json['wallet']),
      nextResolver: json['next_resolver'],
      sites: List<String>.from(json['sites']),
      storage: json['storage'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'wallet': wallet?.toJson(),
      'next_resolver': nextResolver,
      'sites': sites,
      'storage': storage
    };
  }
}
