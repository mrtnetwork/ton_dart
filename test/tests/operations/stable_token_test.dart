import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

void main() {
  _mint();
}

void _mint() {
  test("mint", () {
    final Cell cell = Cell.fromBase64(
        "te6cckEBAgEAbgABY2QrfQcAAAAAAAAAAIAOg31rlDkfhXhgiiol6SbgW7dPz5sztQKZnz8lclUPsah3NZQBAQBtF41FGQAAAAAAAAAAgDWVoaDoC+AIAOg31rlDkfhXhgiiol6SbgW7dPz5sztQKZnz8lclUPsaAlN4lsk=");
    final operation =
        StableJettonMinterOperation.deserialize(cell.beginParse());
    final fromJson = StableJettonMinterOperation.fromJson(operation.toJson());
    expect(fromJson.type, StableJettonMinterOperationType.mint);
    final mint = fromJson as StableJettonMinterMint;
    expect(mint.totalTonAmount, TonHelper.toNano("1"));
    expect(mint.transfer.jettonAmount, TonHelper.toNano("241323123"));
    expect(mint.transfer.forwardTonAmount, BigInt.zero);
  });
  test("mint", () {
    final Cell cell = Cell.fromHex(
        "b5ee9c7241010201004f000163642b7d070000000000000000800e837d6b94391f8578608a2a25e926e05bb74fcf9b33b502999f3f2572550fb1a82faf080101002f178d4519000000000000000060a1afb3546000405f5e10046f7b6a90");
    final operation =
        StableJettonMinterOperation.deserialize(cell.beginParse());
    final fromJson = StableJettonMinterOperation.fromJson(operation.toJson());
    expect(fromJson.type, StableJettonMinterOperationType.mint);
    final mint = fromJson as StableJettonMinterMint;
    expect(mint.totalTonAmount, TonHelper.toNano("0.4"));
    expect(mint.transfer.jettonAmount, TonHelper.toNano("11111"));
    expect(mint.transfer.forwardTonAmount, TonHelper.toNano("0.1"));
  });

  test("burn wallet token from minter", () {
    final Cell cell = Cell.fromHex(
        "b5ee9c72410102010049000163235caf520000000000000000800e837d6b94391f8578608a2a25e926e05bb74fcf9b33b502999f3f2572550fb1a80bebc201010023595f07bc0000000000000000519d81d96001f12d17af");
    final operation =
        StableJettonMinterOperation.deserialize(cell.beginParse());
    final fromJson = StableJettonMinterOperation.fromJson(operation.toJson());
    expect(fromJson.type, StableJettonMinterOperationType.callTo);
    final callTo = fromJson.cast<StableJettonMinterCallTo>();
    expect(callTo.address,
        TonAddress("EQB0G-tcocj8K8MEUVEvSTcC3bp-fNmdqBTM-fkrkqh9jeck"));
    expect(callTo.operation.type, StableJettonWalletOperationType.burn);
    final callToOperation = callTo.operation.cast<StableJettonWalletBurn>();
    expect(callToOperation.jettonAmount, TonHelper.toNano("111"));
  });
  test("transfer", () {
    final Cell cell = Cell.fromBase64(
        "te6cckEBAQEAOgAAbw+KfqUAAAAAAAAAAFF0h26ACAH3D7O6FBGij0TZ1H5KbV0KPhICZx2dzw6m01NYsNKRyBAX14QB1Igwsw==");
    final operation =
        StableJettonWalletOperation.deserialize(cell.beginParse());
    final fromJson = StableJettonWalletOperation.fromJson(operation.toJson());
    expect(fromJson.type, StableJettonWalletOperationType.transfer);
    final callTo = fromJson.cast<StableJettonWalletTransfer>();
    expect(callTo.to,
        TonAddress("EQD7h9ndCgjRR6Js6j8lNq6FHwkBM47O54dTaamsWGlI5CMv"));
    expect(callTo.jettonAmount, TonHelper.toNano("100"));
    expect(callTo.forwardTonAmount, TonHelper.toNano("0.1"));
  });
}

/// te6cckEBAQEAOgAAbw+KfqUAAAAAAAAAAFF0h26ACAH3D7O6FBGij0TZ1H5KbV0KPhICZx2dzw6m01NYsNKRyBAX14QB1Igwsw==
