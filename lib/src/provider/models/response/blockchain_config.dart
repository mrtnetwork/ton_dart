import 'package:ton_dart/src/provider/models/response/block_configs/block_configs.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'validators_set.dart';

class BlockchainConfigResponse with JsonSerialization {
  final String raw;
  final String r0;
  final String r1;
  final String r2;
  final String? r3;
  final String r4;
  final BlockchainConfig5? r5;
  final BlockchainConfig6? r6;
  final BlockchainConfig7? r7;
  final BlockchainConfig8? r8;
  final BlockchainConfig9? r9;
  final BlockchainConfig10? r10;
  final BlockchainConfig11? r11;
  final BlockchainConfig12? r12;
  final BlockchainConfig13? r13;
  final BlockchainConfig14? r14;
  final BlockchainConfig15? r15;
  final BlockchainConfig16? r16;
  final BlockchainConfig17? r17;
  final BlockchainConfig18? r18;
  final BlockchainConfig20? r20;
  final BlockchainConfig21? r21;
  final BlockchainConfig22? r22;
  final BlockchainConfig23? r23;
  final BlockchainConfig24? r24;
  final BlockchainConfig25? r25;
  final BlockchainConfig28? r28;
  final BlockchainConfig29? r29;
  final BlockchainConfig31? r31;
  final ValidatorsSetResponse? r32;
  final ValidatorsSetResponse? r33;
  final ValidatorsSetResponse? r34;
  final ValidatorsSetResponse? r35;
  final ValidatorsSetResponse? r36;
  final ValidatorsSetResponse? r37;
  final BlockchainConfig40? r40;
  final BlockchainConfig43? r43;
  final BlockchainConfig44 r44;
  final BlockchainConfig71? r71;
  final BlockchainConfig72? r72;
  final BlockchainConfig73? r73;
  final BlockchainConfig79? r79;
  final BlockchainConfig81? r81;
  final BlockchainConfig82? r82;

  const BlockchainConfigResponse({
    required this.raw,
    required this.r0,
    required this.r1,
    required this.r2,
    this.r3,
    required this.r4,
    this.r5,
    this.r6,
    this.r7,
    this.r8,
    this.r9,
    this.r10,
    this.r11,
    this.r12,
    this.r13,
    this.r14,
    this.r15,
    this.r16,
    this.r17,
    this.r18,
    this.r20,
    this.r21,
    this.r22,
    this.r23,
    this.r24,
    this.r25,
    this.r28,
    this.r29,
    this.r31,
    this.r32,
    this.r33,
    this.r34,
    this.r35,
    this.r36,
    this.r37,
    this.r40,
    this.r43,
    required this.r44,
    this.r71,
    this.r72,
    this.r73,
    this.r79,
    this.r81,
    this.r82,
  });

