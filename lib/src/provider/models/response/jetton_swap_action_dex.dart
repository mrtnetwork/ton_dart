class JettonSwapActionDexResponse {
  final String _value;

  const JettonSwapActionDexResponse._(this._value);

  static const JettonSwapActionDexResponse stonfi =
      JettonSwapActionDexResponse._("stonfi");
  static const JettonSwapActionDexResponse dedust =
      JettonSwapActionDexResponse._("dedust");
  static const JettonSwapActionDexResponse megatonfi =
      JettonSwapActionDexResponse._("megatonfi");

  static const List<JettonSwapActionDexResponse> values = [
    stonfi,
    dedust,
    megatonfi,
  ];

  String get value => _value;

  static JettonSwapActionDexResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element._value == name,
      orElse: () => throw Exception(
          "No JettonSwapActionDexResponse found with the provided name: $name"),
    );
  }
}
