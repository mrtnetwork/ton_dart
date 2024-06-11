import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:ton_dart/src/address/core/ton_address.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class ExternalAddress with JsonSerialization implements TonBaseAddress {
  final BigInt value;
  final int bits;
  const ExternalAddress(this.value, this.bits);
  factory ExternalAddress.fromJson(Map<String, dynamic> json) {
    return ExternalAddress(BigintUtils.parse(json["value"]), json["bits"]);
  }

  @override
  String toString() {
    return 'External<$bits:$value>';
  }

  @override
  Map<String, dynamic> toJson() {
    return {"value": value.toString(), "bits": bits};
  }
}
