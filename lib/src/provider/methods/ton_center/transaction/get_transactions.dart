import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get transaction history of a given address.
/// https://toncenter.com/api/v2/#/accounts/get_transactions_getTransactions_get
class TonCenterGetTransactions extends TonCenterPostRequestParam<
    List<Map<String, dynamic>>, List<Map<String, dynamic>>> {
  /// Identifier of target TON account in any form.
  final String address;

  /// Maximum number of transactions in response.
  final int? limit;

  /// Logical time of transaction to start with, must be sent with hash.
  final int? lt;

  /// Hash of transaction to start with, in base64 or hex encoding , must be sent with lt.
  final String? hash;

  /// Logical time of transaction to finish with (to get tx from lt to toLt).
  final int? toLt;

  /// By default getTransaction request is processed by any available liteserver. If archival=true only liteservers with full history are used.
  final bool? archival;
  TonCenterGetTransactions(
      {required this.address,
      this.limit,
      this.lt,
      this.hash,
      this.toLt,
      this.archival});

  @override
  String get method => TonCenterMethods.getTransactions.name;

  @override
  Map<String, dynamic> params() {
    return {
      "address": address,
      "limit": limit,
      "lt": lt,
      "hash": hash,
      "to_lt": toLt,
      "archival": archival
    };
  }
}
