import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:blockchain_utils/utils/utils.dart';

import 'account_status.dart';

class AccountResponse with JsonSerialization {
  final String address;
  final BigInt balance;
  final BigInt lastActivity;
  final AccountStatusResponse status;
  final List<String> interfaces;
  final String? name;
  final bool? isScam;
  final String? icon;
  final bool? memoRequired;
  final List<String> getMethods;
  final bool? isSuspended;
  final bool isWallet;

  const AccountResponse({
    required this.address,
    required this.balance,
    required this.lastActivity,
    required this.status,
    required this.interfaces,
    this.name,
    this.isScam,
    this.icon,
    this.memoRequired,
    required this.getMethods,
    this.isSuspended,
    required this.isWallet,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json) {
    return AccountResponse(
        address: json['address'],
        balance: BigintUtils.parse(json['balance']),
        lastActivity: BigintUtils.parse(json['last_activity']),
        status: AccountStatusResponse.fromName(json['status']),
        interfaces: List<String>.from(json['interfaces'] ?? []),
        name: json['name'],
        isScam: json['is_scam'],
        icon: json['icon'],
        memoRequired: json['memo_required'],
        getMethods: List<String>.from(json['get_methods']),
        isSuspended: json['is_suspended'],
        isWallet: json['is_wallet']);
  }

  @override
  Map<String, dynamic> toJson() => {
        'address': address,
        'balance': balance.toString(),
        'last_activity': lastActivity.toString(),
        'status': status.value,
        'interfaces': interfaces,
        'name': name,
        'is_scam': isScam,
        'icon': icon,
        'memo_required': memoRequired,
        'get_methods': getMethods,
        'is_suspended': isSuspended,
        'is_wallet': isWallet,
      };
}
