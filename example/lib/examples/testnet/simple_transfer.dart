import 'package:example/examples/testnet/tx.dart';
import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

/// TON simple transfer on **testnet** through the basechain.
///
/// The sender and receiver are deterministic wallets (seed 122, index 0/1) from
/// the shared [TestWallet] helper. Fund the sender before running:
///
/// ```sh
/// dart run lib/examples/testnet/simple_transfer.dart
/// ```
Future<void> main() async {
  final sender = TestWallet<WalletV4>(version: WalletVersion.v4, index: 0, log: false);
  final receiver = TestWallet<WalletV4>(version: WalletVersion.v4, index: 1, log: false);

  print('TON testnet simple transfer (basechain)');
  print('  sender:   ${sender.address.toRawAddress()}');
  print('  receiver: ${receiver.address.toRawAddress()}');

  final before = await sender.wallet.getBalance(sender.client);
  print('  balance before: ${TonHelper.fromNanoGrams(before)} TON');
  if (before < TonHelper.toNanoGrams('0.02')) {
    print('  fund the sender with at least 0.02 TON and rerun');
    return;
  }

  final tx = await sender.wallet.sendTransfer(
    params: VersionedTransferParams(
      privateKey: sender.signer,
      messages: [
        OutActionSendMsg(
          outMessage: TonHelper.internal(
            destination: receiver.address,
            amount: TonHelper.toNanoGrams('0.01'),
          ),
        ),
      ],
    ),
    client: sender.client,
  );
  print('  tx: ${txHash(tx)}');
  print('  explorer: ${txExplorer(tx)}');

  await Future.delayed(const Duration(seconds: 15));

  final after = await sender.wallet.getBalance(sender.client);
  final receiverBalance = await receiver.wallet.getBalance(receiver.client);
  print('  balance after:  ${TonHelper.fromNanoGrams(after)} TON');
  print('  receiver:       ${TonHelper.fromNanoGrams(receiverBalance)} TON');
}