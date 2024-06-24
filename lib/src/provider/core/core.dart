import 'package:blockchain_utils/utils/string/string.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';
import 'package:ton_dart/src/provider/utils/utils.dart';

enum RequestMethod { post, put, get }

class TonApiType {
  final String name;
  const TonApiType._(this.name);
  static const TonApiType tonApi = TonApiType._("tonApi");
  static const TonApiType tonCenter = TonApiType._("tonCenter");
  static const List<TonApiType> values = [tonApi, tonCenter];
  bool get isTonCenter => this == tonCenter;

  factory TonApiType.fromValue(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw TonDartPluginException(
          "Cannot find TonApiType from provided name",
          details: {"name": name}),
    );
  }
}

/// An abstract class representing request parameters for TonApi API calls.
abstract class TonApiRequestParams {
  /// method for the request.
  abstract final String method;
  TonRequestInfo toRequest(int v);
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
  @override
  TonRequestInfo toRequest(int v) {
    final pathParams = TonApiUtils.extractParams(method);
    if (pathParams.length != pathParameters.length) {
      throw TonDartPluginException("Invalid Path Parameters.", details: {
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
      for (final i in queries.entries) {
        if (i.value is List) continue;
        queries[i.key] = i.value.toString();
      }
      if (queries.isNotEmpty) {
        params = Uri(path: params, queryParameters: queries).toString();
      }
    }

    return TonRequestInfo(
      id: v,
      pathParams: params,
      apiType: TonApiType.tonApi,
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
        pathParams: TonCenterMethods.tonCenterV2BaseUrl,
        apiType: TonApiType.tonCenter,
        body: StringUtils.fromJson(jsonRpc),
        requestType: RequestMethod.post,
        isJsonRpc: true);
  }
}

/// An abstract class representing request parameters for TonApi API calls.
abstract class TonCenterV3RequestParam<RESULT, RESPONSE>
    extends TonApiRequestParam<RESULT, RESPONSE> {
  @override
  TonRequestInfo toRequest(int v) {
    return super.toRequest(v).copyWith(apiType: TonApiType.tonCenter);
  }
}

abstract class TonCenterV3PostRequestParam<RESULT, RESPONSE>
    extends TonApiPostRequestParam<RESULT, RESPONSE> {
  @override
  TonRequestInfo toRequest(int v) {
    final request = super.toRequest(v);
    return request.copyWith(apiType: TonApiType.tonCenter);
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
      this.body,
      this.isJsonRpc = false});

  TonRequestInfo copyWith(
      {int? id,
      String? pathParams,
      RequestMethod? requestType,
      Map<String, String>? header,
      Object? body,
      TonApiType? apiType,
      bool? isJsonRpc}) {
    return TonRequestInfo(
        id: id ?? this.id,
        pathParams: pathParams ?? this.pathParams,
        requestType: requestType ?? this.requestType,
        header: header ?? this.header,
        body: body ?? this.body,
        apiType: apiType ?? this.apiType,
        isJsonRpc: isJsonRpc ?? this.isJsonRpc);
  }

  /// Unique identifier for the request.
  final int id;

  /// URL path parameters
  final String pathParams;

  final RequestMethod requestType;

  final Map<String, String> header;

  final Object? body;

  final TonApiType apiType;

  final bool isJsonRpc;

  /// Generates the complete request URL by combining the base URI and method-specific URI.
  String url({String? tonApiUrl, String? tonCenterUrl}) {
    String? url;
    if (apiType == TonApiType.tonApi) {
      url = tonApiUrl;
    } else {
      url = tonCenterUrl;
    }
    if (url == null) {
      throw TonDartPluginException("API URL does not set for ${apiType.name}");
    }

    if (url.endsWith("/")) {
      url = url.substring(0, url.length - 1);
    }
    return "$url$pathParams";
  }
}
