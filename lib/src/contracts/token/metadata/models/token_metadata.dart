import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/token/metadata/core/metadata.dart';
import 'package:ton_dart/src/contracts/token/metadata/utils/metadata.dart';

class JettonRawMetadata implements TokenMetadata {
  final Cell content;
  const JettonRawMetadata(this.content);
  @override
  TokenContentType get type => TokenContentType.unknown;

  @override
  Map<String, dynamic> toJson() {
    return {"content": content.toBase64()};
  }

  @override
  Cell encode() {
    return content;
  }
}

class JettonOffChainMetadata implements TokenMetadata {
  final String uri;
  const JettonOffChainMetadata(this.uri);

  @override
  TokenContentType get type => TokenContentType.offchain;

  @override
  Map<String, dynamic> toJson() {
    return {"uri": uri};
  }

  @override
  Cell encode() {
    return TokneMetadataUtils.createJettonOffChainMetadata(uri);
  }
}
