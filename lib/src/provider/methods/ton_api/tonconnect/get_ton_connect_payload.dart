import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// GetTonConnectPayload invokes getTonConnectPayload operation.
///
/// Get a payload for further token receipt.
///
class TonApiGetTonConnectPayload
    extends TonApiRequest<String, Map<String, dynamic>> {
  @override
  String get method => TonApiMethods.gettonconnectpayload.url;

  @override
  String onResonse(Map<String, dynamic> result) {
    return result['payload'];
  }
}
