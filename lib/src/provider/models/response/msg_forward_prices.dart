import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

class MsgForwardPricesResponse with JsonSerialization {
  final BigInt lumpPrice;
  final BigInt bitPrice;
  final BigInt cellPrice;
  final BigInt ihrPriceFactor;
  final BigInt firstFrac;
  final BigInt nextFrac;

  const MsgForwardPricesResponse({
    required this.lumpPrice,
    required this.bitPrice,
    required this.cellPrice,
    required this.ihrPriceFactor,
    required this.firstFrac,
    required this.nextFrac,
  });

  factory MsgForwardPricesResponse.fromJson(Map<String, dynamic> json) {
    return MsgForwardPricesResponse(
      lumpPrice: BigintUtils.parse(json['lump_price']),
      bitPrice: BigintUtils.parse(json['bit_price']),
      cellPrice: BigintUtils.parse(json['cell_price']),
      ihrPriceFactor: BigintUtils.parse(json['ihr_price_factor']),
      firstFrac: BigintUtils.parse(json['first_frac']),
      nextFrac: BigintUtils.parse(json['next_frac']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'lump_price': lumpPrice.toString(),
      'bit_price': bitPrice.toString(),
      'cell_price': cellPrice.toString(),
      'ihr_price_factor': ihrPriceFactor.toString(),
      'first_frac': firstFrac.toString(),
      'next_frac': nextFrac.toString(),
    };
  }
}
