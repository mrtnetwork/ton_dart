import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class _MsgForwardPricesResponseConst {
  static const int tag = 0xea;
}

class MsgForwardPricesResponse with JsonSerialization {
  final BigInt lumpPrice;
  final BigInt bitPrice;
  final BigInt cellPrice;
  final int ihrPriceFactor;
  final int firstFrac;
  final int nextFrac;

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
      ihrPriceFactor: IntUtils.parse(json['ihr_price_factor']),
      firstFrac: IntUtils.parse(json['first_frac']),
      nextFrac: IntUtils.parse(json['next_frac']),
    );
  }
  factory MsgForwardPricesResponse.deserialize(Slice slice) {
    final tag = slice.loadUint8();
    if (tag != _MsgForwardPricesResponseConst.tag) {
      throw TonDartPluginException("Invalid msg forward prices tag.", details: {
        "excepted": _MsgForwardPricesResponseConst.tag,
        "tag": tag
      });
    }
    return MsgForwardPricesResponse(
        lumpPrice: slice.loadUint64(),
        bitPrice: slice.loadUint64(),
        cellPrice: slice.loadUint64(),
        ihrPriceFactor: slice.loadUint32(),
        firstFrac: slice.loadUint16(),
        nextFrac: slice.loadUint16());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'lump_price': lumpPrice.toString(),
      'bit_price': bitPrice.toString(),
      'cell_price': cellPrice.toString(),
      'ihr_price_factor': ihrPriceFactor,
      'first_frac': firstFrac,
      'next_frac': nextFrac,
    };
  }
}
