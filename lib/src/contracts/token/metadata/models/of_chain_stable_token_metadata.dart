import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/token/metadata/core/metadata.dart';

class StableJettonOffChainMetadata extends TokenMetadata {
  final String uri;
  const StableJettonOffChainMetadata(this.uri);
  factory StableJettonOffChainMetadata.deserialize(Slice slice) {
    return StableJettonOffChainMetadata(slice.loadStringTail());
  }

  @override
  TokenContentType get type => TokenContentType.offchain;

  @override
  Map<String, dynamic> toJson() {
    return {"uri": uri};
  }

  @override
  Cell toContent() {
    final cell = beginCell();
    cell.storeStringTail(uri);
    return cell.endCell();
  }
}
