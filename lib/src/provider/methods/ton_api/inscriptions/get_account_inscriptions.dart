import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/inscription_balances.dart';

/// GetAccountInscriptions invokes getAccountInscriptions operation.
///
/// Get all inscriptions by owner address. It's experimental API and can be dropped in the future.
///
class TonApiGetAccountInscriptions extends TonApiRequestParam<
    InscriptionBalancesResponse, Map<String, dynamic>> {
  final String accountId;

  /// default: 100
  final int? limit;

  /// default: 0
  final int? offset;

  TonApiGetAccountInscriptions(
      {required this.accountId, this.limit, this.offset});

  @override
  String get method => TonApiMethods.getaccountinscriptions.url;

  @override
  List<String> get pathParameters => [accountId];

  @override
  Map<String, dynamic> get queryParameters =>
      {"limit": limit, "offset": offset};

  @override
  InscriptionBalancesResponse onResonse(Map<String, dynamic> json) {
    return InscriptionBalancesResponse.fromJson(json);
  }
}
