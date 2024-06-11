import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/numbers/numbers.dart';
import 'account_status.dart';
import 'account_storage_info.dart';
import 'blockchain_raw_account_libraries_item.dart';

class BlockchainRawAccountResponse with JsonSerialization {
  final String address;
  final BigInt balance;
  final Map<String, String>? extraBalance;
  final String? code;
  final String? data;
  final BigInt lastTransactionLt;
  final String? lastTransactionHash;
  final String? frozenHash;
  final AccountStatusResponse status;
  final AccountStorageInfoResponse storage;
  final List<BlockchainRawAccountLibrariesItemResponse> libraries;

  const BlockchainRawAccountResponse({
    required this.address,
    required this.balance,
    this.extraBalance,
    this.code,
    this.data,
    required this.lastTransactionLt,
    this.lastTransactionHash,
    this.frozenHash,
    required this.status,
    required this.storage,
    required this.libraries,
  });

  factory BlockchainRawAccountResponse.fromJson(Map<String, dynamic> json) {
    return BlockchainRawAccountResponse(
      address: json['address'],
      balance: BigintUtils.parse(json['balance']),
      extraBalance: json['extra_balance'] != null
          ? (json['extra_balance'] as Map).cast()
          : null,
      code: json['code'],
      data: json['data'],
      lastTransactionLt: BigintUtils.parse(json['last_transaction_lt']),
      lastTransactionHash: json['last_transaction_hash'],
      frozenHash: json['frozen_hash'],
      status: AccountStatusResponse.fromName(json['status']),
      storage: AccountStorageInfoResponse.fromJson(json['storage']),
      libraries: List<BlockchainRawAccountLibrariesItemResponse>.from(
          json['libraries'].map(
              (x) => BlockchainRawAccountLibrariesItemResponse.fromJson(x))),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'balance': balance.toString(),
      'extra_balance': extraBalance,
      'code': code,
      'data': data,
      'last_transaction_lt': lastTransactionLt.toString(),
      'last_transaction_hash': lastTransactionHash,
      'frozen_hash': frozenHash,
      'status': status.value,
      'storage': storage.toJson(),
      'libraries': libraries.map((x) => x.toJson()).toList(),
    };
  }
}
