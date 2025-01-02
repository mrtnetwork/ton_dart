import 'package:ton_dart/src/boc/boc.dart';

class HighloadWalletConst {
  static const int transferOp = 0xae42e5a4;
  static const int defaultHighLoadSubWallet = 0x10ad;
  static const int highLoadTimeStampSize = 64;
  static const int highLoadTimeOutSize = 22;
  static const int defaultTimeout = 128;
  static const String _hightloadWallet3State =
      'te6cckECEAEAAigAART/APSkE/S88sgLAQIBIAINAgFIAwQAeNAg10vAAQHAYLCRW+EB0NMDAXGwkVvg+kAw+CjHBbORMODTHwGCEK5C5aS6nYBA1yHXTPgqAe1V+wTgMAIBIAUKAgJzBgcAEa3OdqJoa4X/wAIBIAgJABqrtu1E0IEBItch1ws/ABiqO+1E0IMH1yHXCx8CASALDAAbuabu1E0IEBYtch1wsVgA5bi/Ltou37IasJAoQJsO1E0IEBINch9AT0BNM/0xXRBY4b+CMloVIQuZ8ybfgjBaoAFaESuZIwbd6SMDPikjAz4lIwgA30D2+hntAh1yHXCgCVXwN/2zHgkTDiWYAN9A9voZzQAdch1woAk3/bMeCRW+JwgB9vLUgwjXGNEh+QDtRNDT/9Mf9AT0BNM/0xXR+CMhoVIguY4SM234IySqAKESuZJtMt5Y+CMB3lQWdfkQ8qEG0NMf1NMH0wzTCdM/0xXRUWi68qJRWrrypvgjKqFSULzyowT4I7vyo1MEgA30D2+hmdAk1yHXCgDyZJEw4g4B/lMJgA30D2+hjhPQUATXGNIAAfJkyFjPFs+DAc8WjhAwyCTPQM+DhAlQBaGlFM9A4vgAyUA5gA30FwTIy/8Tyx/0ABL0ABLLPxLLFcntVPgPIdDTAAHyZdMCAXGwkl8D4PpAAdcLAcAA8qX6QDH6ADH0AfoAMfoAMYBg1yHTAAEPACDyZdIAAZPUMdGRMOJysfsAtYW/Aw==';
  static Cell code() {
    return Cell.fromBase64(_hightloadWallet3State);
  }
}
