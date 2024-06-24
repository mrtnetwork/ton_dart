import 'package:blockchain_utils/crypto/quick_crypto.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/token/metadata/constant/constant.dart';
import 'package:ton_dart/src/contracts/token/metadata/core/metadata.dart';
import 'package:ton_dart/src/contracts/token/metadata/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/metadata/models/ft_token_metadata.dart';
import 'package:ton_dart/src/contracts/token/metadata/models/token_metadata.dart';
import 'package:ton_dart/src/dict/dictionary.dart';

class TokneMetadataUtils {
  /// Convert metadata key to sha256
  static String toKey(String key) {
    return BytesUtils.toHexString(
        QuickCrypto.sha256Hash(StringUtils.encode(key)));
  }

  /// ensure metadata key is 32 bytes hex string otherwise use [toKey] method for generate key
  static Map<String, V> keyToMetadataKey<V>(Map<String, V> metadata) {
    return metadata.map((key, value) {
      final keyBytes = BytesUtils.tryFromHexString(key);
      if (keyBytes == null || keyBytes.length != 32) {
        final String correctKey =
            TonMetadataConstant.defaultKeys[key] ?? toKey(key);
        return MapEntry(correctKey, value);
      }
      return MapEntry(key, value);
    });
  }

  /// load metadata
  static TokenMetadata? loadContent(Cell content) {
    final slice = content.beginParse();
    final type = slice.loadUint8();
    if (type == TonMetadataConstant.ftMetadataOffChainTag) {
      if (slice.remainingBits ~/ 8 != 0) {
        return JettonOffChainMetadata(slice.loadStringTail());
      }
      return null;
    } else if (type == TonMetadataConstant.ftMetadataOnChainTag) {
      final dict = _onChainMetadataDict({});
      dict.loadFromClice(slice);
      final result = dict.asMap
          .map((key, value) => MapEntry(BytesUtils.toHexString(key), value));
      return JettonOnChainMetadata.fromJson(result);
    }
    return JettonRawMetadata(content);
  }

  static Cell encodeMetadata(TokenMetadata? metadata) {
    if (metadata != null) return metadata.encode();
    final cell = beginCell();
    cell.storeUint(TonMetadataConstant.ftMetadataOffChainTag, 8);
    return cell.endCell();
  }

  /// [TEP](https://github.com/ton-blockchain/TEPs/blob/master/text/0064-token-data-standard.md)
  /// Off-chain content layout The first byte is 0x01 and the rest is the URI pointing to the JSON document
  /// containing the token metadata. The URI is encoded as ASCII. If the URI does not fit into one cell,
  /// then it uses the "Snake format" described in the "Data serialization" paragraph, the snake-format-prefix 0x00 is dropped.
  static Cell createJettonOffChainMetadata(String uri) {
    final cell = beginCell();
    cell.storeUint(TonMetadataConstant.ftMetadataOffChainTag, 8);
    cell.storeStringTail(uri);
    return cell.endCell();
  }

  /// [TEP](https://github.com/ton-blockchain/TEPs/blob/master/text/0064-token-data-standard.md)
  /// On-chain content: layout The first byte is 0x00 and the rest is key/value dictionary. Key is sha256 hash of string.
  /// Value is data encoded as described in "Data serialization" paragraph.
  ///
  /// Semi-chain content layout Data encoded as described in "2. On-chain content layout".
  /// The dictionary must have uri key with a value containing the URI pointing to the JSON document
  /// with token metadata. Clients in this case should merge the keys of the on-chain dictionary
  /// and off-chain JSON doc. In case of collisions (the field exists in both off-chain data and on-chain data), on-chain values are used.
  /// Snake format when we store part of the data in a cell and the rest of the data in the first child cell (and so recursively).
  static Cell createOnChainContentStakeFormat(Map<String, String> content) {
    final fixedKeys = keyToMetadataKey(content);
    final dict = _onChainMetadataDict(fixedKeys);
    final builder = beginCell();
    builder.storeUint(TonMetadataConstant.ftMetadataOnChainTag, 8);
    builder.storeDict(dict: dict);
    return builder.endCell();
  }

  /// [TEP](https://github.com/ton-blockchain/TEPs/blob/master/text/0064-token-data-standard.md)
  /// On-chain content: layout The first byte is 0x00 and the rest is key/value dictionary. Key is sha256 hash of string.
  /// Value is data encoded as described in "Data serialization" paragraph.
  ///
  /// Semi-chain content: layout Data encoded as described in "2. On-chain content layout".
  /// The dictionary must have uri key with a value containing the URI pointing to the JSON document
  /// with token metadata. Clients in this case should merge the keys of the on-chain dictionary
  /// and off-chain JSON doc. In case of collisions (the field exists in both off-chain data and on-chain data), on-chain values are used.
  /// Chunked format when we store data in dictionary chunk_index -> chunk.
  static Cell createOnChainContentChunckedFormat(
      Map<String, Map<int, String>> content) {
    final dict = _onChainMetadataDict(keyToMetadataKey(content));
    final builder = beginCell();
    builder.storeUint(TonMetadataConstant.ftMetadataOnChainTag, 8);
    builder.storeDict(dict: dict);
    return builder.endCell();
  }

  static final DictionaryValue _onChainMetadataValueCodec =
      DictionaryValue(serialize: (source, builder) {
    final Builder ref = beginCell();
    if (source is String) {
      ref.storeUint(0, 8);
      builder.storeRef(ref.storeStringTail(source).endCell());
    } else {
      Map<int, String> castMap;
      try {
        castMap = Map<int, String>.from(source);
      } catch (e) {
        throw TokenMetadataException(
            "Invalid metadata value. value must be string or chunked format(Map<int,String>)",
            details: {"value": source});
      }
      ref.storeUint(1, 8);
      final result = Dictionary.fromEnteries<int, Cell>(
        key: DictionaryKey.uintCodec(32),
        value: DictionaryValue.cellCodec(),
        map: castMap.map((key, value) =>
            MapEntry(key, beginCell().storeStringTail(value).endCell())),
      );
      builder.storeRef(ref.storeDict(dict: result).endCell());
    }
  }, parse: (source) {
    final slice = source.loadRef().beginParse();
    final type = slice.loadUint8();
    if (type == 0) {
      return slice.loadStringTail();
    } else if (type == 1) {
      final result = slice.loadDict(
          DictionaryKey.uintCodec(32), DictionaryValue.cellCodec());
      return result.asMap.values.map((e) => e.beginParse().loadStringTail());
    }
    throw const TokenMetadataException("Invalid or Unsuported metadata type.");
  });
  static Dictionary<List<int>, dynamic> _onChainMetadataDict(
      Map<String, dynamic> content) {
    final dict = Dictionary.fromEnteries<List<int>, dynamic>(
        key: DictionaryKey.bufferCodec(32),
        value: _onChainMetadataValueCodec,
        map: content.map(
            (key, value) => MapEntry(BytesUtils.fromHexString(key), value)));
    return dict;
  }
}
