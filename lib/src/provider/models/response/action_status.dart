class ActionStatusResponse {
  final String _value;

  const ActionStatusResponse._(this._value);

  static const ActionStatusResponse ok = ActionStatusResponse._("ok");
  static const ActionStatusResponse failed = ActionStatusResponse._("failed");

  static const List<ActionStatusResponse> values = [
    ok,
    failed,
  ];

  String get value => _value;

  static ActionStatusResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element.value == name,
      orElse: () => throw Exception(
          "No ActionStatusResponse found with the provided name: $name"),
    );
  }
}
