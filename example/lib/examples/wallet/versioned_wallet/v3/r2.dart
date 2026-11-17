import 'package:blockchain_utils/utils/binary/src/utils.dart';
import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final TestWallet<WalletV3R2> wallet = TestWallet(version: WalletVersion.v3R2);
  final destination = TestWallet(version: WalletVersion.v4);
  final destination2 = TestWallet(version: WalletVersion.v5R1);
  await wallet.wallet.sendTransfer(
      params: VersionedTransferParams(privateKey: wallet.signer, messages: [
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination.address,
                amount: TonHelper.toNanoGrams("0.5"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination2.address,
                amount: TonHelper.toNanoGrams("0.4")))
      ]),
      client: wallet.client);
  await wallet.wallet.getBalance(wallet.client);
  final publicKey = await wallet.wallet.getPublicKey(wallet.client);
  assert(publicKey == wallet.signer.toPublicKey().toHex());
  final state = await wallet.wallet.readState(wallet.client);
  assert(BytesUtils.bytesEqual(
      state.publicKey.toBytes(), wallet.signer.toPublicKey().toBytes()));
  assert(state.subwallet == wallet.wallet.state!.subwallet);
  await WalletV3R2.fromAddress(address: wallet.address, client: wallet.client);
}
