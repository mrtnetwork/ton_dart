import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/versioned/versioned_wallet.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/models/v5_client_id.dart';
import 'package:ton_dart/src/crypto/crypto.dart';
import 'package:ton_dart/src/models/models.dart';

abstract class VersionedWalletState implements ContractState {
  final TonPublicKey publicKey;
  final int seqno;
  final WalletVersion version;

  @override
  StateInit initialState() {
    return StateInit(code: version.getCode(), data: initialData());
  }

  VersionedWalletState(
      {required List<int> publicKey,
      required this.seqno,
      required this.version})
      : publicKey = TonPublicKey.fromBytes(publicKey);

  @override
  Cell initialData();
}

class NoneSubWalletVersionedWalletState extends VersionedWalletState {
  NoneSubWalletVersionedWalletState(
      {required List<int> publicKey,
      int? seqno,
      required WalletVersion version})
      : super(publicKey: publicKey, seqno: seqno ?? 0, version: version);

  @override
  Cell initialData() {
    return beginCell()
        .storeUint(0, 32)
        .storeBuffer(publicKey.toBytes())
        .endCell();
  }
}

class SubWalletVersionedWalletState extends VersionedWalletState {
  final int subwallet;
  SubWalletVersionedWalletState({
    required List<int> publicKey,
    int? seqno,
    required WalletVersion version,
    required this.subwallet,
  }) : super(publicKey: publicKey, seqno: seqno ?? 0, version: version);

  @override
  Cell initialData() {
    switch (version) {
      case WalletVersion.v3R1:
      case WalletVersion.v3R2:
        return beginCell()
            .storeUint(0, 32)
            .storeUint(subwallet, 32)
            .storeBuffer(publicKey.toBytes())
            .endCell();
      case WalletVersion.v4:
        return beginCell()
            .storeUint(0, 32)
            .storeUint(subwallet, 32)
            .storeBuffer(publicKey.toBytes())
            .storeBit(0)
            .endCell();
      default:
        throw const TonContractException(
            "SubWalletVersionedWalletState only accept version 3 and 4");
    }
  }
}

class V5VersionedWalletState extends VersionedWalletState {
  final V5R1Context context;
  final bool setPubKeyEnabled;
  final List<TonAddress> extensionPubKeys;

  V5VersionedWalletState(
      {required List<int> publicKey,
      int? seqno,
      required this.context,
      required WalletVersion version,
      this.setPubKeyEnabled = true,
      List<TonAddress> extensionPubKeys = const []})
      : extensionPubKeys = List<TonAddress>.unmodifiable(extensionPubKeys),
        super(publicKey: publicKey, seqno: seqno ?? 0, version: version);

  @override
  Cell initialData() {
    return beginCell()
        .storeUint(1, 1)
        .storeUint(0, 32)
        .store(context)
        .storeBuffer(publicKey.toBytes())
        .storeBit(0)
        .endCell();
  }
}
