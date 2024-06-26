import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/contracts/core/provider.dart';
import 'package:ton_dart/src/contracts/wallet/core/version.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/wallet/constant/constant.dart';
import 'package:ton_dart/src/contracts/wallet/core/versioned_wallet.dart';
import 'package:ton_dart/src/contracts/wallet/utils/utils.dart';

/// This version introduces the subwallet_id parameter, which allows you to create multiple wallets
/// using the same public key (so you can have only one seed phrase and lots of wallets). And,
/// as before, V3R2 only adds the get-method for public key.
/// Basically, subwallet_id is just a number which is added to the contract state when it is deployed.
/// And since the contract address in TON is a hash of its state and code, the wallet address will change with a different subwallet_id.
/// This version is the most used right now. It covers most use-cases and remains clean and simple.
class WalletV3R1 extends WalletContract {
  @override
  final StateInit? state;

  @override
  final TonAddress address;
  @override
  final int? subWalletId;

  const WalletV3R1._(
      {this.state, required this.address, required this.subWalletId});

  const WalletV3R1(
      {this.state, required this.address, required int this.subWalletId});

  factory WalletV3R1.create(
      {required int workChain,
      required List<int> publicKey,
      int? subWalletId,
      bool bounceableAddress = false}) {
    subWalletId ??= VersionedWalletConst.defaultSubWalletId + workChain;
    final state = VersionedWalletUtils.buildState(
        publicKey: publicKey,
        subWalletId: subWalletId,
        type: WalletVersion.v3R1);
    return WalletV3R1._(
        state: state,
        address: TonAddress.fromState(
            state: state, workChain: workChain, bounceable: bounceableAddress),
        subWalletId: subWalletId);
  }
  static Future<WalletV3R1> fromAddress(
      {required TonAddress address, required TonProvider rpc}) async {
    final data =
        await ContractProvider.getStaticState(rpc: rpc, address: address);
    final state = VersionedWalletUtils.buildFromAddress(
        address: address, stateData: data.data, type: WalletVersion.v3R1);
    return WalletV3R1._(
        state: state.item1, address: address, subWalletId: state.item2!);
  }

  factory WalletV3R1.watch(TonAddress address) {
    return WalletV3R1._(address: address, subWalletId: null);
  }

  @override
  WalletVersion get type => WalletVersion.v3R1;
}
