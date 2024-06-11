import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/wallet/constant/constant.dart';

class WalletVersion {
  final String name;
  final int version;
  const WalletVersion._(this.name, this.version);
  static const WalletVersion v1R1 = WalletVersion._("v1R1", 1);
  static const WalletVersion v1R2 = WalletVersion._("v1R2", 1);
  static const WalletVersion v1R3 = WalletVersion._("v1R3", 1);
  static const WalletVersion v2R1 = WalletVersion._("v2R1", 2);
  static const WalletVersion v2R2 = WalletVersion._("v2R2", 2);
  static const WalletVersion v3R1 = WalletVersion._("v3R1", 3);
  static const WalletVersion v3R2 = WalletVersion._("v3R2", 3);
  static const WalletVersion v4 = WalletVersion._("v4", 4);

  bool get isVersionedWallet {
    return true;
  }

  String get state {
    switch (this) {
      case WalletVersion.v1R1:
        return VersionedWalletConst.v1R1State;
      case WalletVersion.v1R2:
        return VersionedWalletConst.v1R2State;
      case WalletVersion.v1R3:
        return VersionedWalletConst.v1R3State;
      case WalletVersion.v2R1:
        return VersionedWalletConst.v2R1State;
      case WalletVersion.v2R2:
        return VersionedWalletConst.v2R2State;
      case WalletVersion.v3R1:
        return VersionedWalletConst.v3R1State;
      case WalletVersion.v3R2:
        return VersionedWalletConst.v3R2State;
      case WalletVersion.v4:
        return VersionedWalletConst.v4R2State;
      default:
        throw UnimplementedError();
    }
  }

  Cell getCode() => Cell.fromBase64(state);

  @override
  String toString() {
    return "WalletVersion.$name";
  }
}
