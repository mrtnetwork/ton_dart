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
class WalletV3R1
    extends
        VersionedWalletContract<
          SubWalletVersionedWalletState,
          VersionedTransferParams
        > {
  WalletV3R1({
    super.stateInit,
    required super.address,
    super.workchain,
    required super.chainId,
  }) : super(type: WalletVersion.v3R1);

  factory WalletV3R1.create({
    TonWorkChain workchain = TonWorkChain.basechain,
    TonChainId chainId = TonChainId.mainnet,
    required List<int> publicKey,
    int? subWalletId,
    bool bounceableAddress = false,
  }) {
    subWalletId ??= VersionedWalletConst.defaultSubWalletId + workchain.id;
    final state = SubWalletVersionedWalletState(
      publicKey: publicKey,
      version: WalletVersion.v3R1,
      subwallet: subWalletId,
    );
    return WalletV3R1(
      stateInit: state,
      address: TonAddress.fromState(
        state: state.initialState(),
        config: TonAddressConfing.friendly(
          workchain,
          bounceable: bounceableAddress,
          testOnly: chainId.isTestnet,
        ),
      ),
      workchain: workchain,
      chainId: chainId,
    );
  }
  static Future<WalletV3R1> fromAddress({
    required TonAddress address,
    required TonProvider rpc,
    TonWorkChain? workchain,
    TonChainId? chainId,
  }) async {
    final data = await ContractProvider.getActiveState(
      rpc: rpc,
      address: address,
    );
    final state =
        VersionedWalletUtils.buildFromAddress<SubWalletVersionedWalletState>(
          address: address,
          stateData: data.data,
          type: WalletVersion.v3R1,
          workchain: workchain,
          chainId: chainId,
        );
    return WalletV3R1(
      address: address,
      stateInit: state,
      chainId:
          chainId ??
          (address.isTestOnly ? TonChainId.testnet : TonChainId.mainnet),
    );
  }

  factory WalletV3R1.watch(TonAddress address, {TonChainId? chainId}) {
    return WalletV3R1(
      address: address,
      chainId:
          chainId ??
          (address.isTestOnly ? TonChainId.testnet : TonChainId.mainnet),
    );
  }
}
