class WalletV5AuthType {
  final String name;
  final int tag;
  const WalletV5AuthType._({required this.name, required this.tag});
  static const WalletV5AuthType extension =
      WalletV5AuthType._(name: 'Extension', tag: 0x6578746e);
  static const WalletV5AuthType external =
      WalletV5AuthType._(name: 'External', tag: 0x7369676e);
  static const WalletV5AuthType internal =
      WalletV5AuthType._(name: 'Internal', tag: 0x73696e74);
}
