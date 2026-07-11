import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:ton_dart/src/serialization/identifiers.dart';
import 'package:ton_dart/src/exception/ton.dart';

class TokenMetadataException extends BaseTonDartPluginException {
  const TokenMetadataException(super.message, {super.details});
  factory TokenMetadataException.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: TonSerializationIdentifiers.tonTokenMetadataError,
      cborBytes: bytes,
      cborObject: obj,
    );
    return TokenMetadataException(
      values.rawValueAt(0),
      details: values.maybeRawMapAt<String, String?>(1),
    );
  }

  @override
  TonSerializationIdentifiers get serializationIdentifier =>
      TonSerializationIdentifiers.tonTokenMetadataError;
}
