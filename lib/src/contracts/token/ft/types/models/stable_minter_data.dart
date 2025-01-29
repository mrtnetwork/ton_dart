import 'package:blockchain_utils/utils/numbers/utils/bigint_utils.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/tuple/tuple/tuple_reader.dart';

/// data related to stable token minter
class StableTokenMinterData {
  /// admin address
  final TonAddress adminAddress;

  /// jetton content (metadata)
  final Cell content;

  /// minting status
  final bool mutable;

  /// total supply
  final BigInt totalSupply;

  /// wallet code
  final Cell? walletCode;
  Map<String, dynamic> toJson() {
    return {
      'adminAddress': adminAddress.toRawAddress(),
      'content': content.toBase64(),
      'totalSupply': totalSupply.toString(),
      'walletCode': walletCode?.toBase64(),
      'metadata': metadata.toJson()
    };
  }

  const StableTokenMinterData({
    required this.adminAddress,
    required this.totalSupply,
    required this.walletCode,
    required this.content,
    required this.mutable,
  });
  factory StableTokenMinterData.fromJson(Map<String, dynamic> json) {
    return StableTokenMinterData(
        adminAddress: TonAddress(json['adminAddress']),
        totalSupply: BigintUtils.parse(json['totalSupply']),
        mutable: json['mutable'],
        walletCode: Cell.fromBase64(json['walletCode']),
        content: Cell.fromBase64(json['content']));
  }

  factory StableTokenMinterData.fromTuple(TupleReader reader) {
    final BigInt totalSupply = reader.readBigNumber();
    final bool mutable = reader.readBoolean();
    final TonAddress adminAddress = reader.readAddress();
    final Cell content = reader.readCell();
    final Cell walletCode = reader.readCell();

    return StableTokenMinterData(
        adminAddress: adminAddress,
        mutable: mutable,
        totalSupply: totalSupply,
        walletCode: walletCode,
        content: content);
  }

  /// convert content to metadata
  TokenMetadata get metadata => TokneMetadataUtils.loadContent(content);
}
