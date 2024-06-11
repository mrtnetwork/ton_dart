import 'package:ton_dart/src/serialization/serialization.dart';
import 'address_parse_ok_bounceable.dart';

class AddressParseResponse with JsonSerialization {
  final String rawForm;
  final AddressParseBounceableResponse bounceable;
  final AddressParseBounceableResponse nonBounceable;
  final String givenType;
  final bool testOnly;
  const AddressParseResponse(
      {required this.rawForm,
      required this.bounceable,
      required this.nonBounceable,
      required this.givenType,
      required this.testOnly});

  factory AddressParseResponse.fromJson(Map<String, dynamic> json) {
    return AddressParseResponse(
        rawForm: json["raw_form"],
        bounceable: AddressParseBounceableResponse.fromJson(json["bounceable"]),
        nonBounceable:
            AddressParseBounceableResponse.fromJson(json["non_bounceable"]),
        givenType: json["given_type"],
        testOnly: json["test_only"]);
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      "raw_form": rawForm,
      "bounceable": bounceable.toJson(),
      "non_bounceable": nonBounceable.toJson(),
      "given_type": givenType,
      "test_only": testOnly
    };
  }
}
