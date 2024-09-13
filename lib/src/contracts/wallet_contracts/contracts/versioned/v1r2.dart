import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/transfer_params/versioned.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/state/versioned.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/core/versioned/versioned_wallet.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/utils/versioned.dart';

/// This is the simplest one. It only allows you to send one transaction at
/// the time and it doesn't check anything besides your signature and seqno.
/// This version isn't even used in regular apps because it has some major issues:
/// No easy way to retrieve the seqno and public key from the contract
/// No valid_until check, so you can't be sure that the transaction won't be confirmed too late.
/// The first issue is fixed in V1R2 and V1R3. That R letter means revision. Usually revisions are just small updates which only add get-methods which allows you to retrieve seqno and public key from the contract. But this version also has a second issue, which is fixed in the next version.
/// https://docs.ton.org/participate/wallets/contracts
class WalletV1R2 extends VersionedWalletContract<
    NoneSubWalletVersionedWalletState, VersionedTransferParams> {
  WalletV1R2(
      {NoneSubWalletVersionedWalletState? stateInit,
      required TonAddress address,
      TonChain? chain})
      : super(
            address: address,
            stateInit: stateInit,
            type: WalletVersion.v1R2,
            chain: chain);

  factory WalletV1R2.create(
      {required TonChain chain,
      required List<int> publicKey,
      bool bounceableAddress = false}) {
    final state = NoneSubWalletVersionedWalletState(
        publicKey: publicKey, version: WalletVersion.v1R2);
    return WalletV1R2(
        address: TonAddress.fromState(
            state: state.initialState(),
            workChain: chain.workchain,
            bounceable: bounceableAddress),
        stateInit: state,
        chain: chain);
  }
  static Future<WalletV1R2> fromAddress(
      {required TonAddress address,
      required TonProvider rpc,
      TonChain? chain}) async {
    final data =
        await ContractProvider.getActiveState(rpc: rpc, address: address);
    final state = VersionedWalletUtils.buildFromAddress<
            NoneSubWalletVersionedWalletState>(
        address: address,
        stateData: data.data,
        type: WalletVersion.v1R2,
        chain: chain);
    return WalletV1R2(address: address, stateInit: state);
  }

  factory WalletV1R2.watch(TonAddress address) {
    return WalletV1R2(address: address);
  }
}
