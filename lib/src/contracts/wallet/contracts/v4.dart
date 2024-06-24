import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/contracts/core/provider.dart';
import 'package:ton_dart/src/contracts/wallet/core/version.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/wallet/constant/constant.dart';
import 'package:ton_dart/src/contracts/wallet/core/versioned_wallet.dart';
import 'package:ton_dart/src/contracts/wallet/utils/utils.dart';

/// It is the most modern wallet version at the moment. It still has all the functionality of the previous versions,
/// but also introduces something very powerful — plugins.
/// This feature allows developers to implement complex logic that will work in tandem with a
/// user's wallet. For example, some DApp may require a user to pay a small amount of coins every day
/// to use some features, so the user will need to install the plugin on their wallet by signing a transaction.
/// This plugin will send coins to the destination address every day when it will be reqested by an external message.
/// This is a very customizable feature which is unique to TON Blockchain.
/// https://docs.ton.org/participate/wallets/contracts#wallet-v4
class WalletV4 extends WalletContract {
  @override
  final StateInit? state;

  @override
  final TonAddress address;

  @override
  final int? subWalletId;

  const WalletV4._(
      {required this.state, required this.address, required this.subWalletId});

  const WalletV4(
      {required this.state,
      required this.address,
      required int this.subWalletId});

  factory WalletV4.create(
      {required int workChain,
      required List<int> publicKey,
      int? subWalletId,
      bool bounceableAddress = false}) {
    subWalletId ??= VersionedWalletConst.defaultSubWalletId + workChain;
    final state = VersionedWalletUtils.buildState(
        publicKey: publicKey, subWalletId: subWalletId, type: WalletVersion.v4);
    return WalletV4._(
        state: state,
        address: TonAddress.fromState(
            state: state, workChain: workChain, bounceable: bounceableAddress),
        subWalletId: subWalletId);
  }

  static Future<WalletV4> fromAddress(
      {required TonAddress address, required TonProvider rpc}) async {
    final data =
        await ContractProvider.getStaticState(rpc: rpc, address: address);
    final state = VersionedWalletUtils.buildFromAddress(
        address: address, stateData: data.data, type: WalletVersion.v4);
    return WalletV4._(
        state: state.item1, address: address, subWalletId: state.item2!);
  }

  factory WalletV4.watch(TonAddress address) {
    return WalletV4._(state: null, address: address, subWalletId: null);
  }
  @override
  WalletVersion get type => WalletVersion.v4;
}