  factory BlockchainConfigResponse.fromJson(Map<String, dynamic> json) {
    return BlockchainConfigResponse(
      raw: json['raw'],
      r0: json['0'],
      r1: json['1'],
      r2: json['2'],
      r3: json['3'],
      r4: json['4'],
      r5: json['5'] != null ? BlockchainConfig5.fromJson(json['5']) : null,
      r6: json['6'] != null ? BlockchainConfig6.fromJson(json['6']) : null,
      r7: json['7'] != null ? BlockchainConfig7.fromJson(json['7']) : null,
      r8: json['8'] != null ? BlockchainConfig8.fromJson(json['8']) : null,
      r9: json['9'] != null ? BlockchainConfig9.fromJson(json['9']) : null,
      r10: json['10'] != null ? BlockchainConfig10.fromJson(json['10']) : null,
      r11: json['11'] != null ? BlockchainConfig11.fromJson(json['11']) : null,
      r12: json['12'] != null ? BlockchainConfig12.fromJson(json['12']) : null,
      r13: json['13'] != null ? BlockchainConfig13.fromJson(json['13']) : null,
      r14: json['14'] != null ? BlockchainConfig14.fromJson(json['14']) : null,
      r15: json['15'] != null ? BlockchainConfig15.fromJson(json['15']) : null,
      r16: json['16'] != null ? BlockchainConfig16.fromJson(json['16']) : null,
      r17: json['17'] != null ? BlockchainConfig17.fromJson(json['17']) : null,
      r18: json['18'] != null ? BlockchainConfig18.fromJson(json['18']) : null,
      r20: json['20'] != null ? BlockchainConfig20.fromJson(json['20']) : null,
      r21: json['21'] != null ? BlockchainConfig21.fromJson(json['21']) : null,
      r22: json['22'] != null ? BlockchainConfig22.fromJson(json['22']) : null,
      r23: json['23'] != null ? BlockchainConfig23.fromJson(json['23']) : null,
      r24: json['24'] != null ? BlockchainConfig24.fromJson(json['24']) : null,
      r25: json['25'] != null ? BlockchainConfig25.fromJson(json['25']) : null,
      r28: json['28'] != null ? BlockchainConfig28.fromJson(json['28']) : null,
      r29: json['29'] != null ? BlockchainConfig29.fromJson(json['29']) : null,
      r31: json['31'] != null ? BlockchainConfig31.fromJson(json['31']) : null,
      r32: json['32'] != null
          ? ValidatorsSetResponse.fromJson(json['32'])
          : null,
      r33: json['33'] != null
          ? ValidatorsSetResponse.fromJson(json['33'])
          : null,
      r34: json['34'] != null
          ? ValidatorsSetResponse.fromJson(json['34'])
          : null,
      r35: json['35'] != null
          ? ValidatorsSetResponse.fromJson(json['35'])
          : null,
      r36: json['36'] != null
          ? ValidatorsSetResponse.fromJson(json['36'])
          : null,
      r37: json['37'] != null
          ? ValidatorsSetResponse.fromJson(json['37'])
          : null,
      r40: json['40'] != null ? BlockchainConfig40.fromJson(json['40']) : null,
      r43: json['43'] != null ? BlockchainConfig43.fromJson(json['43']) : null,
      r44: BlockchainConfig44.fromJson(json['44']),
      r71: json['71'] != null ? BlockchainConfig71.fromJson(json['71']) : null,
      r72: json['72'] != null ? BlockchainConfig72.fromJson(json['72']) : null,
      r73: json['73'] != null ? BlockchainConfig73.fromJson(json['73']) : null,
      r79: json['79'] != null ? BlockchainConfig79.fromJson(json['79']) : null,
      r81: json['81'] != null ? BlockchainConfig81.fromJson(json['81']) : null,
      r82: json['82'] != null ? BlockchainConfig82.fromJson(json['82']) : null,
    );
  }
  @override
  Map<String, dynamic> toJson() {
    return {
      'raw': raw,
      '0': r0,
      '1': r1,
      '2': r2,
      '3': r3,
      '4': r4,
      '5': r5?.toJson(),
      '6': r6?.toJson(),
      '7': r7?.toJson(),
      '8': r8?.toJson(),
      '9': r9?.toJson(),
      '10': r10?.toJson(),
      '11': r11?.toJson(),
      '12': r12?.toJson(),
      '13': r13?.toJson(),
      '14': r14?.toJson(),
      '15': r15?.toJson(),
      '16': r16?.toJson(),
      '17': r17?.toJson(),
      '18': r18?.toJson(),
      '20': r20?.toJson(),
      '21': r21?.toJson(),
      '22': r22?.toJson(),
      '23': r23?.toJson(),
      '24': r24?.toJson(),
      '25': r25?.toJson(),
      '28': r28?.toJson(),
      '29': r29?.toJson(),
      '31': r31?.toJson(),
      '32': r32?.toJson(),
      '33': r33?.toJson(),
      '34': r34?.toJson(),
      '35': r35?.toJson(),
      '36': r36?.toJson(),
      '37': r37?.toJson(),
      '40': r40?.toJson(),
      '43': r43?.toJson(),
      '44': r44.toJson(),
      '71': r71?.toJson(),
      '72': r72?.toJson(),
      '73': r73?.toJson(),
      '79': r79?.toJson(),
      '81': r81?.toJson(),
      '82': r82?.toJson(),
    };
  }
}
