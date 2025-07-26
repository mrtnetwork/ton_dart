import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

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
  await stableJetton.deploy(
      params: VersionedV5TransferParams.external(signer: wallet.signer),
      rpc: wallet.rpc,
      amount: TonHelper.toNano("0.3"));
}
