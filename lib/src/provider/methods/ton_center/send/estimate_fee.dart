import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';
import 'package:ton_dart/src/provider/models/response/estimate_fee_response.dart';

/// Estimate fees required for query processing. body, init-code and init-data accepted in serialized format (b64-encoded).
/// https://toncenter.com/api/v2/#/send/estimate_fee_estimateFee_post
class TonCenterEstimateFee
    extends TonCenterPostRequest<EstimateFeeResponse, Map<String, dynamic>> {
  final String address;
  final String body;
  final String initCode;
  final String initData;
  final bool ignoreChksig;
  TonCenterEstimateFee(
      {required this.address,
      required this.body,
      required this.initCode,
      required this.initData,
      this.ignoreChksig = true});

  @override
  String get method => TonCenterMethods.estimateFee.name;

  @override
  Map<String, dynamic> params() {
    return {
      'address': address,
      'body': body,
      'init_code': initCode,
      'init_data': initData,
      'ignore_chksig': ignoreChksig
    };
  }

  @override
  EstimateFeeResponse onResonse(Map<String, dynamic> result) {
    return EstimateFeeResponse.fromJson(result);
  }
}
