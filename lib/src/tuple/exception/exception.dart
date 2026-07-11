import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:ton_dart/src/serialization/identifiers.dart';
import 'package:ton_dart/src/exception/ton.dart';

/// Exception class for errors related to tuple processing.
class TupleException extends BaseTonDartPluginException {
  /// Creates a new instance of TupleException.
  ///
  /// [message] - The error message associated with the exception.
  /// [details] - Optional additional details about the error. This can include any context-specific information.
  const TupleException(super.message, {super.details});

  factory TupleException.deserialize({List<int>? bytes, CborObject? obj}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: TonSerializationIdentifiers.tonTuppleError,
      cborBytes: bytes,
      cborObject: obj,
    );
    return TupleException(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  TonSerializationIdentifiers get serializationIdentifier =>
      TonSerializationIdentifiers.tonTuppleError;
}
