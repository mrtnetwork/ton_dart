import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';
import 'package:ton_dart/src/provider/models/response/run_method_response.dart';

/// Run get method on smart contract.
/// https://toncenter.com/api/v2/#/run%20method/run_get_method_runGetMethod_post
class TonCenterRunGetMethod extends TonCenterPostRequestParam<
    TonCenterRunMethodResponse, Map<String, dynamic>> {
  final String address;
  final String methodName;
  final List<dynamic> stack;
  TonCenterRunGetMethod(
      {required this.address, required this.methodName, required this.stack});

  @override
  String get method => TonCenterMethods.runGetMethod.name;

  @override
  Map<String, dynamic> params() {
    return {"address": address, "method": methodName, "stack": stack};
  }

  @override
  TonCenterRunMethodResponse onResonse(Map<String, dynamic> json) {
    return TonCenterRunMethodResponse.fromJson(json);
  }
}
