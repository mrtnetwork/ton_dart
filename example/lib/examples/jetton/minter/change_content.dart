import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final wallet = TestWallet<WalletV5R1>(version: WalletVersion.v5R1, index: 96);

  final metadata = JettonOnChainMetadata.snakeFormat(
      name: "MRT JETTON",
      image: "https://avatars.githubusercontent.com/u/56779182?s=96&v=4",
      symbol: "MRT",
      decimals: 12,
      description: "https://github.com/mrtnetwork/ton_dart");
  final jetton = await JettonMinter.fromAddress(
      owner: wallet.wallet,
      address: TonAddress("Ef9sa8u1xuh6V5-ueNUEEiOYIjxxAQlqRAZ__7GGc_yJ5Lqf"),
      rpc: wallet.rpc);
  await jetton.sendOperation(
      signerParams: VersionedV5TransferParams.external(signer: wallet.signer),
      rpc: wallet.rpc,
      amount: TonHelper.toNano("0.2"),
      operation: JettonMinterChangeContent(content: metadata.toContent()));
}
