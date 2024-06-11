class InscriptionTypeResponse {
  final String _value;

  const InscriptionTypeResponse._(this._value);

  static const InscriptionTypeResponse ton20 =
      InscriptionTypeResponse._("ton20");
  static const InscriptionTypeResponse gram20 =
      InscriptionTypeResponse._("gram20");

  static const List<InscriptionTypeResponse> values = [
    ton20,
    gram20,
  ];

  String get value => _value;

  static InscriptionTypeResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element.value == name,
      orElse: () => throw Exception(
          "No InscriptionTypeResponse found with the provided name: $name"),
    );
  }
}
