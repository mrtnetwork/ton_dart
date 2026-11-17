import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final wallet = TestWallet<WalletV5R1>(version: WalletVersion.v5R1, index: 96);
  final royalityParamsWallet =
      TestWallet<WalletV5R1>(version: WalletVersion.v5R1, index: 97);
  final nftCollection = await NFTCollectionContract.fromAddress(
      owner: wallet.wallet,
      address: TonAddress("Ef-CHcyJannW7zf8pNeqV_6egmdu5nLOZfsxHSAqAOd9tQc7"),
      client: wallet.client);

  final item = await nftCollection.getNFTItemContractByIndex(
      index: BigInt.two, client: wallet.client, owner: wallet.wallet);
  await item.sendOperation(
      params: VersionedV5TransferParams.external(signer: wallet.signer),
      client: wallet.client,
      amount: TonHelper.toNanoGrams("0.2"),
      operation: NFTItemTransfer(
          newOwnerAddress: royalityParamsWallet.address,
          // responseDestination: responseDestination,
          forwardAmount: BigInt.zero));
  await Future.delayed(const Duration(seconds: 20));
  final state = await item.getNftData(wallet.client);
  assert(state.ownerAddress == royalityParamsWallet.address);
}
