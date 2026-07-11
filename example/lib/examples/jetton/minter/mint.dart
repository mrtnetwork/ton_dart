import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final wallet = TestWallet<WalletV5R1>(version: WalletVersion.v5R1, index: 96);

  final metadata = JettonOnChainMetadata.snakeFormat(
      name: "MRT NETWORK",
      image: "https://avatars.githubusercontent.com/u/56779182?s=96&v=4",
      symbol: "MRT",
      decimals: 9,
      description: "https://github.com/mrtnetwork/ton_dart");
  final jetton = JettonMinter.create(
      owner: wallet.wallet,
      state: MinterWalletState(
        owner: wallet.address,
        metadata: metadata,
      ));
  await jetton.sendOperation(
      signerParams: VersionedV5TransferParams.external(signer: wallet.signer),
      rpc: wallet.rpc,
      amount: TonHelper.toNanoGrams("0.9"),
      operation: JettonMinterMint(
          totalTonAmount: TonHelper.toNanoGrams("0.5"),
          to: wallet.address,
          transfer: JettonMinterInternalTransfer(
              jettonAmount: TonHelper.toNanoGrams("100000"),
              forwardTonAmount: TonHelper.toNanoGrams("0.01")),
          jettonAmount: TonHelper.toNanoGrams("100000")));
}
