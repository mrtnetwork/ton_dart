import 'package:blockchain_utils/utils/utils.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/extensions.dart';
import 'currency_collection.dart';

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L132
/// int_msg_info$0 ihr_disabled:Bool bounce:Bool bounced:Bool
///   src:MsgAddress dest:MsgAddressInt
///   value:CurrencyCollection ihr_fee:Grams fwd_fee:Grams
///   created_lt:uint64 created_at:uint32 = CommonMsgInfoRelaxed;
/// ext_out_msg_info$11 src:MsgAddress dest:MsgAddressExt
///   created_lt:uint64 created_at:uint32 = CommonMsgInfoRelaxed;
class CommonMessageInfoRelaxedType {
  final String name;
  const CommonMessageInfoRelaxedType._(this.name);
  static const CommonMessageInfoRelaxedType internal =
      CommonMessageInfoRelaxedType._('internal');
  static const CommonMessageInfoRelaxedType externalOut =
      CommonMessageInfoRelaxedType._('external-out');
  static const List<CommonMessageInfoRelaxedType> values = [
    internal,
    externalOut
  ];
  factory CommonMessageInfoRelaxedType.fromValue(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw TonDartPluginException(
          'Cannot find CommonMessageInfoRelaxedType from provided name',
          details: {'name': name}),
    );
  }
  @override
  String toString() {
    return 'CommonMessageInfoRelaxedType.$name';
  }
}

abstract class CommonMessageInfoRelaxed extends TonSerialization {
  const CommonMessageInfoRelaxed._();
  abstract final CommonMessageInfoRelaxedType type;
  TonBaseAddress? get dest;
  factory CommonMessageInfoRelaxed.deserialize(Slice slice) {
    if (!slice.loadBit()) {
      return CommonMessageInfoRelaxedInternal.deserialize(slice);
    }
    if (!slice.loadBit()) {
      throw const TonDartPluginException(
          'Invalid CommonMessageInfoRelaxed Slice');
    }
    return CommonMessageInfoRelaxedExternalOut.deserialize(slice);
  }
  factory CommonMessageInfoRelaxed.fromJson(Map<String, dynamic> json) {
    final type = CommonMessageInfoRelaxedType.fromValue(json['type']);
    switch (type) {
      case CommonMessageInfoRelaxedType.internal:
        return CommonMessageInfoRelaxedInternal.fromJson(json);
      default:
        return CommonMessageInfoRelaxedExternalOut.fromJson(json);
    }
  }

  T cast<T extends CommonMessageInfoRelaxed>() {
    if (this is! T) {
      throw TonDartPluginException('Incorrect message relaxed casting.',
          details: {'expected': '$runtimeType', 'got': '$T'});
    }
    return this as T;
  }
}

class CommonMessageInfoRelaxedInternal extends CommonMessageInfoRelaxed {
  final bool ihrDisabled;
  final bool bounce;
  final bool bounced;
  final TonAddress? src;
  @override
  final TonAddress dest;
  final CurrencyCollection value;
  final BigInt ihrFee;
  final BigInt forwardFee;
  final BigInt createdLt;
  final int createdAt;

