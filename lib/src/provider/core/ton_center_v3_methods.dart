class TonCenterV3Methods {
  final String name;
  static const String tonCenterV3BaseUri = '/api/v3/';
  String get uri => tonCenterV3BaseUri + name;
  const TonCenterV3Methods._({required this.name});

  static const TonCenterV3Methods masterchainInfo =
      TonCenterV3Methods._(name: 'masterchainInfo');
  static const TonCenterV3Methods jettonMasters =
      TonCenterV3Methods._(name: 'jetton/masters');
  static const TonCenterV3Methods jettonWallets =
      TonCenterV3Methods._(name: 'jetton/wallets');

  static const TonCenterV3Methods estimateFee =
      TonCenterV3Methods._(name: 'estimateFee');
  static const TonCenterV3Methods account =
      TonCenterV3Methods._(name: 'account');
}
