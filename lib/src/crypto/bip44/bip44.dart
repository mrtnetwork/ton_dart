import 'package:blockchain_utils/bip/bip/bip.dart';
import 'package:blockchain_utils/bip/bip/bip32/base/bip32_base.dart';
import 'package:blockchain_utils/bip/bip/bip44/base/bip44_base_ex.dart';
import 'package:blockchain_utils/bip/bip/conf/bip_coin_conf.dart';
import 'package:blockchain_utils/bip/bip/conf/bip_conf_const.dart';
import 'package:blockchain_utils/bip/coin_conf/coins_name.dart';
import 'package:blockchain_utils/bip/ecc/bip_ecc.dart';
import 'package:blockchain_utils/bip/slip/slip44/slip44.dart';

class TonCoinConf {
  final CoinConfig conf;
  const TonCoinConf._(this.conf);
  static const int tonSlip44 = 607;
  static final TonCoinConf mainnet = TonCoinConf._(CoinConfig(
    coinNames: const CoinNames("The Open Network", "TON"),
    coinIdx: tonSlip44,
    isTestnet: false,
    defPath: derPathHardenedShort,
    keyNetVer: Bip44Conf.bip44BtcKeyNetVerMain,
    wifNetVer: null,
    type: EllipticCurveTypes.ed25519,
    addressEncoder: ([dynamic kwargs]) => throw UnimplementedError(),
    addrParams: {},
  ));
  static final TonCoinConf testnet = TonCoinConf._(CoinConfig(
    coinNames: const CoinNames("The Open Network", "tTON"),
    coinIdx: Slip44.testnet,
    isTestnet: true,
    defPath: derPathHardenedShort,
    keyNetVer: Bip44Conf.bip44BtcKeyNetVerMain,
    wifNetVer: null,
    type: EllipticCurveTypes.ed25519,
    addressEncoder: ([dynamic kwargs]) => throw UnimplementedError(),
    addrParams: {},
  ));
}

class TonBip44 extends Bip44Base {
  // private constractor
  TonBip44._(Bip32Base bip32Obj, CoinConfig coinConf)
      : super(bip32Obj, coinConf);

  /// Constructor for creating a [TonBip44] object from a seed and coin.
  TonBip44.fromSeed(List<int> seedBytes, {TonCoinConf? conf})
      : super.fromPrivateKey(seedBytes.sublist(Ed25519KeysConst.privKeyByteLen),
            (conf?.conf ?? TonCoinConf.mainnet.conf));

  /// Constructor for creating a [TonBip44] object from a extended key and coin.
  TonBip44.fromExtendedKey(String extendedKey, {TonCoinConf? conf})
      : super.fromExtendedKey(
            extendedKey, (conf?.conf ?? TonCoinConf.mainnet.conf));

  /// Constructor for creating a [TonBip44] object from a private key and coin.
  TonBip44.fromPrivateKey(List<int> privateKeyBytes, TonCoinConf? conf,
      {Bip32KeyData? keyData})
      : super.fromPrivateKey(
            privateKeyBytes, (conf?.conf ?? TonCoinConf.mainnet.conf),
            keyData: keyData ?? Bip32KeyData());

  /// Constructor for creating a [TonBip44] object from a public key and coin.
  TonBip44.fromPublicKey(List<int> pubkeyBytes, TonCoinConf? conf,
      {Bip32KeyData? keyData})
      : super.fromPublicKey(
            pubkeyBytes, (conf?.conf ?? TonCoinConf.mainnet.conf),
            keyData: keyData ??
                Bip32KeyData(depth: Bip32Depth(Bip44Levels.account.value)));

  /// derive purpose
  @override
  TonBip44 get purpose {
    if (!isLevel(Bip44Levels.master)) {
      throw Bip44DepthError(
          "Current depth (${bip32.depth.toInt()}) is not suitable for deriving purpose");
    }
    return TonBip44._(bip32.childKey(Bip44Const.purpose), coinConf);
  }

  /// derive default path
  @override
  TonBip44 get deriveDefaultPath {
    TonBip44 bipObj = purpose.coin;
    return TonBip44._(
        bipObj.bip32.derivePath(bipObj.coinConf.defPath), coinConf);
  }

  /// derive coin
  @override
  TonBip44 get coin {
    if (!isLevel(Bip44Levels.purpose)) {
      throw Bip44DepthError(
          "Current depth (${bip32.depth.toInt()}) is not suitable for deriving coin");
    }
    final coinIndex = coinConf.coinIdx;
    return TonBip44._(
        bip32.childKey(Bip32KeyIndex.hardenIndex(coinIndex)), coinConf);
  }

  /// derive account with index
  @override
  TonBip44 account(int accIndex) {
    if (!isLevel(Bip44Levels.coin)) {
      throw Bip44DepthError(
          "Current depth (${bip32.depth.toInt()}) is not suitable for deriving account");
    }
    return TonBip44._(
        bip32.childKey(Bip32KeyIndex.hardenIndex(accIndex)), coinConf);
  }

  /// derive change with change type [Bip44Changes] internal or external
  @override
  TonBip44 change(Bip44Changes changeType) {
    if (!isLevel(Bip44Levels.account)) {
      throw Bip44DepthError(
          "Current depth (${bip32.depth.toInt()}) is not suitable for deriving change");
    }
    Bip32KeyIndex changeIndex = Bip32KeyIndex(changeType.value);
    if (!bip32Object.isPublicDerivationSupported) {
      changeIndex = Bip32KeyIndex.hardenIndex(changeType.value);
    }
    return TonBip44._(bip32.childKey(changeIndex), coinConf);
  }

  /// derive address with index
  @override
  TonBip44 addressIndex(int addressIndex) {
    if (!isLevel(Bip44Levels.change)) {
      throw Bip44DepthError(
          "Current depth (${bip32.depth.toInt()}) is not suitable for deriving address");
    }
    Bip32KeyIndex changeIndex = Bip32KeyIndex(addressIndex);
    if (!bip32Object.isPublicDerivationSupported) {
      changeIndex = Bip32KeyIndex.hardenIndex(addressIndex);
    }
    return TonBip44._(bip32.childKey(changeIndex), coinConf);
  }

  /// Specification name
  @override
  String get specName {
    return Bip44Const.specName;
  }
}
