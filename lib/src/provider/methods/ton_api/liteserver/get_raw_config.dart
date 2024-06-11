import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';
import 'package:ton_dart/src/provider/models/response/raw_config.dart';

/// GetRawConfig invokes getRawConfig operation.
///
/// Get raw config.
///
class TonApiGetRawConfig
    extends TonApiRequestParam<RawConfigResponse, Map<String, dynamic>> {
  /// (-1,8000000000000000,4234234,3E575DAB1D25...90D8,47192E5C46C...BB29)
  final String blockId;
  final int mode;
  TonApiGetRawConfig({required this.blockId, required this.mode});

  @override
  String get method => TonApiMethods.getrawconfig.url;

  @override
  List<String> get pathParameters => [blockId];

  @override
  Map<String, dynamic> get queryParameters => {"mode": mode};

  @override
  RawConfigResponse onResonse(Map<String, dynamic> json) {
    return RawConfigResponse.fromJson(json);
  }
}
