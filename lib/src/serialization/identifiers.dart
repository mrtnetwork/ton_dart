import 'package:blockchain_utils/cbor/serialization/cbor/tag.dart';
import 'package:blockchain_utils/exception/exception/blockchain_utils.dart';

enum TonSerializationIdentifiers implements SerializationIdentifier {
  tornAddressfriendly(18001),
  tornAddressraw(18002),
  tonPluginError(18003),
  tonKeyError(18004),
  tonDictError(18005),
  tonContractError(18006),
  tonBocError(18007),
  tonTokenMetadataError(18008),
  tonTuppleError(18009);

  @override
  final int id;
  const TonSerializationIdentifiers(this.id);

  static TonSerializationIdentifiers fromIdentifier(int? value) {
    return values.firstWhere(
      (e) => e.id == value,
      orElse:
          () =>
              throw ItemNotFoundException(name: "TonSerializationIdentifiers"),
    );
  }

  @override
  bool isValid(int? tag) {
    return tag == id;
  }
}
