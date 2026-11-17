import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

/// index: 96, v5
void main() async {
  final wallet = TestWallet<WalletV5R1>(
      version: WalletVersion.v5R1, chainId: TonChainId.mainnet);
  final receiver = TestWallet<WalletV5R1>(
      version: WalletVersion.v5R1, chainId: TonChainId.mainnet, index: 2);
  final stableJetton = StableJettonMinter.create(
      owner: wallet.wallet,
      state: StableTokenMinterState(
        adminAddress: wallet.address,
        metadata: const StableJettonOffChainMetadata(
            "https://raw.githubusercontent.com/mrtnetwork/ton_dart/d033738c5aad3877ccdd4fa7f570cad5fe46de7b/example/metadata.json"),
      ));
  final contract = await stableJetton.getJettonWalletContract(
      client: wallet.client, owner: wallet.wallet);

  await contract.sendOperation(
      signerParams: VersionedV5TransferParams.external(signer: wallet.signer),
      client: wallet.client,
      operation: StableJettonWalletTransfer(
          jettonAmount: TonHelper.toNanoGrams("100"),
          to: receiver.address,
          forwardTonAmount: TonHelper.toNanoGrams("0.1")),
      amount: TonHelper.toNanoGrams("0.4"),
      bounce: false);
}
