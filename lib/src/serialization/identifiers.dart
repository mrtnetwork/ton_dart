import 'package:blockchain_utils/blockchain_utils.dart';

enum TonSerializationIdentifiers implements SerializationIdentifier {
  tornAddressfriendly(18001),
  tornAddressraw(18002),
  tonPluginError(18003),
  tonKeyError(18004),
  tonDictError(18005),
  tonContractError(18006),
  tonBocError(18007),
  tonTokenMetadataError(18008),
  tonTuppleError(18009),
  tonConnectRequest(18010),
  tonConnectEvent(18011),
  tonConnectSubscription(18012);

  @override
  final int id;
  const TonSerializationIdentifiers(this.id);

  static TonSerializationIdentifiers fromIdentifier(int? value) {
    return values.firstWhere(
      (e) => e.id == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching TonSerializationIdentifiers found for the given value. null"),
    );
  }

  @override
  bool isValid(int? tag) {
    return tag == id;
  }
}
