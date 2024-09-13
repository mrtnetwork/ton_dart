import 'package:example/examples/versioned_wallet/test_wallet.dart';
import 'package:ton_dart/ton_dart.dart';

void main() async {
  final wallet = TestWallet<WalletV5R1>(version: WalletVersion.v5R1, index: 96);
  final newOwner =
      TestWallet<WalletV5R1>(version: WalletVersion.v5R1, index: 96);

  final jetton = await JettonMinter.fromAddress(
      owner: wallet.wallet,
      address: TonAddress("Ef9sa8u1xuh6V5-ueNUEEiOYIjxxAQlqRAZ__7GGc_yJ5Lqf"),
      rpc: wallet.rpc);
  await jetton.sendOperation(
      signerParams: VersionedV5TransferParams.external(signer: wallet.signer),
      rpc: wallet.rpc,
      amount: TonHelper.toNano("0.1"),
      operation: JettonMinterChangeAdmin(newOwner: newOwner.address),
      bounce: false);
  await Future.delayed(const Duration(seconds: 20));
  final state = await jetton.getJettonData(wallet.rpc);
  assert(state.owner == newOwner.address);
}
