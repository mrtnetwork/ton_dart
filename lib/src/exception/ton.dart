import 'package:blockchain_utils/cbor/core/cbor.dart';
import 'package:blockchain_utils/cbor/serialization/cbor/exception.dart';
import 'package:blockchain_utils/cbor/serialization/cbor/tag.dart';
import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:blockchain_utils/networks/networks.dart';
import 'package:ton_dart/src/boc/exception/exception.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/crypto/exception/exception.dart';
import 'package:ton_dart/src/dict/exception/exception.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/serialization/identifiers.dart';
import 'package:ton_dart/src/tuple/exception/exception.dart';

abstract class BaseTonDartPluginException extends IException {
  const BaseTonDartPluginException(super.message, {super.details});
  factory BaseTonDartPluginException.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValueWithInfo(
      expectedTags: TonSerializationIdentifiers.values,
      cborBytes: bytes,
      cborObject: obj,
    );
    final identifier = values.identifier;
    return switch (identifier) {
      TonSerializationIdentifiers.tonPluginError =>
        TonDartPluginException.deserialize(obj: values.tag),
      TonSerializationIdentifiers.tonKeyError => KeyException.deserialize(
        obj: values.tag,
      ),
      TonSerializationIdentifiers.tonDictError => DictException.deserialize(
        obj: values.tag,
      ),
      TonSerializationIdentifiers.tonContractError =>
        TonContractException.deserialize(obj: values.tag),
      TonSerializationIdentifiers.tonBocError => BocException.deserialize(
        obj: values.tag,
      ),
      TonSerializationIdentifiers.tonTokenMetadataError =>
        TokenMetadataException.deserialize(obj: values.tag),
      TonSerializationIdentifiers.tonTuppleError => TupleException.deserialize(
        obj: values.tag,
      ),
      _ =>
        throw CborSerializableException.incorrectTagValue(tag: values.tag.tags),
    };
  }
  @override
  TonSerializationIdentifiers get serializationIdentifier;

  @override
  BlockchainNetwork get relatedNetwork => BlockchainNetwork.ton;
}
