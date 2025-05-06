import 'package:ton_dart/src/exception/exception.dart';

class AccountStatusResponse {
  final String _value;

  const AccountStatusResponse._(this._value);

  static const AccountStatusResponse nonexist =
      AccountStatusResponse._('nonexist');
  static const AccountStatusResponse uninit = AccountStatusResponse._('uninit');
  static const AccountStatusResponse active = AccountStatusResponse._('active');
  static const AccountStatusResponse frozen = AccountStatusResponse._('frozen');

  static const List<AccountStatusResponse> values = [
    nonexist,
    uninit,
    active,
    frozen,
  ];

  String get value => _value;

  bool get isActive => this == active || this == frozen;
  bool get isFrozen => this == frozen;

  static AccountStatusResponse fromName(String? name) {
    if (name == 'uninitialized') return AccountStatusResponse.uninit;
    return values.firstWhere(
      (element) => element.value == name,
      orElse: () => throw TonDartPluginException(
          'No AccountStatusResponse found with the provided name: $name'),
    );
  }
}
