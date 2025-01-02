import 'package:ton_dart/src/exception/exception.dart';

class JettonVerificationTypeResponse {
  final String _value;

  const JettonVerificationTypeResponse._(this._value);

  static const JettonVerificationTypeResponse whitelist =
      JettonVerificationTypeResponse._('whitelist');
  static const JettonVerificationTypeResponse blacklist =
      JettonVerificationTypeResponse._('blacklist');
  static const JettonVerificationTypeResponse none =
      JettonVerificationTypeResponse._('none');

  static const List<JettonVerificationTypeResponse> values = [
    whitelist,
    blacklist,
    none
  ];

  String get value => _value;

  static JettonVerificationTypeResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element._value == name,
      orElse: () => throw TonDartPluginException(
          'No JettonVerificationTypeResponse found with the provided name: $name'),
    );
  }
}
