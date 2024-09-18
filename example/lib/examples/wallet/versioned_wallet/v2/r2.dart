import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final TestWallet<WalletV2R2> wallet = TestWallet(version: WalletVersion.v2R2);
  final destination = TestWallet(version: WalletVersion.v3R1);
  final destination1 = TestWallet(version: WalletVersion.v4);
  final destination2 = TestWallet(version: WalletVersion.v5R1);
  await wallet.wallet.sendTransfer(
      params: VersionedTransferParams(privateKey: wallet.signer, messages: [
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination.address,
                amount: TonHelper.toNano("3.6"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination1.address,
                amount: TonHelper.toNano("0.001"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination2.address,
                amount: TonHelper.toNano("0.001")))
      ]),
      rpc: wallet.rpc);

  await wallet.wallet.getBalance(wallet.rpc);
  final publicKey = await wallet.wallet.getPublicKey(wallet.rpc);
  assert(publicKey == wallet.signer.toPublicKey().toHex());
  final state = await wallet.wallet.readState(wallet.rpc);
  assert(BytesUtils.bytesEqual(
      state.publicKey.toBytes(), wallet.signer.toPublicKey().toBytes()));
  await WalletV2R2.fromAddress(address: wallet.address, rpc: wallet.rpc);
}
