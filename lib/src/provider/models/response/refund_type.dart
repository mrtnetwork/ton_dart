import 'package:ton_dart/src/exception/exception.dart';

class RefundTypeResponse {
  final String _value;

  const RefundTypeResponse._(this._value);

  static const RefundTypeResponse dnsTon = RefundTypeResponse._("DNS.ton");
  static const RefundTypeResponse dnsTG = RefundTypeResponse._("DNS.tg");
  static const RefundTypeResponse getGems = RefundTypeResponse._("GetGems");

  static const List<RefundTypeResponse> values = [
    dnsTon,
    dnsTG,
    getGems,
  ];

  String get value => _value;

  static RefundTypeResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element.value == name,
      orElse: () => throw TonDartPluginException(
          "No RefundTypeResponse found with the provided name: $name"),
    );
  }
}
