import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_v3_methods.dart';
import 'package:ton_dart/src/provider/models/response/estimate_fee_response.dart';

/// Estimate fees required for query processing. body, init-code and init-data accepted in serialized format (b64-encoded).
/// https://toncenter.com/api/v2/#/send/estimate_fee_estimateFee_post
class TonCenterV3EstimateFee extends TonCenterV3PostRequestParam<
    EstimateFeeResponse, Map<String, dynamic>> {
  final String address;
  final String messageBody;
  final String initCode;
  final String initData;
  final bool ignoreChksig;
  TonCenterV3EstimateFee(
      {required this.address,
      required this.messageBody,
      required this.initCode,
      required this.initData,
      this.ignoreChksig = true});

  @override
  Map<String, dynamic>? get body => {
        'address': address,
        'body': messageBody,
        'init_code': initCode,
        'init_data': initData,
        'ignore_chksig': ignoreChksig
      };

  @override
  String get method => TonCenterV3Methods.estimateFee.uri;

  @override
  EstimateFeeResponse onResonse(Map<String, dynamic> result) {
    return EstimateFeeResponse.fromJson(result);
  }
}
