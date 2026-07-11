import 'package:blockchain_utils/cbor/cbor.dart';
import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:blockchain_utils/helper/helper.dart';
import 'package:blockchain_utils/networks/types/network.dart';
import 'package:blockchain_utils/service/const/constant.dart';
import 'package:blockchain_utils/service/models/params.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';
import 'package:ton_dart/src/provider/utils/utils.dart';

// enum RequestMethod { post, put, get }

enum TonApiType {
  tonApi(0, "Ton API"),
  tonCenter(1, "Ton Center");

  final int id;
  final String tr;
  const TonApiType(this.id, this.tr);
  bool get isTonCenter => this == tonCenter;
  factory TonApiType.fromId(int? id) {
    return values.firstWhere(
      (element) => element.id == id,
      orElse: () => throw ItemNotFoundException(name: "TonApiType"),
    );
  }

  factory TonApiType.fromName(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw ItemNotFoundException(name: "TonApiType"),
    );
  }
}

/// An abstract class representing request parameters for TonApi API calls.
abstract class TonApiRequest<RESULT, RESPONSE>
    extends BaseServiceRequest<RESULT, RESPONSE, TonRequestDetails> {
  abstract final String method;

  /// list of path parameters variable
  final List<String> pathParameters = [];
  @override
  RequestMethod get requestMethod => RequestMethod.get;

  /// map of query parameters
  final Map<String, dynamic> queryParameters = {};

  /// map of header
  final Map<String, String?> headers = {};

  /// Converts the request parameters to [TonRequestDetails] with a unique identifier.
  @override
  TonRequestDetails buildRequest(int v) {
    final pathParams = TonApiUtils.extractParams(method);
    if (pathParams.length != pathParameters.length) {
      throw TonDartPluginException(
        'Invalid Path Parameters.',
        details: {
          'pathParams': pathParameters.join(","),
          'expected': pathParams.length.toString(),
          'method': method,
        },
      );
    }
    String params = method;
    for (int i = 0; i < pathParams.length; i++) {
      params = params.replaceFirst(pathParams[i], pathParameters[i]);
    }
    if (queryParameters.isNotEmpty) {
      final Map<String, dynamic> queries = Map<String, dynamic>.from(
        queryParameters,
      )..removeWhere((key, value) => value == null);
      for (final i in queries.entries) {
        if (i.value is List) continue;
        queries[i.key] = i.value.toString();
      }
      if (queries.isNotEmpty) {
        params = Uri(path: params, queryParameters: queries).toString();
      }
    }
    return TonRequestDetails(
      requestID: v,
      path: params,
      headers: headers.notNullValue.cast<String, String>(),
      requestMethod: requestMethod,
      api: TonApiType.tonApi,
      responseEncoding: ServiceReponseEncoding.fromType<RESPONSE>(),
    );
  }
}

/// An abstract class representing post request parameters for TonApi API calls.
abstract class TonApiPostRequest<RESULT, RESPONSE>
    extends TonApiRequest<RESULT, RESPONSE> {
  abstract final Map<String, dynamic>? body;

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  TonRequestDetails buildRequest(int v) {
    final request = super.buildRequest(v);
    final body = this.body;
    return request.copyWith(
      bodyString: body == null ? null : StringUtils.fromJson(body),
      requestMethod: requestMethod,
      headers: ServiceConst.defaultPostHeaders,
    );
  }
}

/// An abstract class representing post request parameters for TonApi API calls.
abstract class TonCenterPostRequest<RESULT, RESPONSE>
    extends TonApiRequest<RESULT, RESPONSE> {
  Map<String, dynamic> params();

  @override
  TonRequestDetails buildRequest(int v) {
    final Map<String, dynamic> jsonBody = {
      'method': method,
      'params': params()..removeWhere((key, value) => value == null),
      'id': '$v',
      'jsonrpc': '2.0',
    };
    return TonRequestDetails(
      requestID: v,
      path: TonCenterMethods.tonCenterV2BaseUrl,
      api: TonApiType.tonCenter,
      bodyString: StringUtils.fromJson(jsonBody),
      responseEncoding: ServiceReponseEncoding.map,
      headers: headers.notNullValue.cast<String, String>(),
      requestMethod: RequestMethod.post,
      isJsonRpc: true,
    );
  }
}

/// An abstract class representing request parameters for TonApi API calls.
abstract class TonCenterV3RequestParam<RESULT, RESPONSE>
    extends TonApiRequest<RESULT, RESPONSE> {
  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }
}

abstract class TonCenterV3PostRequestParam<RESULT, RESPONSE>
    extends TonApiPostRequest<RESULT, RESPONSE> {
  @override
  TonRequestDetails buildRequest(int v) {
    final request = super.buildRequest(v);
    return request.copyWith(api: TonApiType.tonCenter);
  }
}

class TonRequestDetails extends BaseServiceRequestParams {
  final TonApiType api;
  final bool isJsonRpc;

  const TonRequestDetails({
    required super.requestID,
    required super.path,
    required super.responseEncoding,
    required super.headers,
    super.successStatusCodes,
    super.errorStatusCodes = const [404],
    required super.requestMethod,
    super.bodyBytes,
    super.bodyString,
    required this.api,
    this.isJsonRpc = false,
  }) : super(network: BlockchainNetwork.ton);
  factory TonRequestDetails.deserialize({List<int>? bytes, CborObject? obj}) {
    final values = CborTagSerializable.decodeTaggedValue(
      identifier: BlockchainNetwork.ton.identifier,
      cborBytes: bytes,
      cborObject: obj,
    );
    return TonRequestDetails(
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
      api: TonApiType.fromId(values.rawValueAt(9)),
      isJsonRpc: values.rawValueAt(10),
    );
  }
  TonRequestDetails copyWith({
    int? requestID,
    String? path,
    RequestMethod? requestMethod,
    Map<String, String>? headers,
    List<int>? bodyBytes,
    String? bodyString,
    ServiceReponseEncoding? responseEncoding,
    List<int>? errorStatusCodes,
    List<int>? successStatusCodes,
    TonApiType? api,
    bool? isJsonRpc,
  }) {
    return TonRequestDetails(
      requestID: requestID ?? this.requestID,
      headers: headers ?? this.headers,
      path: path ?? this.path,
      responseEncoding: responseEncoding ?? this.responseEncoding,
      requestMethod: requestMethod ?? this.requestMethod,
      bodyString: bodyString ?? this.bodyString,
      errorStatusCodes: errorStatusCodes ?? this.errorStatusCodes,
      bodyBytes: bodyBytes ?? this.bodyBytes,
      successStatusCodes: successStatusCodes ?? this.successStatusCodes,
      api: api ?? this.api,
      isJsonRpc: isJsonRpc ?? this.isJsonRpc,
    );
  }

  @override
  Uri encodeUrl(String uri) {
    if (uri.endsWith('/')) {
      uri = uri.substring(0, uri.length - 1);
    }
    return Uri.parse('$uri${path ?? ''}');
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': requestID,
      'api': api.name,
      'body': bodyString ?? BytesUtils.tryToHexString(bodyBytes),
      'path': path,
      'type': requestMethod.name,
    };
  }

  @override
  List<int>? encodeBody({ServiceProtocol protocol = ServiceProtocol.http}) {
    assert(protocol.isHttp, "Unsupported protocol.");
    return super.encodeBody(protocol: protocol);
  }

  @override
  SerializationIdentifier get serializationIdentifier =>
      BlockchainNetwork.ton.identifier;

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
    api.id.toCbor(),
    isJsonRpc.toCbor(),
  ];
}
