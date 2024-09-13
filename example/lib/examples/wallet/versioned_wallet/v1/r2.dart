import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final TestWallet<WalletV1R2> wallet = TestWallet(version: WalletVersion.v1R2);
  final destination = TestWallet(version: WalletVersion.v1R3);
  await wallet.wallet.sendTransfer(
      params: VersionedTransferParams(privateKey: wallet.signer, messages: [
        OutActionSendMsg(
            outMessage: TransactioUtils.internal(
                destination: destination.address,
                amount: TonHelper.toNano("4.3")))
      ]),
      rpc: wallet.rpc);
  final publicKey = await wallet.wallet.getPublicKey(wallet.rpc);
  assert(publicKey == wallet.signer.toPublicKey().toHex());
  final state = await wallet.wallet.readState(wallet.rpc);
  assert(BytesUtils.bytesEqual(
      state.publicKey, wallet.signer.toPublicKey().toBytes()));
  await WalletV1R2.fromAddress(address: wallet.address, rpc: wallet.rpc);

  /// https://testnet.tonscan.org/address/kf9PppquOLEHxw89z20d_aRKhRuVN3po1FnNmxoTwpI6TjNo
  /// te6cckECBAEAAR4AA9GJ/p9NNVxxYg+OHnue2jv7SJUKNypu9NGos5s2NCeFJHScEZ4+wlW9RyWOJ//yi4pbFZIAzrES/1KBtv4QAHdlissp5Bt9XlkrImuNzj0wnIW1JjYx0JHl5t8EEK6vdTe/LcCgAAAAADABAgMAov8AIN0gggFMl7qXMO1E0NcLH+Ck8mCBAgDXGCDXCx/tRNDTH9P/0VESuvKhIvkBVBBE+RDyovgAAdMfMSDXSpbTB9QC+wDe0aTIyx/L/8ntVABIAAAAAKtgoEJ1ZN5Mh+qkE6uI0oqj1O+J3xvj4fEVxGNbJdrrAGpCf+T222vdI+gGe/iYGArf7PUYvXHt1PIr1bG3SupogDWdKAgCZlgAAAAAAAAAAAAAAAAAAIDYq7Q=
}
