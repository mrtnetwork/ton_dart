import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

import 'block_currency_collection_other_item.dart';

class BlockCurrencyCollectionResponse with JsonSerialization {
  final BigInt grams;
  final List<BlockCurrencyCollectionOtherItemResponse> other;

  const BlockCurrencyCollectionResponse({
    required this.grams,
    required this.other,
  });

  factory BlockCurrencyCollectionResponse.fromJson(Map<String, dynamic> json) {
    return BlockCurrencyCollectionResponse(
        grams: BigintUtils.parse(json['grams']),
        other: (json['other'] as List<dynamic>)
            .map((item) =>
                BlockCurrencyCollectionOtherItemResponse.fromJson(item))
            .toList());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'grams': grams,
      'other': other.map((item) => item.toJson()).toList()
    };
  }
}
