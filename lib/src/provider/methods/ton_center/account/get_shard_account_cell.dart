import 'package:blockchain_utils/utils/json/json.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/core/ton_center_methods.dart';

/// Get balance (in nanograms) of a given address.
/// https://toncenter.com/api/v2/#/accounts/get_address_balance_getAddressBalance_get
class TonCenterGetShardAccountCell
    extends TonCenterPostRequest<ShardAccount, Map<String, dynamic>> {
  /// Identifier of target TON account in any form.
  final String address;
  final int? seqno;

  TonCenterGetShardAccountCell({required this.address, this.seqno});

  @override
  String get method => TonCenterMethods.getShardAccountCell.name;

  @override
  Map<String, dynamic> params() {
    return {'address': address, "seqno": seqno};
  }

  @override
  ShardAccount onResonse(Map<String, dynamic> result) {
    return ShardAccount.deserialize(
      Cell.fromBase64(result.valueAs("bytes")).beginParse(),
    );
  }
}
