import 'package:ton_dart/src/exception/exception.dart';

class SendMode {
  final String name;
  final int mode;
  const SendMode._(this.mode, this.name);

  static const SendMode carryAllRemainingBalance =
      SendMode._(128, "carryAllRemainingBalance");
  static const SendMode carryAllRemainingIncomingValue =
      SendMode._(64, "carryAllRemainingIncomingValue");
  static const SendMode destroyAccountIfZero =
      SendMode._(32, "destroyAccountIfZero");
  static const SendMode payGasSeparately = SendMode._(1, "payGasSeparately");
  static const SendMode ignoreErrors = SendMode._(2, "ignoreErrors");
  static const SendMode none = SendMode._(0, "none");
  static const List<SendMode> values = [
    carryAllRemainingBalance,
    carryAllRemainingIncomingValue,
    destroyAccountIfZero,
    payGasSeparately,
    ignoreErrors,
    none
  ];
  factory SendMode.fromValue(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw TonDartPluginException(
          "Cannot find SendMode from provided name",
          details: {"name": name}),
    );
  }
  factory SendMode.fromMode(int? mode) {
    return values.firstWhere(
      (element) => element.mode == mode,
      orElse: () => throw TonDartPluginException(
          "Cannot find SendMode from provided mode",
          details: {"mode": mode}),
    );
  }
  @override
  String toString() {
    return "SendMode.$name";
  }
}
