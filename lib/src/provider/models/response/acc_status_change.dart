import 'package:ton_dart/src/exception/exception.dart';

class AccStatusChangeResponse {
  final String _value;

  const AccStatusChangeResponse._(this._value);

  static const AccStatusChangeResponse acstUnchanged =
      AccStatusChangeResponse._("acst_unchanged");
  static const AccStatusChangeResponse acstFrozen =
      AccStatusChangeResponse._("acst_frozen");
  static const AccStatusChangeResponse acstDeleted =
      AccStatusChangeResponse._("acst_deleted");

  static const List<AccStatusChangeResponse> values = [
    acstUnchanged,
    acstFrozen,
    acstDeleted,
  ];

  String get value => _value;

  static AccStatusChangeResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element._value == name,
      orElse: () => throw TonDartPluginException(
          "No AccStatusChangeResponse found with the provided name: $name"),
    );
  }
}
