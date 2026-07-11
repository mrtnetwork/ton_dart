import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/constant/constant.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/state/versioned.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/provider/impl/versioned.dart';

enum WalletVersion {
  v1R1('v1R1', 1),
  v1R2('v1R2', 1),
  v1R3('v1R3', 1),
  v2R1('v2R1', 2),
  v2R2('v2R2', 2),
  v3R1('v3R1', 3),
  v3R2('v3R2', 3),
  v4('v4', 4),
  v5R1('v5R1', 5);

  final String name;
  final int version;
  const WalletVersion(this.name, this.version);

  bool get isVersionedWallet {
    return true;
  }

  bool get hasSubwalletId => version > 2;
  int get maxMessageLength {
    switch (this) {
      case WalletVersion.v1R1:
      case WalletVersion.v1R2:
      case WalletVersion.v1R3:
        return 1;
      case WalletVersion.v2R1:
      case WalletVersion.v2R2:
      case WalletVersion.v3R1:
      case WalletVersion.v3R2:
      case WalletVersion.v4:
        return 4;
      case WalletVersion.v5R1:
        return 255;
    }
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
    }
  }

  Cell getCode() => Cell.fromBase64(state);

  factory WalletVersion.fromValue(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse:
          () =>
              throw TonContractException(
                'Cannot find WalletVersion from provided status',
                details: {'name': name},
              ),
    );
  }

  @override
  String toString() {
    return 'WalletVersion.$name';
  }
}

abstract class VersionedWalletContract<
  STATE extends VersionedWalletState,
  TRANSFERPARAMS extends WalletContractTransferParams
>
    extends WalletContract<STATE, TRANSFERPARAMS>
    with VerionedProviderImpl<STATE, TRANSFERPARAMS> {
  @override
  final WalletVersion type;
  VersionedWalletContract({
    required STATE? stateInit,
    required TonWorkChain? workchain,
    required super.address,
    required this.type,
    required super.chainId,
  }) : super(state: stateInit, workchain: workchain ?? address.workchain);
}
