import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/methods.dart';

/// GetRawTime invokes getRawTime operation.
///
/// Get raw time.
///
class TonApiGetRawTime extends TonApiRequest<BigInt, Map<String, dynamic>> {
  @override
  String get method => TonApiMethods.getrawtime.url;

  @override
  BigInt onResonse(Map<String, dynamic> result) {
    return BigintUtils.parse(result['time']);
  }
}
