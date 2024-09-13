import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final TestWallet<WalletV1R1> wallet = TestWallet(version: WalletVersion.v1R1);
  final destination = TestWallet(version: WalletVersion.v1R2);
  await wallet.wallet.sendTransfer(
      params: VersionedTransferParams(privateKey: wallet.signer, messages: [
        OutActionSendMsg(
            outMessage: TransactioUtils.internal(
                destination: destination.address,
                amount: TonHelper.toNano("4.5")))
      ]),
      rpc: wallet.rpc);
  await wallet.wallet.getBalance(wallet.rpc);
  final publicKey = await wallet.wallet.getPublicKey(wallet.rpc);
  assert(publicKey == wallet.signer.toPublicKey().toHex());
  final state = await wallet.wallet.readState(wallet.rpc);
  assert(BytesUtils.bytesEqual(
      state.publicKey, wallet.signer.toPublicKey().toBytes()));
  await WalletV1R1.fromAddress(address: wallet.address, rpc: wallet.rpc);

  /// https://testnet.tonscan.org/address/kf9serWJThPWFoZqR5ad3GSjWsGmY8I_8d3IQuKOyIlODJlh
}
