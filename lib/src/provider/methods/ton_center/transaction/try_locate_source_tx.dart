import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Locate incoming transaction of source address by outcoming message.
/// https://toncenter.com/api/v2/#/transactions/get_try_locate_source_tx_tryLocateSourceTx_get
class TonCenterTryLocateSourceTx extends TonCenterPostRequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  final String source;
  final String destination;
  final int createdLt;

  TonCenterTryLocateSourceTx(
      {required this.source,
      required this.destination,
      required this.createdLt});

  @override
  String get method => TonCenterMethods.tryLocateSourceTx.name;

  @override
  Map<String, dynamic> params() {
    return {
      "source": source,
      "destination": destination,
      "created_lt": createdLt
    };
  }
}
