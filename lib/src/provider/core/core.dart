import 'package:blockchain_utils/service/models/params.dart';
import 'package:blockchain_utils/utils/string/string.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';
import 'package:ton_dart/src/provider/utils/utils.dart';

enum RequestMethod { post, put, get }

class TonApiType {
  final String name;
  const TonApiType._(this.name);
  static const TonApiType tonApi = TonApiType._('Ton API');
  static const TonApiType tonCenter = TonApiType._('Ton Center');
  static const List<TonApiType> values = [tonApi, tonCenter];
  bool get isTonCenter => this == tonCenter;

  factory TonApiType.fromValue(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw TonDartPluginException(
          'Cannot find TonApiType from provided name',
          details: {'name': name}),
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
  RequestServiceType get requestType => RequestServiceType.get;

  /// map of query parameters
  final Map<String, dynamic> queryParameters = {};

  /// map of header
  final Map<String, String?> headers = {};

  /// Converts the request parameters to [TonRequestDetails] with a unique identifier.
  @override
  TonRequestDetails buildRequest(int v) {
    final pathParams = TonApiUtils.extractParams(method);
    if (pathParams.length != pathParameters.length) {
      throw TonDartPluginException('Invalid Path Parameters.', details: {
        'pathParams': pathParameters,
        'excepted': pathParams.length,
        'method': method
      });
    }
    String params = method;
    for (int i = 0; i < pathParams.length; i++) {
      params = params.replaceFirst(pathParams[i], pathParameters[i]);
    }
    if (queryParameters.isNotEmpty) {
      final Map<String, dynamic> queries =
          Map<String, dynamic>.from(queryParameters)
            ..removeWhere((key, value) => value == null);
      for (final i in queries.entries) {
        if (i.value is List) continue;
        queries[i.key] = i.value.toString();
      }
      if (queries.isNotEmpty) {
        params = Uri(path: params, queryParameters: queries).toString();
      }
    }
    final headers = Map.from(this.headers)..removeWhere((k, v) => v == null);
    return TonRequestDetails(
      requestID: v,
      pathParams: params,
      type: requestType,
      apiType: TonApiType.tonApi,
      headers: headers.cast<String, String>(),
    );
  }
}

/// An abstract class representing post request parameters for TonApi API calls.
abstract class TonApiPostRequest<RESULT, RESPONSE>
    extends TonApiRequest<RESULT, RESPONSE> {
  abstract final Map<String, dynamic>? body;

  @override
  RequestServiceType get requestType => RequestServiceType.post;

  @override
  TonRequestDetails buildRequest(int v) {
    final request = super.buildRequest(v);
    return request.copyWith(jsonBody: body, type: requestType);
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
      'jsonrpc': '2.0'
    };
    final headers = Map.from(this.headers)..removeWhere((k, v) => v == null);
    return TonRequestDetails(
        requestID: v,
        pathParams: TonCenterMethods.tonCenterV2BaseUrl,
        apiType: TonApiType.tonCenter,
        jsonBody: jsonBody,
        headers: headers.cast<String, String>(),
        type: RequestServiceType.post,
        isJsonRpc: true);
  }
}

/// An abstract class representing request parameters for TonApi API calls.
abstract class TonCenterV3RequestParam<RESULT, RESPONSE>
    extends TonApiRequest<RESULT, RESPONSE> {
  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(apiType: TonApiType.tonCenter);
  }
}

abstract class TonCenterV3PostRequestParam<RESULT, RESPONSE>
    extends TonApiPostRequest<RESULT, RESPONSE> {
  @override
  TonRequestDetails buildRequest(int v) {
    final request = super.buildRequest(v);
    return request.copyWith(apiType: TonApiType.tonCenter);
  }
}

/// Represents the details of a TonApi request.
class TonRequestDetails extends BaseServiceRequestParams {
  /// Constructs a new [TonRequestDetails] instance with the specified parameters.
  const TonRequestDetails(
      {required super.requestID,
      required super.headers,
      required super.type,
      required this.pathParams,
      required this.apiType,
      this.jsonBody,
      this.isJsonRpc = false});

  TonRequestDetails copyWith(
      {int? requestID,
      String? pathParams,
      RequestServiceType? type,
      Map<String, String>? headers,
      Map<String, dynamic>? jsonBody,
      TonApiType? apiType,
      bool? isJsonRpc}) {
    return TonRequestDetails(
      requestID: requestID ?? this.requestID,
      pathParams: pathParams ?? this.pathParams,
      jsonBody: jsonBody ?? this.jsonBody,
      headers: headers ?? this.headers,
      type: type ?? this.type,
      apiType: apiType ?? this.apiType,
      isJsonRpc: isJsonRpc ?? this.isJsonRpc,
    );
  }

  /// URL path parameters
  final String pathParams;

  final Map<String, dynamic>? jsonBody;

  final TonApiType apiType;

  final bool isJsonRpc;

  /// Generates the complete request URL by combining the base URI and method-specific URI.
  @override
  Uri toUri(String uri) {
    if (uri.endsWith('/')) {
      uri = uri.substring(0, uri.length - 1);
    }
    return Uri.parse('$uri$pathParams');
  }

  @override
  List<int>? body() {
    if (jsonBody == null) return null;
    return StringUtils.encode(StringUtils.fromJson(jsonBody!));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': requestID,
      'api': apiType.name,
      'body': jsonBody,
      'pathParameters': pathParams,
      'type': type.name
    };
  }
}
