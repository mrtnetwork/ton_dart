import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/transfer_params/versioned.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/state/versioned.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/constant/constant.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/versioned/versioned_wallet.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/utils/versioned.dart';

/// This version introduces the subwallet_id parameter, which allows you to create multiple wallets
/// using the same public key (so you can have only one seed phrase and lots of wallets). And,
/// as before, V3R2 only adds the get-method for public key.
/// Basically, subwallet_id is just a number which is added to the contract state when it is deployed.
/// And since the contract address in TON is a hash of its state and code, the wallet address will change with a different subwallet_id.
/// This version is the most used right now. It covers most use-cases and remains clean and simple.
/// https://docs.ton.org/participate/wallets/contracts
class WalletV3R2 extends VersionedWalletContract<SubWalletVersionedWalletState,
    VersionedTransferParams> {
  WalletV3R2({super.stateInit, required super.address, super.chain})
      : super(type: WalletVersion.v3R2);

  factory WalletV3R2.create(
      {required TonChainId chain,
      required List<int> publicKey,
      int? subWalletId,
      bool bounceableAddress = false}) {
    subWalletId ??= VersionedWalletConst.defaultSubWalletId + chain.workchain;
    final state = SubWalletVersionedWalletState(
        publicKey: publicKey,
        version: WalletVersion.v3R2,
        subwallet: subWalletId);
    return WalletV3R2(
        address: TonAddress.fromState(
            state: state.initialState(),
            workChain: chain.workchain,
            bounceable: bounceableAddress),
        stateInit: state,
        chain: chain);
  }
  static Future<WalletV3R2> fromAddress(
      {required TonAddress address,
      required TonProvider rpc,
      TonChainId? chain}) async {
    final data =
        await ContractProvider.getActiveState(rpc: rpc, address: address);
    final state =
        VersionedWalletUtils.buildFromAddress<SubWalletVersionedWalletState>(
            address: address,
            stateData: data.data,
            type: WalletVersion.v3R2,
            chain: chain);
    return WalletV3R2(address: address, stateInit: state, chain: chain);
  }

  factory WalletV3R2.watch(TonAddress address) {
    return WalletV3R2(address: address);
  }
}
