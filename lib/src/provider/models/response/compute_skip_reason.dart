import 'package:ton_dart/src/exception/exception.dart';

class ComputeSkipReasonResponse {
  final String _value;

  const ComputeSkipReasonResponse._(this._value);

  static const ComputeSkipReasonResponse cskipNoState =
      ComputeSkipReasonResponse._('cskip_no_state');
  static const ComputeSkipReasonResponse cskipBadState =
      ComputeSkipReasonResponse._('cskip_bad_state');
  static const ComputeSkipReasonResponse cskipNoGas =
      ComputeSkipReasonResponse._('cskip_no_gas');

  static const List<ComputeSkipReasonResponse> values = [
    cskipNoState,
    cskipBadState,
    cskipNoGas
  ];

  String get value => _value;

  static ComputeSkipReasonResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element.value == name,
      orElse: () => throw TonDartPluginException(
          'No ComputeSkipReasonResponse find with provided name.',
          details: {'name': name}),
    );
  }
}
