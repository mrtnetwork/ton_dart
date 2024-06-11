import 'package:blockchain_utils/exception/exception.dart';

class BouncePhaseTypeResponse {
  final String _value;

  const BouncePhaseTypeResponse._(this._value);

  static const BouncePhaseTypeResponse trPhaseBounceNegfunds =
      BouncePhaseTypeResponse._("TrPhaseBounceNegfunds");
  static const BouncePhaseTypeResponse trPhaseBounceNofunds =
      BouncePhaseTypeResponse._("TrPhaseBounceNofunds");
  static const BouncePhaseTypeResponse trPhaseBounceOk =
      BouncePhaseTypeResponse._("TrPhaseBounceOk");

  static const List<BouncePhaseTypeResponse> values = [
    trPhaseBounceNegfunds,
    trPhaseBounceNofunds,
    trPhaseBounceOk,
  ];

  String get value => _value;
  static BouncePhaseTypeResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element.value == name,
      orElse: () => throw MessageException(
          "No BouncePhaseTypeResponse find with provided name.",
          details: {"name": name}),
    );
  }
}
