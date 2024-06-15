// BlockRawResponse

import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/provider/provider.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class TonCenterFullAccountStateResponse with JsonSerialization {
  final BlockRawResponse blockId;
  final BigInt balance;
  final String code;
  final String data;
  final String frozenHash;
  final BigInt syncUtim;
  final AccountStatusResponse state;
  const TonCenterFullAccountStateResponse(
      {required this.blockId,
      required this.balance,
      required this.code,
      required this.data,
      required this.frozenHash,
      required this.state,
      required this.syncUtim});
  factory TonCenterFullAccountStateResponse.fromJson(
      Map<String, dynamic> json) {
    return TonCenterFullAccountStateResponse(
        blockId: BlockRawResponse.fromJson(json["block_id"]),
        balance: BigintUtils.parse(json["balance"]),
        code: json["code"],
        data: json["data"],
        frozenHash: json["frozen_hash"],
        state: AccountStatusResponse.fromName(json["state"]),
        syncUtim: BigintUtils.parse(json["sync_utime"]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "sync_utime": syncUtim.toString(),
      "block_id": blockId.toJson(),
      "balance": balance.toString(),
      "code": code,
      "data": data,
      "frozen_hash": frozenHash,
      "state": state.value,
    };
  }
}

class TonCenterTransactionIdResponse with JsonSerialization {
  final BigInt lt;
  final String hash;
  const TonCenterTransactionIdResponse({required this.lt, required this.hash});
  factory TonCenterTransactionIdResponse.fromJson(Map<String, dynamic> json) {
    return TonCenterTransactionIdResponse(
        lt: BigintUtils.parse(json["lt"]), hash: json["hash"]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"lt": lt.toString(), "hash": hash};
  }
}
