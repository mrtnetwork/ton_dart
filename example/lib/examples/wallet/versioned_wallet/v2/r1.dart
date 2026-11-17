import 'package:blockchain_utils/utils/utils.dart';
import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final TestWallet<WalletV2R1> wallet = TestWallet(version: WalletVersion.v2R1);
  final destination = TestWallet(version: WalletVersion.v2R2);
  await wallet.wallet.sendTransfer(
      params: VersionedTransferParams(privateKey: wallet.signer, messages: [
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination.address,
                amount: TonHelper.toNanoGrams("3.9")))
      ]),
      client: wallet.client);
  await wallet.wallet.getBalance(wallet.client);
  final publicKey = await wallet.wallet.getPublicKey(wallet.client);
  assert(publicKey == wallet.signer.toPublicKey().toHex());
  final state = await wallet.wallet.readState(wallet.client);
  assert(BytesUtils.bytesEqual(
      state.publicKey.toBytes(), wallet.signer.toPublicKey().toBytes()));
  await WalletV2R1.fromAddress(address: wallet.address, client: wallet.client);

  /// https://testnet.tonscan.org/address/kf9PppquOLEHxw89z20d_aRKhRuVN3po1FnNmxoTwpI6TjNo
  /// te6cckECBAEAASUAA9mJ/6r/sDgx0V89qt3W0WmEgyt6WuQwDtrnAUfkSnIvNqReEZtEP5LQx+sw0R4cKV5s+H4O6bUfgXwohyTiCS7x6Ypv/IC1e4NuEVDD3WwX0b8MY8jUTt5V8HbWzfMiReRFDMHgAAAAH////+AwAQIDAKr/ACDdIIIBTJe6lzDtRNDXCx/gpPJggwjXGCDTH9MfAfgju/Jj7UTQ0x/T/9FRMbryoQP5AVQQQvkQ8qL4AAKTINdKltMH1AL7AOjRpMjLH8v/ye1UAEgAAAAAq2CgQnVk3kyH6qQTq4jSiqPU74nfG+Ph8RXEY1sl2usAaEJ/wNzpXSCNWkjyB6KI7uAJadnuP+GA3Y0Nj84gaklvgHCnQ6o4AAAAAAAAAAAAAAAAAAAKyyGV
}
