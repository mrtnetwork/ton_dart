import 'package:ton_dart/src/serialization/serialization.dart';
import 'account.dart';

class AccountsResponse with JsonSerialization {
  final List<AccountResponse> accounts;

  const AccountsResponse({required this.accounts});

  factory AccountsResponse.fromJson(Map<String, dynamic> json) {
    return AccountsResponse(
        accounts: List<AccountResponse>.from((json['accounts'] as List)
            .map((account) => AccountResponse.fromJson(account))));
  }

  @override
  @override
  Map<String, dynamic> toJson() =>
      {'accounts': accounts.map((account) => account.toJson()).toList()};
}
