import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

enum TokenContentType { unknown, offchain, onchain }

abstract class TokenMetadata with JsonSerialization {
  TokenContentType get type;
  const TokenMetadata();
  Cell toContent();
  T cast<T extends TokenMetadata>() {
    if (this is! T) {
      throw TonDartPluginException(
          'Invalid token metadata casting. expected: $runtimeType got: $T');
    }
    return this as T;
  }
}

abstract class NFTMetadata extends TonSerialization {
  const NFTMetadata();
  Cell toContent({bool collectionless = false});
  factory NFTMetadata.deserialize(Slice slice) {
    try {
      if (slice.remainingRefs == 0) {
        return NFTItemMetadata.deserialize(slice);
      }
      if (slice.remainingRefs == 2) {
        return NFTCollectionMetadata.deserialize(slice);
      }
    } catch (_) {}
    return NFTRawMetadata(slice.asCell());
  }
  T cast<T extends NFTMetadata>() {
    if (this is! T) {
      throw TonContractException(
          'Invalid metadata casting. expected: $runtimeType got: $T');
    }
    return this as T;
  }
}

enum OnChainMetadataFormat { snake, chunked }
