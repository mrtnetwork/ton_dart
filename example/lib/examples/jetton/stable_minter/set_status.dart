import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

/// index: 96, v5
void main() async {
  final wallet = TestWallet<WalletV5R1>(
      version: WalletVersion.v5R1, chain: TonChainId.mainnet);
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
      operation: StableJettonMinterCallTo(
          address: wallet.address,
          amount: TonHelper.toNano("0.1"),
          operation: StableJettonWalletSetStatus(
              status: StableTokenWalletStatus.statusFull)),
      amount: TonHelper.toNano("0.2"));
}
