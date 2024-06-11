import 'package:ton_dart/src/provider/core/ton_center_methods.dart';
import 'package:ton_dart/src/provider/models/response/run_method_response.dart';
import 'package:ton_dart/src/provider/provider.dart';

/// Run get method on smart contract.
/// https://toncenter.com/api/v2/#/run%20method/run_get_method_runGetMethod_post
class TonCenterRunGetMethod
    extends TonCenterPostRequestParam<RunMethodResponse, Map<String, dynamic>> {
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
  RunMethodResponse onResonse(Map<String, dynamic> json) {
    if (json["exit_code"] != 0) {
      throw TonApiError(
          "Unable to execute get method. exit_code: ${json["exit_code"]}",
          request: params());
    }
    return RunMethodResponse.fromJson(json);
  }
}
