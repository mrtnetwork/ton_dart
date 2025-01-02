import 'package:ton_dart/src/exception/exception.dart';

class TonContractExceptionConst {
  static const TonContractException stateIsInactive = TonContractException(
      'Unable to read contract data. The contract is not active.');
  static TonContractException unknownBody(String name,
          {String? message, String? trace}) =>
      TonContractException('Unknown $name operation body',
          details: {'message': message, 'trace': trace}
            ..removeWhere((k, v) => v == null));
  static TonContractException invalidJson(String name,
          {String? message, String? trace, Map? data}) =>
      TonContractException('Provided json is not valid for $name',
          details: {'message': message, 'trace': trace, 'data': data}
            ..removeWhere((k, v) => v == null));
  static TonContractException invalidOperationId({Object? tag}) =>
      TonContractException('Unknow or unsupported operation.',
          details: {'tag': tag});
  static TonContractException incorrectOperation(
          {required String excepted, required String got}) =>
      TonContractException('Incorrect operation.',
          details: {'excepted': excepted, 'got': got});
}

class TonContractException extends TonDartPluginException {
  const TonContractException(super.message, {super.details});
}
