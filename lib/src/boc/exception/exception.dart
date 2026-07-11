import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:ton_dart/src/serialization/identifiers.dart';
import 'package:ton_dart/src/exception/ton.dart';

/// Exception thrown for errors related to the Binary Object Container (BOC) operations.
///
/// This class extends `TonDartPluginException` to handle exceptions specific to BOC parsing
/// and manipulation. It allows for custom error messages and additional details.
class BocException extends BaseTonDartPluginException {
  /// Creates a new instance of `BocException`.
  ///
  /// [message] is the error message describing the exception.
  /// [details] is an optional map of additional details to include with the exception.
  const BocException(super.message, {super.details});
  factory BocException.deserialize({List<int>? bytes, CborObject? obj}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: TonSerializationIdentifiers.tonBocError,
      cborBytes: bytes,
      cborObject: obj,
    );
    return BocException(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  TonSerializationIdentifiers get serializationIdentifier =>
      TonSerializationIdentifiers.tonBocError;
}
