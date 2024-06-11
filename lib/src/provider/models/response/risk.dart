import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'jetton_quantity.dart';
import 'nft_item.dart';

class RiskResponse with JsonSerialization {
  final bool transferAllRemainingBalance;
  final BigInt ton;
  final List<JettonQuantityResponse> jettons;
  final List<NftItemResponse> nfts;

  const RiskResponse(
      {required this.transferAllRemainingBalance,
      required this.ton,
      required this.jettons,
      required this.nfts});

  factory RiskResponse.fromJson(Map<String, dynamic> json) {
    return RiskResponse(
        transferAllRemainingBalance: json['transfer_all_remaining_balance'],
        ton: BigintUtils.parse(json['ton']),
        jettons: List<JettonQuantityResponse>.from((json['jettons'] as List)
            .map((x) => JettonQuantityResponse.fromJson(x))),
        nfts: List<NftItemResponse>.from(
            (json['nfts'] as List).map((x) => NftItemResponse.fromJson(x))));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'transfer_all_remaining_balance': transferAllRemainingBalance,
      'ton': ton.toString(),
      'jettons': jettons.map((x) => x.toJson()).toList(),
      'nfts': nfts.map((x) => x.toJson()).toList(),
    };
  }
}
