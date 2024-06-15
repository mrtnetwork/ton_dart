import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'block_raw.dart';

class RawListBlockTransactionsIdsItemResponse with JsonSerialization {
  final int mode;
  final String? account;
  final BigInt? lt;
  final String? hash;
  const RawListBlockTransactionsIdsItemResponse(
      {required this.mode,
      required this.account,
      required this.lt,
      required this.hash});
  factory RawListBlockTransactionsIdsItemResponse.fromJson(
      Map<String, dynamic> json) {
    return RawListBlockTransactionsIdsItemResponse(
      mode: json["mode"],
      account: json["versaccountion"],
      lt: BigintUtils.tryParse(json["lt"]),
      hash: json["hash"],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "hash": hash,
      "lt": lt?.toString(),
      "account": account,
      "mode": mode
    };
  }
}

class RawListBlockTransactionsResponse with JsonSerialization {
  final BlockRawResponse id;
  final int reqCount;
  final bool incomplete;
  final List<RawListBlockTransactionsIdsItemResponse> ids;
  final String proof;
  const RawListBlockTransactionsResponse({
    required this.id,
    required this.reqCount,
    required this.incomplete,
    required this.ids,
    required this.proof,
  });

  factory RawListBlockTransactionsResponse.fromJson(Map<String, dynamic> json) {
    return RawListBlockTransactionsResponse(
        id: BlockRawResponse.fromJson(json["id"]),
        reqCount: json["req_count"],
        incomplete: json["incomplete"],
        ids: (json["ids"] as List)
            .map((e) => RawListBlockTransactionsIdsItemResponse.fromJson(e))
            .toList(),
        proof: json["proof"]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": id.toJson(),
      "req_count": reqCount,
      "incomplete": incomplete,
      "ids": ids.map((e) => e.toJson()).toList(),
      "proof": proof
    };
  }
}
