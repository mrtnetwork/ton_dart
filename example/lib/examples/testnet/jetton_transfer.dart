import 'package:example/examples/testnet/tx.dart';
import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

/// Jetton (token) deploy + mint + transfer on **testnet**, basechain.
///
/// The same seed-122 wallet (index 0) is the minter admin and the initial token
/// holder; index 1 is the receiver. Amounts are intentionally small.
///
/// ```sh
/// dart run lib/examples/testnet/jetton_transfer.dart
/// ```
Future<void> main() async {
  final wallet = TestWallet<WalletV4>(version: WalletVersion.v4, index: 0, log: false);
  final receiver = TestWallet<WalletV4>(version: WalletVersion.v4, index: 1, log: false);

  final metadata = JettonOnChainMetadata.snakeFormat(
    name: 'TON DART TEST',
    description: 'Jetton test token for ton_dart examples',
    image: 'https://avatars.githubusercontent.com/u/56779182?s=96&v=4',
    symbol: 'TDT',
    decimals: 9,
  );
  final minter = JettonMinter.create(
    owner: wallet.wallet,
    state: MinterWalletState(owner: wallet.address, metadata: metadata),
  );

  print('Jetton deploy + mint + transfer (testnet, basechain)');
  print('  owner:    ${wallet.address.toRawAddress()}');
  print('  receiver: ${receiver.address.toRawAddress()}');
  print('  minter:   ${minter.address.toRawAddress()}');

  final balance = await wallet.wallet.getBalance(wallet.client);
  print('  balance:  ${TonHelper.fromNanoGrams(balance)} TON');
  if (balance < TonHelper.toNanoGrams('0.8')) {
    print('  fund the owner with at least 0.8 TON and rerun');
    return;
  }

  // The mint message carries the minter state init, so this also deploys the
  // minter on first use.
  final mintTx = await minter.sendOperation(
    signerParams: VersionedTransferParams(privateKey: wallet.signer),
    client: wallet.client,
    amount: TonHelper.toNanoGrams('0.3'),
    operation: JettonMinterMint(
      totalTonAmount: TonHelper.toNanoGrams('0.2'),
      to: wallet.address,
      transfer: JettonMinterInternalTransfer(
        jettonAmount: TonHelper.toNanoGrams('1000'),
        forwardTonAmount: TonHelper.toNanoGrams('0.01'),
      ),
      jettonAmount: TonHelper.toNanoGrams('1000'),
    ),
  );
  print('  mint tx:  ${txHash(mintTx)}');
  print('  explorer: ${txExplorer(mintTx)}');

  await Future.delayed(const Duration(seconds: 20));

  final jettonWallet = await minter.getJettonWalletContract(
    client: wallet.client,
    owner: wallet.wallet,
  );
  final ownerJettonBalance = await jettonWallet.getBalance(wallet.client);
  print('  owner jetton balance: $ownerJettonBalance');

  final transferTx = await jettonWallet.sendOperation(
    signerParams: VersionedTransferParams(privateKey: wallet.signer),
    client: wallet.client,
    amount: TonHelper.toNanoGrams('0.15'),
    operation: JettonWalletTransfer(
      amount: TonHelper.toNanoGrams('100'),
      destination: receiver.address,
      forwardTonAmount: TonHelper.toNanoGrams('0.01'),
      responseDestination: wallet.address,
    ),
  );
  print('  transfer tx: ${txHash(transferTx)}');
  print('  explorer:    ${txExplorer(transferTx)}');

  await Future.delayed(const Duration(seconds: 20));

  final receiverJettonWallet = await minter.getJettonWalletContract(
    client: wallet.client,
    owner: receiver.wallet,
  );
  print('  receiver jetton balance: '
      '${await receiverJettonWallet.getBalance(wallet.client)}');
}