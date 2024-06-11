import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Send query - unpacked external message. This method takes address, body and init-params (if any),
/// packs it to external message and sends to network. All params should be boc-serialized.
/// https://toncenter.com/api/v2/#/send/send_query_sendQuery_post
class TonCenterSendQuery extends TonCenterPostRequestParam<Map<String, dynamic>,
    Map<String, dynamic>> {
  final String address;
  final String body;
  final String initCode;
  final String initData;
  TonCenterSendQuery(
      {required this.address,
      required this.body,
      required this.initCode,
      required this.initData});

  @override
  String get method => TonCenterMethods.sendQuery.name;

  @override
  Map<String, dynamic> params() {
    return {
      "address": address,
      "body": body,
      "init_code": initCode,
      "init_data": initData
    };
  }
}
