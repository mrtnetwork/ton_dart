import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/dict/dictionary.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class NFTMintParams extends TonSerialization {
  final TonAddress ownerAddress;
  final NFTMetadata metadata;
  final BigInt initAmount;
  final BigInt itemIndex;
  NFTMintParams({
    required this.ownerAddress,
    required this.metadata,
    required this.initAmount,
    required this.itemIndex,
  });

  @override
  void store(Builder builder) {
    builder.storeUint64(itemIndex);
    builder.storeCoins(initAmount);
    final content = beginCell();
    content.storeAddress(ownerAddress);
    metadata.store(content);
    builder.storeRef(content.endCell());
  }

  // @override
  // void store(Builder builder) {
  //   builder.storeUint64(itemIndex);
  //   final newCell = beginCell();
  //   newCell.storeCoins(initAmount);
  //   final content = beginCell();
  //   content.storeAddress(ownerAddress);
  //   metadata.store(content);
  //   newCell.storeRef(content.endCell());
  //   builder.storeRef(newCell.endCell());
  // }

  @override
  Map<String, dynamic> toJson() {
    return {
      "metadata": metadata.toJson(),
      "amount": initAmount.toString(),
      "owner_address": ownerAddress.toFriendlyAddress(),
      "item_index": itemIndex.toString()
    };
  }
}

class _BatchNFTsMintParamsUtils {
  static final DictionaryValue<NFTMintParams> nftBatchMintsCodec =
      DictionaryValue(
          serialize: (source, builder) {
            builder.storeCoins(source.initAmount);
            final content = beginCell();
            content.storeAddress(source.ownerAddress);
            source.metadata.store(content);
            builder.storeRef(content.endCell());
          },
          parse: (slice) => throw UnimplementedError());
  static Dictionary<BigInt, NFTMintParams> getDict(
      {Map<BigInt, NFTMintParams> enteries = const {}}) {
    return Dictionary.fromEnteries(
        key: DictionaryKey.bigIntCodec(64),
        value: nftBatchMintsCodec,
        map: enteries);
  }
}

class BatchNFTsMintParams extends TonSerialization {
  final List<NFTMintParams> nfts;

  BatchNFTsMintParams(List<NFTMintParams> nfts)
      : nfts = List<NFTMintParams>.unmodifiable(nfts);

  @override
  void store(Builder builder) {
    final Map<BigInt, NFTMintParams> nftOBjects =
        Map.fromEntries(nfts.map((e) => MapEntry(e.itemIndex, e)));
    final dict = _BatchNFTsMintParamsUtils.getDict(enteries: nftOBjects);
    builder.storeDict(dict: dict);
  }

  BigInt get initializeAmount => nfts.fold<BigInt>(
        BigInt.zero,
        (previousValue, element) => previousValue + element.initAmount,
      );

  @override
  Map<String, dynamic> toJson() {
    return {"nfts": nfts.map((e) => e.toJson()).toList()};
  }
}
