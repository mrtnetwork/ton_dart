import 'package:blockchain_utils/exception/exception.dart';
import 'package:blockchain_utils/string/string.dart';
import 'package:ton_dart/src/provider/utils/utils.dart';

enum RequestMethod { post, put, get }

enum ApiType { tonApi, tonCenter }

/// An abstract class representing request parameters for TonApi API calls.
abstract class TonApiRequestParams {
  /// method for the request.
  abstract final String method;
  const TonApiRequestParams();
}

/// An abstract class representing request parameters for TonApi API calls.
abstract class TonApiRequestParam<RESULT, RESPONSE>
    implements TonApiRequestParams {
  /// Converts the response result to the specified type [RESULT].
  RESULT onResonse(RESPONSE json) {
    return json as RESULT;
  }

  /// list of path parameters variable
  final List<String> pathParameters = [];

  /// map of query parameters
  final Map<String, dynamic> queryParameters = {};

  /// map of header
  final Map<String, String?> header = {};

  /// Converts the request parameters to [TonRequestInfo] with a unique identifier.
  TonRequestInfo toRequest(int v) {
    final pathParams = TonApiUtils.extractParams(method);
    if (pathParams.length != pathParameters.length) {
      throw MessageException("Invalid Path Parameters.", details: {
        "pathParams": pathParameters,
        "excepted": pathParams.length,
        "method": method
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
      if (queries.isNotEmpty) {
        params = Uri(path: params, queryParameters: queries).toString();
      }
    }

    return TonRequestInfo(
      id: v,
      pathParams: params,
      apiType: ApiType.tonApi,
      header: Map<String, String>.fromEntries(header.entries
          .where((element) => element.value != null)
          .toList()
          .cast()),
    );
  }
}

/// An abstract class representing post request parameters for TonApi API calls.
abstract class TonApiPostRequestParam<RESULT, RESPONSE>
    extends TonApiRequestParam<RESULT, RESPONSE> {
  abstract final Object? body;

  RequestMethod get requestType => RequestMethod.post;

  @override
  TonRequestInfo toRequest(int v) {
    final request = super.toRequest(v);
    Object? b = body;
    if (body != null) {
      if (body is Map) {
        b = StringUtils.fromJson(body!);
      }
    }
    return request.copyWith(body: b, requestType: requestType);
  }
}

/// An abstract class representing post request parameters for TonApi API calls.
abstract class TonCenterPostRequestParam<RESULT, RESPONSE>
    extends TonApiRequestParam<RESULT, RESPONSE> {
  Map<String, dynamic> params();

  @override
  TonRequestInfo toRequest(int v) {
    final Map<String, dynamic> jsonRpc = {
      "method": method,
      "params": params()..removeWhere((key, value) => value == null),
      "id": "$v",
      "jsonrpc": "2.0"
    };
    return TonRequestInfo(
        id: v,
        pathParams: method,
        apiType: ApiType.tonCenter,
        body: StringUtils.fromJson(jsonRpc),
        requestType: RequestMethod.post);
  }
}

/// Represents the details of a TonApi request.
class TonRequestInfo {
  /// Constructs a new [TonRequestInfo] instance with the specified parameters.
  const TonRequestInfo(
      {required this.id,
      required this.pathParams,
      required this.apiType,
      this.header = const {},
      this.requestType = RequestMethod.get,
      this.body});

  TonRequestInfo copyWith(
      {int? id,
      String? pathParams,
      RequestMethod? requestType,
      Map<String, String>? header,
      Object? body,
      ApiType? apiType}) {
    return TonRequestInfo(
        id: id ?? this.id,
        pathParams: pathParams ?? this.pathParams,
        requestType: requestType ?? this.requestType,
        header: header ?? this.header,
        body: body ?? this.body,
        apiType: apiType ?? this.apiType);
  }

  /// Unique identifier for the request.
  final int id;

  /// URL path parameters
  final String pathParams;

  final RequestMethod requestType;

  final Map<String, String> header;

  final Object? body;

  final ApiType apiType;

  /// Generates the complete request URL by combining the base URI and method-specific URI.
  String url({String? tonApiUrl, String? tonCenterUrl}) {
    String? url;
    if (apiType == ApiType.tonApi) {
      url = tonApiUrl;
    } else {
      url = tonCenterUrl;
    }
    if (url == null) {
      throw MessageException("API URL does not set for ${apiType.name}");
    }

    if (url.endsWith("/")) {
      url = url.substring(0, url.length - 1);
    }
    if (apiType == ApiType.tonCenter) return url;
    return "$url$pathParams";
  }
}
