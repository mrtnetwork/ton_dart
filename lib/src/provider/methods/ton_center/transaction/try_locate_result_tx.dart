import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Same as tryLocateTx. Locate outcoming transaction of destination address by incoming message
/// https://toncenter.com/api/v2/#/transactions/get_try_locate_result_tx_tryLocateResultTx_get
class TonCenterTryLocateResultTx
    extends TonCenterPostRequest<Map<String, dynamic>, Map<String, dynamic>> {
  final String source;
  final String destination;
  final int createdLt;

  TonCenterTryLocateResultTx(
      {required this.source,
      required this.destination,
      required this.createdLt});

  @override
  String get method => TonCenterMethods.tryLocateResultTx.name;

  @override
  Map<String, dynamic> params() {
    return {
      'source': source,
      'destination': destination,
      'created_lt': createdLt,
    };
  }
}
