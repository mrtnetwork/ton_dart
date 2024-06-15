import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/wallet/core/version.dart';
import 'package:ton_dart/src/crypto/crypto.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/contracts/wallet/models/versioned_wallet_account_params.dart';

class VersionedWalletUtils {
  static VersionedWalletAccountPrams readState({
    required Cell? stateData,
    required WalletVersion type,
  }) {
    try {
      final cell = stateData!.beginParse();
      int seqno = cell.loadUint(32);
      List<int> pubkeyBytes;
      int? subWallet;
      switch (type) {
        case WalletVersion.v1R1:
        case WalletVersion.v1R2:
        case WalletVersion.v1R3:
        case WalletVersion.v2R1:
        case WalletVersion.v2R2:
          pubkeyBytes = cell.loadBuffer(32);
          break;
        case WalletVersion.v3R1:
        case WalletVersion.v3R2:
        case WalletVersion.v4:
          subWallet = cell.loadUint(32);
          pubkeyBytes = cell.loadBuffer(32);
          break;
        default:
          throw UnimplementedError();
      }
      return VersionedWalletAccountPrams(
        subwallet: subWallet,
        publicKey: pubkeyBytes,
        seqno: seqno,
      );
    } catch (e) {
      throw MessageException("Invalid ${type.name} state account data.");
    }
  }

  static Tuple<StateInit, int?> buildFromAddress(
      {required Cell? stateData,
      required WalletVersion type,
      required TonAddress address}) {
    final state = readState(stateData: stateData, type: type);
    StateInit currentState = buildState(
        type: type, publicKey: state.publicKey, subWalletId: state.subwallet);
    final currentAddress =
        TonAddress.fromState(state: currentState, workChain: address.workChain);
    if (currentAddress.toRawAddress() != address.toRawAddress()) {
      throw MessageException(
          "Invalid wallet address. state gives a different address",
          details: {
            "excepted": currentAddress.toRawAddress(),
            "address": address.toRawAddress()
          });
    }
    return Tuple(currentState, state.subwallet);
  }

  static StateInit buildState({
    required WalletVersion type,
    required List<int> publicKey,
    int? subWalletId,
  }) {
    return StateInit(
        code: type.getCode(),
        data: buldData(
            type: type, publicKey: publicKey, subWalletId: subWalletId));
  }

  static Cell buldData({
    required WalletVersion type,
    required List<int> publicKey,
    required int? subWalletId,
  }) {
    if (type.version > 2 && subWalletId == null) {
      throw TonContractException(
          "Subwallet id is required for wallet version 3, 4",
          details: {"version": type.name});
    }
    final pubkey = TonPublicKey.fromBytes(publicKey);
    switch (type) {
      case WalletVersion.v3R1:
      case WalletVersion.v3R2:
        return beginCell()
            .storeUint(0, 32)
            .storeUint(subWalletId, 32)
            .storeBuffer(pubkey.toBytes())
            .endCell();
      case WalletVersion.v4:
        return beginCell()
            .storeUint(0, 32)
            .storeUint(subWalletId, 32)
            .storeBuffer(pubkey.toBytes())
            .storeBit(0)
            .endCell();
      default:
        return beginCell()
            .storeUint(0, 32)
            .storeBuffer(pubkey.toBytes())
            .endCell();
    }
  }
}
