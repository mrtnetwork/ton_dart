import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class JettonWalletsResponse with JsonSerialization {
  final TonAddress address;
  final BigInt balance;
  final TonAddress owner;
  final TonAddress jetton;
  final BigInt lastTransactionLt;
  final String codeHash;
  final String dataHash;

  const JettonWalletsResponse({
    required this.address,
    required this.balance,
    required this.owner,
    required this.jetton,
    required this.lastTransactionLt,
    required this.codeHash,
    required this.dataHash,
  });

  factory JettonWalletsResponse.fromJson(Map<String, dynamic> json) {
    return JettonWalletsResponse(
      address: TonAddress(json['address']),
      balance: BigintUtils.parse(json['balance']),
      owner: TonAddress(json['owner']),
      jetton: TonAddress(json['jetton']),
      lastTransactionLt: BigintUtils.parse(json['last_transaction_lt']),
      codeHash: json['code_hash'],
      dataHash: json['data_hash'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address.toFriendlyAddress(),
      'balance': balance.toString(),
      'owner': owner.toFriendlyAddress(),
      'jetton': jetton.toFriendlyAddress(),
      'last_transaction_lt': lastTransactionLt.toString(),
      'code_hash': codeHash,
      'data_hash': dataHash,
    };
  }
}
