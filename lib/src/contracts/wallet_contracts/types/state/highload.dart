import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core/state.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/constant/constant.dart';
import 'package:ton_dart/src/models/models/state_init.dart';

class HighloadWalletV3State implements ContractState {
  final List<int> publicKey;
  final int timeout;
  final int subWalletId;
  const HighloadWalletV3State(
      {required this.publicKey,
      required this.timeout,
      required this.subWalletId});

  factory HighloadWalletV3State.deserialize(Slice slice) {
    return HighloadWalletV3State(
        publicKey: slice.loadBuffer(32),
        subWalletId: slice.loadUint(32),
        timeout: slice
            .skip(1 + 1 + HighloadWalletConst.highLoadTimeStampSize)
            .loadUint(HighloadWalletConst.highLoadTimeOutSize));
  }

  @override
  StateInit initialState() {
    return StateInit(code: HighloadWalletConst.code(), data: initialData());
  }

  @override
  Cell initialData() {
    return beginCell()
        .storeBuffer(publicKey)
        .storeUint(subWalletId, 32)
        .storeUint(0, 1 + 1 + HighloadWalletConst.highLoadTimeStampSize)
        .storeUint(timeout, HighloadWalletConst.highLoadTimeOutSize)
        .endCell();
  }
}
