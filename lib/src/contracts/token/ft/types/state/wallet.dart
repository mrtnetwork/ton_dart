import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/token/ft/constants/constant/wallet.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/tuple/tuple/tuple_reader.dart';

class JettonWalletState extends ContractState {
  final BigInt balance;
  final TonAddress owanetOfJettonWallet;
  final TonAddress minterAddress;
  final Cell? walletCode;
  const JettonWalletState(
      {required this.balance,
      required this.owanetOfJettonWallet,
      required this.minterAddress,
      this.walletCode});
  factory JettonWalletState.fromTuple(TupleReader reader) {
    final balance = reader.readBigNumber();
    return JettonWalletState(
        balance: balance,
        owanetOfJettonWallet: reader.readAddress(),
        minterAddress: reader.readAddress(),
        walletCode: reader.readCell());
  }
  factory JettonWalletState.deserialize(Slice slice) {
    return JettonWalletState(
        balance: slice.loadCoins(),
        owanetOfJettonWallet: slice.loadAddress(),
        minterAddress: slice.loadAddress(),
        walletCode: slice.loadRef());
  }

  @override
  StateInit initialState() {
    final Cell code =
        walletCode ?? JettonWalletConst.code(minterAddress.workChain);
    return StateInit(data: initialData(), code: code);
  }

  @override
  Cell initialData() {
    final Cell code =
        walletCode ?? JettonWalletConst.code(minterAddress.workChain);
    return beginCell()
        .storeCoins(BigInt.zero)
        .storeAddress(owanetOfJettonWallet)
        .storeAddress(minterAddress)
        .storeRef(code)
        .endCell();
  }
}
