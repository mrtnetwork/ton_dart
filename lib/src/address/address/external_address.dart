import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/address/core/ton_address.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

/// Represents an external address with a value and bit length.
class ExternalAddress with JsonSerialization implements TonBaseAddress {
  final BigInt value;
  final int bits;

  /// Constructs an [ExternalAddress] with the given value and bit length.
  const ExternalAddress(this.value, this.bits);

  /// Creates an [ExternalAddress] from a JSON object.
  factory ExternalAddress.fromJson(Map<String, dynamic> json) {
    return ExternalAddress(BigintUtils.parse(json["value"]), json["bits"]);
  }

  /// Returns a string representation of the external address.
  @override
  String toString() {
    return 'External<$bits:$value>';
  }

  /// Converts the external address to a JSON object.
  @override
  Map<String, dynamic> toJson() {
    return {"value": value.toString(), "bits": bits};
  }
}
