import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class GetJettonWalletResponse {
  final List<JettonWalletsResponse> jettonWallets;
  final List<JetonWalletTokenData> metadata;
  const GetJettonWalletResponse(
      {required this.jettonWallets, required this.metadata});
  factory GetJettonWalletResponse.fromJson(Map<String, dynamic> json) {
    final metadata = Map<String, dynamic>.from(json["metadata"]);
    return GetJettonWalletResponse(
        jettonWallets: (json['jetton_wallets'] as List?)
                ?.map((e) => JettonWalletsResponse.fromJson(e))
                .toList() ??
            [],
        metadata: metadata.entries
            .map((e) => JetonWalletTokenData(
                tokens: (e.value["token_info"] as List?)
                        ?.map((e) => JetonWalletTokenInfo.fromJson(e))
                        .toList() ??
                    [],
                address: TonAddress(e.key)))
            .toList());
  }
}

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

enum JettonWalletTokenInfoType {
  wallet("jetton_wallets"),
  master("jetton_masters"),
  unknown("");

  final String name;
  const JettonWalletTokenInfoType(this.name);
  static JettonWalletTokenInfoType fromName(String? name) {
    return values.firstWhere((e) => e.name == name,
        orElse: () => JettonWalletTokenInfoType.unknown);
  }
}

class JetonWalletTokenData {
  final TonAddress address;
  final List<JetonWalletTokenInfo> tokens;
  const JetonWalletTokenData({required this.tokens, required this.address});
}

abstract class JetonWalletTokenInfo {
  final JettonWalletTokenInfoType type;
  final Map<String, dynamic> json;
  const JetonWalletTokenInfo({required this.json, required this.type});

  factory JetonWalletTokenInfo.fromJson(Map<String, dynamic> json) {
    final type = JettonWalletTokenInfoType.fromName(json["type"]);
    final bool valid = json["valid"];
    if (!valid) {
      return JettonWalletTokenInfoUnknow(json: json);
    }
    // print(type);
    // print(json);
    switch (type) {
      case JettonWalletTokenInfoType.unknown:
        return JettonWalletTokenInfoUnknow(json: json);
      case JettonWalletTokenInfoType.wallet:
        return JettonWalletTokenInfoWallet.fromJson(json);
      case JettonWalletTokenInfoType.master:
        return JettonWalletTokenInfoMaster.fromJson(json);
    }
  }
}

class JettonWalletTokenInfoUnknow extends JetonWalletTokenInfo {
  const JettonWalletTokenInfoUnknow({required super.json})
      : super(type: JettonWalletTokenInfoType.unknown);
}

class JettonWalletTokenInfoMaster extends JetonWalletTokenInfo {
  final String name;
  final String symbol;
  final String? image;
  final int? decimals;
  const JettonWalletTokenInfoMaster(
      {required this.name,
      required this.symbol,
      required this.image,
      required this.decimals,
      required super.json})
      : super(type: JettonWalletTokenInfoType.master);
  factory JettonWalletTokenInfoMaster.fromJson(Map<String, dynamic> json) {
    return JettonWalletTokenInfoMaster(
        name: json["name"],
        symbol: json["symbol"],
        image: json["image"],
        decimals: IntUtils.tryParse(json["extra"]["decimals"]),
        json: json);
  }
}

class JettonWalletTokenInfoWallet extends JetonWalletTokenInfo {
  final BigInt balance;
  final TonAddress jetton;
  final TonAddress owner;
  factory JettonWalletTokenInfoWallet.fromJson(Map<String, dynamic> json) {
    return JettonWalletTokenInfoWallet(
        balance: BigintUtils.parse(json["extra"]["balance"]),
        jetton: TonAddress(json["extra"]["jetton"]),
        owner: TonAddress(json["extra"]["owner"]),
        json: json);
  }
  const JettonWalletTokenInfoWallet(
      {required this.balance,
      required this.jetton,
      required this.owner,
      required super.json})
      : super(type: JettonWalletTokenInfoType.wallet);
}
