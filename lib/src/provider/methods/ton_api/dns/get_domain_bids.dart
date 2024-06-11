import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/domain_bids.dart';

/// GetDomainBids invokes getDomainBids operation.
///
/// Get domain bids.
///
class TonApiGetDomainBids
    extends TonApiRequestParam<DomainBidsResponse, Map<String, dynamic>> {
  /// domain name with .ton or .t.me
  final String domainName;
  TonApiGetDomainBids(this.domainName);

  @override
  String get method => TonApiMethods.getdomainbids.url;

  @override
  List<String> get pathParameters => [domainName];

  @override
  DomainBidsResponse onResonse(Map<String, dynamic> json) {
    return DomainBidsResponse.fromJson(json);
  }
}
