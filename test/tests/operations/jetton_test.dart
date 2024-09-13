import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

void main() {
  _mint();
}

/// te6cckEBAQEAFAAAI1lfB7wAAAAAAAAAAFTYhYwgAQaKm+g=
void _mint() {
  test("Burn", () {
    final body =
        Cell.fromBase64("te6cckEBAQEAFAAAI1lfB7wAAAAAAAAAAFTYhYwgAQaKm+g=");
    final deserializeOperation =
        JettonWalletOperation.deserialize(body.beginParse());
    final operation =
        JettonWalletOperation.fromJson(deserializeOperation.toJson());
    expect(operation.type, JettonWalletOperationType.burn);
    final mint = operation.cast<JettonWalletBurn>();
    expect(mint.burnAmount, TonHelper.toNano("333"));
  });
  test("Transfer", () {
    final body = Cell.fromBase64(
        "te6cckEBAQEANQAAZQ+KfqUAAAAAAAAAAEstBeAJ/3kLd3xG5gu8XU9A1ha2yyrilzi3s1NfAAcsUGoIYs2wAZVfpzA=");
    final deserializeOperation =
        JettonWalletOperation.deserialize(body.beginParse());
    final operation =
        JettonWalletOperation.fromJson(deserializeOperation.toJson());
    expect(operation.type, JettonWalletOperationType.transfer);
    final mint = operation.cast<JettonWalletTransfer>();
    expect(mint.destination,
        TonAddress("kf-8hbu-I3MF3i6noGsLW2WVcUucW9mpr4ADlig1BDFm2HQz"));
    expect(mint.amount, TonHelper.toNano("3"));
    expect(mint.forwardTonAmount, BigInt.zero);
  });
  test("Mint", () {
    final body = Cell.fromBase64(
        "te6cckEBAgEAVQABcQAAABUAAAAAAAAAAJ/meF1TIFWCIICf/RbdYtFYCDZV1dhbGEPQD81v5MreL4g7msoAy15iD0gAEAEALReNRRkAAAAAAAAAAGWvMQekAAA5iWgE93fVgg==");
    final deserializeOperation =
        JettonMinterOperation.deserialize(body.beginParse());
    final operation =
        JettonMinterOperation.fromJson(deserializeOperation.toJson());
    expect(operation.type, JettonMinterOperationType.mint);
    final mint = operation.cast<JettonMinterMint>();
    expect(mint.to,
        TonAddress("kf8zwuqZAqwRBAT_6LbrForAQbKursLYwh6Afmt_JlbxfGJm"));
    expect(mint.totalTonAmount, TonHelper.toNano("0.5"));
    expect(mint.jettonAmount, TonHelper.toNano("100000"));
    expect(mint.transfer.forwardTonAmount, TonHelper.toNano("0.01"));
  });
  test("ChangeContent", () {
    final body = Cell.fromHex(
        "b5ee9c724102100100015a00011800000004000000000000000001010300c00202012003050143bff082eb663b57a00192f4a6ac467288df2dfeddb9da1bee28f6521c8bebd21f1ec00400740068747470733a2f2f617661746172732e67697468756275736572636f6e74656e742e636f6d2f752f35363737393138323f733d393626763d34020120060b02012007090141bf4546a6ffe1b79cfdd86bad3db874313dcde2fb05e6a74aa7f3552d9617c79d13080016004d5254204a4554544f4e0141bf6ed4f942a7848ce2cb066b77a1128c6a1ff8c43f438a2dce24612ba9ffab8b030a0008004d52540201200c0e0141bf5208def46f5a1d4f9dce66ab309f4a851305f166f91ef79d923ef58e34f9a2090d004e0068747470733a2f2f6769746875622e636f6d2f6d72746e6574776f726b2f746f6e5f646172740141bf5d01fa5e3c06901c45046c6b2ddcea5af764fea0eed72a10d404f2312ceb247d0f000600313204d8a8f0");
    final deserializeOperation =
        JettonMinterOperation.deserialize(body.beginParse());
    final operation =
        JettonMinterOperation.fromJson(deserializeOperation.toJson());
    expect(operation.type, JettonMinterOperationType.changeContent);
    final changeContent = operation.cast<JettonMinterChangeContent>();
    expect(changeContent.contentMetaData.type, TokenContentType.onchain);
    final metadata =
        changeContent.contentMetaData.cast<JettonOnChainMetadata>();
    expect(metadata.image,
        "https://avatars.githubusercontent.com/u/56779182?s=96&v=4");
    expect(metadata.name, "MRT JETTON");
    expect(metadata.decimals, 12);
    expect(metadata.description, "https://github.com/mrtnetwork/ton_dart");
    expect(metadata.symbol, "MRT");
  });
  test("ChangeOwner", () {
    final body = Cell.fromHex(
        "b5ee9c7241010101003000005b0000000300000000000000009ff790b777c46e60bbc5d4f40d616b6cb2ae29738b7b3535f00072c506a0862cdb10e94d71d9");
    final deserializeOperation =
        JettonMinterOperation.deserialize(body.beginParse());
    final operation =
        JettonMinterOperation.fromJson(deserializeOperation.toJson());
    expect(operation.type, JettonMinterOperationType.changeAdmin);
    final changeOwner = operation.cast<JettonMinterChangeAdmin>();
    expect(changeOwner.newOwner,
        TonAddress("kf-8hbu-I3MF3i6noGsLW2WVcUucW9mpr4ADlig1BDFm2HQz"));
  });
}

/// b5ee9c7241010101003000005b0000000300000000000000009fe6785d5320558220809ffd16dd62d158083655d5d85b1843d00fcd6fe4cade2f90f7aa6ca5
