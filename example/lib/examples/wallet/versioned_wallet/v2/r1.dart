import 'package:blockchain_utils/utils/binary/utils.dart';
import 'package:example/examples/wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final TestWallet<WalletV2R1> wallet = TestWallet(version: WalletVersion.v2R1);
  final destination = TestWallet(version: WalletVersion.v2R2);
  await wallet.wallet.sendTransfer(
      params: VersionedTransferParams(privateKey: wallet.signer, messages: [
        OutActionSendMsg(
            outMessage: TransactioUtils.internal(
                destination: destination.address,
                amount: TonHelper.toNano("3.9")))
      ]),
      rpc: wallet.rpc);
  await wallet.wallet.getBalance(wallet.rpc);
  final publicKey = await wallet.wallet.getPublicKey(wallet.rpc);
  assert(publicKey == wallet.signer.toPublicKey().toHex());
  final state = await wallet.wallet.readState(wallet.rpc);
  assert(BytesUtils.bytesEqual(
      state.publicKey, wallet.signer.toPublicKey().toBytes()));
  await WalletV2R1.fromAddress(address: wallet.address, rpc: wallet.rpc);

  /// https://testnet.tonscan.org/address/kf9PppquOLEHxw89z20d_aRKhRuVN3po1FnNmxoTwpI6TjNo
  /// te6cckECBAEAASUAA9mJ/6r/sDgx0V89qt3W0WmEgyt6WuQwDtrnAUfkSnIvNqReEZtEP5LQx+sw0R4cKV5s+H4O6bUfgXwohyTiCS7x6Ypv/IC1e4NuEVDD3WwX0b8MY8jUTt5V8HbWzfMiReRFDMHgAAAAH////+AwAQIDAKr/ACDdIIIBTJe6lzDtRNDXCx/gpPJggwjXGCDTH9MfAfgju/Jj7UTQ0x/T/9FRMbryoQP5AVQQQvkQ8qL4AAKTINdKltMH1AL7AOjRpMjLH8v/ye1UAEgAAAAAq2CgQnVk3kyH6qQTq4jSiqPU74nfG+Ph8RXEY1sl2usAaEJ/wNzpXSCNWkjyB6KI7uAJadnuP+GA3Y0Nj84gaklvgHCnQ6o4AAAAAAAAAAAAAAAAAAAKyyGV
}
