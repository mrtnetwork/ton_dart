import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/contracts/token/nft/constant/constant.dart';
import 'package:ton_dart/src/contracts/token/nft/models/models.dart';
import 'package:ton_dart/src/models/models.dart';

class NftWalletUtils {
  static Cell buildNftCollectionData(
      {required TonAddress ownerAddress,
      required RoyaltyParams royaltyParams,
      required NFTMetadata content,
      BigInt? nextItemIndex}) {
    final builder = beginCell();
    builder.storeAddress(ownerAddress);
    builder.storeUint64(nextItemIndex ?? BigInt.zero);
    content.store(builder);
    builder.storeRef(TomNftConst.nftItemCode(ownerAddress.workChain));
    builder.store(royaltyParams);
    return builder.endCell();
  }

  static StateInit buildNftCollectionState(
      {required TonAddress ownerAddress,
      required RoyaltyParams royaltyParams,
      required NFTMetadata content,
      required Cell code,
      BigInt? nextItemIndex}) {
    return StateInit(
        code: code,
        data: buildNftCollectionData(
            ownerAddress: ownerAddress,
            royaltyParams: royaltyParams,
            content: content,
            nextItemIndex: nextItemIndex));
  }
}
