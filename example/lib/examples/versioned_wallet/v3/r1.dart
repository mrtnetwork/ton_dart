import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:example/examples/versioned_wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final TestWallet<WalletV3R1> wallet = TestWallet(version: WalletVersion.v3R1);
  final destination = TestWallet(version: WalletVersion.v3R2);
  final destination1 = TestWallet(version: WalletVersion.v4);
  final destination2 = TestWallet(version: WalletVersion.v5R1);
  await wallet.wallet.sendTransfer(
      params: VersionedTransferParams(privateKey: wallet.signer, messages: [
        OutActionSendMsg(
            outMessage: TransactioUtils.internal(
                destination: destination.address,
                amount: TonHelper.toNano("3.3"))),
        OutActionSendMsg(
            outMessage: TransactioUtils.internal(
                destination: destination1.address,
                amount: TonHelper.toNano("0.001"))),
        OutActionSendMsg(
            outMessage: TransactioUtils.internal(
                destination: destination2.address,
                amount: TonHelper.toNano("0.001")))
      ]),
      rpc: wallet.rpc);
  await wallet.wallet.getBalance(wallet.rpc);
  final publicKey = await wallet.wallet.getPublicKey(wallet.rpc);
  assert(publicKey == wallet.signer.toPublicKey().toHex());
  final state = await wallet.wallet.readState(wallet.rpc);
  assert(BytesUtils.bytesEqual(
      state.publicKey, wallet.signer.toPublicKey().toBytes()));
  assert(state.subwallet == wallet.wallet.state!.subwallet);
  await WalletV3R1.fromAddress(address: wallet.address, rpc: wallet.rpc);
}
