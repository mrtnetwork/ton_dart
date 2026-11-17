import 'package:example/examples/testnet/tx.dart';
import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

/// Collection-less NFT deploy + transfer on **testnet**, basechain.
///
/// The same seed-122 wallet (index 0) deploys the item and index 1 becomes the
/// new owner. A collection-less item keeps the example cheap: one contract
/// instead of a collection + item.
///
/// ```sh
/// dart run lib/examples/testnet/nft_transfer.dart
/// ```
Future<void> main() async {
  final wallet =
      TestWallet<WalletV4>(version: WalletVersion.v4, index: 0, log: false);
  final receiver =
      TestWallet<WalletV4>(version: WalletVersion.v4, index: 1, log: false);

  final item = NFTItemContract.create(
    owner: wallet.wallet,
    state: NFTItemState(
      index: BigInt.zero,
      metadata: const NFTItemMetadata('https://example.com/ton-dart-nft.json'),
      ownerAddress: wallet.address,
    ),
  );

  print('NFT deploy + transfer (testnet, basechain)');
  print('  owner:    ${wallet.address.toRawAddress()}');
  print('  receiver: ${receiver.address.toRawAddress()}');
  print('  item:     ${item.address.toRawAddress()}');

  final balance = await wallet.wallet.getBalance(wallet.client);
  print('  balance:  ${TonHelper.fromNanoGrams(balance)} TON');
  if (balance < TonHelper.toNanoGrams('0.3')) {
    print('  fund the owner with at least 0.3 TON and rerun');
    return;
  }

  final deployTx = await item.deploy(
    params: VersionedTransferParams(privateKey: wallet.signer),
    client: wallet.client,
    amount: TonHelper.toNanoGrams('0.1'),
  );
  print('  deploy tx: ${txHash(deployTx)}');
  print('  explorer:  ${txExplorer(deployTx)}');

  await Future.delayed(const Duration(seconds: 20));

  final transferTx = await item.sendOperation(
    params: VersionedTransferParams(privateKey: wallet.signer),
    client: wallet.client,
    amount: TonHelper.toNanoGrams('0.1'),
    operation: NFTItemTransfer(
      newOwnerAddress: receiver.address,
      responseDestination: wallet.address,
      forwardAmount: TonHelper.toNanoGrams('0.01'),
    ),
  );
  print('  transfer tx: ${txHash(transferTx)}');
  print('  explorer:    ${txExplorer(transferTx)}');

  await Future.delayed(const Duration(seconds: 20));

  final data = await item.getNftData(wallet.client);
  print('  owner after: ${data.ownerAddress?.toRawAddress()}');
}
