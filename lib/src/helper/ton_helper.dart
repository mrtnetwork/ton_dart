import 'package:blockchain_utils/blockchain_utils.dart';

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
}
