import 'package:ton_dart/src/exception/exception.dart';

/// the repository of exceptions
class TonContractExceptionConst {
  /// contract state is not active (freez or inActive)
  static const TonContractException stateIsInactive = TonContractException(
      'Unable to read contract data. The contract is not active.');

  /// operation body deserialization failed.
  static TonContractException unknownBody(String name,
          {String? message, String? trace}) =>
      TonContractException('Unknown $name operation body',
          details: {'message': message, 'trace': trace}
            ..removeWhere((k, v) => v == null));

  /// cannot parse json
  static TonContractException invalidJson(String name,
          {String? message, String? trace, Map? data}) =>
      TonContractException('Provided json is not valid for $name',
          details: {'message': message, 'trace': trace, 'data': data}
            ..removeWhere((k, v) => v == null));

  /// cannot find operation from given id.
  static TonContractException invalidOperationId({Object? tag}) =>
      TonContractException('Unknow or unsupported operation.',
          details: {'tag': tag});

  /// operation is not valid
  static TonContractException incorrectOperation(
          {required String excepted, required String got}) =>
      TonContractException('Incorrect operation.',
          details: {'excepted': excepted, 'got': got});
}

/// exception related to ton contracts.
class TonContractException extends TonDartPluginException {
  const TonContractException(super.message, {super.details});
}
