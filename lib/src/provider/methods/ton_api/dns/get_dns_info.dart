import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/domain_info.dart';

/// GetDnsInfo invokes getDnsInfo operation.
///
/// Get full information about domain name.
///
class TonApiGetDnsInfo
    extends TonApiRequest<DomainInfoResponse, Map<String, dynamic>> {
  /// domain name with .ton or .t.me
  final String domainName;
  TonApiGetDnsInfo(this.domainName);
  @override
  String get method => TonApiMethods.getdnsinfo.url;

  @override
  List<String> get pathParameters => [domainName];

  @override
  DomainInfoResponse onResonse(Map<String, dynamic> result) {
    return DomainInfoResponse.fromJson(result);
  }
}
