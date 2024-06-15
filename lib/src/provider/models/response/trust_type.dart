import 'package:ton_dart/src/exception/exception.dart';

class TrustTypeResponse {
  final String _value;

  const TrustTypeResponse._(this._value);

  static const TrustTypeResponse whitelist = TrustTypeResponse._("whitelist");
  static const TrustTypeResponse graylist = TrustTypeResponse._("graylist");
  static const TrustTypeResponse blacklist = TrustTypeResponse._("blacklist");
  static const TrustTypeResponse none = TrustTypeResponse._("none");

  static const List<TrustTypeResponse> values = [
    whitelist,
    graylist,
    blacklist,
    none,
  ];

  String get value => _value;

  static TrustTypeResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element.value == name,
      orElse: () => throw TonDartPluginException(
          "No TrustTypeResponse found with the provided name: $name"),
    );
  }
}
