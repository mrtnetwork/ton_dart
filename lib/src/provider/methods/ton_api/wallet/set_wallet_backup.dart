import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// SetWalletBackup invokes setWalletBackup operation.
///
/// Set backup info.
///
class TonApiSetWalletBackup
    extends TonApiPostRequestParam<Null, Map<String, dynamic>> {
  @override
  Object get body => BytesUtils.fromHexString(backup);
  final String xTonConnectAuth;
  final String backup;
  TonApiSetWalletBackup({required this.xTonConnectAuth, required this.backup});

  @override
  String get method => TonApiMethods.setwalletbackup.url;

  @override
  RequestMethod get requestType => RequestMethod.put;

  @override
  Map<String, String?> get header => {"X-TonConnect-Auth": xTonConnectAuth};
}
