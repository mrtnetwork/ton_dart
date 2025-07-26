import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

/// index: 96, v5
void main() async {
  final wallet = TestWallet<WalletV5R1>(
      version: WalletVersion.v5R1, chain: TonChainId.mainnet);
  final receiver = TestWallet<WalletV5R1>(
      version: WalletVersion.v5R1, chain: TonChainId.mainnet, index: 2);
  final stableJetton = StableJettonMinter.create(
      owner: wallet.wallet,
      state: StableTokenMinterState(
        adminAddress: wallet.address,
        metadata: const StableJettonOffChainMetadata(
            "https://raw.githubusercontent.com/mrtnetwork/ton_dart/d033738c5aad3877ccdd4fa7f570cad5fe46de7b/example/metadata.json"),
      ));
  final contract = await stableJetton.getJettonWalletContract(
      rpc: wallet.rpc, owner: wallet.wallet);

  await contract.sendOperation(
      signerParams: VersionedV5TransferParams.external(signer: wallet.signer),
      rpc: wallet.rpc,
      operation: StableJettonWalletTransfer(
          jettonAmount: TonHelper.toNano("100"),
          to: receiver.address,
          forwardTonAmount: TonHelper.toNano("0.1")),
      amount: TonHelper.toNano("0.4"),
      bounce: false);
}
