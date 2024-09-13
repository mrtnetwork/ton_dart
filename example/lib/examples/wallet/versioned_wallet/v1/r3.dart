import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final TestWallet<WalletV1R3> wallet = TestWallet(version: WalletVersion.v1R3);
  final destination = TestWallet(version: WalletVersion.v2R1);
  await wallet.wallet.sendTransfer(
      params: VersionedTransferParams(privateKey: wallet.signer, messages: [
        OutActionSendMsg(
            outMessage: TransactioUtils.internal(
                destination: destination.address,
                amount: TonHelper.toNano("4.1")))
      ]),
      rpc: wallet.rpc);
  await wallet.wallet.getBalance(wallet.rpc);
  final publicKey = await wallet.wallet.getPublicKey(wallet.rpc);
  assert(publicKey == wallet.signer.toPublicKey().toHex());
  final state = await wallet.wallet.readState(wallet.rpc);
  assert(BytesUtils.bytesEqual(
      state.publicKey, wallet.signer.toPublicKey().toBytes()));
  await WalletV1R3.fromAddress(address: wallet.address, rpc: wallet.rpc);
}
