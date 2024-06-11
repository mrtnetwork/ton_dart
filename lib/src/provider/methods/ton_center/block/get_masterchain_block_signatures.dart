import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get up-to-date masterchain state.
/// https://toncenter.com/api/v2/#/blocks/get_masterchain_block_signatures_getMasterchainBlockSignatures_get
class TonCenterGetMasterchainBlockSignatures extends TonCenterPostRequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  final int seqno;
  TonCenterGetMasterchainBlockSignatures(this.seqno);

  @override
  String get method => TonCenterMethods.getMasterchainBlockSignatures.name;

  @override
  Map<String, dynamic> params() {
    return {"seqno": seqno};
  }
}
