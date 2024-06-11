import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/dns_expiring.dart';

/// GetAccountDnsExpiring invokes getAccountDnsExpiring operation.
///
/// Get expiring account .ton dns.
///
class TonApiGetAccountDnsExpiring
    extends TonApiRequestParam<DnsExpiringResponse, Map<String, dynamic>> {
  final String accountId;
  final int? period;
  TonApiGetAccountDnsExpiring({required this.accountId, this.period});
  @override
  String get method => TonApiMethods.getaccountdnsexpiring.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters => {"period": period.toString()};

  @override
  DnsExpiringResponse onResonse(Map<String, dynamic> json) {
    return DnsExpiringResponse.fromJson(json);
  }
}
