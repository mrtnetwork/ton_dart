import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

enum TokenContentType { unknown, offchain, onchain }

abstract class TokenMetadata with JsonSerialization {
  TokenContentType get type;
  Cell encode();
}

abstract class NFTMetadata extends TonSerialization {
  const NFTMetadata();
}

enum OnChainMetadataFormat { snake, chunked }
