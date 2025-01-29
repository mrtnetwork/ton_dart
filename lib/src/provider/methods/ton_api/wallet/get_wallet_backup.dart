import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// GetWalletBackup invokes getWalletBackup operation.
///
/// Get backup info.
///
class TonApiGetWalletBackup
    extends TonApiRequest<String, Map<String, dynamic>> {
  final String xTonConnectAuth;
  TonApiGetWalletBackup(this.xTonConnectAuth);
  @override
  String get method => TonApiMethods.getwalletbackup.url;

  @override
  Map<String, String?> get headers => {'X-TonConnect-Auth': xTonConnectAuth};

  @override
  String onResonse(Map<String, dynamic> result) {
    return result['dump'];
  }
}
