import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final extensionWallet = TestWallet<WalletV5R1>(version: WalletVersion.v5R1);

  final TestWallet<WalletV5R1> wallet =
      TestWallet(version: WalletVersion.v5R1, index: 96);

  await extensionWallet.wallet.sendTransfer(
      params:
          VersionedV5TransferParams.external(signer: extensionWallet.signer),
      messages: [
        TonHelper.internal(
            destination: wallet.address,
            amount: TonHelper.toNano("0.1"),
            body: wallet.wallet.createExtensionMessage(
                actions: [const OutActionSetIsPublicKeyEnabled(false)])),
      ],
      rpc: extensionWallet.rpc);
}
