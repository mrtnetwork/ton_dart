class MessageMsgTypeResponse {
  final String _value;

  const MessageMsgTypeResponse._(this._value);

  static const MessageMsgTypeResponse intMsg =
      MessageMsgTypeResponse._("int_msg");
  static const MessageMsgTypeResponse extInMsg =
      MessageMsgTypeResponse._("ext_in_msg");
  static const MessageMsgTypeResponse extOutMsg =
      MessageMsgTypeResponse._("ext_out_msg");

  static const List<MessageMsgTypeResponse> values = [
    intMsg,
    extInMsg,
    extOutMsg
  ];

  String get value => _value;

  static MessageMsgTypeResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element.value == name,
      orElse: () => throw Exception(
          "No MessageMsgTypeResponse found with the provided name: $name"),
    );
  }
}
