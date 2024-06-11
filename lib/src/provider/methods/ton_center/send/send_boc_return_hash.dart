import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Send serialized boc file: fully packed and serialized external
/// message to blockchain. The method returns message hash
/// https://toncenter.com/api/v2/#/send/send_boc_return_hash_sendBocReturnHash_post
class TonCenterSendBocReturnHash extends TonCenterPostRequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  final String boc;
  TonCenterSendBocReturnHash(this.boc);

  @override
  String get method => TonCenterMethods.sendBocReturnHash.name;

  @override
  Map<String, dynamic> params() {
    return {"boc": boc};
  }
}
