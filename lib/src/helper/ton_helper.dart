import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/boc/boc.dart';

class TonHelper {
  static const int nanoDecimalPlaces = 9;
  static final BigRational _nanoDecimal =
      BigRational(BigInt.from(10).pow(nanoDecimalPlaces));

  static BigInt toNano(String price) {
    final parse = BigRational.parseDecimal(price);
    return (parse * _nanoDecimal).toBigInt();
  }

  static String fromNano(BigInt price) {
    final parse = BigRational(price);
    return (parse / _nanoDecimal).toDecimal(digits: nanoDecimalPlaces);
  }

  static Cell? tryToCell(String? data) {
    if (data?.trim().isEmpty ?? true) return null;
    if (StringUtils.isHexBytes(data!)) {
      return Cell.fromBytes(BytesUtils.fromHexString(data));
    }
    return Cell.fromBase64(data);
  }
}
