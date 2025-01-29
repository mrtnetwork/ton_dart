import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/dns_record.dart';

/// DnsResolve invokes dnsResolve operation.
///
/// DNS resolve for domain name.
///
class TonApiDnsResolve
    extends TonApiRequest<DnsRecordResponse, Map<String, dynamic>> {
  final String domainName;
  TonApiDnsResolve(this.domainName);
  @override
  String get method => TonApiMethods.dnsresolve.url;

  @override
  List<String> get pathParameters => [domainName];

  @override
  DnsRecordResponse onResonse(Map<String, dynamic> result) {
    return DnsRecordResponse.fromJson(result);
  }
}
