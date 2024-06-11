import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get consensus block and its update timestamp.
/// https://toncenter.com/api/v2/#/blocks/get_consensus_block_getConsensusBlock_get
class TonCenterGetConsensusBlock extends TonCenterPostRequestParam<
    Map<String, dynamic>, Map<String, dynamic>> {
  TonCenterGetConsensusBlock();

  @override
  String get method => TonCenterMethods.getConsensusBlock.name;

  @override
  Map<String, dynamic> params() {
    return {};
  }
}
