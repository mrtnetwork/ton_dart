import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:blockchain_utils/cbor/serialization/cbor/cbor.dart';
import 'package:blockchain_utils/cbor/serialization/cbor/tag.dart';
import 'package:ton_dart/src/exception/ton.dart';
import 'package:ton_dart/src/serialization/identifiers.dart';

class TonDartPluginException extends BaseTonDartPluginException {
  const TonDartPluginException(super.message, {super.details});
  factory TonDartPluginException.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: TonSerializationIdentifiers.tonPluginError,
      cborBytes: bytes,
      cborObject: obj,
    );
    return TonDartPluginException(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  TonSerializationIdentifiers get serializationIdentifier =>
      TonSerializationIdentifiers.tonPluginError;
}
