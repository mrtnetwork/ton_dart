import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/transfer_params/versioned.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/state/versioned.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/constant/constant.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/versioned/versioned_wallet.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/utils/versioned.dart';

/// It is the most modern wallet version at the moment. It still has all the functionality of the previous versions,
/// but also introduces something very powerful — plugins.
/// This feature allows developers to implement complex logic that will work in tandem with a
/// user's wallet. For example, some DApp may require a user to pay a small amount of coins every day
/// to use some features, so the user will need to install the plugin on their wallet by signing a transaction.
/// This plugin will send coins to the destination address every day when it will be reqested by an external message.
/// This is a very customizable feature which is unique to TON Blockchain.
/// https://docs.ton.org/participate/wallets/contracts#wallet-v4
class WalletV4 extends VersionedWalletContract<SubWalletVersionedWalletState,
    VersionedTransferParams> {
  WalletV4({super.stateInit, required super.address, super.chain})
      : super(type: WalletVersion.v4);

  factory WalletV4.create(
      {required TonChainId chain,
      required List<int> publicKey,
      int? subWalletId,
      bool bounceableAddress = false}) {
    subWalletId ??= VersionedWalletConst.defaultSubWalletId + chain.workchain;
    final state = SubWalletVersionedWalletState(
        publicKey: publicKey,
        version: WalletVersion.v4,
        subwallet: subWalletId);
    return WalletV4(
        address: TonAddress.fromState(
            state: state.initialState(),
            workChain: chain.workchain,
            bounceable: bounceableAddress),
        stateInit: state,
        chain: chain);
  }

  static Future<WalletV4> fromAddress(
      {required TonAddress address,
      required TonProvider rpc,
      TonChainId? chain}) async {
    final data =
        await ContractProvider.getActiveState(rpc: rpc, address: address);
    final state =
        VersionedWalletUtils.buildFromAddress<SubWalletVersionedWalletState>(
            address: address,
            stateData: data.data,
            type: WalletVersion.v4,
            chain: chain);
    return WalletV4(address: address, stateInit: state, chain: chain);
  }

  factory WalletV4.watch(TonAddress address) {
    return WalletV4(address: address);
  }
}
