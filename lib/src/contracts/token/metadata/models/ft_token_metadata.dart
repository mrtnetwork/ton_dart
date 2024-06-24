import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/contracts/token/metadata/constant/constant.dart';
import 'package:ton_dart/src/contracts/token/metadata/exception/exception.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class _JettonOnChainMetadataUtils {
  static Tuple<Map<String, dynamic>, OnChainMetadataFormat> validateContent(
      Map<String, dynamic> content) {
    Map<String, dynamic> metadata;
    OnChainMetadataFormat format = OnChainMetadataFormat.snake;
    try {
      try {
        metadata = Map<String, String>.from(content);
      } catch (e) {
        metadata = content.map<String, Map<int, String>>(
            (key, value) => MapEntry(key, Map<int, String>.from(value)));
        format = OnChainMetadataFormat.chunked;
      }
    } catch (e) {
      throw TokenMetadataException(
          "Invalid metadat content. metadata must be Snake format(Map<String,String>) or Chunked format Map<String,Map<int,String>>",
          details: {"content": content});
    }
    final fixKeys =
        metadata.map((key, value) => MapEntry(StringUtils.strip0x(key), value));
    return Tuple(fixKeys, format);
  }

  static String? key(String key, Map<String, dynamic> json) {
    final hashKey = TonMetadataConstant.defaultKeys[key];
    return json.remove(hashKey);
  }
}

class JettonOnChainMetadata with JsonSerialization implements TokenMetadata {
  /// Optional. Used by "Semi-chain content layout". ASCII string. A URI pointing to JSON document with metadata.
  final String? uri;

  /// Optional. UTF8 string. The name of the token - e.g. "Example Coin".
  final String? name;

  /// Optional. UTF8 string. Describes the token - e.g. "This is an example jetton for the TON network".
  final String? description;

  /// Optional. ASCII string. A URI pointing to a jetton icon with mime type image.
  final String? image;

  /// Optional. Either binary representation of the image for onchain layout or base64 for offchain layout.
  final String? imageData;

  /// Optional. UTF8 string. The symbol of the token - e.g. "XMPL". Used in the form "You received 99 XMPL".
  final String? symbol;

  /// Optional. If not specified, 9 is used by default. UTF8 encoded string with number from 0 to 255.
  /// The number of decimals the token uses - e.g. 8, means to divide the token amount by 100000000 to
  /// get its user representation, while 0 means that tokens are indivisible: user representation of
  /// token number should correspond to token amount in wallet-contract storage. In case you specify
  /// decimals, it is highly recommended that you specify this parameter on-chain and that the smart
  /// contract code ensures that this parameter is immutable.
  final int? decimals;

  /// Optional. Needed by external applications to understand which format for displaying the number of jettons.
  /// "n":  number of jettons (default value). If the user has 100 tokens with decimals 0, then display that user has 100 tokens
  ///
  /// "n-of-total":  the number of jettons out of the total number of issued jettons.
  /// For example, totalSupply Jetton = 1000. A user has 100 jettons in the jetton wallet.
  /// For example must be displayed in the user's wallet as 100 of 1000 or in
  /// any other textual or graphical way to demonstrate the particular from the general.
  ///
  /// "%": percentage of jettons from the total number of issued jettons. For example, totalSupply Jetton = 1000.
  /// A user has 100 jettons in the jetton wallet. For example it should be displayed in the user's wallet as 10%.
  final String? amountStyle;

  ///  Optional. Needed by external applications to understand which group the jetton belongs to and how to display it.
  /// "currency" - display as currency (default value).
  /// "game" - display for games. It should be displayed as NFT, but at the same time display the number of jettons considering the amount_style
  final String? renderType;

  final Map<String, dynamic> content;

  final OnChainMetadataFormat dataFormat;
  JettonOnChainMetadata._(
      {this.uri,
      this.name,
      this.description,
      this.image,
      this.imageData,
      this.symbol,
      this.decimals,
      this.amountStyle,
      this.renderType,
      required this.dataFormat,
      Map<String, dynamic> content = const {}})
      : content = Map.unmodifiable(content);

  factory JettonOnChainMetadata.snakeFormat(
      {String? uri,
      String? name,
      String? description,
      String? image,
      String? imageData,
      String? symbol,
      int? decimals,
      String? amountStyle,
      String? renderType,
      Map<String, String> customContent = const {}}) {
    return JettonOnChainMetadata._(
        uri: uri,
        amountStyle: amountStyle,
        content: customContent,
        decimals: decimals,
        description: description,
        image: image,
        imageData: imageData,
        name: name,
        renderType: renderType,
        symbol: symbol,
        dataFormat: OnChainMetadataFormat.snake);
  }
  factory JettonOnChainMetadata.chunkFormat(
      Map<String, Map<int, String>> content) {
    return JettonOnChainMetadata._(
        content: content, dataFormat: OnChainMetadataFormat.chunked);
  }

  factory JettonOnChainMetadata.fromJson(Map<String, dynamic> json) {
    final content = _JettonOnChainMetadataUtils.validateContent(json);
    final data = content.item1;
    final format = content.item2;
    if (format == OnChainMetadataFormat.chunked) {
      return JettonOnChainMetadata._(
          content: data, dataFormat: OnChainMetadataFormat.chunked);
    }
    return JettonOnChainMetadata._(
        uri: _JettonOnChainMetadataUtils.key("uri", data),
        name: _JettonOnChainMetadataUtils.key("name", data),
        description: _JettonOnChainMetadataUtils.key("description", data),
        image: _JettonOnChainMetadataUtils.key("image", data),
        imageData: _JettonOnChainMetadataUtils.key("image_data", data),
        symbol: _JettonOnChainMetadataUtils.key("symbol", data),
        decimals: int.tryParse(
            _JettonOnChainMetadataUtils.key("decimals", data) ?? ""),
        amountStyle: _JettonOnChainMetadataUtils.key("amount_style", data),
        renderType: _JettonOnChainMetadataUtils.key("render_type", data),
        content: data,
        dataFormat: OnChainMetadataFormat.snake);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "uri": uri,
      "name": name,
      "description": description,
      "image": image,
      "image_data": imageData,
      "symbol": symbol,
      "decimals": decimals,
      "amount_style": amountStyle,
      "render_type": renderType,
      "content": content
    };
  }

  @override
  TokenContentType get type => TokenContentType.onchain;

  @override
  Cell encode() {
    if (dataFormat == OnChainMetadataFormat.chunked) {
      return TokneMetadataUtils.createOnChainContentChunckedFormat(
          Map<String, Map<int, String>>.from(content));
    }
    final contentData = content.entries
        .where((element) => element.value != null)
        .map((e) => MapEntry(e.key, e.value.toString()));
    final contentJson = Map<String, String>.fromEntries(contentData);
    final inJson = toJson()
      ..removeWhere((key, value) => value == null || key == "content");
    for (final i in contentJson.entries) {
      inJson.putIfAbsent(i.key, () => i.value);
    }
    final Map<String, String> correctContent =
        inJson.map((key, value) => MapEntry(key, value.toString()));
    return TokneMetadataUtils.createOnChainContentStakeFormat(correctContent);
  }
}
