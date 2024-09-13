import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

void main() {
  group("Token data", () {
    test("Mint", () {
      const body =
          "b5ee9c724101020100790001730000001500000000000000009ff4610d333687fab6317886baba916f1e908c55a7470e72bec9eb202058e52e2d082faf0800e071afd498d00010010073178d451900000000000000007038d7ea4c6800027ff59f4c0f3039140d56bb3bef5b17e9ca0118e2007174a0a6d36640edfa923c6da08f0d1802a38d780f";
      final decode =
          JettonMinterOperation.deserialize(Cell.fromHex(body).beginParse());
      expect(decode.type, JettonMinterOperationType.mint);
      final mint = decode.cast<JettonMinterMint>();
      final forwardAmount = TonHelper.toNano("0.3");
      final totalAmount = TonHelper.toNano("0.4");
      final jettonAmountForMint = BigInt.parse("1${"0" * 15}");

      expect(mint.transfer.forwardTonAmount, forwardAmount);
      expect(mint.totalTonAmount, totalAmount);
      expect(mint.transfer.jettonAmount, jettonAmountForMint);
      expect(decode.serialize().toHex(), body);
    });
    test("Change content OFFChain", () {
      const body =
          "b5ee9c7241010201002f00011800000004000000000000000001003c0168747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726bf9b4eb62";
      final decode =
          JettonMinterOperation.deserialize(Cell.fromHex(body).beginParse());
      expect(decode.type, JettonMinterOperationType.changeContent);
      final mint = decode.cast<JettonMinterChangeContent>();

      expect(mint.contentMetaData.type, TokenContentType.offchain);
      final metadata = mint.contentMetaData.cast<JettonOffChainMetadata>();
      expect(metadata.uri, "https://github.com/mrtnetwork");
      expect(decode.serialize().toHex(), body);
    });
    test("Change content OnChain", () {
      const body =
          "b5ee9c724102100100015a00011800000004000000000000000001010300c00202012003050143bff082eb663b57a00192f4a6ac467288df2dfeddb9da1bee28f6521c8bebd21f1ec00400740068747470733a2f2f617661746172732e67697468756275736572636f6e74656e742e636f6d2f752f35363737393138323f733d393626763d34020120060b02012007090141bf4546a6ffe1b79cfdd86bad3db874313dcde2fb05e6a74aa7f3552d9617c79d13080018004d5254204e4554574f524b0141bf6ed4f942a7848ce2cb066b77a1128c6a1ff8c43f438a2dce24612ba9ffab8b030a0008004d52540201200c0e0141bf5208def46f5a1d4f9dce66ab309f4a851305f166f91ef79d923ef58e34f9a2090d004e0068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b2f746f6e5f646172740141bf5d01fa5e3c06901c45046c6b2ddcea5af764fea0eed72a10d404f2312ceb247d0f00040039a21978ee";
      final decode =
          JettonMinterOperation.deserialize(Cell.fromHex(body).beginParse());
      expect(decode.type, JettonMinterOperationType.changeContent);
      final mint = decode.cast<JettonMinterChangeContent>();

      expect(mint.contentMetaData.type, TokenContentType.onchain);
      final metadata = mint.contentMetaData.cast<JettonOnChainMetadata>();
      expect(metadata.image,
          "https://avatars.githubusercontent.com/u/56779182?s=96&v=4");
      expect(metadata.symbol, "MRT");
      expect(metadata.description, "https://github.com/mrtnetwork/ton_dart");
      expect(metadata.decimals, 9);
      expect(metadata.name, "MRT NETWORK");
      expect(decode.serialize().toHex(), body);
    });
  });
}

///
