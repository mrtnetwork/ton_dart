import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

void main() {
  _collection();
  _item();
}

/// b5ee9c724101010100550000a55fcc3d1400000000000000009ff790b777c46e60bbc5d4f40d616b6cb2ae29738b7b3535f00072c506a0862cdb13fccf0baa640ab0441013ffa2dbac5a2b0106cababb0b63087a01f9adfc995bc5f07312d008e6f0dfe0
void _item() {
  test("transfer nft", () {
    final body = Cell.fromHex(
        "b5ee9c7241010101003100005d5fcc3d1400000000000000009ff790b777c46e60bbc5d4f40d616b6cb2ae29738b7b3535f00072c506a0862cdb00109f758314");
    final deserializeOperation =
        NFTItemOperation.deserialize(body.beginParse());
    final operation = NFTItemOperation.fromJson(deserializeOperation.toJson());
    expect(operation.type, NFTItemOperationType.transfer);
    final mint = operation.cast<NFTItemTransfer>();
    expect(mint.newOwnerAddress,
        TonAddress("kf-8hbu-I3MF3i6noGsLW2WVcUucW9mpr4ADlig1BDFm2HQz"));
  });
}

/// b5ee9c7241010101003100005d5fcc3d1400000000000000009ff790b777c46e60bbc5d4f40d616b6cb2ae29738b7b3535f00072c506a0862cdb00109f758314
void _collection() {
  test("mint", () {
    final body = Cell.fromBase64(
        "te6cckEBAwEAVwABMQAAAAEAAAAAAAAAAAAAAAAAAAAAQdzWUAgBAUOf5nhdUyBVgiCAn/0W3WLRWAg2VdXYWxhD0A/Nb+TK3i+QAgAoLz9maWxlbmFtZT1uZnQxLmpzb24j2HoI");
    final deserializeOperation =
        NFTCollectionOperation.deserialize(body.beginParse());
    final operation =
        NFTCollectionOperation.fromJson(deserializeOperation.toJson());
    expect(operation.type, NFTCollectionOperationType.mint);
    final mint = operation.cast<NFTCollectionMint>();
    expect(mint.mint.itemIndex, BigInt.zero);
    expect(mint.mint.initAmount, TonHelper.toNano("0.5"));
    expect(mint.mint.ownerAddress,
        TonAddress("kf8zwuqZAqwRBAT_6LbrForAQbKursLYwh6Afmt_JlbxfGJm"));
    final metadata = mint.mint.metadata.cast<NFTItemMetadata>();
    expect(metadata.uri, "/?filename=nft1.json");
  });
  test("mint2", () {
    final body = Cell.fromBase64(
        "te6cckEBAwEAVwABMQAAAAEAAAAAAAAAAAAAAAAAAAABQL68IAgBAUOf5nhdUyBVgiCAn/0W3WLRWAg2VdXYWxhD0A/Nb+TK3i+QAgAoLz9maWxlbmFtZT1uZnQyLmpzb26MmMBk");
    final deserializeOperation =
        NFTCollectionOperation.deserialize(body.beginParse());
    final operation =
        NFTCollectionOperation.fromJson(deserializeOperation.toJson());
    expect(operation.type, NFTCollectionOperationType.mint);
    final mint = operation.cast<NFTCollectionMint>();
    expect(mint.mint.itemIndex, BigInt.one);
    expect(mint.mint.initAmount, TonHelper.toNano("0.2"));
    expect(mint.mint.ownerAddress,
        TonAddress("kf8zwuqZAqwRBAT_6LbrForAQbKursLYwh6Afmt_JlbxfGJm"));
    final metadata = mint.mint.metadata.cast<NFTItemMetadata>();
    expect(metadata.uri, "/?filename=nft2.json");
  });
  test("batch mint", () {
    final body = Cell.fromBase64(
        "te6cckEBDAEA5QABGQAAAAIAAAAAAAAAAMABAgPPYAIJAgFYAwYBCRAvrwgCBAFDn+Z4XVMgVYIggJ/9Ft1i0VgINlXV2FsYQ9APzW/kyt4vkAUAKC8/ZmlsZW5hbWU9bmZ0Mi5qc29uAQkQL68IAgcBQ5/meF1TIFWCIICf/RbdYtFYCDZV1dhbGEPQD81v5MreL5AIACgvP2ZpbGVuYW1lPW5mdDMuanNvbgEL0gX14QBACgFDn+Z4XVMgVYIggJ/9Ft1i0VgINlXV2FsYQ9APzW/kyt4vkAsAKC8/ZmlsZW5hbWU9bmZ0NC5qc29uHm0KPQ==");
    final deserializeOperation =
        NFTCollectionOperation.deserialize(body.beginParse());
    final operation =
        NFTCollectionOperation.fromJson(deserializeOperation.toJson());
    expect(operation.type, NFTCollectionOperationType.batchMint);
    final mint = operation.cast<NFTCollectionBatchMint>();
    expect(mint.nfts.length, 3);
    for (int i = 0; i < mint.nfts.length; i++) {
      final nft = mint.nfts[i];
      final itemIndex = BigInt.two + BigInt.from(i);
      expect(nft.itemIndex, itemIndex);
      expect(nft.initAmount, TonHelper.toNano("0.2"));
      expect(nft.ownerAddress,
          TonAddress("kf8zwuqZAqwRBAT_6LbrForAQbKursLYwh6Afmt_JlbxfGJm"));
      final metadata = nft.metadata.cast<NFTItemMetadata>();
      expect(metadata.uri, "/?filename=nft$itemIndex.json");
    }
  });
  test("change owner", () {
    final body = Cell.fromBase64(
        "te6cckEBAQEAMAAAWwAAAAMAAAAAAAAAAJ/3kLd3xG5gu8XU9A1ha2yyrilzi3s1NfAAcsUGoIYs2xDpTXHZ");
    final deserializeOperation =
        NFTCollectionOperation.deserialize(body.beginParse());
    final operation =
        NFTCollectionOperation.fromJson(deserializeOperation.toJson());
    expect(operation.type, NFTCollectionOperationType.changeOwner);
    final changeOwner = operation.cast<NFTCollectionChangeOwner>();
    expect(changeOwner.newOwnerAddress,
        TonAddress("kf-8hbu-I3MF3i6noGsLW2WVcUucW9mpr4ADlig1BDFm2HQz"));
  });
}

/// te6cckEBDAEA5QABGQAAAAIAAAAAAAAAAMABAgPPYAIJAgFYAwYBCRAvrwgCBAFDn+Z4XVMgVYIggJ/9Ft1i0VgINlXV2FsYQ9APzW/kyt4vkAUAKC8/ZmlsZW5hbWU9bmZ0Mi5qc29uAQkQL68IAgcBQ5/meF1TIFWCIICf/RbdYtFYCDZV1dhbGEPQD81v5MreL5AIACgvP2ZpbGVuYW1lPW5mdDMuanNvbgEL0gX14QBACgFDn+Z4XVMgVYIggJ/9Ft1i0VgINlXV2FsYQ9APzW/kyt4vkAsAKC8/ZmlsZW5hbWU9bmZ0NC5qc29uHm0KPQ==
