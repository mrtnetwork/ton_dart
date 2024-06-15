import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

void main() {
  group("Message", () => _test());
}

void _test() {
  test('should handle edge case with extra currency', () {
    const tx =
        'te6cckEBBwEA3QADs2gB7ix8WDhQdzzFOCf6hmZ2Dzw2vFNtbavUArvbhXqqqmEAMpuMhx8zp7O3wqMokkuyFkklKpftc4Dh9_5bvavmCo-UXR6uVOIGMkCwAAAAAAC3GwLLUHl_4AYCAQCA_____________________________________________________________________________________gMBPAUEAwFDoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAOAUACAAAAAAAAAANoAAAAAEIDF-r-4Q';

    final cell = Cell.fromBase64(tx);
    final message = Message.deserialize(cell.beginParse());
    final stored = beginCell();
    message.store(stored);
    expect(stored.endCell(), cell);
    final decodeJson = Message.fromJson(message.toJson());
    expect(decodeJson.body.toBase64(),
        "te6cckEBAQEAQgAAgP////////////////////////////////////////////////////////////////////////////////////4S1gKN");
    expect(decodeJson.info.type, CommonMessageInfoType.internal);
    final msg = decodeJson.info as CommonMessageInfoInternal;
    expect(msg.bounce, true);
    expect(msg.bounced, false);
    expect(msg.src.toFriendlyAddress(),
        "EQD3Fj4sHCg7nmKcE_1DMzsHnhteKba21eoBXe3CvVVVMOGu");
    expect(msg.dest.toFriendlyAddress(),
        "EQDKbjIcfM6ezt8KjKJJLshZJJSqX7XOA4ff-W72r5gqPrHF");
    expect(msg.value.coins, BigInt.from(99986675000));
    expect(msg.ihrFee, BigInt.zero);
    expect(msg.forwardFee, BigInt.from(1646680));
    expect(msg.createdLt, BigInt.from(6000001));
    expect(msg.createdAt, 1705524415);
  });
}
