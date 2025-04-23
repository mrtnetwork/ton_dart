import 'package:ton_dart/src/exception/exception.dart';

class SendModeConst {
  static const int carryAllRemainingBalance = 128;
  static const int carryAllRemainingIncomingValue = 64;
  static const int destroyAccountIfZero = 32;
  static const int payGasSeparately = 1;
  static const int ignoreErrors = 2;
  static const int none = 0;
}

class SendMode {
  final String name;
  final int mode;
  const SendMode._(this.mode, this.name);

  /// Predefined constant for the mode that carries all the remaining balance.
  static const SendMode carryAllRemainingBalance = SendMode._(
      SendModeConst.carryAllRemainingBalance, 'carryAllRemainingBalance');

  /// Predefined constant for the mode that carries all remaining incoming value.
  static const SendMode carryAllRemainingIncomingValue = SendMode._(
      SendModeConst.carryAllRemainingIncomingValue,
      'carryAllRemainingIncomingValue');

  /// Predefined constant for the mode that destroys the account if balance reaches zero.
  static const SendMode destroyAccountIfZero =
      SendMode._(SendModeConst.destroyAccountIfZero, 'destroyAccountIfZero');

  /// Predefined constant for the mode that pays gas separately.
  static const SendMode payGasSeparately =
      SendMode._(SendModeConst.payGasSeparately, 'payGasSeparately');

  /// Predefined constant for the mode that ignores errors during transaction.
  static const SendMode ignoreErrors =
      SendMode._(SendModeConst.ignoreErrors, 'ignoreErrors');

  /// Predefined constant for the mode with no special send behavior.
  static const SendMode none = SendMode._(SendModeConst.none, 'none');
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
          'Cannot find SendMode from provided name',
          details: {'name': name}),
    );
  }
  factory SendMode.fromMode(int? mode) {
    return values.firstWhere(
      (element) => element.mode == mode,
      orElse: () => throw TonDartPluginException(
          'Cannot find SendMode from provided mode',
          details: {'mode': mode}),
    );
  }
  @override
  String toString() {
    return 'SendMode.$name';
  }
}
