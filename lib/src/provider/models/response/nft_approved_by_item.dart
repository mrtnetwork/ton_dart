class NftApprovedByItemResponse {
  final String _value;

  const NftApprovedByItemResponse._(this._value);

  static const NftApprovedByItemResponse getgems =
      NftApprovedByItemResponse._("getgems");
  static const NftApprovedByItemResponse tonkeeper =
      NftApprovedByItemResponse._("tonkeeper");
  static const NftApprovedByItemResponse tonDiamonds =
      NftApprovedByItemResponse._("ton.diamonds");

  static const List<NftApprovedByItemResponse> values = [
    getgems,
    tonkeeper,
    tonDiamonds
  ];

  String get value => _value;

  static NftApprovedByItemResponse fromName(String? name) {
    return values.firstWhere((element) => element.value == name,
        orElse: () => throw Exception(
            "No NftApprovedByItemResponse found with the provided name: $name"));
  }
}
