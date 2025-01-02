import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

void main() {
  group('Jetton wallet', () {
    test('Transfer', () {
      const body =
          'b5ee9c724101010100570000aa0f8a7ea500000000000000005367b7ca4009ff8de0d1830272cc1610f05953efb58f63050e0b0d05563edda5b8fe57ff21bc293fe8c21a666d0ff56c62f10d757522de3d2118ab4e8e1ce57d93d64040b1ca5c5a006d52c616';
      final decode =
          JettonWalletOperation.deserialize(Cell.fromHex(body).beginParse());
      expect(decode.type, JettonWalletOperationType.transfer);
      final transfer = decode.cast<JettonWalletTransfer>();
      expect(transfer.amount, TonHelper.toNano('234'));
      expect(transfer.forwardTonAmount, BigInt.zero);
      expect(decode.serialize().toHex(), body);
    });
  });
}
