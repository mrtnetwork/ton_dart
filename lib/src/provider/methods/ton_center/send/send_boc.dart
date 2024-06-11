import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Send serialized boc file: fully packed and serialized external message to blockchain.
/// https://toncenter.com/api/v2/#/send/send_boc_sendBoc_post
class TonCenterSendBoc extends TonCenterPostRequestParam<Map<String, dynamic>,
    Map<String, dynamic>> {
  final String boc;
  TonCenterSendBoc(this.boc);

  @override
  String get method => TonCenterMethods.sendBoc.name;

  @override
  Map<String, dynamic> params() {
    return {"boc": boc};
  }
}
