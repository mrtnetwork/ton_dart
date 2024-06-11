import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// ReindexAccount invokes reindexAccount operation.
///
/// Update internal cache for a particular account.
///
class TonApiReindexAccount
    extends TonApiPostRequestParam<Null, Map<String, dynamic>> {
  final String accountId;
  TonApiReindexAccount(this.accountId);
  @override
  Object? get body => null;

  @override
  String get method => TonApiMethods.reindexaccount.url;

  @override
  List<String> get pathParameters => [accountId];
}
