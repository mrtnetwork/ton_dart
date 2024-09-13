import 'package:example/examples/versioned_wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

/// index: 96, v5
void main() async {
  final wallet = TestWallet<WalletV5R1>(
      version: WalletVersion.v5R1, chain: TonChain.mainnet);
  final stableJetton = StableJettonMinter.create(
      owner: wallet.wallet,
      state: StableTokenMinterState(
        adminAddress: wallet.address,
        metadata: const StableJettonOffChainMetadata(
            "https://raw.githubusercontent.com/mrtnetwork/ton_dart/d033738c5aad3877ccdd4fa7f570cad5fe46de7b/example/metadata.json"),
      ));
  await stableJetton.sendOperation(
      signerParams: VersionedV5TransferParams.external(signer: wallet.signer),
      rpc: wallet.rpc,
      operation: StableJettonMinterMint(
          totalTonAmount: TonHelper.toNano("0.4"),
          to: wallet.address,
          transfer: StableJettonMinterInternalTransfer(
              jettonAmount: TonHelper.toNano("11111"),
              forwardTonAmount: TonHelper.toNano("0.1"))),
      amount: TonHelper.toNano("0.5"),
      bounce: false);
}
