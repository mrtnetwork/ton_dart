import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final wallet = TestWallet<WalletV5R1>(version: WalletVersion.v5R1, index: 96);

  final nftItem = NFTItemContract.create(
      owner: wallet.wallet,
      state: NFTItemState(
          index: BigInt.zero,
          metadata: const NFTItemMetadata(
              "https://avatars.githubusercontent.com/u/56779182?s=96&v=4"),
          ownerAddress: wallet.address));
  await nftItem.deploy(
      params: VersionedV5TransferParams.external(signer: wallet.signer),
      amount: TonHelper.toNano("0.3"),
      rpc: wallet.rpc);
}
