import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/extentions.dart';
import 'currency_collection.dart';

class CommonMessageInfoType {
  final String name;
  const CommonMessageInfoType._(this.name);
  static const CommonMessageInfoType internal =
      CommonMessageInfoType._("internal");
  static const CommonMessageInfoType externalIn =
      CommonMessageInfoType._("external-in");
  static const CommonMessageInfoType externalOut =
      CommonMessageInfoType._("external-out");
  static const List<CommonMessageInfoType> values = [
    internal,
    externalIn,
    externalOut
  ];
  factory CommonMessageInfoType.fromValue(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw MessageException(
          "Cannot find CommonMessageInfoType from provided name",
          details: {"name": name}),
    );
  }
  @override
  String toString() {
    return "CommonMessageInfoType.$name";
  }
}

abstract class CommonMessageInfo extends TonSerialization {
  abstract final CommonMessageInfoType type;
  factory CommonMessageInfo.deserialize(Slice slice) {
    if (!slice.loadBit()) {
      return CommonMessageInfoInternal.deserialize(slice);
    }
    if (!slice.loadBit()) {
      return CommonMessageInfoExternalIn.deserialize(slice);
    }
    return CommonMessageInfoExternalOut.deserialize(slice);
  }
  factory CommonMessageInfo.fromJson(Map<String, dynamic> json) {
    final type = CommonMessageInfoType.fromValue(json["type"]);
    switch (type) {
      case CommonMessageInfoType.externalIn:
        return CommonMessageInfoExternalIn.fromJson(json);
      case CommonMessageInfoType.internal:
        return CommonMessageInfoInternal.fromJson(json);
      default:
        return CommonMessageInfoExternalOut.fromJson(json);
    }
  }
}

class CommonMessageInfoInternal implements CommonMessageInfo {
  final bool ihrDisabled;
  final bool bounce;
  final bool bounced;
  final TonAddress src;
  final TonAddress dest;
  final CurrencyCollection value;
  final BigInt ihrFee;
  final BigInt forwardFee;
  final BigInt createdLt;
  final int createdAt;

  const CommonMessageInfoInternal(
      {required this.ihrDisabled,
      required this.bounce,
      required this.bounced,
      required this.src,
      required this.dest,
      required this.value,
      required this.ihrFee,
      required this.forwardFee,
      required this.createdLt,
      required this.createdAt});
  factory CommonMessageInfoInternal.deserialize(Slice slice) {
    final ihrDisabled = slice.loadBit();
    final bounce = slice.loadBit();
    final bounced = slice.loadBit();
    final src = slice.loadAddress();
    final dest = slice.loadAddress();
    final value = CurrencyCollection.deserialize(slice);
    final ihrFee = slice.loadCoins();
    final forwardFee = slice.loadCoins();
    final createdLt = slice.loadUintBig(64);
    final createdAt = slice.loadUint(32);
    return CommonMessageInfoInternal(
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
  factory CommonMessageInfoInternal.fromJson(Map<String, dynamic> json) {
    return CommonMessageInfoInternal(
        ihrDisabled: json["ihrDisabled"],
        bounce: json["bounce"],
        bounced: json["bounced"],
        src: TonAddress(json["src"]),
        dest: TonAddress(json["dest"]),
        value: CurrencyCollection.fromJson(json["value"]),
        ihrFee: BigintUtils.parse(json["ihrFee"]),
        forwardFee: BigintUtils.parse(json["forwardFee"]),
        createdLt: BigintUtils.parse(json["createdLt"]),
        createdAt: json["createdAt"]);
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
  CommonMessageInfoType get type => CommonMessageInfoType.internal;

  @override
  Map<String, dynamic> toJson() {
    return {
      "bounce": bounce,
      "ihrDisabled": ihrDisabled,
      "bounced": bounced,
      "src": src.toRawAddress(),
      "dest": dest.toRawAddress(),
      "value": value.toJson(),
      "ihrFee": ihrFee.toString(),
      "forwardFee": forwardFee.toString(),
      "createdLt": createdLt.toString(),
      "createdAt": createdAt,
      "type": type.name
    };
  }
}

class CommonMessageInfoExternalIn implements CommonMessageInfo {
  final ExternalAddress? src;
  final TonAddress dest;
  final BigInt importFee;
  const CommonMessageInfoExternalIn(
      {this.src, required this.dest, required this.importFee});

  factory CommonMessageInfoExternalIn.deserialize(Slice slice) {
    final src = slice.loadMaybeExternalAddress();
    final dest = slice.loadAddress();
    final importFee = slice.loadCoins();
    return CommonMessageInfoExternalIn(
        dest: dest, importFee: importFee, src: src);
  }
  factory CommonMessageInfoExternalIn.fromJson(Map<String, dynamic> json) {
    return CommonMessageInfoExternalIn(
        dest: TonAddress(json["dest"]),
        importFee: BigintUtils.parse(json["importFee"]),
        src: (json["src"] as Object?)?.to<ExternalAddress, Map>((p0) {
          return ExternalAddress.fromJson(p0.cast());
        }));
  }

  @override
  void store(Builder builder) {
    builder.storeBit(1);
    builder.storeBit(0);
    builder.storeAddress(src);
    builder.storeAddress(dest);
    builder.storeCoins(importFee);
  }

  @override
  CommonMessageInfoType get type => CommonMessageInfoType.externalIn;

  @override
  Map<String, dynamic> toJson() {
    return {
      "dest": dest.toRawAddress(),
      "src": src?.toJson(),
      "importFee": importFee.toString(),
      "type": type.name
    };
  }
}

class CommonMessageInfoExternalOut implements CommonMessageInfo {
  final TonAddress src;
  final ExternalAddress? dest;
  final BigInt createdLt;
  final int createdAt;
  const CommonMessageInfoExternalOut(
      {required this.src,
      this.dest,
      required this.createdLt,
      required this.createdAt});
  factory CommonMessageInfoExternalOut.deserialize(Slice slice) {
    final src = slice.loadAddress();
    final dest = slice.loadMaybeExternalAddress();
    final createdLt = slice.loadUintBig(64);
    final createdAt = slice.loadUint(32);
    return CommonMessageInfoExternalOut(
        src: src, createdLt: createdLt, createdAt: createdAt, dest: dest);
  }
  factory CommonMessageInfoExternalOut.fromJson(Map<String, dynamic> json) {
    return CommonMessageInfoExternalOut(
        src: TonAddress(json["src"]),
        createdLt: BigintUtils.parse(json["createdLt"]),
        createdAt: json["createdAt"],
        dest: (json["dest"] as Object?)?.to<ExternalAddress, Map>(
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
  CommonMessageInfoType get type => CommonMessageInfoType.externalOut;

  @override
  Map<String, dynamic> toJson() {
    return {
      "src": src.toRawAddress(),
      "dest": dest?.toJson(),
      "createdLt": createdLt.toString(),
      "createdAt": createdAt,
      "type": type.name
    };
  }
}
