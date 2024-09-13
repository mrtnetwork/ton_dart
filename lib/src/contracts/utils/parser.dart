import 'package:ton_dart/src/contracts/exception/exception.dart';

class TonModelParser {
  static T parseJson<T>(
      {required T Function() parse, required String name, Map? data}) {
    try {
      return parse();
    } on TonContractException {
      rethrow;
    } catch (e, t) {
      throw TonContractExceptionConst.invalidJson(name,
          data: data, message: e.toString(), trace: t.toString());
    }
  }

  static T parseBoc<T>(
      {required T Function() parse, required String name, Map? data}) {
    try {
      return parse();
    } on TonContractException {
      rethrow;
    } catch (e, t) {
      throw TonContractExceptionConst.unknownBody(name,
          message: e.toString(), trace: t.toString());
    }
  }
}
