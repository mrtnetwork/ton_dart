import 'package:blockchain_utils/binary/binary.dart';
import 'package:blockchain_utils/compare/compare.dart';
import 'package:ton_dart/src/address/constant/constant.dart';
import 'package:ton_dart/src/address/exception/exception.dart';
import 'package:ton_dart/src/address/models/decode_address_result.dart';
import 'package:ton_dart/src/utils/crypto.dart';
import 'package:ton_dart/src/utils/utils.dart';

class TonAddressUtils {
  static final RegExp _friendlyRegixAddress = RegExp(r'[A-Za-z0-9+/_-]+');
  static bool isFriendly(String source) {
    if (source.length == TonAddressConst.friendlyAddressLength &&
        _friendlyRegixAddress.hasMatch(source)) {
      return true;
    }
    return false;
  }

  static bool isRaw(String source) {
    final parts = source.split(':');
    try {
      int.parse(parts[0]);
      final hashBytes = BytesUtils.fromHexString(parts[1]);
      if (hashBytes.length == TonAddressConst.addressHashLength) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static DecodeAddressResult fromFriendlyAddress(String address) {
    final data = Base64Utils.decodeBase64(address);
    // 1 byte tag + 1 byte workchain + 32 bytes hash + 2 byte crc
    if (data.length != TonAddressConst.friendlyAddressBytesLength) {
      throw TonAddressException(
          "Unknown address type. byte length is not equal to ${TonAddressConst.friendlyAddressBytesLength}",
          details: {"length": data.length});
    }

    // Prepare data
    final addr = data.sublist(0, 34);
    final crc = data.sublist(34, 36);
    final calcedCrc = CryptoUtils.crc16(addr);
    if (!bytesEqual(crc, calcedCrc)) {
      throw TonAddressException("Invalid checksum",
          details: {"excepted": calcedCrc, "checksum": crc});
    }

    // Parse tag
    int tag = addr[0];
    bool isTestOnly = false;
    bool isBounceable = false;
    if ((tag & TonAddressConst.testFlag) != 0) {
      isTestOnly = true;
      tag ^= TonAddressConst.testFlag;
    }
    if (tag != TonAddressConst.bounceableTag &&
        tag != TonAddressConst.nonBounceableTag) {
      throw TonAddressException("Unknown address tag", details: {"tag": tag});
    }
    isBounceable = tag == TonAddressConst.bounceableTag;
    int? workchain;
    if (addr[1] == mask8) {
      workchain = -1;
    } else {
      workchain = addr[1];
    }
    final hashPart = addr.sublist(2, 34);
    return DecodeAddressResult(
        isTestOnly: isTestOnly,
        isBounceable: isBounceable,
        workchain: workchain,
        hash: hashPart);
  }

  static DecodeAddressResult fromRawAddress(String address) {
    try {
      final parts = address.split(':');
      final int workChain = int.parse(parts[0]);
      final hash = BytesUtils.fromHexString(parts[1]);
      return DecodeAddressResult(hash: hash, workchain: workChain);
    } catch (e) {
      throw TonAddressException("Invalid raw address",
          details: {"address": address});
    }
  }

  static String encodeAddress(
      {required List<int> hash,
      required int workChain,
      bool bounceable = true,
      bool testOnly = false,
      bool urlSafe = false}) {
    int tag = bounceable
        ? TonAddressConst.bounceableTag
        : TonAddressConst.nonBounceableTag;
    if (testOnly) {
      tag |= TonAddressConst.testFlag;
    }
    final List<int> addr =
        List<int>.unmodifiable([tag, workChain & mask8, ...hash]);
    final addrBytes = [...addr, ...CryptoUtils.crc16(addr)];
    return Base64Utils.encodeBase64(addrBytes, urlSafe: urlSafe);
  }

  static DecodeAddressResult decodeAddress(String address) {
    if (isFriendly(address)) {
      return fromFriendlyAddress(address);
    } else if (isRaw(address)) {
      return fromRawAddress(address);
    } else {
      throw TonAddressException('Unknown address type.',
          details: {"address": address});
    }
  }

  static List<int> validateAddressHash(List<int> bytes) {
    if (bytes.length != TonAddressConst.addressHashLength) {
      throw TonAddressException("Invalid address hash length.", details: {
        "excepted": TonAddressConst.addressHashLength,
        "length": bytes.length
      });
    }
    return BytesUtils.toBytes(bytes, unmodifiable: true);
  }
}
