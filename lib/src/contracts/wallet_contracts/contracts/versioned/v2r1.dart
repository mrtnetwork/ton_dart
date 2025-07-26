import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/transfer_params/versioned.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/state/versioned.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/versioned/versioned_wallet.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/utils/versioned.dart';

/// This version introduces the valid_until parameter which is used to set a time limit for a
/// transaction in case you don't want it to be confirmed too late. This version also doesn't
/// have the get-method for public key, which is added in V2R2.
/// It can be used in most cases, but it misses one cool feature, which was added in V3.
/// https://docs.ton.org/participate/wallets/contracts
class WalletV2R1 extends VersionedWalletContract<
    NoneSubWalletVersionedWalletState, VersionedTransferParams> {
  WalletV2R1({super.stateInit, required super.address, super.chain})
      : super(type: WalletVersion.v2R1);

  factory WalletV2R1.create(
      {required TonChainId chain,
      required List<int> publicKey,
      bool bounceableAddress = false}) {
    final state = NoneSubWalletVersionedWalletState(
        publicKey: publicKey, version: WalletVersion.v2R1);
    return WalletV2R1(
        address: TonAddress.fromState(
            state: state.initialState(),
            workChain: chain.workchain,
            bounceable: bounceableAddress),
        stateInit: state,
        chain: chain);
  }
  static Future<WalletV2R1> fromAddress(
      {required TonAddress address,
      required TonProvider rpc,
      TonChainId? chain}) async {
    final data =
        await ContractProvider.getActiveState(rpc: rpc, address: address);
    final state = VersionedWalletUtils.buildFromAddress<
            NoneSubWalletVersionedWalletState>(
        address: address,
        stateData: data.data,
        type: WalletVersion.v2R1,
        chain: chain);
    return WalletV2R1(address: address, stateInit: state);
  }
}
