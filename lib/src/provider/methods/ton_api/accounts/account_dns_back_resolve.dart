import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/domain_names.dart';

/// AccountDnsBackResolve invokes accountDnsBackResolve operation.
///
/// Get account's domains.
///
class TonApiAccountDnsBackResolve
    extends TonApiRequestParam<DomainNamesResponse, Map<String, dynamic>> {
  final String accountId;
  TonApiAccountDnsBackResolve(this.accountId);
  @override
  String get method => TonApiMethods.accountdnsbackresolve.url;

  @override
  List<String> get pathParameters => [accountId];
  @override
  DomainNamesResponse onResonse(Map<String, dynamic> json) {
    return DomainNamesResponse.fromJson(json);
  }
}