  const CommonMessageInfoRelaxedInternal(
      {required this.ihrDisabled,
      required this.bounce,
      required this.bounced,
      this.src,
      required this.dest,
      required this.value,
      required this.ihrFee,
      required this.forwardFee,
      required this.createdLt,
      required this.createdAt})
      : super._();
  factory CommonMessageInfoRelaxedInternal.deserialize(Slice slice) {
    final ihrDisabled = slice.loadBit();
    final bounce = slice.loadBit();
    final bounced = slice.loadBit();
    final src = slice.loadMaybeAddress();
    final dest = slice.loadAddress();
    final value = CurrencyCollection.deserialize(slice);
    final ihrFee = slice.loadCoins();
    final forwardFee = slice.loadCoins();
    final createdLt = slice.loadUintBig(64);
    final createdAt = slice.loadUint(32);
    return CommonMessageInfoRelaxedInternal(
        ihrDisabled: ihrDisabled,
        bounce: bounce,
        bounced: bounced,
        src: src,
        dest: dest,
        value: value,
        ihrFee: ihrFee,
        forwardFee: forwardFee,
        createdLt: createdLt,
        createdAt: createdAt);
  }
  factory CommonMessageInfoRelaxedInternal.fromJson(Map<String, dynamic> json) {
    return CommonMessageInfoRelaxedInternal(
        ihrDisabled: json['ihrDisabled'],
        bounce: json['bounce'],
        bounced: json['bounced'],
        src: (json['src'] as Object?)
            ?.convertTo<TonAddress, String>((result) => TonAddress(result)),
        dest: TonAddress(json['dest']),
        value: CurrencyCollection.fromJson(json['value']),
        ihrFee: BigintUtils.parse(json['ihrFee']),
        forwardFee: BigintUtils.parse(json['forwardFee']),
        createdLt: BigintUtils.parse(json['createdLt']),
        createdAt: json['createdAt']);
  }
  @override
  void store(Builder builder) {
    builder.storeBit(0);
    builder.storeBitBolean(ihrDisabled);
    builder.storeBitBolean(bounce);
    builder.storeBitBolean(bounced);
    builder.storeAddress(src);
    builder.storeAddress(dest);
    value.store(builder);
    builder.storeCoins(ihrFee);
    builder.storeCoins(forwardFee);
    builder.storeUint(createdLt, 64);
    builder.storeUint(createdAt, 32);
  }

  @override
  CommonMessageInfoRelaxedType get type =>
      CommonMessageInfoRelaxedType.internal;

  @override
  Map<String, dynamic> toJson() {
    return {
      'bounce': bounce,
      'ihrDisabled': ihrDisabled,
      'bounced': bounced,
      'src': src?.toRawAddress(),
      'dest': dest.toRawAddress(),
      'value': value.toJson(),
      'ihrFee': ihrFee.toString(),
      'forwardFee': forwardFee.toString(),
      'createdLt': createdLt.toString(),
      'createdAt': createdAt,
      'type': type.name
    };
  }
}

class CommonMessageInfoRelaxedExternalOut extends CommonMessageInfoRelaxed {
  final TonAddress? src;
  @override
  final ExternalAddress? dest;
  final BigInt createdLt;
  final int createdAt;

  const CommonMessageInfoRelaxedExternalOut(
      {this.src, this.dest, required this.createdLt, required this.createdAt})
      : super._();
  factory CommonMessageInfoRelaxedExternalOut.deserialize(Slice slice) {
    final src = slice.loadMaybeAddress();
    final dest = slice.loadMaybeExternalAddress();
    final createdLt = slice.loadUintBig(64);
    final createdAt = slice.loadUint(32);
    return CommonMessageInfoRelaxedExternalOut(
        src: src, createdLt: createdLt, createdAt: createdAt, dest: dest);
  }
  factory CommonMessageInfoRelaxedExternalOut.fromJson(
      Map<String, dynamic> json) {
    return CommonMessageInfoRelaxedExternalOut(
        src: (json['src'] as Object?)
            ?.convertTo<TonAddress, String>((result) => TonAddress(result)),
        createdLt: BigintUtils.parse(json['createdLt']),
        createdAt: json['createdAt'],
        dest: (json['dest'] as Object?)?.convertTo<ExternalAddress, Map>(
            (p0) => ExternalAddress.fromJson(p0.cast())));
  }

  @override
  void store(Builder builder) {
    builder.storeBit(1);
    builder.storeBit(1);
    builder.storeAddress(src);
    builder.storeAddress(dest);
    builder.storeUint(createdLt, 64);
    builder.storeUint(createdAt, 32);
  }

  @override
  CommonMessageInfoRelaxedType get type =>
      CommonMessageInfoRelaxedType.externalOut;

  @override
  Map<String, dynamic> toJson() {
    return {
      'src': src?.toRawAddress(),
      'dest': dest?.toJson(),
      'createdLt': createdLt.toString(),
      'createdAt': createdAt,
      'type': type.name
    };
  }
}
