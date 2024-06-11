import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';

import 'account_address.dart';
import 'message_msg_type.dart';
import 'state_init.dart';

class MessageResponse with JsonSerialization {
  final MessageMsgTypeResponse msgType;
  final BigInt createdLt;
  final bool ihrDisabled;
  final bool bounce;
  final bool bounced;
  final BigInt value;
  final BigInt fwdFee;
  final BigInt ihrFee;
  final AccountAddressResponse? destination;
  final AccountAddressResponse? source;
  final BigInt importFee;
  final BigInt createdAt;
  final String? opCode;
  final StateInitResponse? init;
  final String? rawBody;
  final String? decodedOpName;
  final dynamic decodedBody;

  const MessageResponse({
    required this.msgType,
    required this.createdLt,
    required this.ihrDisabled,
    required this.bounce,
    required this.bounced,
    required this.value,
    required this.fwdFee,
    required this.ihrFee,
    this.destination,
    this.source,
    required this.importFee,
    required this.createdAt,
    this.opCode,
    this.init,
    this.rawBody,
    this.decodedOpName,
    required this.decodedBody,
  });

  factory MessageResponse.fromJson(Map<String, dynamic> json) {
    return MessageResponse(
      msgType: MessageMsgTypeResponse.fromName(json['msg_type']),
      createdLt: BigintUtils.parse(json['created_lt']),
      ihrDisabled: json['ihr_disabled'],
      bounce: json['bounce'],
      bounced: json['bounced'],
      value: BigintUtils.parse(json['value']),
      fwdFee: BigintUtils.parse(json['fwd_fee']),
      ihrFee: BigintUtils.parse(json['ihr_fee']),
      destination: json['destination'] != null
          ? AccountAddressResponse.fromJson(json['destination'])
          : null,
      source: json['source'] != null
          ? AccountAddressResponse.fromJson(json['source'])
          : null,
      importFee: BigintUtils.parse(json['import_fee']),
      createdAt: BigintUtils.parse(json['created_at']),
      opCode: json['op_code'],
      init: json['init'] != null
          ? StateInitResponse.fromJson(json['init'])
          : null,
      rawBody: json['raw_body'],
      decodedOpName: json['decoded_op_name'],
      decodedBody: json['decoded_body'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'msg_type': msgType.toString().split('.').last,
      'created_lt': createdLt.toString(),
      'ihr_disabled': ihrDisabled,
      'bounce': bounce,
      'bounced': bounced,
      'value': value.toString(),
      'fwd_fee': fwdFee.toString(),
      'ihr_fee': ihrFee.toString(),
      'destination': destination?.toJson(),
      'source': source?.toJson(),
      'import_fee': importFee.toString(),
      'created_at': createdAt.toString(),
      'op_code': opCode,
      'init': init?.toJson(),
      'raw_body': rawBody,
      'decoded_op_name': decodedOpName,
      'decoded_body': decodedBody,
    };
  }
}
