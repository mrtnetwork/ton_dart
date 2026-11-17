import 'package:blockchain_utils/utils/binary/src/utils.dart';
import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final TestWallet<WalletV1R1> wallet = TestWallet(version: WalletVersion.v1R1);
  final destination = TestWallet(version: WalletVersion.v1R2);
  await wallet.wallet.sendTransfer(
      params: VersionedTransferParams(privateKey: wallet.signer, messages: [
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination.address,
                amount: TonHelper.toNanoGrams("4.5")))
      ]),
      client: wallet.client);
  await wallet.wallet.getBalance(wallet.client);
  final publicKey = await wallet.wallet.getPublicKey(wallet.client);
  assert(publicKey == wallet.signer.toPublicKey().toHex());
  final state = await wallet.wallet.readState(wallet.client);
  assert(BytesUtils.bytesEqual(
      state.publicKey.toBytes(), wallet.signer.toPublicKey().toBytes()));
  await WalletV1R1.fromAddress(address: wallet.address, client: wallet.client);

  /// https://testnet.tonscan.org/address/kf9serWJThPWFoZqR5ad3GSjWsGmY8I_8d3IQuKOyIlODJlh
}
