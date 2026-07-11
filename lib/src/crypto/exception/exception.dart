import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:ton_dart/src/serialization/identifiers.dart';
import 'package:ton_dart/src/exception/ton.dart';

class KeyException extends BaseTonDartPluginException {
  const KeyException(super.message, {super.details});
  factory KeyException.deserialize({List<int>? bytes, CborObject? obj}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: TonSerializationIdentifiers.tonKeyError,
      cborBytes: bytes,
      cborObject: obj,
    );
    return KeyException(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  TonSerializationIdentifiers get serializationIdentifier =>
      TonSerializationIdentifiers.tonKeyError;
}
