import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/service_status.dart';

/// Status invokes status operation.
///
/// Status.
///
class TonApiStatus
    extends TonApiRequest<ServiceStatusResponse, Map<String, dynamic>> {
  @override
  String get method => TonApiMethods.status.url;

  @override
  ServiceStatusResponse onResonse(Map<String, dynamic> result) {
    return ServiceStatusResponse.fromJson(result);
  }
}
