import 'package:ton_dart/src/serialization/serialization.dart';
import 'account_address.dart';

class WalletDNSResponse with JsonSerialization {
  final String address;
  final AccountAddressResponse account;
  final bool isWallet;
  final bool hasMethodPubkey;
  final bool hasMethodSeqno;
  final List<String> names;

  const WalletDNSResponse({
    required this.address,
    required this.account,
    required this.isWallet,
    required this.hasMethodPubkey,
    required this.hasMethodSeqno,
    required this.names,
  });

  factory WalletDNSResponse.fromJson(Map<String, dynamic> json) {
    return WalletDNSResponse(
      address: json['address'],
      account: AccountAddressResponse.fromJson(json['account']),
      isWallet: json['is_wallet'],
      hasMethodPubkey: json['has_method_pubkey'],
      hasMethodSeqno: json['has_method_seqno'],
      names: List<String>.from(json['names']),
    );
  }

  @override
  @override
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'account': account.toJson(),
      'is_wallet': isWallet,
      'has_method_pubkey': hasMethodPubkey,
      'has_method_seqno': hasMethodSeqno,
      'names': names
    };
  }
}
