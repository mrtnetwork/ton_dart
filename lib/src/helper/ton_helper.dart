import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/exception/exception.dart';

class TonHelper {
  static const int nanoDecimalPlaces = 9;
  static final BigRational _nanoDecimal =
      BigRational(BigInt.from(10).pow(nanoDecimalPlaces));

  /// Example  toNano("1.0") = 1000000000
  static BigInt toNano(String ton) {
    final parse = BigRational.parseDecimal(ton);
    return (parse * _nanoDecimal).toBigInt();
  }

  /// Example  fromNano(BigInt.from(1000000000)) = "1"
  static String fromNano(BigInt nanotons) {
    final parse = BigRational(nanotons);
    return (parse / _nanoDecimal).toDecimal(digits: nanoDecimalPlaces);
  }

  static Cell? tryToCell(String? data) {
    try {
      if (data?.trim().isEmpty ?? true) return null;
      if (StringUtils.isHexBytes(data!)) {
        return Cell.fromBytes(BytesUtils.fromHexString(data));
      }
      return Cell.fromBase64(data);
    } catch (e) {
      return null;
    }
  }

  static Cell toCell(String? data) {
    final toCell = tryToCell(data);
    if (toCell == null) {
      throw TonDartPluginException("Invalid cell data.",
          details: {"data": data});
    }
    return toCell;
  }
}
