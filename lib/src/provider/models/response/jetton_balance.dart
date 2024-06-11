import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';
import 'jetton_balance_lock.dart';
import 'jetton_preview.dart';
import 'token_rates.dart';

class JettonBalanceResponse with JsonSerialization {
  final String balance;
  final TokenRatesResponse? price;
  final AccountAddressResponse walletAddress;
  final JettonPreviewResponse jetton;
  final JettonBalanceLockResponse? lock;

  const JettonBalanceResponse(
      {required this.balance,
      required this.walletAddress,
      required this.jetton,
      this.price,
      this.lock});

  factory JettonBalanceResponse.fromJson(Map<String, dynamic> json) {
    return JettonBalanceResponse(
      balance: json['balance'],
      price: json['price'] != null
          ? TokenRatesResponse.fromJson(json['price'])
          : null,
      walletAddress: AccountAddressResponse.fromJson(json['wallet_address']),
      jetton: JettonPreviewResponse.fromJson(json['jetton']),
      lock: json['lock'] != null
          ? JettonBalanceLockResponse.fromJson(json['lock'])
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
      'price': price?.toJson(),
      'wallet_address': walletAddress.toJson(),
      'jetton': jetton.toJson(),
      'lock': lock?.toJson(),
    };
  }
}
