import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/serialization/identifiers.dart';

/// Request parameters for the TON Connect HTTP bridge.
///
/// Unlike [TonRequestDetails] (tonApi/tonCenter, `api: TonApiType`),
/// the bridge base URL is per-wallet and carried by the injected
/// service: [encodeUrl] appends [path] to whatever base the wallet
/// configured (e.g. `https://bridge.tonapi.io/bridge`).
class TonConnectRequestDetails extends BaseServiceRequestParams {
  const TonConnectRequestDetails({
    required super.requestID,
    required super.path,
    required super.responseEncoding,
    required super.headers,
    super.successStatusCodes,
    super.errorStatusCodes = const [400, 404, 500],
    required super.requestMethod,
    super.bodyBytes,
    super.bodyString,
  }) : super(network: BlockchainNetwork.ton);

  factory TonConnectRequestDetails.deserialize({
    List<int>? bytes,
    CborObject? obj,
  }) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: TonSerializationIdentifiers.tonConnectRequest,
      cborBytes: bytes,
      cborObject: obj,
    );
    return TonConnectRequestDetails(
      headers: values
          .mapAt<CborStringValue, CborStringValue>(0)
          .map((k, v) => MapEntry(k.value, v.value)),
      requestMethod: RequestMethod.fromValue(values.rawValueAt(1)),
      responseEncoding: ServiceReponseEncoding.fromValue(values.rawValueAt(2)),
      successStatusCodes:
          values
              .listAt<CborIntValue>(3)
              .map((e) => e.value)
              .toList()
              .emptyAsNull,
      errorStatusCodes:
          values
              .listAt<CborIntValue>(4)
              .map((e) => e.value)
              .toList()
              .emptyAsNull,
      bodyBytes: values.rawValueAt(5),
      bodyString: values.rawValueAt(6),
      path: values.rawValueAt(7),
      requestID: values.rawValueAt(8),
    );
  }

  TonConnectRequestDetails copyWith({
    int? requestID,
    String? path,
    RequestMethod? requestMethod,
    Map<String, String>? headers,
    List<int>? bodyBytes,
    String? bodyString,
    ServiceReponseEncoding? responseEncoding,
    List<int>? errorStatusCodes,
    List<int>? successStatusCodes,
  }) {
    return TonConnectRequestDetails(
      requestID: requestID ?? this.requestID,
      headers: headers ?? this.headers,
      path: path ?? this.path,
      responseEncoding: responseEncoding ?? this.responseEncoding,
      requestMethod: requestMethod ?? this.requestMethod,
      bodyString: bodyString ?? this.bodyString,
      errorStatusCodes: errorStatusCodes ?? this.errorStatusCodes,
      bodyBytes: bodyBytes ?? this.bodyBytes,
      successStatusCodes: successStatusCodes ?? this.successStatusCodes,
    );
  }

  @override
  Uri encodeUrl(String url) {
    var base = url;
    if (base.endsWith('/')) {
      base = base.substring(0, base.length - 1);
    }
    return Uri.parse('$base${path ?? ''}');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': requestID,
      'body': bodyString ?? BytesUtils.tryToHexString(bodyBytes),
      'path': path,
      'type': requestMethod.name,
    };
  }

  @override
  TonSerializationIdentifiers get serializationIdentifier =>
      TonSerializationIdentifiers.tonConnectRequest;

  @override
  List<CborObject?> get serializationItems => [
    CborMapValue.definite(
      headers.map((k, v) => MapEntry(CborStringValue(k), CborStringValue(v))),
    ),
    requestMethod.value.toCbor(),
    responseEncoding.value.toCbor(),
    CborTagSerializable.listFromDynamic(
      successStatusCodes?.map((e) => CborIntValue(e)).toList() ?? [],
    ),
    CborTagSerializable.listFromDynamic(
      errorStatusCodes?.map((e) => CborIntValue(e)).toList() ?? [],
    ),
    bodyBytes?.toCborBytes(),
    bodyString?.toCbor(),
    path?.toCbor(),
    requestID.toCbor(),
  ];
}
