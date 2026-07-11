import 'package:blockchain_utils/utils/json/json.dart';
import 'package:ton_dart/src/boc/boc.dart';

class V2ConfigParamsResponse {
  final String bytes;
  const V2ConfigParamsResponse(this.bytes);
  factory V2ConfigParamsResponse.fromJson(Map<String, dynamic> json) {
    return V2ConfigParamsResponse(json.valueAs("bytes"));
  }

  Cell asCell() => Cell.fromBase64(bytes);

  Slice asSlice() => asCell().beginParse();
}
