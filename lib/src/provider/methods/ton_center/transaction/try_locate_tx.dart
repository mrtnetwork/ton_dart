import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Locate outcoming transaction of destination address by incoming message
/// https://toncenter.com/api/v2/#/transactions/get_try_locate_tx_tryLocateTx_get
class TonCenterTryLocateTx
    extends TonCenterPostRequest<Map<String, dynamic>, Map<String, dynamic>> {
  final String source;
  final String destination;
  final int createdLt;

  TonCenterTryLocateTx(
      {required this.source,
      required this.destination,
      required this.createdLt});

  @override
  String get method => TonCenterMethods.tryLocateTx.name;

  @override
  Map<String, dynamic> params() {
    return {
      'source': source,
      'destination': destination,
      'created_lt': createdLt,
    };
  }
}
