import 'package:ton_dart/src/serialization/serialization.dart';

class DecodedRawMessageMessageResponse with JsonSerialization {
  final String boc;
  final String? decodedOpName;
  final String? opCode;
  final String decodedBody;

  const DecodedRawMessageMessageResponse(
      {required this.boc,
      this.decodedOpName,
      this.opCode,
      required this.decodedBody});

  factory DecodedRawMessageMessageResponse.fromJson(Map<String, dynamic> json) {
    return DecodedRawMessageMessageResponse(
      boc: json['boc'],
      decodedOpName: json['decoded_op_name'],
      opCode: json['op_code'],
      decodedBody: json['decoded_body'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'boc': boc,
        'decoded_op_name': decodedOpName,
        'op_code': opCode,
        'decoded_body': decodedBody
      };
}
