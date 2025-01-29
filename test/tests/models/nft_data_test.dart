import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

void main() {
  group('NFT body', () {
    test('edit content', () {
      const body =
          'b5ee9c724101050100dd00021800000004000000000000000001040200020300b00168747470733a2f2f697066732e696f2f697066732f516d536b317145594e517a4e5853664437705852586a6571574d3974457133766d64424d3367616b4132374d794e3f66696c656e616d653d69706632332e6a736f6e008a68747470733a2f2f697066732e696f2f6970667333322f516d536b317145594e517a4e5853664437705852586a6571574d3974457133766d64424d3367616b4132374d794e004b000a03e89fedf42aa27b4f307df0a993d16f13df5c7e208f2a988bf683ed116fa98202a6c3905c229b88';
      final decode =
          NFTCollectionOperation.deserialize(Cell.fromHex(body).beginParse());
      expect(decode.type, NFTCollectionOperationType.changeContent);
      final changeContent = decode.cast<NFTEditableCollectionChangeContent>();
      expect(changeContent.royaltyParams.address,
          TonAddress('Uf9voVUT2nmD74VMnot4nvrj8QR5VMRftB9oi31MEBU2HKBJ'));
      expect(changeContent.royaltyParams.royaltyFactor, 10);
      expect(changeContent.royaltyParams.royaltyBase, 1000);
      final metadata = changeContent.metadata.cast<NFTCollectionMetadata>();
      expect(metadata.collectionBase,
          'https://ipfs.io/ipfs32/QmSk1qEYNQzNXSfD7pXRXjeqWM9tEq3vmdBM3gakA27MyN');
      expect(metadata.collectionMetadataUri,
          'https://ipfs.io/ipfs/QmSk1qEYNQzNXSfD7pXRXjeqWM9tEq3vmdBM3gakA27MyN?filename=ipf23.json');
      expect(decode.serialize().toHex(), body);
    });
    test('mint', () {
      const body =
          'b5ee9c724101030100550001310000000100000000000000000000000000000000405f5e10080101439feaa7a02bc8ca97445291f8e9d6bf9d38798006431a3bec06776fed5ae44bdd9bb00200243f66696c656e616d653d6970662e6a736f6ea5dcee93';
      final decode =
          NFTCollectionOperation.deserialize(Cell.fromHex(body).beginParse());
      expect(decode.type, NFTCollectionOperationType.mint);
      final mint = decode.cast<NFTCollectionMint>();
      expect(mint.mint.initAmount, BigInt.from(100000000));
      expect(mint.mint.ownerAddress,
          TonAddress('Ef9VPQFeRlS6IpSPx061_OnDzAAyGNHfYDO7f2rXIl7s3a_i'));
      expect(mint.mint.itemIndex, BigInt.zero);
      expect(decode.serialize().toHex(), body);
    });
    test('batch mint', () {
      const body =
          'b5ee9c7241021001000129000119000000020000000000000000c0010203cf60020d0201200306010a5405f5e1000401439feaa7a02bc8ca97445291f8e9d6bf9d38798006431a3bec06776fed5ae44bdd9bb00500263f66696c656e616d653d697066342e6a736f6e020120070a01091017d784020801439feaa7a02bc8ca97445291f8e9d6bf9d38798006431a3bec06776fed5ae44bdd9bb00900263f66696c656e616d653d697066332e6a736f6e01091017d784020b01439feaa7a02bc8ca97445291f8e9d6bf9d38798006431a3bec06776fed5ae44bdd9bb00c00263f66696c656e616d653d697066322e6a736f6e010bd202faf080400e01439feaa7a02bc8ca97445291f8e9d6bf9d38798006431a3bec06776fed5ae44bdd9bb00f00263f66696c656e616d653d697066312e6a736f6e15cdb08a';
      final decode =
          NFTCollectionOperation.deserialize(Cell.fromHex(body).beginParse());
      expect(decode.type, NFTCollectionOperationType.batchMint);
      final mint = decode.cast<NFTCollectionBatchMint>();
      expect(mint.nfts.length, 4);
      for (final i in mint.nfts) {
        expect(i.ownerAddress,
            TonAddress('Ef9VPQFeRlS6IpSPx061_OnDzAAyGNHfYDO7f2rXIl7s3a_i'));
      }
      expect(decode.serialize().toHex(), body);
    });
    test('change owner', () {
      const body =
          'te6cckEBAQEAMAAAWwAAAAMAAAAAAAAAAJ/7kMXko5pxtt1KlYWEiM4O6Y7LIpcDMOFLKZcmWfYVIJD/sb1u';
      final decode = NFTCollectionOperation.deserialize(
          Cell.fromBase64(body).beginParse());
      expect(decode.type, NFTCollectionOperationType.changeOwner);
      final changeOwner = decode.cast<NFTCollectionChangeOwner>();
      expect(changeOwner.newOwnerAddress,
          TonAddress('Uf_chi8lHNONtupUrCwkRnB3THZZFLgZhwpZTLkyz7CpBHwX'));
      expect(decode.serialize().toBase64(), body);
    });
    test('transfer item', () {
      const body =
          'b5ee9c7241010101003100005d5fcc3d1400000000000000009ffb90c5e4a39a71b6dd4a95858488ce0ee98ecb22970330e14b29972659f615208010e499cb22';
      final decode =
          NFTItemOperation.deserialize(Cell.fromHex(body).beginParse());
      expect(decode.type, NFTItemOperationType.transfer);
      final changeOwner = decode.cast<NFTItemTransfer>();
      expect(changeOwner.newOwnerAddress,
          TonAddress('Uf_chi8lHNONtupUrCwkRnB3THZZFLgZhwpZTLkyz7CpBHwX'));
      expect(decode.serialize().toHex(), body);
    });
  });
}
