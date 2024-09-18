import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/constant/constant.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/state/versioned.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/provider/impl/versioned.dart';

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
  static const WalletVersion v5R1 = WalletVersion._("v5R1", 5);

  static const List<WalletVersion> values = [
    v1R1,
    v1R2,
    v1R3,
    v2R1,
    v2R2,
    v3R1,
    v3R2,
    v4,
    v5R1
  ];

  bool get isVersionedWallet {
    return true;
  }

  bool get hasSubwalletId => version > 2;
  int get maxMessageLength {
    if (version == 1) {
      return 1;
    }
    return 4;
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
      case WalletVersion.v5R1:
        return VersionedWalletConst.v5R1State;
      default:
        throw UnimplementedError();
    }
  }

  Cell getCode() => Cell.fromBase64(state);

  factory WalletVersion.fromValue(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw TonContractException(
          "Cannot find WalletVersion from provided status",
          details: {"name": name}),
    );
  }

  @override
  String toString() {
    return "WalletVersion.$name";
  }
}

abstract class VersionedWalletContract<STATE extends VersionedWalletState,
        TRANSFERPARAMS extends WalletContractTransferParams>
    extends WalletContract<STATE, TRANSFERPARAMS>
    with VerionedProviderImpl<STATE, TRANSFERPARAMS> {
  @override
  final WalletVersion type;

  VersionedWalletContract(
      {required STATE? stateInit,
      required TonChain? chain,
      required TonAddress address,
      required this.type})
      : super(
            state: stateInit,
            address: address,
            chain: chain ?? TonChain.fromWorkchain(address.workChain));
}
