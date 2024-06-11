class PoolImplementationTypeResponse {
  final String _value;

  const PoolImplementationTypeResponse._(this._value);

  static const PoolImplementationTypeResponse whales =
      PoolImplementationTypeResponse._("whales");
  static const PoolImplementationTypeResponse tf =
      PoolImplementationTypeResponse._("tf");
  static const PoolImplementationTypeResponse liquidTF =
      PoolImplementationTypeResponse._("liquidTF");

  static const List<PoolImplementationTypeResponse> values = [
    whales,
    tf,
    liquidTF,
  ];

  String get value => _value;

  static PoolImplementationTypeResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element.value == name,
      orElse: () => throw Exception(
          "No PoolImplementationTypeResponse found with the provided name: $name"),
    );
  }
}
