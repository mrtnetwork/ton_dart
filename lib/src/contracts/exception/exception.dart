import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:ton_dart/src/serialization/identifiers.dart';
import 'package:ton_dart/src/exception/ton.dart';

/// the repository of exceptions
class TonContractExceptionConst {
  /// contract state is not active (freez or inActive)
  static const TonContractException stateIsInactive = TonContractException(
    'Unable to read contract data. The contract is not active.',
  );
  static const TonContractException stateIsFrozen = TonContractException(
    'Unable to read contract data. The contract is frozen.',
  );

  /// operation body deserialization failed.
  static TonContractException unknownBody(
    String name, {
    String? message,
    String? trace,
  }) => TonContractException(
    'Unknown $name operation body',
    details: {'message': message, 'trace': trace}
      ..removeWhere((k, v) => v == null),
  );

  /// cannot parse json
  static TonContractException invalidJson(
    String name, {
    String? message,
    String? trace,
    Map? data,
  }) => TonContractException(
    'Provided json is not valid for $name',
    details: {'message': message, 'trace': trace}
      ..removeWhere((k, v) => v == null),
  );

  /// cannot find operation from given id.
  static TonContractException invalidOperationId({Object? tag}) =>
      TonContractException(
        'Unknow or unsupported operation.',
        details: {'tag': tag?.toString()},
      );

  /// operation is not valid
  static TonContractException incorrectOperation({
    required String expected,
    required String got,
  }) => TonContractException(
    'Incorrect operation.',
    details: {'expected': expected, 'got': got},
  );
}

/// exception related to ton contracts.
class TonContractException extends BaseTonDartPluginException {
  const TonContractException(super.message, {super.details});

  factory TonContractException.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: TonSerializationIdentifiers.tonContractError,
      cborBytes: bytes,
      cborObject: obj,
    );
    return TonContractException(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  TonSerializationIdentifiers get serializationIdentifier =>
      TonSerializationIdentifiers.tonContractError;
}
