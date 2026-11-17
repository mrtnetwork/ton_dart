import 'package:ton_dart/src/error/ton_error.dart';
import 'package:blockchain_utils/blockchain_utils.dart';

class TonModelParser {
  static T parseJson<T>({
    required T Function() parse,
    required String name,
    Map? data,
  }) {
    try {
      return parse();
    } on BuError {
      rethrow;
    } catch (e, t) {
      throw TonContractErrors.invalidJson(
        name,
        data: data,
        message: e.toString(),
        trace: t.toString(),
      );
    }
  }

  static T parseBoc<T>({
    required T Function() parse,
    required String name,
    Map? data,
  }) {
    try {
      return parse();
    } on BuError {
      rethrow;
    } catch (e, t) {
      throw TonContractErrors.unknownBody(
        name,
        message: e.toString(),
        trace: t.toString(),
      );
    }
  }
}
