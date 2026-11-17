// GENERATED CODE - DO NOT MODIFY BY HAND
// Source: OpenAPI 3.0.0
// REST api to TON blockchain explorer 2.0.0
//
// toJson contract (config-driven): every `toJson` takes an optional
// `JsonifyConfig` (`config`, default `DefaultJsonifyConfig.defaultConfig`) and
// returns the result through `config.encodeMap`, so `toJson` never
// returns null — it always yields a Map.
// BigInt / null handling is delegated to the config: `encodeBigint`
// encodes BigInt values and `encodeMap` post-processes the map.
// Make sure the configured output is `jsonEncode`-compatible: raw
// BigInt values are rejected by `jsonEncode`, so either keep the
// default string encoding or handle BigInt in your own encoder.

import 'package:blockchain_utils/blockchain_utils.dart';

/// Each inner array is a pair [timestamp, price]:
///   • index 0 — Unix timestamp (int64)
///   • index 1 — token price (decimal) in the requested currency.
typedef ChartPoints = List<List<num>>;

typedef NftApprovedBy = List<NftApprovedByItem>;

enum AccStatusChange {
  acstUnchanged("acst_unchanged"),
  acstFrozen("acst_frozen"),
  acstDeleted("acst_deleted");

  final String value;
  const AccStatusChange(this.value);

  static AccStatusChange fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching AccStatusChange found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum AccountStatus {
  nonexist("nonexist"),
  uninit("uninit"),
  active("active"),
  frozen("frozen");

  final String value;
  const AccountStatus(this.value);

  static AccountStatus fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching AccountStatus found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum BouncePhaseType {
  trPhaseBounceNegfunds("TrPhaseBounceNegfunds"),
  trPhaseBounceNofunds("TrPhaseBounceNofunds"),
  trPhaseBounceOk("TrPhaseBounceOk");

  final String value;
  const BouncePhaseType(this.value);

  static BouncePhaseType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching BouncePhaseType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum ComputeSkipReason {
  cskipNoState("cskip_no_state"),
  cskipBadState("cskip_bad_state"),
  cskipNoGas("cskip_no_gas"),
  cskipSuspended("cskip_suspended");

  final String value;
  const ComputeSkipReason(this.value);

  static ComputeSkipReason fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching ComputeSkipReason found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum CurrencyType {
  native("native"),
  extraCurrency("extra_currency"),
  jetton("jetton"),
  fiat("fiat");

  final String value;
  const CurrencyType(this.value);

  static CurrencyType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching CurrencyType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum DefiAssetType {
  staking("staking"),
  lendingSupply("lending_supply"),
  lendingBorrow("lending_borrow"),
  liquidStaking("liquid_staking"),
  liquidPool("liquid_pool"),
  yieldToken("yield_token");

  final String value;
  const DefiAssetType(this.value);

  static DefiAssetType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching DefiAssetType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// Data type of the argument value:
/// - `nan`: Not-a-Number value
/// - `null`: Null value
/// - `tinyint`: Decimal integer (e.g., `100500`)
/// - `int257`: 257-bit integer in hex format with 0x prefix (e.g., `0xfa01d78381ae32`)
/// - `slice`: TON blockchain address (e.g., `0:6e731f2e...`)
/// - `cell_boc_base64`: Base64-encoded cell BOC (Binary Object Code) (e.g., `te6ccgEBAQEAAgAAAA==`)
/// - `slice_boc_hex`: Hex-encoded slice BOC (e.g., `b5ee9c72...`)
enum ExecGetMethodArgType {
  nan("nan"),
  null_("null"),
  tinyint("tinyint"),
  int257("int257"),
  slice("slice"),
  cellBocBase64("cell_boc_base64"),
  sliceBocHex("slice_boc_hex");

  final String value;
  const ExecGetMethodArgType(this.value);

  static ExecGetMethodArgType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching ExecGetMethodArgType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum JettonVerificationType {
  whitelist("whitelist"),
  graylist("graylist"),
  blacklist("blacklist"),
  none("none");

  final String value;
  const JettonVerificationType(this.value);

  static JettonVerificationType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching JettonVerificationType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum PoolImplementationType {
  whales("whales"),
  tf("tf"),
  liquidTF("liquidTF"),
  ffvault("ffvault"),
  hipo("hipo");

  final String value;
  const PoolImplementationType(this.value);

  static PoolImplementationType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching PoolImplementationType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum TransactionType {
  transOrd("TransOrd"),
  transTickTock("TransTickTock"),
  transSplitPrepare("TransSplitPrepare"),
  transSplitInstall("TransSplitInstall"),
  transMergePrepare("TransMergePrepare"),
  transMergeInstall("TransMergeInstall"),
  transStorage("TransStorage");

  final String value;
  const TransactionType(this.value);

  static TransactionType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TransactionType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum TrustType {
  whitelist("whitelist"),
  graylist("graylist"),
  blacklist("blacklist"),
  none("none");

  final String value;
  const TrustType(this.value);

  static TrustType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TrustType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum ActionStatus {
  ok("ok"),
  failed("failed");

  final String value;
  const ActionStatus(this.value);

  static ActionStatus fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching ActionStatus found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum ActionType {
  tonTransfer("TonTransfer"),
  extraCurrencyTransfer("ExtraCurrencyTransfer"),
  contractDeploy("ContractDeploy"),
  jettonTransfer("JettonTransfer"),
  flawedJettonTransfer("FlawedJettonTransfer"),
  jettonBurn("JettonBurn"),
  jettonMint("JettonMint"),
  nftItemTransfer("NftItemTransfer"),
  subscribe("Subscribe"),
  unSubscribe("UnSubscribe"),
  auctionBid("AuctionBid"),
  nftPurchase("NftPurchase"),
  depositStake("DepositStake"),
  withdrawStake("WithdrawStake"),
  withdrawStakeRequest("WithdrawStakeRequest"),
  electionsDepositStake("ElectionsDepositStake"),
  electionsRecoverStake("ElectionsRecoverStake"),
  jettonSwap("JettonSwap"),
  smartContractExec("SmartContractExec"),
  domainRenew("DomainRenew"),
  purchase("Purchase"),
  addExtension("AddExtension"),
  removeExtension("RemoveExtension"),
  setSignatureAllowedAction("SetSignatureAllowedAction"),
  gasRelay("GasRelay"),
  depositTokenStake("DepositTokenStake"),
  withdrawTokenStakeRequest("WithdrawTokenStakeRequest"),
  liquidityDeposit("LiquidityDeposit"),
  oracleRequest("OracleRequest"),
  buyXTR("BuyXTR"),
  depositXTR("DepositXTR"),
  withdrawXTR("WithdrawXTR"),
  unknown("Unknown");

  final String value;
  const ActionType(this.value);

  static ActionType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching ActionType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum AuctionBidActionAuctionType {
  dNSTon("DNS.ton"),
  dNSTg("DNS.tg"),
  nUMBERTg("NUMBER.tg"),
  getgems("getgems");

  final String value;
  const AuctionBidActionAuctionType(this.value);

  static AuctionBidActionAuctionType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching AuctionBidActionAuctionType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum BlockchainAccountInspectCompiler {
  func("func"),
  fift("fift"),
  tact("tact"),
  tolk("tolk");

  final String value;
  const BlockchainAccountInspectCompiler(this.value);

  static BlockchainAccountInspectCompiler fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching BlockchainAccountInspectCompiler found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// native Gram or jetton asset
enum DefiLockedAssetType {
  native("native"),
  jetton("jetton");

  final String value;
  const DefiLockedAssetType(this.value);

  static DefiLockedAssetType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching DefiLockedAssetType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum JettonOperationOperation {
  transfer("transfer"),
  mint("mint"),
  burn("burn");

  final String value;
  const JettonOperationOperation(this.value);

  static JettonOperationOperation fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching JettonOperationOperation found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum MessageMsgType {
  intMsg("int_msg"),
  extInMsg("ext_in_msg"),
  extOutMsg("ext_out_msg");

  final String value;
  const MessageMsgType(this.value);

  static MessageMsgType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching MessageMsgType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// Who pays the gas:
///   - `self` — the source wallet pays, as usual
///   - `battery` — asset transfers are sponsored by the Tonkeeper Battery
///   - `gasless` — source wallet pays with jetton, in this case `gas_jetton_master` is required too (only from this list: `/v2/gasless/config`)
enum MigrationPrepareRequestGasPayer {
  self("self"),
  battery("battery"),
  gasless("gasless");

  final String value;
  const MigrationPrepareRequestGasPayer(this.value);

  static MigrationPrepareRequestGasPayer fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching MigrationPrepareRequestGasPayer found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum NftApprovedByItem {
  getgems("getgems"),
  tonkeeper("tonkeeper");

  final String value;
  const NftApprovedByItem(this.value);

  static NftApprovedByItem fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching NftApprovedByItem found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum PictureDNSType {
  url("url"),
  bagId("bag_id");

  final String value;
  const PictureDNSType(this.value);

  static PictureDNSType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching PictureDNSType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum RefundType {
  dNSTon("DNS.ton"),
  dNSTg("DNS.tg"),
  getGems("GetGems");

  final String value;
  const RefundType(this.value);

  static RefundType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching RefundType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// address allows unlimited pagination via last_account_id cursor, balance sorting allow getting top holders
enum SortBy {
  balance("balance"),
  address("address");

  final String value;
  const SortBy(this.value);

  static SortBy fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SortBy found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// used to sort the result-set in ascending or descending order by lt.
enum SortOrder {
  desc("desc"),
  asc("asc");

  final String value;
  const SortOrder(this.value);

  static SortOrder fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SortOrder found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum SubscriptionStatus {
  notReady("not_ready"),
  active("active"),
  suspended("suspended"),
  cancelled("cancelled");

  final String value;
  const SubscriptionStatus(this.value);

  static SubscriptionStatus fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching SubscriptionStatus found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum TvmStackRecordType {
  cell("cell"),
  num_("num"),
  nan("nan"),
  null_("null"),
  tuple("tuple");

  final String value;
  const TvmStackRecordType(this.value);

  static TvmStackRecordType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching TvmStackRecordType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// Contract type detected by code hash.
enum ValidatorRewardEntryPoolType {
  nominatorPoolV10("nominator-pool-v1.0"),
  singleNominatorPoolV10("single-nominator-pool-v1.0"),
  singleNominatorPoolV11("single-nominator-pool-v1.1"),
  other("other");

  final String value;
  const ValidatorRewardEntryPoolType(this.value);

  static ValidatorRewardEntryPoolType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching ValidatorRewardEntryPoolType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// GET /v2/accounts/{account_id} (response)
class Account {
  final String address;
  final BigInt balance;

  /// {'USD': 1, 'IDR': 1000}
  final Map<String, dynamic>? currenciesBalance;
  final List<ExtraCurrency>? extraBalance;
  final List<String> getMethods;
  final String? icon;
  final List<String>? interfaces;
  final bool? isScam;
  final bool? isSuspended;
  final bool isWallet;

  /// unix timestamp
  final BigInt lastActivity;
  final bool? memoRequired;
  final String? name;
  final AccountStatus status;

  const Account({
    required this.address,
    required this.balance,
    this.currenciesBalance,
    this.extraBalance,
    required this.getMethods,
    this.icon,
    this.interfaces,
    this.isScam,
    this.isSuspended,
    required this.isWallet,
    required this.lastActivity,
    this.memoRequired,
    this.name,
    required this.status,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      balance: json.valueAsBigInt<BigInt>('balance'),
      currenciesBalance: json.valueAsMap<Map<String, dynamic>?>(
        'currencies_balance',
      ),
      extraBalance:
          json.hasValue('extra_balance')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('extra_balance')
                  .map((e) => ExtraCurrency.fromJson(e))
                  .toList()
              : null,
      getMethods: json.valueAsList<List<String>>('get_methods'),
      icon:
          (json['icon'] is num
              ? json['icon'].toString()
              : json.valueAsString<String?>('icon')),
      interfaces: json.valueAsList<List<String>?>('interfaces'),
      isScam: json.valueAsBool<bool?>('is_scam'),
      isSuspended: json.valueAsBool<bool?>('is_suspended'),
      isWallet: json.valueAsBool<bool>('is_wallet'),
      lastActivity: json.valueAsBigInt<BigInt>('last_activity'),
      memoRequired: json.valueAsBool<bool?>('memo_required'),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String?>('name')),
      status: json.valueTo<AccountStatus, Object>(
        key: 'status',
        parse: (e) => AccountStatus.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'balance': config.encodeBigint(balance),
    'currencies_balance': currenciesBalance,
    'extra_balance':
        extraBalance?.map((e) => e.toJson(config: config)).toList(),
    'get_methods': getMethods,
    'icon': icon,
    'interfaces': interfaces,
    'is_scam': isScam,
    'is_suspended': isSuspended,
    'is_wallet': isWallet,
    'last_activity': config.encodeBigint(lastActivity),
    'memo_required': memoRequired,
    'name': name,
    'status': status.toJson(config: config),
  });
}

class AccountAddress {
  final String address;
  final String? icon;

  /// Is this account was marked as part of scammers activity
  final bool isScam;
  final bool isWallet;

  /// Display name. Data collected from different sources like moderation lists, dns, collections names and over.
  final String? name;

  const AccountAddress({
    required this.address,
    this.icon,
    required this.isScam,
    required this.isWallet,
    this.name,
  });

  factory AccountAddress.fromJson(Map<String, dynamic> json) {
    return AccountAddress(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      icon:
          (json['icon'] is num
              ? json['icon'].toString()
              : json.valueAsString<String?>('icon')),
      isScam: json.valueAsBool<bool>('is_scam'),
      isWallet: json.valueAsBool<bool>('is_wallet'),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String?>('name')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'icon': icon,
    'is_scam': isScam,
    'is_wallet': isWallet,
    'name': name,
  });
}

/// High-level view over a transaction trace caused by a single inbound message. TonAPI analyses the trace, detects known patterns and groups low-level transactions into user-facing actions (Jetton transfer, NFT purchase, etc.). Actions are a best-effort UI abstraction and may change; do not rely on them for protocol-critical logic.
///
/// POST /v2/accounts/{account_id}/events/emulate (response)
/// GET /v2/accounts/{account_id}/events/{event_id} (response)
class AccountEvent {
  final AccountAddress account;
  final List<Action> actions;
  final String eventId;

  /// Normalized hash of the root external inbound message (hex).
  final String? extMsgHash;

  /// Net Gram change for this account not explained by actions, in nanograms: extra = final_balance - initial_balance - sum(explicit Gram changes from actions). extra < 0 - implicit fee, extra > 0 - refund. For UI display only
  final BigInt extra;

  /// Event trace is not finished yet. Transactions still happening.
  final bool inProgress;

  /// scam
  final bool isScam;
  final BigInt lt;

  /// Event completion ratio in [0,1]
  final double progress;
  final BigInt timestamp;

  const AccountEvent({
    required this.account,
    required this.actions,
    required this.eventId,
    this.extMsgHash,
    required this.extra,
    required this.inProgress,
    required this.isScam,
    required this.lt,
    required this.progress,
    required this.timestamp,
  });

  factory AccountEvent.fromJson(Map<String, dynamic> json) {
    return AccountEvent(
      account: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'account',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      actions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('actions')
              .map((e) => Action.fromJson(e))
              .toList(),
      eventId:
          (json['event_id'] is num
              ? json['event_id'].toString()
              : json.valueAsString<String>('event_id')),
      extMsgHash:
          (json['ext_msg_hash'] is num
              ? json['ext_msg_hash'].toString()
              : json.valueAsString<String?>('ext_msg_hash')),
      extra: json.valueAsBigInt<BigInt>('extra'),
      inProgress: json.valueAsBool<bool>('in_progress'),
      isScam: json.valueAsBool<bool>('is_scam'),
      lt: json.valueAsBigInt<BigInt>('lt'),
      progress: json.valueAsDouble<double>('progress'),
      timestamp: json.valueAsBigInt<BigInt>('timestamp'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'account': account.toJson(config: config),
    'actions': actions.map((e) => e.toJson(config: config)).toList(),
    'event_id': eventId,
    'ext_msg_hash': extMsgHash,
    'extra': config.encodeBigint(extra),
    'in_progress': inProgress,
    'is_scam': isScam,
    'lt': config.encodeBigint(lt),
    'progress': progress,
    'timestamp': config.encodeBigint(timestamp),
  });
}

/// Paginated list of events for a single account.
///
/// GET /v2/accounts/{account_id}/events (response)
/// GET /v2/accounts/{account_id}/extra-currency/{id}/history (response)
/// GET /v2/accounts/{account_id}/jettons/{jetton_id}/history (response)
/// GET /v2/nfts/{account_id}/history (response)
class AccountEvents {
  final List<AccountEvent> events;
  final BigInt nextFrom;

  const AccountEvents({required this.events, required this.nextFrom});

  factory AccountEvents.fromJson(Map<String, dynamic> json) {
    return AccountEvents(
      events:
          json
              .valueEnsureAsList<Map<String, dynamic>>('events')
              .map((e) => AccountEvent.fromJson(e))
              .toList(),
      nextFrom: json.valueAsBigInt<BigInt>('next_from'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'events': events.map((e) => e.toJson(config: config)).toList(),
    'next_from': config.encodeBigint(nextFrom),
  });
}

/// POST /v2/tonconnect/stateinit (response)
class AccountInfoByStateInit {
  final String address;
  final String publicKey;

  const AccountInfoByStateInit({
    required this.address,
    required this.publicKey,
  });

  factory AccountInfoByStateInit.fromJson(Map<String, dynamic> json) {
    return AccountInfoByStateInit(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      publicKey:
          (json['public_key'] is num
              ? json['public_key'].toString()
              : json.valueAsString<String>('public_key')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'public_key': publicKey,
  });
}

/// GET /v2/purchases/{account_id}/history (response)
class AccountPurchases {
  final BigInt nextFrom;
  final List<Purchase> purchases;

  const AccountPurchases({required this.nextFrom, required this.purchases});

  factory AccountPurchases.fromJson(Map<String, dynamic> json) {
    return AccountPurchases(
      nextFrom: json.valueAsBigInt<BigInt>('next_from'),
      purchases:
          json
              .valueEnsureAsList<Map<String, dynamic>>('purchases')
              .map((e) => Purchase.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'next_from': config.encodeBigint(nextFrom),
    'purchases': purchases.map((e) => e.toJson(config: config)).toList(),
  });
}

/// GET /v2/staking/nominator/{account_id}/pools (response)
class AccountStaking {
  final List<AccountStakingInfo> pools;

  const AccountStaking({required this.pools});

  factory AccountStaking.fromJson(Map<String, dynamic> json) {
    return AccountStaking(
      pools:
          json
              .valueEnsureAsList<Map<String, dynamic>>('pools')
              .map((e) => AccountStakingInfo.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'pools': pools.map((e) => e.toJson(config: config)).toList(),
  });
}

class AccountStakingInfo {
  final BigInt amount;
  final BigInt pendingDeposit;
  final BigInt pendingWithdraw;
  final String pool;
  final BigInt readyWithdraw;

  const AccountStakingInfo({
    required this.amount,
    required this.pendingDeposit,
    required this.pendingWithdraw,
    required this.pool,
    required this.readyWithdraw,
  });

  factory AccountStakingInfo.fromJson(Map<String, dynamic> json) {
    return AccountStakingInfo(
      amount: json.valueAsBigInt<BigInt>('amount'),
      pendingDeposit: json.valueAsBigInt<BigInt>('pending_deposit'),
      pendingWithdraw: json.valueAsBigInt<BigInt>('pending_withdraw'),
      pool:
          (json['pool'] is num
              ? json['pool'].toString()
              : json.valueAsString<String>('pool')),
      readyWithdraw: json.valueAsBigInt<BigInt>('ready_withdraw'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': config.encodeBigint(amount),
    'pending_deposit': config.encodeBigint(pendingDeposit),
    'pending_withdraw': config.encodeBigint(pendingWithdraw),
    'pool': pool,
    'ready_withdraw': config.encodeBigint(readyWithdraw),
  });
}

class AccountStorageInfo {
  final BigInt duePayment;

  /// time of the last payment
  final BigInt lastPaid;
  final BigInt usedBits;
  final BigInt usedCells;
  final BigInt usedPublicCells;

  const AccountStorageInfo({
    required this.duePayment,
    required this.lastPaid,
    required this.usedBits,
    required this.usedCells,
    required this.usedPublicCells,
  });

  factory AccountStorageInfo.fromJson(Map<String, dynamic> json) {
    return AccountStorageInfo(
      duePayment: json.valueAsBigInt<BigInt>('due_payment'),
      lastPaid: json.valueAsBigInt<BigInt>('last_paid'),
      usedBits: json.valueAsBigInt<BigInt>('used_bits'),
      usedCells: json.valueAsBigInt<BigInt>('used_cells'),
      usedPublicCells: json.valueAsBigInt<BigInt>('used_public_cells'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'due_payment': config.encodeBigint(duePayment),
    'last_paid': config.encodeBigint(lastPaid),
    'used_bits': config.encodeBigint(usedBits),
    'used_cells': config.encodeBigint(usedCells),
    'used_public_cells': config.encodeBigint(usedPublicCells),
  });
}

/// POST /v2/accounts/_bulk (response)
class Accounts {
  final List<Account> accounts;

  const Accounts({required this.accounts});

  factory Accounts.fromJson(Map<String, dynamic> json) {
    return Accounts(
      accounts:
          json
              .valueEnsureAsList<Map<String, dynamic>>('accounts')
              .map((e) => Account.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'accounts': accounts.map((e) => e.toJson(config: config)).toList(),
  });
}

class Action {
  final AddExtensionAction? addExtension;
  final AuctionBidAction? auctionBid;
  final BuyXTRAction? buyXTR;
  final ContractDeployAction? contractDeploy;
  final DepositStakeAction? depositStake;
  final DepositTokenStakeAction? depositTokenStake;
  final DepositXTRAction? depositXTR;
  final DomainRenewAction? domainRenew;
  final ElectionsDepositStakeAction? electionsDepositStake;
  final ElectionsRecoverStakeAction? electionsRecoverStake;
  final ExtraCurrencyTransferAction? extraCurrencyTransfer;
  final FlawedJettonTransferAction? flawedJettonTransfer;
  final GasRelayAction? gasRelay;
  final JettonBurnAction? jettonBurn;
  final JettonMintAction? jettonMint;
  final JettonSwapAction? jettonSwap;
  final JettonTransferAction? jettonTransfer;
  final LiquidityDepositAction? liquidityDeposit;
  final NftItemTransferAction? nftItemTransfer;
  final NftPurchaseAction? nftPurchase;
  final OracleRequestAction? oracleRequest;
  final PurchaseAction? purchase;
  final RemoveExtensionAction? removeExtension;
  final SetSignatureAllowedAction? setSignatureAllowedAction;
  final SmartContractAction? smartContractExec;
  final SubscriptionAction? subscribe;
  final TonTransferAction? tonTransfer;
  final UnSubscriptionAction? unSubscribe;
  final WithdrawStakeAction? withdrawStake;
  final WithdrawStakeRequestAction? withdrawStakeRequest;
  final WithdrawTokenStakeRequestAction? withdrawTokenStakeRequest;
  final WithdrawXTRAction? withdrawXTR;
  final List<String> baseTransactions;
  final ActionSimplePreview simplePreview;
  final ActionStatus status;
  final ActionType type;

  const Action({
    this.addExtension,
    this.auctionBid,
    this.buyXTR,
    this.contractDeploy,
    this.depositStake,
    this.depositTokenStake,
    this.depositXTR,
    this.domainRenew,
    this.electionsDepositStake,
    this.electionsRecoverStake,
    this.extraCurrencyTransfer,
    this.flawedJettonTransfer,
    this.gasRelay,
    this.jettonBurn,
    this.jettonMint,
    this.jettonSwap,
    this.jettonTransfer,
    this.liquidityDeposit,
    this.nftItemTransfer,
    this.nftPurchase,
    this.oracleRequest,
    this.purchase,
    this.removeExtension,
    this.setSignatureAllowedAction,
    this.smartContractExec,
    this.subscribe,
    this.tonTransfer,
    this.unSubscribe,
    this.withdrawStake,
    this.withdrawStakeRequest,
    this.withdrawTokenStakeRequest,
    this.withdrawXTR,
    required this.baseTransactions,
    required this.simplePreview,
    required this.status,
    required this.type,
  });

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
      addExtension: json.valueTo<AddExtensionAction?, Map<String, dynamic>>(
        key: 'AddExtension',
        parse: (v) => AddExtensionAction.fromJson(v),
      ),
      auctionBid: json.valueTo<AuctionBidAction?, Map<String, dynamic>>(
        key: 'AuctionBid',
        parse: (v) => AuctionBidAction.fromJson(v),
      ),
      buyXTR: json.valueTo<BuyXTRAction?, Map<String, dynamic>>(
        key: 'BuyXTR',
        parse: (v) => BuyXTRAction.fromJson(v),
      ),
      contractDeploy: json.valueTo<ContractDeployAction?, Map<String, dynamic>>(
        key: 'ContractDeploy',
        parse: (v) => ContractDeployAction.fromJson(v),
      ),
      depositStake: json.valueTo<DepositStakeAction?, Map<String, dynamic>>(
        key: 'DepositStake',
        parse: (v) => DepositStakeAction.fromJson(v),
      ),
      depositTokenStake: json
          .valueTo<DepositTokenStakeAction?, Map<String, dynamic>>(
            key: 'DepositTokenStake',
            parse: (v) => DepositTokenStakeAction.fromJson(v),
          ),
      depositXTR: json.valueTo<DepositXTRAction?, Map<String, dynamic>>(
        key: 'DepositXTR',
        parse: (v) => DepositXTRAction.fromJson(v),
      ),
      domainRenew: json.valueTo<DomainRenewAction?, Map<String, dynamic>>(
        key: 'DomainRenew',
        parse: (v) => DomainRenewAction.fromJson(v),
      ),
      electionsDepositStake: json
          .valueTo<ElectionsDepositStakeAction?, Map<String, dynamic>>(
            key: 'ElectionsDepositStake',
            parse: (v) => ElectionsDepositStakeAction.fromJson(v),
          ),
      electionsRecoverStake: json
          .valueTo<ElectionsRecoverStakeAction?, Map<String, dynamic>>(
            key: 'ElectionsRecoverStake',
            parse: (v) => ElectionsRecoverStakeAction.fromJson(v),
          ),
      extraCurrencyTransfer: json
          .valueTo<ExtraCurrencyTransferAction?, Map<String, dynamic>>(
            key: 'ExtraCurrencyTransfer',
            parse: (v) => ExtraCurrencyTransferAction.fromJson(v),
          ),
      flawedJettonTransfer: json
          .valueTo<FlawedJettonTransferAction?, Map<String, dynamic>>(
            key: 'FlawedJettonTransfer',
            parse: (v) => FlawedJettonTransferAction.fromJson(v),
          ),
      gasRelay: json.valueTo<GasRelayAction?, Map<String, dynamic>>(
        key: 'GasRelay',
        parse: (v) => GasRelayAction.fromJson(v),
      ),
      jettonBurn: json.valueTo<JettonBurnAction?, Map<String, dynamic>>(
        key: 'JettonBurn',
        parse: (v) => JettonBurnAction.fromJson(v),
      ),
      jettonMint: json.valueTo<JettonMintAction?, Map<String, dynamic>>(
        key: 'JettonMint',
        parse: (v) => JettonMintAction.fromJson(v),
      ),
      jettonSwap: json.valueTo<JettonSwapAction?, Map<String, dynamic>>(
        key: 'JettonSwap',
        parse: (v) => JettonSwapAction.fromJson(v),
      ),
      jettonTransfer: json.valueTo<JettonTransferAction?, Map<String, dynamic>>(
        key: 'JettonTransfer',
        parse: (v) => JettonTransferAction.fromJson(v),
      ),
      liquidityDeposit: json
          .valueTo<LiquidityDepositAction?, Map<String, dynamic>>(
            key: 'LiquidityDeposit',
            parse: (v) => LiquidityDepositAction.fromJson(v),
          ),
      nftItemTransfer: json
          .valueTo<NftItemTransferAction?, Map<String, dynamic>>(
            key: 'NftItemTransfer',
            parse: (v) => NftItemTransferAction.fromJson(v),
          ),
      nftPurchase: json.valueTo<NftPurchaseAction?, Map<String, dynamic>>(
        key: 'NftPurchase',
        parse: (v) => NftPurchaseAction.fromJson(v),
      ),
      oracleRequest: json.valueTo<OracleRequestAction?, Map<String, dynamic>>(
        key: 'OracleRequest',
        parse: (v) => OracleRequestAction.fromJson(v),
      ),
      purchase: json.valueTo<PurchaseAction?, Map<String, dynamic>>(
        key: 'Purchase',
        parse: (v) => PurchaseAction.fromJson(v),
      ),
      removeExtension: json
          .valueTo<RemoveExtensionAction?, Map<String, dynamic>>(
            key: 'RemoveExtension',
            parse: (v) => RemoveExtensionAction.fromJson(v),
          ),
      setSignatureAllowedAction: json
          .valueTo<SetSignatureAllowedAction?, Map<String, dynamic>>(
            key: 'SetSignatureAllowedAction',
            parse: (v) => SetSignatureAllowedAction.fromJson(v),
          ),
      smartContractExec: json
          .valueTo<SmartContractAction?, Map<String, dynamic>>(
            key: 'SmartContractExec',
            parse: (v) => SmartContractAction.fromJson(v),
          ),
      subscribe: json.valueTo<SubscriptionAction?, Map<String, dynamic>>(
        key: 'Subscribe',
        parse: (v) => SubscriptionAction.fromJson(v),
      ),
      tonTransfer: json.valueTo<TonTransferAction?, Map<String, dynamic>>(
        key: 'TonTransfer',
        parse: (v) => TonTransferAction.fromJson(v),
      ),
      unSubscribe: json.valueTo<UnSubscriptionAction?, Map<String, dynamic>>(
        key: 'UnSubscribe',
        parse: (v) => UnSubscriptionAction.fromJson(v),
      ),
      withdrawStake: json.valueTo<WithdrawStakeAction?, Map<String, dynamic>>(
        key: 'WithdrawStake',
        parse: (v) => WithdrawStakeAction.fromJson(v),
      ),
      withdrawStakeRequest: json
          .valueTo<WithdrawStakeRequestAction?, Map<String, dynamic>>(
            key: 'WithdrawStakeRequest',
            parse: (v) => WithdrawStakeRequestAction.fromJson(v),
          ),
      withdrawTokenStakeRequest: json
          .valueTo<WithdrawTokenStakeRequestAction?, Map<String, dynamic>>(
            key: 'WithdrawTokenStakeRequest',
            parse: (v) => WithdrawTokenStakeRequestAction.fromJson(v),
          ),
      withdrawXTR: json.valueTo<WithdrawXTRAction?, Map<String, dynamic>>(
        key: 'WithdrawXTR',
        parse: (v) => WithdrawXTRAction.fromJson(v),
      ),
      baseTransactions: json.valueAsList<List<String>>('base_transactions'),
      simplePreview: json.valueTo<ActionSimplePreview, Map<String, dynamic>>(
        key: 'simple_preview',
        parse: (v) => ActionSimplePreview.fromJson(v),
      ),
      status: json.valueTo<ActionStatus, Object>(
        key: 'status',
        parse: (e) => ActionStatus.fromJson(JsonParser.valueAs(e)),
      ),
      type: json.valueTo<ActionType, Object>(
        key: 'type',
        parse: (e) => ActionType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'AddExtension': addExtension?.toJson(config: config),
    'AuctionBid': auctionBid?.toJson(config: config),
    'BuyXTR': buyXTR?.toJson(config: config),
    'ContractDeploy': contractDeploy?.toJson(config: config),
    'DepositStake': depositStake?.toJson(config: config),
    'DepositTokenStake': depositTokenStake?.toJson(config: config),
    'DepositXTR': depositXTR?.toJson(config: config),
    'DomainRenew': domainRenew?.toJson(config: config),
    'ElectionsDepositStake': electionsDepositStake?.toJson(config: config),
    'ElectionsRecoverStake': electionsRecoverStake?.toJson(config: config),
    'ExtraCurrencyTransfer': extraCurrencyTransfer?.toJson(config: config),
    'FlawedJettonTransfer': flawedJettonTransfer?.toJson(config: config),
    'GasRelay': gasRelay?.toJson(config: config),
    'JettonBurn': jettonBurn?.toJson(config: config),
    'JettonMint': jettonMint?.toJson(config: config),
    'JettonSwap': jettonSwap?.toJson(config: config),
    'JettonTransfer': jettonTransfer?.toJson(config: config),
    'LiquidityDeposit': liquidityDeposit?.toJson(config: config),
    'NftItemTransfer': nftItemTransfer?.toJson(config: config),
    'NftPurchase': nftPurchase?.toJson(config: config),
    'OracleRequest': oracleRequest?.toJson(config: config),
    'Purchase': purchase?.toJson(config: config),
    'RemoveExtension': removeExtension?.toJson(config: config),
    'SetSignatureAllowedAction': setSignatureAllowedAction?.toJson(
      config: config,
    ),
    'SmartContractExec': smartContractExec?.toJson(config: config),
    'Subscribe': subscribe?.toJson(config: config),
    'TonTransfer': tonTransfer?.toJson(config: config),
    'UnSubscribe': unSubscribe?.toJson(config: config),
    'WithdrawStake': withdrawStake?.toJson(config: config),
    'WithdrawStakeRequest': withdrawStakeRequest?.toJson(config: config),
    'WithdrawTokenStakeRequest': withdrawTokenStakeRequest?.toJson(
      config: config,
    ),
    'WithdrawXTR': withdrawXTR?.toJson(config: config),
    'base_transactions': baseTransactions,
    'simple_preview': simplePreview.toJson(config: config),
    'status': status.toJson(config: config),
    'type': type.toJson(config: config),
  });
}

class ActionPhase {
  final BigInt fwdFees;
  final int resultCode;
  final String? resultCodeDescription;
  final int skippedActions;
  final bool success;
  final int totalActions;
  final BigInt totalFees;

  const ActionPhase({
    required this.fwdFees,
    required this.resultCode,
    this.resultCodeDescription,
    required this.skippedActions,
    required this.success,
    required this.totalActions,
    required this.totalFees,
  });

  factory ActionPhase.fromJson(Map<String, dynamic> json) {
    return ActionPhase(
      fwdFees: json.valueAsBigInt<BigInt>('fwd_fees'),
      resultCode: json.valueAsInt<int>('result_code'),
      resultCodeDescription:
          (json['result_code_description'] is num
              ? json['result_code_description'].toString()
              : json.valueAsString<String?>('result_code_description')),
      skippedActions: json.valueAsInt<int>('skipped_actions'),
      success: json.valueAsBool<bool>('success'),
      totalActions: json.valueAsInt<int>('total_actions'),
      totalFees: json.valueAsBigInt<BigInt>('total_fees'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'fwd_fees': config.encodeBigint(fwdFees),
    'result_code': resultCode,
    'result_code_description': resultCodeDescription,
    'skipped_actions': skippedActions,
    'success': success,
    'total_actions': totalActions,
    'total_fees': config.encodeBigint(totalFees),
  });
}

/// shortly describes what this action is about.
class ActionSimplePreview {
  final List<AccountAddress> accounts;

  /// a link to an image for this particular action.
  final String? actionImage;
  final String description;

  /// the value of this action expressed in the requested fiat currency.
  final String? fiatValue;
  final String name;
  final String? value;

  /// a link to an image that depicts this action's asset.
  final String? valueImage;

  const ActionSimplePreview({
    required this.accounts,
    this.actionImage,
    required this.description,
    this.fiatValue,
    required this.name,
    this.value,
    this.valueImage,
  });

  factory ActionSimplePreview.fromJson(Map<String, dynamic> json) {
    return ActionSimplePreview(
      accounts:
          json
              .valueEnsureAsList<Map<String, dynamic>>('accounts')
              .map((e) => AccountAddress.fromJson(e))
              .toList(),
      actionImage:
          (json['action_image'] is num
              ? json['action_image'].toString()
              : json.valueAsString<String?>('action_image')),
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString<String>('description')),
      fiatValue:
          (json['fiat_value'] is num
              ? json['fiat_value'].toString()
              : json.valueAsString<String?>('fiat_value')),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String>('name')),
      value:
          (json['value'] is num
              ? json['value'].toString()
              : json.valueAsString<String?>('value')),
      valueImage:
          (json['value_image'] is num
              ? json['value_image'].toString()
              : json.valueAsString<String?>('value_image')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'accounts': accounts.map((e) => e.toJson(config: config)).toList(),
    'action_image': actionImage,
    'description': description,
    'fiat_value': fiatValue,
    'name': name,
    'value': value,
    'value_image': valueImage,
  });
}

class AddExtensionAction {
  final String extension_;
  final AccountAddress wallet;

  const AddExtensionAction({required this.extension_, required this.wallet});

  factory AddExtensionAction.fromJson(Map<String, dynamic> json) {
    return AddExtensionAction(
      extension_:
          (json['extension'] is num
              ? json['extension'].toString()
              : json.valueAsString<String>('extension')),
      wallet: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'wallet',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'extension': extension_,
    'wallet': wallet.toJson(config: config),
  });
}

class ApyHistory {
  final num apy;
  final int time;

  const ApyHistory({required this.apy, required this.time});

  factory ApyHistory.fromJson(Map<String, dynamic> json) {
    return ApyHistory(
      apy: json.valueAsNum<num>('apy'),
      time: json.valueAsInt<int>('time'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'apy': apy, 'time': time});
}

class Auction {
  final BigInt bids;
  final BigInt date;
  final String domain;
  final String owner;
  final BigInt price;

  const Auction({
    required this.bids,
    required this.date,
    required this.domain,
    required this.owner,
    required this.price,
  });

  factory Auction.fromJson(Map<String, dynamic> json) {
    return Auction(
      bids: json.valueAsBigInt<BigInt>('bids'),
      date: json.valueAsBigInt<BigInt>('date'),
      domain:
          (json['domain'] is num
              ? json['domain'].toString()
              : json.valueAsString<String>('domain')),
      owner:
          (json['owner'] is num
              ? json['owner'].toString()
              : json.valueAsString<String>('owner')),
      price: json.valueAsBigInt<BigInt>('price'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bids': config.encodeBigint(bids),
    'date': config.encodeBigint(date),
    'domain': domain,
    'owner': owner,
    'price': config.encodeBigint(price),
  });
}

class AuctionBidAction {
  final Price amount;
  final AccountAddress auction;
  final AuctionBidActionAuctionType auctionType;
  final AccountAddress bidder;
  final NftItem? nft;

  const AuctionBidAction({
    required this.amount,
    required this.auction,
    required this.auctionType,
    required this.bidder,
    this.nft,
  });

  factory AuctionBidAction.fromJson(Map<String, dynamic> json) {
    return AuctionBidAction(
      amount: json.valueTo<Price, Map<String, dynamic>>(
        key: 'amount',
        parse: (v) => Price.fromJson(v),
      ),
      auction: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'auction',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      auctionType: json.valueTo<AuctionBidActionAuctionType, Object>(
        key: 'auction_type',
        parse:
            (e) => AuctionBidActionAuctionType.fromJson(JsonParser.valueAs(e)),
      ),
      bidder: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'bidder',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      nft: json.valueTo<NftItem?, Map<String, dynamic>>(
        key: 'nft',
        parse: (v) => NftItem.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount.toJson(config: config),
    'auction': auction.toJson(config: config),
    'auction_type': auctionType.toJson(config: config),
    'bidder': bidder.toJson(config: config),
    'nft': nft?.toJson(config: config),
  });
}

/// GET /v2/dns/auctions (response)
class Auctions {
  final List<Auction> data;
  final BigInt total;

  const Auctions({required this.data, required this.total});

  factory Auctions.fromJson(Map<String, dynamic> json) {
    return Auctions(
      data:
          json
              .valueEnsureAsList<Map<String, dynamic>>('data')
              .map((e) => Auction.fromJson(e))
              .toList(),
      total: json.valueAsBigInt<BigInt>('total'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'data': data.map((e) => e.toJson(config: config)).toList(),
    'total': config.encodeBigint(total),
  });
}

class BlockCurrencyCollection {
  final BigInt grams;
  final List<BlockCurrencyCollectionOtherItem> other;

  const BlockCurrencyCollection({required this.grams, required this.other});

  factory BlockCurrencyCollection.fromJson(Map<String, dynamic> json) {
    return BlockCurrencyCollection(
      grams: json.valueAsBigInt<BigInt>('grams'),
      other:
          json
              .valueEnsureAsList<Map<String, dynamic>>('other')
              .map((e) => BlockCurrencyCollectionOtherItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'grams': config.encodeBigint(grams),
    'other': other.map((e) => e.toJson(config: config)).toList(),
  });
}

class BlockInfo {
  /// Masterchain block sequence number.
  final int seqno;
  final BigInt? utime;

  const BlockInfo({required this.seqno, this.utime});

  factory BlockInfo.fromJson(Map<String, dynamic> json) {
    return BlockInfo(
      seqno: json.valueAsInt<int>('seqno'),
      utime: json.valueAsBigInt<BigInt?>('utime'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'seqno': seqno,
    'utime': config.encodeBigint(utime),
  });
}

class BlockLimits {
  final BlockParamLimits bytes;
  final BlockParamLimits gas;
  final BlockParamLimits ltDelta;

  const BlockLimits({
    required this.bytes,
    required this.gas,
    required this.ltDelta,
  });

  factory BlockLimits.fromJson(Map<String, dynamic> json) {
    return BlockLimits(
      bytes: json.valueTo<BlockParamLimits, Map<String, dynamic>>(
        key: 'bytes',
        parse: (v) => BlockParamLimits.fromJson(v),
      ),
      gas: json.valueTo<BlockParamLimits, Map<String, dynamic>>(
        key: 'gas',
        parse: (v) => BlockParamLimits.fromJson(v),
      ),
      ltDelta: json.valueTo<BlockParamLimits, Map<String, dynamic>>(
        key: 'lt_delta',
        parse: (v) => BlockParamLimits.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bytes': bytes.toJson(config: config),
    'gas': gas.toJson(config: config),
    'lt_delta': ltDelta.toJson(config: config),
  });
}

class BlockParamLimits {
  final BigInt hardLimit;
  final BigInt softLimit;
  final BigInt underload;

  const BlockParamLimits({
    required this.hardLimit,
    required this.softLimit,
    required this.underload,
  });

  factory BlockParamLimits.fromJson(Map<String, dynamic> json) {
    return BlockParamLimits(
      hardLimit: json.valueAsBigInt<BigInt>('hard_limit'),
      softLimit: json.valueAsBigInt<BigInt>('soft_limit'),
      underload: json.valueAsBigInt<BigInt>('underload'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'hard_limit': config.encodeBigint(hardLimit),
    'soft_limit': config.encodeBigint(softLimit),
    'underload': config.encodeBigint(underload),
  });
}

class BlockRaw {
  final String fileHash;
  final String rootHash;
  final int seqno;
  final String shard;
  final int workchain;

  const BlockRaw({
    required this.fileHash,
    required this.rootHash,
    required this.seqno,
    required this.shard,
    required this.workchain,
  });

  factory BlockRaw.fromJson(Map<String, dynamic> json) {
    return BlockRaw(
      fileHash:
          (json['file_hash'] is num
              ? json['file_hash'].toString()
              : json.valueAsString<String>('file_hash')),
      rootHash:
          (json['root_hash'] is num
              ? json['root_hash'].toString()
              : json.valueAsString<String>('root_hash')),
      seqno: json.valueAsInt<int>('seqno'),
      shard:
          (json['shard'] is num
              ? json['shard'].toString()
              : json.valueAsString<String>('shard')),
      workchain: json.valueAsInt<int>('workchain'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'file_hash': fileHash,
    'root_hash': rootHash,
    'seqno': seqno,
    'shard': shard,
    'workchain': workchain,
  });
}

class BlockValueFlow {
  final BlockCurrencyCollection? burned;
  final BlockCurrencyCollection created;
  final BlockCurrencyCollection exported;
  final BlockCurrencyCollection feesCollected;
  final BlockCurrencyCollection feesImported;
  final BlockCurrencyCollection fromPrevBlk;
  final BlockCurrencyCollection imported;
  final BlockCurrencyCollection minted;
  final BlockCurrencyCollection recovered;
  final BlockCurrencyCollection toNextBlk;

  const BlockValueFlow({
    this.burned,
    required this.created,
    required this.exported,
    required this.feesCollected,
    required this.feesImported,
    required this.fromPrevBlk,
    required this.imported,
    required this.minted,
    required this.recovered,
    required this.toNextBlk,
  });

  factory BlockValueFlow.fromJson(Map<String, dynamic> json) {
    return BlockValueFlow(
      burned: json.valueTo<BlockCurrencyCollection?, Map<String, dynamic>>(
        key: 'burned',
        parse: (v) => BlockCurrencyCollection.fromJson(v),
      ),
      created: json.valueTo<BlockCurrencyCollection, Map<String, dynamic>>(
        key: 'created',
        parse: (v) => BlockCurrencyCollection.fromJson(v),
      ),
      exported: json.valueTo<BlockCurrencyCollection, Map<String, dynamic>>(
        key: 'exported',
        parse: (v) => BlockCurrencyCollection.fromJson(v),
      ),
      feesCollected: json
          .valueTo<BlockCurrencyCollection, Map<String, dynamic>>(
            key: 'fees_collected',
            parse: (v) => BlockCurrencyCollection.fromJson(v),
          ),
      feesImported: json.valueTo<BlockCurrencyCollection, Map<String, dynamic>>(
        key: 'fees_imported',
        parse: (v) => BlockCurrencyCollection.fromJson(v),
      ),
      fromPrevBlk: json.valueTo<BlockCurrencyCollection, Map<String, dynamic>>(
        key: 'from_prev_blk',
        parse: (v) => BlockCurrencyCollection.fromJson(v),
      ),
      imported: json.valueTo<BlockCurrencyCollection, Map<String, dynamic>>(
        key: 'imported',
        parse: (v) => BlockCurrencyCollection.fromJson(v),
      ),
      minted: json.valueTo<BlockCurrencyCollection, Map<String, dynamic>>(
        key: 'minted',
        parse: (v) => BlockCurrencyCollection.fromJson(v),
      ),
      recovered: json.valueTo<BlockCurrencyCollection, Map<String, dynamic>>(
        key: 'recovered',
        parse: (v) => BlockCurrencyCollection.fromJson(v),
      ),
      toNextBlk: json.valueTo<BlockCurrencyCollection, Map<String, dynamic>>(
        key: 'to_next_blk',
        parse: (v) => BlockCurrencyCollection.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'burned': burned?.toJson(config: config),
    'created': created.toJson(config: config),
    'exported': exported.toJson(config: config),
    'fees_collected': feesCollected.toJson(config: config),
    'fees_imported': feesImported.toJson(config: config),
    'from_prev_blk': fromPrevBlk.toJson(config: config),
    'imported': imported.toJson(config: config),
    'minted': minted.toJson(config: config),
    'recovered': recovered.toJson(config: config),
    'to_next_blk': toNextBlk.toJson(config: config),
  });
}

/// GET /v2/blockchain/accounts/{account_id}/inspect (response)
class BlockchainAccountInspect {
  final String code;
  final String codeHash;
  final BlockchainAccountInspectCompiler compiler;
  final String? disassembledCode;
  final List<Method> methods;
  final Source? source;

  const BlockchainAccountInspect({
    required this.code,
    required this.codeHash,
    required this.compiler,
    this.disassembledCode,
    required this.methods,
    this.source,
  });

  factory BlockchainAccountInspect.fromJson(Map<String, dynamic> json) {
    return BlockchainAccountInspect(
      code:
          (json['code'] is num
              ? json['code'].toString()
              : json.valueAsString<String>('code')),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String>('code_hash')),
      compiler: json.valueTo<BlockchainAccountInspectCompiler, Object>(
        key: 'compiler',
        parse:
            (e) => BlockchainAccountInspectCompiler.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      disassembledCode:
          (json['disassembled_code'] is num
              ? json['disassembled_code'].toString()
              : json.valueAsString<String?>('disassembled_code')),
      methods:
          json
              .valueEnsureAsList<Map<String, dynamic>>('methods')
              .map((e) => Method.fromJson(e))
              .toList(),
      source: json.valueTo<Source?, Map<String, dynamic>>(
        key: 'source',
        parse: (v) => Source.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'code': code,
    'code_hash': codeHash,
    'compiler': compiler.toJson(config: config),
    'disassembled_code': disassembledCode,
    'methods': methods.map((e) => e.toJson(config: config)).toList(),
    'source': source?.toJson(config: config),
  });
}

/// GET /v2/blockchain/blocks/{block_id} (response)
/// GET /v2/blockchain/masterchain-head (response)
class BlockchainBlock {
  final bool afterMerge;
  final bool afterSplit;
  final bool beforeSplit;
  final String createdBy;
  final BigInt endLt;
  final String fileHash;
  final int genCatchainSeqno;
  final BigInt? genSoftwareCapabilities;
  final int? genSoftwareVersion;
  final BigInt genUtime;
  final int globalId;
  final BigInt inMsgDescrLength;
  final bool keyBlock;
  final String? masterRef;
  final int minRefMcSeqno;
  final BigInt outMsgDescrLength;
  final int prevKeyBlockSeqno;
  final List<String> prevRefs;
  final String randSeed;
  final String rootHash;
  final int seqno;
  final String shard;
  final BigInt startLt;
  final int txQuantity;
  final BlockValueFlow valueFlow;
  final int version;
  final int vertSeqno;
  final bool wantMerge;
  final bool wantSplit;
  final int workchainId;

  const BlockchainBlock({
    required this.afterMerge,
    required this.afterSplit,
    required this.beforeSplit,
    required this.createdBy,
    required this.endLt,
    required this.fileHash,
    required this.genCatchainSeqno,
    this.genSoftwareCapabilities,
    this.genSoftwareVersion,
    required this.genUtime,
    required this.globalId,
    required this.inMsgDescrLength,
    required this.keyBlock,
    this.masterRef,
    required this.minRefMcSeqno,
    required this.outMsgDescrLength,
    required this.prevKeyBlockSeqno,
    required this.prevRefs,
    required this.randSeed,
    required this.rootHash,
    required this.seqno,
    required this.shard,
    required this.startLt,
    required this.txQuantity,
    required this.valueFlow,
    required this.version,
    required this.vertSeqno,
    required this.wantMerge,
    required this.wantSplit,
    required this.workchainId,
  });

  factory BlockchainBlock.fromJson(Map<String, dynamic> json) {
    return BlockchainBlock(
      afterMerge: json.valueAsBool<bool>('after_merge'),
      afterSplit: json.valueAsBool<bool>('after_split'),
      beforeSplit: json.valueAsBool<bool>('before_split'),
      createdBy:
          (json['created_by'] is num
              ? json['created_by'].toString()
              : json.valueAsString<String>('created_by')),
      endLt: json.valueAsBigInt<BigInt>('end_lt'),
      fileHash:
          (json['file_hash'] is num
              ? json['file_hash'].toString()
              : json.valueAsString<String>('file_hash')),
      genCatchainSeqno: json.valueAsInt<int>('gen_catchain_seqno'),
      genSoftwareCapabilities: json.valueAsBigInt<BigInt?>(
        'gen_software_capabilities',
      ),
      genSoftwareVersion: json.valueAsInt<int?>('gen_software_version'),
      genUtime: json.valueAsBigInt<BigInt>('gen_utime'),
      globalId: json.valueAsInt<int>('global_id'),
      inMsgDescrLength: json.valueAsBigInt<BigInt>('in_msg_descr_length'),
      keyBlock: json.valueAsBool<bool>('key_block'),
      masterRef:
          (json['master_ref'] is num
              ? json['master_ref'].toString()
              : json.valueAsString<String?>('master_ref')),
      minRefMcSeqno: json.valueAsInt<int>('min_ref_mc_seqno'),
      outMsgDescrLength: json.valueAsBigInt<BigInt>('out_msg_descr_length'),
      prevKeyBlockSeqno: json.valueAsInt<int>('prev_key_block_seqno'),
      prevRefs: json.valueAsList<List<String>>('prev_refs'),
      randSeed:
          (json['rand_seed'] is num
              ? json['rand_seed'].toString()
              : json.valueAsString<String>('rand_seed')),
      rootHash:
          (json['root_hash'] is num
              ? json['root_hash'].toString()
              : json.valueAsString<String>('root_hash')),
      seqno: json.valueAsInt<int>('seqno'),
      shard:
          (json['shard'] is num
              ? json['shard'].toString()
              : json.valueAsString<String>('shard')),
      startLt: json.valueAsBigInt<BigInt>('start_lt'),
      txQuantity: json.valueAsInt<int>('tx_quantity'),
      valueFlow: json.valueTo<BlockValueFlow, Map<String, dynamic>>(
        key: 'value_flow',
        parse: (v) => BlockValueFlow.fromJson(v),
      ),
      version: json.valueAsInt<int>('version'),
      vertSeqno: json.valueAsInt<int>('vert_seqno'),
      wantMerge: json.valueAsBool<bool>('want_merge'),
      wantSplit: json.valueAsBool<bool>('want_split'),
      workchainId: json.valueAsInt<int>('workchain_id'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'after_merge': afterMerge,
    'after_split': afterSplit,
    'before_split': beforeSplit,
    'created_by': createdBy,
    'end_lt': config.encodeBigint(endLt),
    'file_hash': fileHash,
    'gen_catchain_seqno': genCatchainSeqno,
    'gen_software_capabilities': config.encodeBigint(genSoftwareCapabilities),
    'gen_software_version': genSoftwareVersion,
    'gen_utime': config.encodeBigint(genUtime),
    'global_id': globalId,
    'in_msg_descr_length': config.encodeBigint(inMsgDescrLength),
    'key_block': keyBlock,
    'master_ref': masterRef,
    'min_ref_mc_seqno': minRefMcSeqno,
    'out_msg_descr_length': config.encodeBigint(outMsgDescrLength),
    'prev_key_block_seqno': prevKeyBlockSeqno,
    'prev_refs': prevRefs,
    'rand_seed': randSeed,
    'root_hash': rootHash,
    'seqno': seqno,
    'shard': shard,
    'start_lt': config.encodeBigint(startLt),
    'tx_quantity': txQuantity,
    'value_flow': valueFlow.toJson(config: config),
    'version': version,
    'vert_seqno': vertSeqno,
    'want_merge': wantMerge,
    'want_split': wantSplit,
    'workchain_id': workchainId,
  });
}

/// GET /v2/blockchain/masterchain/{masterchain_seqno}/shards (response)
class BlockchainBlockShards {
  final List<BlockchainBlockShardsShardsItem> shards;

  const BlockchainBlockShards({required this.shards});

  factory BlockchainBlockShards.fromJson(Map<String, dynamic> json) {
    return BlockchainBlockShards(
      shards:
          json
              .valueEnsureAsList<Map<String, dynamic>>('shards')
              .map((e) => BlockchainBlockShardsShardsItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'shards': shards.map((e) => e.toJson(config: config)).toList(),
  });
}

/// GET /v2/blockchain/masterchain/{masterchain_seqno}/blocks (response)
class BlockchainBlocks {
  final List<BlockchainBlock> blocks;

  const BlockchainBlocks({required this.blocks});

  factory BlockchainBlocks.fromJson(Map<String, dynamic> json) {
    return BlockchainBlocks(
      blocks:
          json
              .valueEnsureAsList<Map<String, dynamic>>('blocks')
              .map((e) => BlockchainBlock.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'blocks': blocks.map((e) => e.toJson(config: config)).toList(),
  });
}

/// GET /v2/blockchain/config (response)
/// GET /v2/blockchain/masterchain/{masterchain_seqno}/config (response)
class BlockchainConfig {
  /// config address
  final String n0;

  /// elector address
  final String n1;

  /// List of critical TON parameters, the change of which significantly affects the network, so more voting rounds are held.
  final BlockchainConfign10? n10;

  /// This parameter indicates under what conditions proposals to change the TON configuration are accepted.
  final BlockchainConfign11? n11;

  /// Workchains in the TON Blockchain
  final BlockchainConfign12? n12;

  /// The cost of filing complaints about incorrect operation of validators.
  final BlockchainConfign13? n13;

  /// The reward in nanoGram for block creation in the TON blockchain.
  final BlockchainConfign14? n14;

  /// The reward in nanograms for block creation in the TON blockchain.
  final BlockchainConfign15? n15;

  /// The limits on the number of validators in the TON blockchain.
  final BlockchainConfign16? n16;

  /// The stake parameters configuration in the TON blockchain.
  final BlockchainConfign17? n17;

  /// The prices for data storage.
  final BlockchainConfign18? n18;

  /// minter address
  final String n2;

  /// The cost of computations in the masterchain. The complexity of any computation is estimated in gas units.
  final BlockchainConfign20? n20;

  /// The cost of computations in the basechains. The complexity of any computation is estimated in gas units.
  final BlockchainConfign20? n21;

  /// The limits on the block in the masterchain, upon reaching which the block is finalized and the callback of the remaining messages (if any) is carried over to the next block.
  final BlockchainConfign22? n22;

  /// The limits on the block in the basechains, upon reaching which the block is finalized and the callback of the remaining messages (if any) is carried over to the next block.
  final BlockchainConfign22? n23;

  /// The cost of sending messages in the masterchain of the TON blockchain.
  final BlockchainConfign24? n24;

  /// The cost of sending messages in the basechains of the TON blockchain.
  final BlockchainConfign24? n25;

  /// The configuration for the Catchain protocol.
  final BlockchainConfign28? n28;

  /// The configuration for the consensus protocol above catchain.
  final BlockchainConfign29? n29;

  /// The address of the transaction fee collector.
  final String? n3;

  /// The configuration for the new consensus protocol. Each chain can have its own optional configuration.
  final BlockchainConfign30? n30;

  /// The configuration for the consensus protocol above catchain.
  final BlockchainConfign31? n31;
  final ValidatorsSet? n32;
  final ValidatorsSet? n33;
  final ValidatorsSet? n34;
  final ValidatorsSet? n35;
  final ValidatorsSet? n36;
  final ValidatorsSet? n37;

  /// dns root address
  final String n4;

  /// The configuration for punishment for improper behavior (non-validation). In the absence of the parameter, the default fine size is 101 Gram
  final BlockchainConfign40? n40;

  /// The size limits and some other characteristics of accounts and messages.
  final BlockchainConfign43? n43;

  /// suspended accounts
  final BlockchainConfign44 n44;

  /// precompiled contracts
  final BlockchainConfign45? n45;
  final BlockchainConfign5? n5;

  /// Minting fees of new currencies.
  final BlockchainConfign6? n6;

  /// The volume of each of the additional currencies in circulation.
  final BlockchainConfign7? n7;

  /// Bridge parameters for wrapping TON in other networks.
  final BlockchainConfign71? n71;

  /// Bridge parameters for wrapping TON in other networks.
  final BlockchainConfign71? n72;

  /// Bridge parameters for wrapping TON in other networks.
  final BlockchainConfign71? n73;

  /// Bridge parameters for wrapping tokens from other networks into tokens on the TON network.
  final BlockchainConfign79? n79;

  /// The network version and additional capabilities supported by the validators.
  final BlockchainConfign8? n8;

  /// Bridge parameters for wrapping tokens from other networks into tokens on the TON network.
  final BlockchainConfign79? n81;

  /// Bridge parameters for wrapping tokens from other networks into tokens on the TON network.
  final BlockchainConfign79? n82;

  /// List of mandatory parameters of the blockchain config.
  final BlockchainConfign9? n9;

  /// config boc in hex format
  final String raw;

  const BlockchainConfig({
    required this.n0,
    required this.n1,
    this.n10,
    this.n11,
    this.n12,
    this.n13,
    this.n14,
    this.n15,
    this.n16,
    this.n17,
    this.n18,
    required this.n2,
    this.n20,
    this.n21,
    this.n22,
    this.n23,
    this.n24,
    this.n25,
    this.n28,
    this.n29,
    this.n3,
    this.n30,
    this.n31,
    this.n32,
    this.n33,
    this.n34,
    this.n35,
    this.n36,
    this.n37,
    required this.n4,
    this.n40,
    this.n43,
    required this.n44,
    this.n45,
    this.n5,
    this.n6,
    this.n7,
    this.n71,
    this.n72,
    this.n73,
    this.n79,
    this.n8,
    this.n81,
    this.n82,
    this.n9,
    required this.raw,
  });

  factory BlockchainConfig.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig(
      n0:
          (json['0'] is num
              ? json['0'].toString()
              : json.valueAsString<String>('0')),
      n1:
          (json['1'] is num
              ? json['1'].toString()
              : json.valueAsString<String>('1')),
      n10: json.valueTo<BlockchainConfign10?, Map<String, dynamic>>(
        key: '10',
        parse: (v) => BlockchainConfign10.fromJson(v),
      ),
      n11: json.valueTo<BlockchainConfign11?, Map<String, dynamic>>(
        key: '11',
        parse: (v) => BlockchainConfign11.fromJson(v),
      ),
      n12: json.valueTo<BlockchainConfign12?, Map<String, dynamic>>(
        key: '12',
        parse: (v) => BlockchainConfign12.fromJson(v),
      ),
      n13: json.valueTo<BlockchainConfign13?, Map<String, dynamic>>(
        key: '13',
        parse: (v) => BlockchainConfign13.fromJson(v),
      ),
      n14: json.valueTo<BlockchainConfign14?, Map<String, dynamic>>(
        key: '14',
        parse: (v) => BlockchainConfign14.fromJson(v),
      ),
      n15: json.valueTo<BlockchainConfign15?, Map<String, dynamic>>(
        key: '15',
        parse: (v) => BlockchainConfign15.fromJson(v),
      ),
      n16: json.valueTo<BlockchainConfign16?, Map<String, dynamic>>(
        key: '16',
        parse: (v) => BlockchainConfign16.fromJson(v),
      ),
      n17: json.valueTo<BlockchainConfign17?, Map<String, dynamic>>(
        key: '17',
        parse: (v) => BlockchainConfign17.fromJson(v),
      ),
      n18: json.valueTo<BlockchainConfign18?, Map<String, dynamic>>(
        key: '18',
        parse: (v) => BlockchainConfign18.fromJson(v),
      ),
      n2:
          (json['2'] is num
              ? json['2'].toString()
              : json.valueAsString<String>('2')),
      n20: json.valueTo<BlockchainConfign20?, Map<String, dynamic>>(
        key: '20',
        parse: (v) => BlockchainConfign20.fromJson(v),
      ),
      n21: json.valueTo<BlockchainConfign20?, Map<String, dynamic>>(
        key: '21',
        parse: (v) => BlockchainConfign20.fromJson(v),
      ),
      n22: json.valueTo<BlockchainConfign22?, Map<String, dynamic>>(
        key: '22',
        parse: (v) => BlockchainConfign22.fromJson(v),
      ),
      n23: json.valueTo<BlockchainConfign22?, Map<String, dynamic>>(
        key: '23',
        parse: (v) => BlockchainConfign22.fromJson(v),
      ),
      n24: json.valueTo<BlockchainConfign24?, Map<String, dynamic>>(
        key: '24',
        parse: (v) => BlockchainConfign24.fromJson(v),
      ),
      n25: json.valueTo<BlockchainConfign24?, Map<String, dynamic>>(
        key: '25',
        parse: (v) => BlockchainConfign24.fromJson(v),
      ),
      n28: json.valueTo<BlockchainConfign28?, Map<String, dynamic>>(
        key: '28',
        parse: (v) => BlockchainConfign28.fromJson(v),
      ),
      n29: json.valueTo<BlockchainConfign29?, Map<String, dynamic>>(
        key: '29',
        parse: (v) => BlockchainConfign29.fromJson(v),
      ),
      n3:
          (json['3'] is num
              ? json['3'].toString()
              : json.valueAsString<String?>('3')),
      n30: json.valueTo<BlockchainConfign30?, Map<String, dynamic>>(
        key: '30',
        parse: (v) => BlockchainConfign30.fromJson(v),
      ),
      n31: json.valueTo<BlockchainConfign31?, Map<String, dynamic>>(
        key: '31',
        parse: (v) => BlockchainConfign31.fromJson(v),
      ),
      n32: json.valueTo<ValidatorsSet?, Map<String, dynamic>>(
        key: '32',
        parse: (v) => ValidatorsSet.fromJson(v),
      ),
      n33: json.valueTo<ValidatorsSet?, Map<String, dynamic>>(
        key: '33',
        parse: (v) => ValidatorsSet.fromJson(v),
      ),
      n34: json.valueTo<ValidatorsSet?, Map<String, dynamic>>(
        key: '34',
        parse: (v) => ValidatorsSet.fromJson(v),
      ),
      n35: json.valueTo<ValidatorsSet?, Map<String, dynamic>>(
        key: '35',
        parse: (v) => ValidatorsSet.fromJson(v),
      ),
      n36: json.valueTo<ValidatorsSet?, Map<String, dynamic>>(
        key: '36',
        parse: (v) => ValidatorsSet.fromJson(v),
      ),
      n37: json.valueTo<ValidatorsSet?, Map<String, dynamic>>(
        key: '37',
        parse: (v) => ValidatorsSet.fromJson(v),
      ),
      n4:
          (json['4'] is num
              ? json['4'].toString()
              : json.valueAsString<String>('4')),
      n40: json.valueTo<BlockchainConfign40?, Map<String, dynamic>>(
        key: '40',
        parse: (v) => BlockchainConfign40.fromJson(v),
      ),
      n43: json.valueTo<BlockchainConfign43?, Map<String, dynamic>>(
        key: '43',
        parse: (v) => BlockchainConfign43.fromJson(v),
      ),
      n44: json.valueTo<BlockchainConfign44, Map<String, dynamic>>(
        key: '44',
        parse: (v) => BlockchainConfign44.fromJson(v),
      ),
      n45: json.valueTo<BlockchainConfign45?, Map<String, dynamic>>(
        key: '45',
        parse: (v) => BlockchainConfign45.fromJson(v),
      ),
      n5: json.valueTo<BlockchainConfign5?, Map<String, dynamic>>(
        key: '5',
        parse: (v) => BlockchainConfign5.fromJson(v),
      ),
      n6: json.valueTo<BlockchainConfign6?, Map<String, dynamic>>(
        key: '6',
        parse: (v) => BlockchainConfign6.fromJson(v),
      ),
      n7: json.valueTo<BlockchainConfign7?, Map<String, dynamic>>(
        key: '7',
        parse: (v) => BlockchainConfign7.fromJson(v),
      ),
      n71: json.valueTo<BlockchainConfign71?, Map<String, dynamic>>(
        key: '71',
        parse: (v) => BlockchainConfign71.fromJson(v),
      ),
      n72: json.valueTo<BlockchainConfign71?, Map<String, dynamic>>(
        key: '72',
        parse: (v) => BlockchainConfign71.fromJson(v),
      ),
      n73: json.valueTo<BlockchainConfign71?, Map<String, dynamic>>(
        key: '73',
        parse: (v) => BlockchainConfign71.fromJson(v),
      ),
      n79: json.valueTo<BlockchainConfign79?, Map<String, dynamic>>(
        key: '79',
        parse: (v) => BlockchainConfign79.fromJson(v),
      ),
      n8: json.valueTo<BlockchainConfign8?, Map<String, dynamic>>(
        key: '8',
        parse: (v) => BlockchainConfign8.fromJson(v),
      ),
      n81: json.valueTo<BlockchainConfign79?, Map<String, dynamic>>(
        key: '81',
        parse: (v) => BlockchainConfign79.fromJson(v),
      ),
      n82: json.valueTo<BlockchainConfign79?, Map<String, dynamic>>(
        key: '82',
        parse: (v) => BlockchainConfign79.fromJson(v),
      ),
      n9: json.valueTo<BlockchainConfign9?, Map<String, dynamic>>(
        key: '9',
        parse: (v) => BlockchainConfign9.fromJson(v),
      ),
      raw:
          (json['raw'] is num
              ? json['raw'].toString()
              : json.valueAsString<String>('raw')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '0': n0,
    '1': n1,
    '10': n10?.toJson(config: config),
    '11': n11?.toJson(config: config),
    '12': n12?.toJson(config: config),
    '13': n13?.toJson(config: config),
    '14': n14?.toJson(config: config),
    '15': n15?.toJson(config: config),
    '16': n16?.toJson(config: config),
    '17': n17?.toJson(config: config),
    '18': n18?.toJson(config: config),
    '2': n2,
    '20': n20?.toJson(config: config),
    '21': n21?.toJson(config: config),
    '22': n22?.toJson(config: config),
    '23': n23?.toJson(config: config),
    '24': n24?.toJson(config: config),
    '25': n25?.toJson(config: config),
    '28': n28?.toJson(config: config),
    '29': n29?.toJson(config: config),
    '3': n3,
    '30': n30?.toJson(config: config),
    '31': n31?.toJson(config: config),
    '32': n32?.toJson(config: config),
    '33': n33?.toJson(config: config),
    '34': n34?.toJson(config: config),
    '35': n35?.toJson(config: config),
    '36': n36?.toJson(config: config),
    '37': n37?.toJson(config: config),
    '4': n4,
    '40': n40?.toJson(config: config),
    '43': n43?.toJson(config: config),
    '44': n44.toJson(config: config),
    '45': n45?.toJson(config: config),
    '5': n5?.toJson(config: config),
    '6': n6?.toJson(config: config),
    '7': n7?.toJson(config: config),
    '71': n71?.toJson(config: config),
    '72': n72?.toJson(config: config),
    '73': n73?.toJson(config: config),
    '79': n79?.toJson(config: config),
    '8': n8?.toJson(config: config),
    '81': n81?.toJson(config: config),
    '82': n82?.toJson(config: config),
    '9': n9?.toJson(config: config),
    'raw': raw,
  });
}

/// GET /v2/blockchain/libraries/{hash} (response)
class BlockchainLibrary {
  final String boc;

  const BlockchainLibrary({required this.boc});

  factory BlockchainLibrary.fromJson(Map<String, dynamic> json) {
    return BlockchainLibrary(
      boc:
          (json['boc'] is num
              ? json['boc'].toString()
              : json.valueAsString<String>('boc')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'boc': boc});
}

/// GET /v2/blockchain/accounts/{account_id} (response)
class BlockchainRawAccount {
  final String address;
  final BigInt balance;
  final String? code;
  final String? data;
  final List<ExtraCurrency>? extraBalance;
  final String? frozenHash;
  final String? lastTransactionHash;
  final BigInt lastTransactionLt;
  final List<BlockchainRawAccountLibrariesItem>? libraries;
  final AccountStatus status;
  final AccountStorageInfo storage;

  const BlockchainRawAccount({
    required this.address,
    required this.balance,
    this.code,
    this.data,
    this.extraBalance,
    this.frozenHash,
    this.lastTransactionHash,
    required this.lastTransactionLt,
    this.libraries,
    required this.status,
    required this.storage,
  });

  factory BlockchainRawAccount.fromJson(Map<String, dynamic> json) {
    return BlockchainRawAccount(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      balance: json.valueAsBigInt<BigInt>('balance'),
      code:
          (json['code'] is num
              ? json['code'].toString()
              : json.valueAsString<String?>('code')),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString<String?>('data')),
      extraBalance:
          json.hasValue('extra_balance')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('extra_balance')
                  .map((e) => ExtraCurrency.fromJson(e))
                  .toList()
              : null,
      frozenHash:
          (json['frozen_hash'] is num
              ? json['frozen_hash'].toString()
              : json.valueAsString<String?>('frozen_hash')),
      lastTransactionHash:
          (json['last_transaction_hash'] is num
              ? json['last_transaction_hash'].toString()
              : json.valueAsString<String?>('last_transaction_hash')),
      lastTransactionLt: json.valueAsBigInt<BigInt>('last_transaction_lt'),
      libraries:
          json.hasValue('libraries')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('libraries')
                  .map((e) => BlockchainRawAccountLibrariesItem.fromJson(e))
                  .toList()
              : null,
      status: json.valueTo<AccountStatus, Object>(
        key: 'status',
        parse: (e) => AccountStatus.fromJson(JsonParser.valueAs(e)),
      ),
      storage: json.valueTo<AccountStorageInfo, Map<String, dynamic>>(
        key: 'storage',
        parse: (v) => AccountStorageInfo.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'balance': config.encodeBigint(balance),
    'code': code,
    'data': data,
    'extra_balance':
        extraBalance?.map((e) => e.toJson(config: config)).toList(),
    'frozen_hash': frozenHash,
    'last_transaction_hash': lastTransactionHash,
    'last_transaction_lt': config.encodeBigint(lastTransactionLt),
    'libraries': libraries?.map((e) => e.toJson(config: config)).toList(),
    'status': status.toJson(config: config),
    'storage': storage.toJson(config: config),
  });
}

/// POST /v2/blockchain/accounts/_bulk (response)
class BlockchainRawAccounts {
  final List<BlockchainRawAccount> accounts;

  const BlockchainRawAccounts({required this.accounts});

  factory BlockchainRawAccounts.fromJson(Map<String, dynamic> json) {
    return BlockchainRawAccounts(
      accounts:
          json
              .valueEnsureAsList<Map<String, dynamic>>('accounts')
              .map((e) => BlockchainRawAccount.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'accounts': accounts.map((e) => e.toJson(config: config)).toList(),
  });
}

class BuyXTRAction {
  final String amount;
  final AccountAddress recipient;

  const BuyXTRAction({required this.amount, required this.recipient});

  factory BuyXTRAction.fromJson(Map<String, dynamic> json) {
    return BuyXTRAction(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      recipient: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'recipient',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'recipient': recipient.toJson(config: config),
  });
}

class ComputePhase {
  final int? exitCode;
  final String? exitCodeDescription;
  final BigInt? gasFees;
  final BigInt? gasUsed;
  final ComputeSkipReason? skipReason;
  final bool skipped;
  final bool? success;
  final int? vmSteps;

  const ComputePhase({
    this.exitCode,
    this.exitCodeDescription,
    this.gasFees,
    this.gasUsed,
    this.skipReason,
    required this.skipped,
    this.success,
    this.vmSteps,
  });

  factory ComputePhase.fromJson(Map<String, dynamic> json) {
    return ComputePhase(
      exitCode: json.valueAsInt<int?>('exit_code'),
      exitCodeDescription:
          (json['exit_code_description'] is num
              ? json['exit_code_description'].toString()
              : json.valueAsString<String?>('exit_code_description')),
      gasFees: json.valueAsBigInt<BigInt?>('gas_fees'),
      gasUsed: json.valueAsBigInt<BigInt?>('gas_used'),
      skipReason: json.valueTo<ComputeSkipReason?, Object>(
        key: 'skip_reason',
        parse: (e) => ComputeSkipReason.fromJson(JsonParser.valueAs(e)),
      ),
      skipped: json.valueAsBool<bool>('skipped'),
      success: json.valueAsBool<bool?>('success'),
      vmSteps: json.valueAsInt<int?>('vm_steps'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'exit_code': exitCode,
    'exit_code_description': exitCodeDescription,
    'gas_fees': config.encodeBigint(gasFees),
    'gas_used': config.encodeBigint(gasUsed),
    'skip_reason': skipReason?.toJson(config: config),
    'skipped': skipped,
    'success': success,
    'vm_steps': vmSteps,
  });
}

class ConfigProposalSetup {
  final BigInt bitPrice;
  final BigInt cellPrice;
  final int maxLosses;
  final BigInt maxStoreSec;
  final int maxTotRounds;
  final BigInt minStoreSec;
  final int minTotRounds;
  final int minWins;

  const ConfigProposalSetup({
    required this.bitPrice,
    required this.cellPrice,
    required this.maxLosses,
    required this.maxStoreSec,
    required this.maxTotRounds,
    required this.minStoreSec,
    required this.minTotRounds,
    required this.minWins,
  });

  factory ConfigProposalSetup.fromJson(Map<String, dynamic> json) {
    return ConfigProposalSetup(
      bitPrice: json.valueAsBigInt<BigInt>('bit_price'),
      cellPrice: json.valueAsBigInt<BigInt>('cell_price'),
      maxLosses: json.valueAsInt<int>('max_losses'),
      maxStoreSec: json.valueAsBigInt<BigInt>('max_store_sec'),
      maxTotRounds: json.valueAsInt<int>('max_tot_rounds'),
      minStoreSec: json.valueAsBigInt<BigInt>('min_store_sec'),
      minTotRounds: json.valueAsInt<int>('min_tot_rounds'),
      minWins: json.valueAsInt<int>('min_wins'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bit_price': config.encodeBigint(bitPrice),
    'cell_price': config.encodeBigint(cellPrice),
    'max_losses': maxLosses,
    'max_store_sec': config.encodeBigint(maxStoreSec),
    'max_tot_rounds': maxTotRounds,
    'min_store_sec': config.encodeBigint(minStoreSec),
    'min_tot_rounds': minTotRounds,
    'min_wins': minWins,
  });
}

class ContractDeployAction {
  final String address;
  final List<String> interfaces;

  const ContractDeployAction({required this.address, required this.interfaces});

  factory ContractDeployAction.fromJson(Map<String, dynamic> json) {
    return ContractDeployAction(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      interfaces: json.valueAsList<List<String>>('interfaces'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'interfaces': interfaces,
  });
}

class CreditPhase {
  final BigInt credit;
  final BigInt feesCollected;

  const CreditPhase({required this.credit, required this.feesCollected});

  factory CreditPhase.fromJson(Map<String, dynamic> json) {
    return CreditPhase(
      credit: json.valueAsBigInt<BigInt>('credit'),
      feesCollected: json.valueAsBigInt<BigInt>('fees_collected'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'credit': config.encodeBigint(credit),
    'fees_collected': config.encodeBigint(feesCollected),
  });
}

/// POST /v2/message/decode (response)
class DecodedMessage {
  final AccountAddress destination;
  final String destinationWalletVersion;
  final DecodedMessageExtInMsgDecoded? extInMsgDecoded;

  const DecodedMessage({
    required this.destination,
    required this.destinationWalletVersion,
    this.extInMsgDecoded,
  });

  factory DecodedMessage.fromJson(Map<String, dynamic> json) {
    return DecodedMessage(
      destination: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'destination',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      destinationWalletVersion:
          (json['destination_wallet_version'] is num
              ? json['destination_wallet_version'].toString()
              : json.valueAsString<String>('destination_wallet_version')),
      extInMsgDecoded: json
          .valueTo<DecodedMessageExtInMsgDecoded?, Map<String, dynamic>>(
            key: 'ext_in_msg_decoded',
            parse: (v) => DecodedMessageExtInMsgDecoded.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'destination': destination.toJson(config: config),
    'destination_wallet_version': destinationWalletVersion,
    'ext_in_msg_decoded': extInMsgDecoded?.toJson(config: config),
  });
}

class DecodedRawMessage {
  final DecodedRawMessageMessage message;
  final int mode;

  const DecodedRawMessage({required this.message, required this.mode});

  factory DecodedRawMessage.fromJson(Map<String, dynamic> json) {
    return DecodedRawMessage(
      message: json.valueTo<DecodedRawMessageMessage, Map<String, dynamic>>(
        key: 'message',
        parse: (v) => DecodedRawMessageMessage.fromJson(v),
      ),
      mode: json.valueAsInt<int>('mode'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'message': message.toJson(config: config),
    'mode': mode,
  });
}

class DefiAsset {
  /// amount in minimal units of the locked asset
  final String amount;
  final String? assetAddress;
  final DefiProvider defiProvider;
  final DefiLockedAsset lockedAsset;
  final String? poolAddress;
  final DefiAssetType type;

  const DefiAsset({
    required this.amount,
    this.assetAddress,
    required this.defiProvider,
    required this.lockedAsset,
    this.poolAddress,
    required this.type,
  });

  factory DefiAsset.fromJson(Map<String, dynamic> json) {
    return DefiAsset(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      assetAddress:
          (json['asset_address'] is num
              ? json['asset_address'].toString()
              : json.valueAsString<String?>('asset_address')),
      defiProvider: json.valueTo<DefiProvider, Map<String, dynamic>>(
        key: 'defi_provider',
        parse: (v) => DefiProvider.fromJson(v),
      ),
      lockedAsset: json.valueTo<DefiLockedAsset, Map<String, dynamic>>(
        key: 'locked_asset',
        parse: (v) => DefiLockedAsset.fromJson(v),
      ),
      poolAddress:
          (json['pool_address'] is num
              ? json['pool_address'].toString()
              : json.valueAsString<String?>('pool_address')),
      type: json.valueTo<DefiAssetType, Object>(
        key: 'type',
        parse: (e) => DefiAssetType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'asset_address': assetAddress,
    'defi_provider': defiProvider.toJson(config: config),
    'locked_asset': lockedAsset.toJson(config: config),
    'pool_address': poolAddress,
    'type': type.toJson(config: config),
  });
}

/// GET /v2/accounts/{account_id}/defi/assets (response)
class DefiAssets {
  final List<DefiAsset> assets;

  const DefiAssets({required this.assets});

  factory DefiAssets.fromJson(Map<String, dynamic> json) {
    return DefiAssets(
      assets:
          json
              .valueEnsureAsList<Map<String, dynamic>>('assets')
              .map((e) => DefiAsset.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'assets': assets.map((e) => e.toJson(config: config)).toList(),
  });
}

class DefiLiquidPoolAssets {
  final DefiLockedAsset asset0;
  final DefiLockedAsset asset1;

  const DefiLiquidPoolAssets({required this.asset0, required this.asset1});

  factory DefiLiquidPoolAssets.fromJson(Map<String, dynamic> json) {
    return DefiLiquidPoolAssets(
      asset0: json.valueTo<DefiLockedAsset, Map<String, dynamic>>(
        key: 'asset0',
        parse: (v) => DefiLockedAsset.fromJson(v),
      ),
      asset1: json.valueTo<DefiLockedAsset, Map<String, dynamic>>(
        key: 'asset1',
        parse: (v) => DefiLockedAsset.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'asset0': asset0.toJson(config: config),
    'asset1': asset1.toJson(config: config),
  });
}

class DefiLockedAsset {
  final JettonPreview? jetton;

  /// native Gram or jetton asset
  final DefiLockedAssetType type;

  const DefiLockedAsset({this.jetton, required this.type});

  factory DefiLockedAsset.fromJson(Map<String, dynamic> json) {
    return DefiLockedAsset(
      jetton: json.valueTo<JettonPreview?, Map<String, dynamic>>(
        key: 'jetton',
        parse: (v) => JettonPreview.fromJson(v),
      ),
      type: json.valueTo<DefiLockedAssetType, Object>(
        key: 'type',
        parse: (e) => DefiLockedAssetType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'jetton': jetton?.toJson(config: config),
    'type': type.toJson(config: config),
  });
}

class DefiProvider {
  final String card;
  final String description;
  final String full;
  final String icon;
  final String link;
  final String? miniappLink;
  final String name;
  final String tag;

  const DefiProvider({
    required this.card,
    required this.description,
    required this.full,
    required this.icon,
    required this.link,
    this.miniappLink,
    required this.name,
    required this.tag,
  });

  factory DefiProvider.fromJson(Map<String, dynamic> json) {
    return DefiProvider(
      card:
          (json['card'] is num
              ? json['card'].toString()
              : json.valueAsString<String>('card')),
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString<String>('description')),
      full:
          (json['full'] is num
              ? json['full'].toString()
              : json.valueAsString<String>('full')),
      icon:
          (json['icon'] is num
              ? json['icon'].toString()
              : json.valueAsString<String>('icon')),
      link:
          (json['link'] is num
              ? json['link'].toString()
              : json.valueAsString<String>('link')),
      miniappLink:
          (json['miniapp_link'] is num
              ? json['miniapp_link'].toString()
              : json.valueAsString<String?>('miniapp_link')),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String>('name')),
      tag:
          (json['tag'] is num
              ? json['tag'].toString()
              : json.valueAsString<String>('tag')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'card': card,
    'description': description,
    'full': full,
    'icon': icon,
    'link': link,
    'miniapp_link': miniappLink,
    'name': name,
    'tag': tag,
  });
}

/// validator's participation in elections
class DepositStakeAction {
  final BigInt amount;
  final PoolImplementationType implementation;
  final AccountAddress pool;

  /// If present, should be used instead of amount
  final Price? stakeMeta;
  final AccountAddress staker;

  const DepositStakeAction({
    required this.amount,
    required this.implementation,
    required this.pool,
    this.stakeMeta,
    required this.staker,
  });

  factory DepositStakeAction.fromJson(Map<String, dynamic> json) {
    return DepositStakeAction(
      amount: json.valueAsBigInt<BigInt>('amount'),
      implementation: json.valueTo<PoolImplementationType, Object>(
        key: 'implementation',
        parse: (e) => PoolImplementationType.fromJson(JsonParser.valueAs(e)),
      ),
      pool: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'pool',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      stakeMeta: json.valueTo<Price?, Map<String, dynamic>>(
        key: 'stake_meta',
        parse: (v) => Price.fromJson(v),
      ),
      staker: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'staker',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': config.encodeBigint(amount),
    'implementation': implementation.toJson(config: config),
    'pool': pool.toJson(config: config),
    'stake_meta': stakeMeta?.toJson(config: config),
    'staker': staker.toJson(config: config),
  });
}

class DepositTokenStakeAction {
  final Protocol protocol;
  final Price? stakeMeta;
  final AccountAddress staker;

  const DepositTokenStakeAction({
    required this.protocol,
    this.stakeMeta,
    required this.staker,
  });

  factory DepositTokenStakeAction.fromJson(Map<String, dynamic> json) {
    return DepositTokenStakeAction(
      protocol: json.valueTo<Protocol, Map<String, dynamic>>(
        key: 'protocol',
        parse: (v) => Protocol.fromJson(v),
      ),
      stakeMeta: json.valueTo<Price?, Map<String, dynamic>>(
        key: 'stake_meta',
        parse: (v) => Price.fromJson(v),
      ),
      staker: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'staker',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'protocol': protocol.toJson(config: config),
    'stake_meta': stakeMeta?.toJson(config: config),
    'staker': staker.toJson(config: config),
  });
}

class DepositXTRAction {
  final String amount;
  final AccountAddress recipient;

  const DepositXTRAction({required this.amount, required this.recipient});

  factory DepositXTRAction.fromJson(Map<String, dynamic> json) {
    return DepositXTRAction(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      recipient: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'recipient',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'recipient': recipient.toJson(config: config),
  });
}

/// GET /v2/accounts/{account_id}/dns/expiring (response)
class DnsExpiring {
  final List<DnsExpiringItemsItem> items;

  const DnsExpiring({required this.items});

  factory DnsExpiring.fromJson(Map<String, dynamic> json) {
    return DnsExpiring(
      items:
          json
              .valueEnsureAsList<Map<String, dynamic>>('items')
              .map((e) => DnsExpiringItemsItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'items': items.map((e) => e.toJson(config: config)).toList(),
  });
}

/// GET /v2/dns/{domain_name}/resolve (response)
class DnsRecord {
  final String? nextResolver;
  final PictureDNS? picture;
  final List<String> sites;

  /// tonstorage bag id
  final String? storage;
  final WalletDNS? wallet;

  const DnsRecord({
    this.nextResolver,
    this.picture,
    required this.sites,
    this.storage,
    this.wallet,
  });

  factory DnsRecord.fromJson(Map<String, dynamic> json) {
    return DnsRecord(
      nextResolver:
          (json['next_resolver'] is num
              ? json['next_resolver'].toString()
              : json.valueAsString<String?>('next_resolver')),
      picture: json.valueTo<PictureDNS?, Map<String, dynamic>>(
        key: 'picture',
        parse: (v) => PictureDNS.fromJson(v),
      ),
      sites: json.valueAsList<List<String>>('sites'),
      storage:
          (json['storage'] is num
              ? json['storage'].toString()
              : json.valueAsString<String?>('storage')),
      wallet: json.valueTo<WalletDNS?, Map<String, dynamic>>(
        key: 'wallet',
        parse: (v) => WalletDNS.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'next_resolver': nextResolver,
    'picture': picture?.toJson(config: config),
    'sites': sites,
    'storage': storage,
    'wallet': wallet?.toJson(config: config),
  });
}

class DomainBid {
  final AccountAddress bidder;
  final bool success;
  final String txHash;
  final BigInt txTime;
  final BigInt value;

  const DomainBid({
    required this.bidder,
    required this.success,
    required this.txHash,
    required this.txTime,
    required this.value,
  });

  factory DomainBid.fromJson(Map<String, dynamic> json) {
    return DomainBid(
      bidder: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'bidder',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      success: json.valueAsBool<bool>('success'),
      txHash:
          (json['txHash'] is num
              ? json['txHash'].toString()
              : json.valueAsString<String>('txHash')),
      txTime: json.valueAsBigInt<BigInt>('txTime'),
      value: json.valueAsBigInt<BigInt>('value'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bidder': bidder.toJson(config: config),
    'success': success,
    'txHash': txHash,
    'txTime': config.encodeBigint(txTime),
    'value': config.encodeBigint(value),
  });
}

/// GET /v2/dns/{domain_name}/bids (response)
class DomainBids {
  final List<DomainBid> data;

  const DomainBids({required this.data});

  factory DomainBids.fromJson(Map<String, dynamic> json) {
    return DomainBids(
      data:
          json
              .valueEnsureAsList<Map<String, dynamic>>('data')
              .map((e) => DomainBid.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'data': data.map((e) => e.toJson(config: config)).toList(),
  });
}

/// GET /v2/dns/{domain_name} (response)
class DomainInfo {
  /// date of expiring. optional. not all domain in ton has expiration date
  final BigInt? expiringAt;
  final NftItem? item;
  final String name;

  const DomainInfo({this.expiringAt, this.item, required this.name});

  factory DomainInfo.fromJson(Map<String, dynamic> json) {
    return DomainInfo(
      expiringAt: json.valueAsBigInt<BigInt?>('expiring_at'),
      item: json.valueTo<NftItem?, Map<String, dynamic>>(
        key: 'item',
        parse: (v) => NftItem.fromJson(v),
      ),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String>('name')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'expiring_at': config.encodeBigint(expiringAt),
    'item': item?.toJson(config: config),
    'name': name,
  });
}

/// GET /v2/accounts/{account_id}/dns/backresolve (response)
class DomainNames {
  final List<String> domains;

  const DomainNames({required this.domains});

  factory DomainNames.fromJson(Map<String, dynamic> json) {
    return DomainNames(domains: json.valueAsList<List<String>>('domains'));
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'domains': domains});
}

class DomainRenewAction {
  final String contractAddress;
  final String domain;
  final AccountAddress renewer;

  const DomainRenewAction({
    required this.contractAddress,
    required this.domain,
    required this.renewer,
  });

  factory DomainRenewAction.fromJson(Map<String, dynamic> json) {
    return DomainRenewAction(
      contractAddress:
          (json['contract_address'] is num
              ? json['contract_address'].toString()
              : json.valueAsString<String>('contract_address')),
      domain:
          (json['domain'] is num
              ? json['domain'].toString()
              : json.valueAsString<String>('domain')),
      renewer: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'renewer',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'contract_address': contractAddress,
    'domain': domain,
    'renewer': renewer.toJson(config: config),
  });
}

/// GET /v2/extra-currency/{id} (response)
class EcPreview {
  final int decimals;
  final int id;
  final String image;
  final String symbol;

  const EcPreview({
    required this.decimals,
    required this.id,
    required this.image,
    required this.symbol,
  });

  factory EcPreview.fromJson(Map<String, dynamic> json) {
    return EcPreview(
      decimals: json.valueAsInt<int>('decimals'),
      id: json.valueAsInt<int>('id'),
      image:
          (json['image'] is num
              ? json['image'].toString()
              : json.valueAsString<String>('image')),
      symbol:
          (json['symbol'] is num
              ? json['symbol'].toString()
              : json.valueAsString<String>('symbol')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'decimals': decimals,
    'id': id,
    'image': image,
    'symbol': symbol,
  });
}

class ElectionsDepositStakeAction {
  final BigInt amount;
  final AccountAddress staker;

  const ElectionsDepositStakeAction({
    required this.amount,
    required this.staker,
  });

  factory ElectionsDepositStakeAction.fromJson(Map<String, dynamic> json) {
    return ElectionsDepositStakeAction(
      amount: json.valueAsBigInt<BigInt>('amount'),
      staker: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'staker',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': config.encodeBigint(amount),
    'staker': staker.toJson(config: config),
  });
}

class ElectionsRecoverStakeAction {
  final BigInt amount;
  final AccountAddress staker;

  const ElectionsRecoverStakeAction({
    required this.amount,
    required this.staker,
  });

  factory ElectionsRecoverStakeAction.fromJson(Map<String, dynamic> json) {
    return ElectionsRecoverStakeAction(
      amount: json.valueAsBigInt<BigInt>('amount'),
      staker: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'staker',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': config.encodeBigint(amount),
    'staker': staker.toJson(config: config),
  });
}

class EncryptedComment {
  final String cipherText;
  final String encryptionType;

  const EncryptedComment({
    required this.cipherText,
    required this.encryptionType,
  });

  factory EncryptedComment.fromJson(Map<String, dynamic> json) {
    return EncryptedComment(
      cipherText:
          (json['cipher_text'] is num
              ? json['cipher_text'].toString()
              : json.valueAsString<String>('cipher_text')),
      encryptionType:
          (json['encryption_type'] is num
              ? json['encryption_type'].toString()
              : json.valueAsString<String>('encryption_type')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'cipher_text': cipherText,
    'encryption_type': encryptionType,
  });
}

class Error {
  final String error;

  const Error({required this.error});

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      error:
          (json['error'] is num
              ? json['error'].toString()
              : json.valueAsString<String>('error')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'error': error});
}

/// POST /v2/events/emulate (response)
/// GET /v2/events/{event_id} (response)
/// GET /v2/events/{event_id}/jettons (response)
class Event {
  final List<Action> actions;
  final String eventId;

  /// Normalized hash of the root external inbound message (hex).
  final String? extMsgHash;

  /// Event trace is not finished yet. Transactions still happening.
  final bool inProgress;

  /// scam
  final bool isScam;

  /// ID of the slice where this event was finalized. Null if not yet finalized.
  final BigInt? lastSliceId;
  final BigInt lt;
  final double progress;
  final BigInt timestamp;
  final List<ValueFlow> valueFlow;

  const Event({
    required this.actions,
    required this.eventId,
    this.extMsgHash,
    required this.inProgress,
    required this.isScam,
    this.lastSliceId,
    required this.lt,
    required this.progress,
    required this.timestamp,
    required this.valueFlow,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      actions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('actions')
              .map((e) => Action.fromJson(e))
              .toList(),
      eventId:
          (json['event_id'] is num
              ? json['event_id'].toString()
              : json.valueAsString<String>('event_id')),
      extMsgHash:
          (json['ext_msg_hash'] is num
              ? json['ext_msg_hash'].toString()
              : json.valueAsString<String?>('ext_msg_hash')),
      inProgress: json.valueAsBool<bool>('in_progress'),
      isScam: json.valueAsBool<bool>('is_scam'),
      lastSliceId: json.valueAsBigInt<BigInt?>('last_slice_id'),
      lt: json.valueAsBigInt<BigInt>('lt'),
      progress: json.valueAsDouble<double>('progress'),
      timestamp: json.valueAsBigInt<BigInt>('timestamp'),
      valueFlow:
          json
              .valueEnsureAsList<Map<String, dynamic>>('value_flow')
              .map((e) => ValueFlow.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'actions': actions.map((e) => e.toJson(config: config)).toList(),
    'event_id': eventId,
    'ext_msg_hash': extMsgHash,
    'in_progress': inProgress,
    'is_scam': isScam,
    'last_slice_id': config.encodeBigint(lastSliceId),
    'lt': config.encodeBigint(lt),
    'progress': progress,
    'timestamp': config.encodeBigint(timestamp),
    'value_flow': valueFlow.map((e) => e.toJson(config: config)).toList(),
  });
}

class ExecGetMethodArg {
  final ExecGetMethodArgType type;

  /// String representation of the value according to the specified type
  final String value;

  const ExecGetMethodArg({required this.type, required this.value});

  factory ExecGetMethodArg.fromJson(Map<String, dynamic> json) {
    return ExecGetMethodArg(
      type: json.valueTo<ExecGetMethodArgType, Object>(
        key: 'type',
        parse: (e) => ExecGetMethodArgType.fromJson(JsonParser.valueAs(e)),
      ),
      value:
          (json['value'] is num
              ? json['value'].toString()
              : json.valueAsString<String>('value')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'type': type.toJson(config: config),
    'value': value,
  });
}

class ExtraCurrencies {
  final List<EcPreview> extraCurrencies;

  const ExtraCurrencies({required this.extraCurrencies});

  factory ExtraCurrencies.fromJson(Map<String, dynamic> json) {
    return ExtraCurrencies(
      extraCurrencies:
          json
              .valueEnsureAsList<Map<String, dynamic>>('extra_currencies')
              .map((e) => EcPreview.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'extra_currencies':
        extraCurrencies.map((e) => e.toJson(config: config)).toList(),
  });
}

class ExtraCurrency {
  final String amount;
  final EcPreview preview;

  const ExtraCurrency({required this.amount, required this.preview});

  factory ExtraCurrency.fromJson(Map<String, dynamic> json) {
    return ExtraCurrency(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      preview: json.valueTo<EcPreview, Map<String, dynamic>>(
        key: 'preview',
        parse: (v) => EcPreview.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'preview': preview.toJson(config: config),
  });
}

class ExtraCurrencyTransferAction {
  /// amount in quanta of tokens
  final String amount;
  final String? comment;
  final EcPreview currency;
  final EncryptedComment? encryptedComment;
  final AccountAddress recipient;
  final AccountAddress sender;

  const ExtraCurrencyTransferAction({
    required this.amount,
    this.comment,
    required this.currency,
    this.encryptedComment,
    required this.recipient,
    required this.sender,
  });

  factory ExtraCurrencyTransferAction.fromJson(Map<String, dynamic> json) {
    return ExtraCurrencyTransferAction(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      comment:
          (json['comment'] is num
              ? json['comment'].toString()
              : json.valueAsString<String?>('comment')),
      currency: json.valueTo<EcPreview, Map<String, dynamic>>(
        key: 'currency',
        parse: (v) => EcPreview.fromJson(v),
      ),
      encryptedComment: json.valueTo<EncryptedComment?, Map<String, dynamic>>(
        key: 'encrypted_comment',
        parse: (v) => EncryptedComment.fromJson(v),
      ),
      recipient: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'recipient',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      sender: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'sender',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'comment': comment,
    'currency': currency.toJson(config: config),
    'encrypted_comment': encryptedComment?.toJson(config: config),
    'recipient': recipient.toJson(config: config),
    'sender': sender.toJson(config: config),
  });
}

class FlawedJettonTransferAction {
  final String? comment;
  final EncryptedComment? encryptedComment;
  final JettonPreview jetton;

  /// actually received amount in quanta of tokens
  final String receivedAmount;
  final AccountAddress? recipient;
  final String recipientsWallet;
  final Refund? refund;
  final AccountAddress? sender;
  final String sendersWallet;

  /// sent amount in quanta of tokens
  final String sentAmount;

  const FlawedJettonTransferAction({
    this.comment,
    this.encryptedComment,
    required this.jetton,
    required this.receivedAmount,
    this.recipient,
    required this.recipientsWallet,
    this.refund,
    this.sender,
    required this.sendersWallet,
    required this.sentAmount,
  });

  factory FlawedJettonTransferAction.fromJson(Map<String, dynamic> json) {
    return FlawedJettonTransferAction(
      comment:
          (json['comment'] is num
              ? json['comment'].toString()
              : json.valueAsString<String?>('comment')),
      encryptedComment: json.valueTo<EncryptedComment?, Map<String, dynamic>>(
        key: 'encrypted_comment',
        parse: (v) => EncryptedComment.fromJson(v),
      ),
      jetton: json.valueTo<JettonPreview, Map<String, dynamic>>(
        key: 'jetton',
        parse: (v) => JettonPreview.fromJson(v),
      ),
      receivedAmount:
          (json['received_amount'] is num
              ? json['received_amount'].toString()
              : json.valueAsString<String>('received_amount')),
      recipient: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'recipient',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      recipientsWallet:
          (json['recipients_wallet'] is num
              ? json['recipients_wallet'].toString()
              : json.valueAsString<String>('recipients_wallet')),
      refund: json.valueTo<Refund?, Map<String, dynamic>>(
        key: 'refund',
        parse: (v) => Refund.fromJson(v),
      ),
      sender: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'sender',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      sendersWallet:
          (json['senders_wallet'] is num
              ? json['senders_wallet'].toString()
              : json.valueAsString<String>('senders_wallet')),
      sentAmount:
          (json['sent_amount'] is num
              ? json['sent_amount'].toString()
              : json.valueAsString<String>('sent_amount')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'comment': comment,
    'encrypted_comment': encryptedComment?.toJson(config: config),
    'jetton': jetton.toJson(config: config),
    'received_amount': receivedAmount,
    'recipient': recipient?.toJson(config: config),
    'recipients_wallet': recipientsWallet,
    'refund': refund?.toJson(config: config),
    'sender': sender?.toJson(config: config),
    'senders_wallet': sendersWallet,
    'sent_amount': sentAmount,
  });
}

/// GET /v2/accounts/search (response)
class FoundAccounts {
  final List<FoundAccountsAddressesItem> addresses;

  const FoundAccounts({required this.addresses});

  factory FoundAccounts.fromJson(Map<String, dynamic> json) {
    return FoundAccounts(
      addresses:
          json
              .valueEnsureAsList<Map<String, dynamic>>('addresses')
              .map((e) => FoundAccountsAddressesItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'addresses': addresses.map((e) => e.toJson(config: config)).toList(),
  });
}

class GasLimitPrices {
  final BigInt blockGasLimit;
  final BigInt deleteDueLimit;
  final BigInt? flatGasLimit;
  final BigInt? flatGasPrice;
  final BigInt freezeDueLimit;
  final BigInt gasCredit;
  final BigInt gasLimit;
  final BigInt gasPrice;
  final BigInt? specialGasLimit;

  const GasLimitPrices({
    required this.blockGasLimit,
    required this.deleteDueLimit,
    this.flatGasLimit,
    this.flatGasPrice,
    required this.freezeDueLimit,
    required this.gasCredit,
    required this.gasLimit,
    required this.gasPrice,
    this.specialGasLimit,
  });

  factory GasLimitPrices.fromJson(Map<String, dynamic> json) {
    return GasLimitPrices(
      blockGasLimit: json.valueAsBigInt<BigInt>('block_gas_limit'),
      deleteDueLimit: json.valueAsBigInt<BigInt>('delete_due_limit'),
      flatGasLimit: json.valueAsBigInt<BigInt?>('flat_gas_limit'),
      flatGasPrice: json.valueAsBigInt<BigInt?>('flat_gas_price'),
      freezeDueLimit: json.valueAsBigInt<BigInt>('freeze_due_limit'),
      gasCredit: json.valueAsBigInt<BigInt>('gas_credit'),
      gasLimit: json.valueAsBigInt<BigInt>('gas_limit'),
      gasPrice: json.valueAsBigInt<BigInt>('gas_price'),
      specialGasLimit: json.valueAsBigInt<BigInt?>('special_gas_limit'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'block_gas_limit': config.encodeBigint(blockGasLimit),
    'delete_due_limit': config.encodeBigint(deleteDueLimit),
    'flat_gas_limit': config.encodeBigint(flatGasLimit),
    'flat_gas_price': config.encodeBigint(flatGasPrice),
    'freeze_due_limit': config.encodeBigint(freezeDueLimit),
    'gas_credit': config.encodeBigint(gasCredit),
    'gas_limit': config.encodeBigint(gasLimit),
    'gas_price': config.encodeBigint(gasPrice),
    'special_gas_limit': config.encodeBigint(specialGasLimit),
  });
}

class GasRelayAction {
  final BigInt amount;
  final bool? isBattery;
  final AccountAddress relayer;
  final GasRelayFee? relayerFee;
  final AccountAddress target;

  const GasRelayAction({
    required this.amount,
    this.isBattery,
    required this.relayer,
    this.relayerFee,
    required this.target,
  });

  factory GasRelayAction.fromJson(Map<String, dynamic> json) {
    return GasRelayAction(
      amount: json.valueAsBigInt<BigInt>('amount'),
      isBattery: json.valueAsBool<bool?>('is_battery'),
      relayer: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'relayer',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      relayerFee: json.valueTo<GasRelayFee?, Map<String, dynamic>>(
        key: 'relayer_fee',
        parse: (v) => GasRelayFee.fromJson(v),
      ),
      target: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'target',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': config.encodeBigint(amount),
    'is_battery': isBattery,
    'relayer': relayer.toJson(config: config),
    'relayer_fee': relayerFee?.toJson(config: config),
    'target': target.toJson(config: config),
  });
}

class GasRelayFee {
  /// amount in quanta of tokens
  final String amount;
  final JettonPreview jetton;

  const GasRelayFee({required this.amount, required this.jetton});

  factory GasRelayFee.fromJson(Map<String, dynamic> json) {
    return GasRelayFee(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      jetton: json.valueTo<JettonPreview, Map<String, dynamic>>(
        key: 'jetton',
        parse: (v) => JettonPreview.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'jetton': jetton.toJson(config: config),
  });
}

/// GET /v2/gasless/config (response)
class GaslessConfig {
  /// list of jettons, any of them can be used to pay for gas
  final List<GaslessConfigGasJettonsItem> gasJettons;

  /// sending excess to this address decreases the commission of a gasless transfer
  final String relayAddress;

  const GaslessConfig({required this.gasJettons, required this.relayAddress});

  factory GaslessConfig.fromJson(Map<String, dynamic> json) {
    return GaslessConfig(
      gasJettons:
          json
              .valueEnsureAsList<Map<String, dynamic>>('gas_jettons')
              .map((e) => GaslessConfigGasJettonsItem.fromJson(e))
              .toList(),
      relayAddress:
          (json['relay_address'] is num
              ? json['relay_address'].toString()
              : json.valueAsString<String>('relay_address')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'gas_jettons': gasJettons.map((e) => e.toJson(config: config)).toList(),
    'relay_address': relayAddress,
  });
}

/// POST /v2/gasless/send (response)
class GaslessTx {
  /// Normalized hash of the external message.
  final String? external_;
  final String protocolName;

  const GaslessTx({this.external_, required this.protocolName});

  factory GaslessTx.fromJson(Map<String, dynamic> json) {
    return GaslessTx(
      external_:
          (json['external'] is num
              ? json['external'].toString()
              : json.valueAsString<String?>('external')),
      protocolName:
          (json['protocol_name'] is num
              ? json['protocol_name'].toString()
              : json.valueAsString<String>('protocol_name')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'external': external_,
    'protocol_name': protocolName,
  });
}

class ImagePreview {
  final String resolution;
  final String url;

  const ImagePreview({required this.resolution, required this.url});

  factory ImagePreview.fromJson(Map<String, dynamic> json) {
    return ImagePreview(
      resolution:
          (json['resolution'] is num
              ? json['resolution'].toString()
              : json.valueAsString<String>('resolution')),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString<String>('url')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) =>
      config.encodeMap(<String, dynamic>{'resolution': resolution, 'url': url});
}

class InitStateRaw {
  final String fileHash;
  final String rootHash;
  final int workchain;

  const InitStateRaw({
    required this.fileHash,
    required this.rootHash,
    required this.workchain,
  });

  factory InitStateRaw.fromJson(Map<String, dynamic> json) {
    return InitStateRaw(
      fileHash:
          (json['file_hash'] is num
              ? json['file_hash'].toString()
              : json.valueAsString<String>('file_hash')),
      rootHash:
          (json['root_hash'] is num
              ? json['root_hash'].toString()
              : json.valueAsString<String>('root_hash')),
      workchain: json.valueAsInt<int>('workchain'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'file_hash': fileHash,
    'root_hash': rootHash,
    'workchain': workchain,
  });
}

/// Present on an error when a request failed because the source wallet does not hold enough TON to cover the required gas (error_code 50000).
class InsufficientFunds {
  /// TON in nanotons currently available on the source wallet
  final BigInt available;

  /// TON in nanotons required to cover transfer gas
  final BigInt required_;

  const InsufficientFunds({required this.available, required this.required_});

  factory InsufficientFunds.fromJson(Map<String, dynamic> json) {
    return InsufficientFunds(
      available: json.valueAsBigInt<BigInt>('available'),
      required_: json.valueAsBigInt<BigInt>('required'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'available': config.encodeBigint(available),
    'required': config.encodeBigint(required_),
  });
}

class JettonAssetInfo {
  final DefiProvider defiProvider;
  final DefiLiquidPoolAssets? poolAssets;
  final DefiAssetType tokenType;
  final DefiAssetType? type;

  const JettonAssetInfo({
    required this.defiProvider,
    this.poolAssets,
    required this.tokenType,
    this.type,
  });

  factory JettonAssetInfo.fromJson(Map<String, dynamic> json) {
    return JettonAssetInfo(
      defiProvider: json.valueTo<DefiProvider, Map<String, dynamic>>(
        key: 'defi_provider',
        parse: (v) => DefiProvider.fromJson(v),
      ),
      poolAssets: json.valueTo<DefiLiquidPoolAssets?, Map<String, dynamic>>(
        key: 'pool_assets',
        parse: (v) => DefiLiquidPoolAssets.fromJson(v),
      ),
      tokenType: json.valueTo<DefiAssetType, Object>(
        key: 'token_type',
        parse: (e) => DefiAssetType.fromJson(JsonParser.valueAs(e)),
      ),
      type: json.valueTo<DefiAssetType?, Object>(
        key: 'type',
        parse: (e) => DefiAssetType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'defi_provider': defiProvider.toJson(config: config),
    'pool_assets': poolAssets?.toJson(config: config),
    'token_type': tokenType.toJson(config: config),
    'type': type?.toJson(config: config),
  });
}

/// GET /v2/accounts/{account_id}/jettons/{jetton_id} (response)
class JettonBalance {
  final String balance;
  final JettonAssetInfo? defiAsset;
  final List<String>? extensions;
  final JettonPreview jetton;
  final JettonBalanceLock? lock;
  final TokenRates? price;
  final AccountAddress walletAddress;

  const JettonBalance({
    required this.balance,
    this.defiAsset,
    this.extensions,
    required this.jetton,
    this.lock,
    this.price,
    required this.walletAddress,
  });

  factory JettonBalance.fromJson(Map<String, dynamic> json) {
    return JettonBalance(
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String>('balance')),
      defiAsset: json.valueTo<JettonAssetInfo?, Map<String, dynamic>>(
        key: 'defi_asset',
        parse: (v) => JettonAssetInfo.fromJson(v),
      ),
      extensions: json.valueAsList<List<String>?>('extensions'),
      jetton: json.valueTo<JettonPreview, Map<String, dynamic>>(
        key: 'jetton',
        parse: (v) => JettonPreview.fromJson(v),
      ),
      lock: json.valueTo<JettonBalanceLock?, Map<String, dynamic>>(
        key: 'lock',
        parse: (v) => JettonBalanceLock.fromJson(v),
      ),
      price: json.valueTo<TokenRates?, Map<String, dynamic>>(
        key: 'price',
        parse: (v) => TokenRates.fromJson(v),
      ),
      walletAddress: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'wallet_address',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'balance': balance,
    'defi_asset': defiAsset?.toJson(config: config),
    'extensions': extensions,
    'jetton': jetton.toJson(config: config),
    'lock': lock?.toJson(config: config),
    'price': price?.toJson(config: config),
    'wallet_address': walletAddress.toJson(config: config),
  });
}

class JettonBridgeParams {
  final String bridgeAddress;
  final BigInt? burnBridgeFee;
  final String? externalChainAddress;
  final List<Oracle> oracles;
  final String oraclesAddress;
  final JettonBridgePrices? prices;
  final int stateFlags;

  const JettonBridgeParams({
    required this.bridgeAddress,
    this.burnBridgeFee,
    this.externalChainAddress,
    required this.oracles,
    required this.oraclesAddress,
    this.prices,
    required this.stateFlags,
  });

  factory JettonBridgeParams.fromJson(Map<String, dynamic> json) {
    return JettonBridgeParams(
      bridgeAddress:
          (json['bridge_address'] is num
              ? json['bridge_address'].toString()
              : json.valueAsString<String>('bridge_address')),
      burnBridgeFee: json.valueAsBigInt<BigInt?>('burn_bridge_fee'),
      externalChainAddress:
          (json['external_chain_address'] is num
              ? json['external_chain_address'].toString()
              : json.valueAsString<String?>('external_chain_address')),
      oracles:
          json
              .valueEnsureAsList<Map<String, dynamic>>('oracles')
              .map((e) => Oracle.fromJson(e))
              .toList(),
      oraclesAddress:
          (json['oracles_address'] is num
              ? json['oracles_address'].toString()
              : json.valueAsString<String>('oracles_address')),
      prices: json.valueTo<JettonBridgePrices?, Map<String, dynamic>>(
        key: 'prices',
        parse: (v) => JettonBridgePrices.fromJson(v),
      ),
      stateFlags: json.valueAsInt<int>('state_flags'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bridge_address': bridgeAddress,
    'burn_bridge_fee': config.encodeBigint(burnBridgeFee),
    'external_chain_address': externalChainAddress,
    'oracles': oracles.map((e) => e.toJson(config: config)).toList(),
    'oracles_address': oraclesAddress,
    'prices': prices?.toJson(config: config),
    'state_flags': stateFlags,
  });
}

class JettonBridgePrices {
  final BigInt bridgeBurnFee;
  final BigInt bridgeMintFee;
  final BigInt discoverGasConsumption;
  final BigInt minterMinGramForStorage;

  /// this field will gone after Sept. 2026, use wallet_min_gram_for_storage instead
  final BigInt? minterMinTonsForStorage;
  final BigInt walletGasConsumption;
  final BigInt walletMinGramForStorage;

  /// this field will gone after Sept. 2026, use wallet_min_gram_for_storage instead
  final BigInt? walletMinTonsForStorage;

  const JettonBridgePrices({
    required this.bridgeBurnFee,
    required this.bridgeMintFee,
    required this.discoverGasConsumption,
    required this.minterMinGramForStorage,
    this.minterMinTonsForStorage,
    required this.walletGasConsumption,
    required this.walletMinGramForStorage,
    this.walletMinTonsForStorage,
  });

  factory JettonBridgePrices.fromJson(Map<String, dynamic> json) {
    return JettonBridgePrices(
      bridgeBurnFee: json.valueAsBigInt<BigInt>('bridge_burn_fee'),
      bridgeMintFee: json.valueAsBigInt<BigInt>('bridge_mint_fee'),
      discoverGasConsumption: json.valueAsBigInt<BigInt>(
        'discover_gas_consumption',
      ),
      minterMinGramForStorage: json.valueAsBigInt<BigInt>(
        'minter_min_gram_for_storage',
      ),
      minterMinTonsForStorage: json.valueAsBigInt<BigInt?>(
        'minter_min_tons_for_storage',
      ),
      walletGasConsumption: json.valueAsBigInt<BigInt>(
        'wallet_gas_consumption',
      ),
      walletMinGramForStorage: json.valueAsBigInt<BigInt>(
        'wallet_min_gram_for_storage',
      ),
      walletMinTonsForStorage: json.valueAsBigInt<BigInt?>(
        'wallet_min_tons_for_storage',
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bridge_burn_fee': config.encodeBigint(bridgeBurnFee),
    'bridge_mint_fee': config.encodeBigint(bridgeMintFee),
    'discover_gas_consumption': config.encodeBigint(discoverGasConsumption),
    'minter_min_gram_for_storage': config.encodeBigint(minterMinGramForStorage),
    'minter_min_tons_for_storage': config.encodeBigint(minterMinTonsForStorage),
    'wallet_gas_consumption': config.encodeBigint(walletGasConsumption),
    'wallet_min_gram_for_storage': config.encodeBigint(walletMinGramForStorage),
    'wallet_min_tons_for_storage': config.encodeBigint(walletMinTonsForStorage),
  });
}

class JettonBurnAction {
  /// amount in quanta of tokens
  final String amount;
  final JettonPreview jetton;
  final AccountAddress sender;
  final String sendersWallet;

  const JettonBurnAction({
    required this.amount,
    required this.jetton,
    required this.sender,
    required this.sendersWallet,
  });

  factory JettonBurnAction.fromJson(Map<String, dynamic> json) {
    return JettonBurnAction(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      jetton: json.valueTo<JettonPreview, Map<String, dynamic>>(
        key: 'jetton',
        parse: (v) => JettonPreview.fromJson(v),
      ),
      sender: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'sender',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      sendersWallet:
          (json['senders_wallet'] is num
              ? json['senders_wallet'].toString()
              : json.valueAsString<String>('senders_wallet')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'jetton': jetton.toJson(config: config),
    'sender': sender.toJson(config: config),
    'senders_wallet': sendersWallet,
  });
}

/// GET /v2/jettons/{account_id}/holders (response)
class JettonHolders {
  final List<JettonHoldersAddressesItem> addresses;

  /// total number of holders
  final BigInt total;

  const JettonHolders({required this.addresses, required this.total});

  factory JettonHolders.fromJson(Map<String, dynamic> json) {
    return JettonHolders(
      addresses:
          json
              .valueEnsureAsList<Map<String, dynamic>>('addresses')
              .map((e) => JettonHoldersAddressesItem.fromJson(e))
              .toList(),
      total: json.valueAsBigInt<BigInt>('total'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'addresses': addresses.map((e) => e.toJson(config: config)).toList(),
    'total': config.encodeBigint(total),
  });
}

/// GET /v2/jettons/{account_id} (response)
class JettonInfo {
  final AccountAddress? admin;

  /// base64-encoded hash of jetton master code cell
  final String? codeHash;

  /// base64-encoded hash of jetton master data cell
  final String? dataHash;
  final int holdersCount;

  /// Contract interfaces implemented by the account (e.g. multisig_v2, wallet_v3r2)
  final List<String>? interfaces;

  /// last transaction lt of the jetton master account
  final String? lastTransactionLt;
  final JettonMetadata metadata;
  final bool mintable;

  /// DNS name resolving to this address (e.g. admin.ton)
  final String? name;
  final String preview;
  final ScaledUI? scaledUi;
  final String totalSupply;
  final JettonVerificationType verification;

  const JettonInfo({
    this.admin,
    this.codeHash,
    this.dataHash,
    required this.holdersCount,
    this.interfaces,
    this.lastTransactionLt,
    required this.metadata,
    required this.mintable,
    this.name,
    required this.preview,
    this.scaledUi,
    required this.totalSupply,
    required this.verification,
  });

  factory JettonInfo.fromJson(Map<String, dynamic> json) {
    return JettonInfo(
      admin: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'admin',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String?>('code_hash')),
      dataHash:
          (json['data_hash'] is num
              ? json['data_hash'].toString()
              : json.valueAsString<String?>('data_hash')),
      holdersCount: json.valueAsInt<int>('holders_count'),
      interfaces: json.valueAsList<List<String>?>('interfaces'),
      lastTransactionLt:
          (json['last_transaction_lt'] is num
              ? json['last_transaction_lt'].toString()
              : json.valueAsString<String?>('last_transaction_lt')),
      metadata: json.valueTo<JettonMetadata, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => JettonMetadata.fromJson(v),
      ),
      mintable: json.valueAsBool<bool>('mintable'),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String?>('name')),
      preview:
          (json['preview'] is num
              ? json['preview'].toString()
              : json.valueAsString<String>('preview')),
      scaledUi: json.valueTo<ScaledUI?, Map<String, dynamic>>(
        key: 'scaled_ui',
        parse: (v) => ScaledUI.fromJson(v),
      ),
      totalSupply:
          (json['total_supply'] is num
              ? json['total_supply'].toString()
              : json.valueAsString<String>('total_supply')),
      verification: json.valueTo<JettonVerificationType, Object>(
        key: 'verification',
        parse: (e) => JettonVerificationType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'admin': admin?.toJson(config: config),
    'code_hash': codeHash,
    'data_hash': dataHash,
    'holders_count': holdersCount,
    'interfaces': interfaces,
    'last_transaction_lt': lastTransactionLt,
    'metadata': metadata.toJson(config: config),
    'mintable': mintable,
    'name': name,
    'preview': preview,
    'scaled_ui': scaledUi?.toJson(config: config),
    'total_supply': totalSupply,
    'verification': verification.toJson(config: config),
  });
}

class JettonMetadata {
  final String address;
  final List<String>? catalogs;
  final String? customPayloadApiUri;
  final String decimals;
  final String? description;

  /// this field currently returns a cached image URL (e.g., "https://cache.tonapi.io/images/jetton.jpg"). In the future, this will be replaced with the original URL from the metadata. The cached image is already available in the `preview` field of `JettonInfo` and will remain there.
  final String? image;
  final String name;
  final List<String>? social;
  final String symbol;
  final List<String>? websites;

  const JettonMetadata({
    required this.address,
    this.catalogs,
    this.customPayloadApiUri,
    required this.decimals,
    this.description,
    this.image,
    required this.name,
    this.social,
    required this.symbol,
    this.websites,
  });

  factory JettonMetadata.fromJson(Map<String, dynamic> json) {
    return JettonMetadata(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      catalogs: json.valueAsList<List<String>?>('catalogs'),
      customPayloadApiUri:
          (json['custom_payload_api_uri'] is num
              ? json['custom_payload_api_uri'].toString()
              : json.valueAsString<String?>('custom_payload_api_uri')),
      decimals:
          (json['decimals'] is num
              ? json['decimals'].toString()
              : json.valueAsString<String>('decimals')),
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString<String?>('description')),
      image:
          (json['image'] is num
              ? json['image'].toString()
              : json.valueAsString<String?>('image')),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String>('name')),
      social: json.valueAsList<List<String>?>('social'),
      symbol:
          (json['symbol'] is num
              ? json['symbol'].toString()
              : json.valueAsString<String>('symbol')),
      websites: json.valueAsList<List<String>?>('websites'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'catalogs': catalogs,
    'custom_payload_api_uri': customPayloadApiUri,
    'decimals': decimals,
    'description': description,
    'image': image,
    'name': name,
    'social': social,
    'symbol': symbol,
    'websites': websites,
  });
}

class JettonMintAction {
  /// amount in quanta of tokens
  final String amount;
  final JettonPreview jetton;
  final AccountAddress recipient;
  final String recipientsWallet;

  const JettonMintAction({
    required this.amount,
    required this.jetton,
    required this.recipient,
    required this.recipientsWallet,
  });

  factory JettonMintAction.fromJson(Map<String, dynamic> json) {
    return JettonMintAction(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      jetton: json.valueTo<JettonPreview, Map<String, dynamic>>(
        key: 'jetton',
        parse: (v) => JettonPreview.fromJson(v),
      ),
      recipient: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'recipient',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      recipientsWallet:
          (json['recipients_wallet'] is num
              ? json['recipients_wallet'].toString()
              : json.valueAsString<String>('recipients_wallet')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'jetton': jetton.toJson(config: config),
    'recipient': recipient.toJson(config: config),
    'recipients_wallet': recipientsWallet,
  });
}

class JettonOperation {
  final String amount;
  final AccountAddress? destination;
  final JettonPreview jetton;
  final BigInt lt;
  final JettonOperationOperation operation;

  final dynamic payload;
  final String queryId;
  final AccountAddress? source;
  final String traceId;
  final String transactionHash;
  final BigInt utime;

  const JettonOperation({
    required this.amount,
    this.destination,
    required this.jetton,
    required this.lt,
    required this.operation,
    this.payload,
    required this.queryId,
    this.source,
    required this.traceId,
    required this.transactionHash,
    required this.utime,
  });

  factory JettonOperation.fromJson(Map<String, dynamic> json) {
    return JettonOperation(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      destination: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'destination',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      jetton: json.valueTo<JettonPreview, Map<String, dynamic>>(
        key: 'jetton',
        parse: (v) => JettonPreview.fromJson(v),
      ),
      lt: json.valueAsBigInt<BigInt>('lt'),
      operation: json.valueTo<JettonOperationOperation, Object>(
        key: 'operation',
        parse: (e) => JettonOperationOperation.fromJson(JsonParser.valueAs(e)),
      ),
      payload: json['payload'],
      queryId:
          (json['query_id'] is num
              ? json['query_id'].toString()
              : json.valueAsString<String>('query_id')),
      source: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'source',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      traceId:
          (json['trace_id'] is num
              ? json['trace_id'].toString()
              : json.valueAsString<String>('trace_id')),
      transactionHash:
          (json['transaction_hash'] is num
              ? json['transaction_hash'].toString()
              : json.valueAsString<String>('transaction_hash')),
      utime: json.valueAsBigInt<BigInt>('utime'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'destination': destination?.toJson(config: config),
    'jetton': jetton.toJson(config: config),
    'lt': config.encodeBigint(lt),
    'operation': operation.toJson(config: config),
    'payload': payload,
    'query_id': queryId,
    'source': source?.toJson(config: config),
    'trace_id': traceId,
    'transaction_hash': transactionHash,
    'utime': config.encodeBigint(utime),
  });
}

/// GET /v2/accounts/{account_id}/jettons/history (response)
/// GET /v2/jettons/{jetton_id}/accounts/{account_id}/history (response)
class JettonOperations {
  final BigInt? nextFrom;
  final List<JettonOperation> operations;

  const JettonOperations({this.nextFrom, required this.operations});

  factory JettonOperations.fromJson(Map<String, dynamic> json) {
    return JettonOperations(
      nextFrom: json.valueAsBigInt<BigInt?>('next_from'),
      operations:
          json
              .valueEnsureAsList<Map<String, dynamic>>('operations')
              .map((e) => JettonOperation.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'next_from': config.encodeBigint(nextFrom),
    'operations': operations.map((e) => e.toJson(config: config)).toList(),
  });
}

class JettonPreview {
  final String address;
  final String? customPayloadApiUri;
  final int decimals;
  final String? description;
  final String image;
  final String name;
  final ScaledUI? scaledUi;
  final int score;
  final String symbol;
  final JettonVerificationType verification;

  const JettonPreview({
    required this.address,
    this.customPayloadApiUri,
    required this.decimals,
    this.description,
    required this.image,
    required this.name,
    this.scaledUi,
    required this.score,
    required this.symbol,
    required this.verification,
  });

  factory JettonPreview.fromJson(Map<String, dynamic> json) {
    return JettonPreview(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      customPayloadApiUri:
          (json['custom_payload_api_uri'] is num
              ? json['custom_payload_api_uri'].toString()
              : json.valueAsString<String?>('custom_payload_api_uri')),
      decimals: json.valueAsInt<int>('decimals'),
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString<String?>('description')),
      image:
          (json['image'] is num
              ? json['image'].toString()
              : json.valueAsString<String>('image')),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String>('name')),
      scaledUi: json.valueTo<ScaledUI?, Map<String, dynamic>>(
        key: 'scaled_ui',
        parse: (v) => ScaledUI.fromJson(v),
      ),
      score: json.valueAsInt<int>('score'),
      symbol:
          (json['symbol'] is num
              ? json['symbol'].toString()
              : json.valueAsString<String>('symbol')),
      verification: json.valueTo<JettonVerificationType, Object>(
        key: 'verification',
        parse: (e) => JettonVerificationType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'custom_payload_api_uri': customPayloadApiUri,
    'decimals': decimals,
    'description': description,
    'image': image,
    'name': name,
    'scaled_ui': scaledUi?.toJson(config: config),
    'score': score,
    'symbol': symbol,
    'verification': verification.toJson(config: config),
  });
}

class JettonQuantity {
  final JettonPreview jetton;
  final String quantity;
  final AccountAddress walletAddress;

  const JettonQuantity({
    required this.jetton,
    required this.quantity,
    required this.walletAddress,
  });

  factory JettonQuantity.fromJson(Map<String, dynamic> json) {
    return JettonQuantity(
      jetton: json.valueTo<JettonPreview, Map<String, dynamic>>(
        key: 'jetton',
        parse: (v) => JettonPreview.fromJson(v),
      ),
      quantity:
          (json['quantity'] is num
              ? json['quantity'].toString()
              : json.valueAsString<String>('quantity')),
      walletAddress: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'wallet_address',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'jetton': jetton.toJson(config: config),
    'quantity': quantity,
    'wallet_address': walletAddress.toJson(config: config),
  });
}

class JettonSwapAction {
  final String amountIn;
  final String amountOut;
  final String dex;
  final BigInt? gramIn;
  final BigInt? gramOut;
  final JettonPreview? jettonMasterIn;
  final JettonPreview? jettonMasterOut;
  final AccountAddress router;

  /// this field will gone after Sept. 2026, use gram_in instead
  final BigInt? tonIn;

  /// this field will gone after Sept. 2026, use gram_out instead
  final BigInt? tonOut;
  final AccountAddress userWallet;

  const JettonSwapAction({
    required this.amountIn,
    required this.amountOut,
    required this.dex,
    this.gramIn,
    this.gramOut,
    this.jettonMasterIn,
    this.jettonMasterOut,
    required this.router,
    this.tonIn,
    this.tonOut,
    required this.userWallet,
  });

  factory JettonSwapAction.fromJson(Map<String, dynamic> json) {
    return JettonSwapAction(
      amountIn:
          (json['amount_in'] is num
              ? json['amount_in'].toString()
              : json.valueAsString<String>('amount_in')),
      amountOut:
          (json['amount_out'] is num
              ? json['amount_out'].toString()
              : json.valueAsString<String>('amount_out')),
      dex:
          (json['dex'] is num
              ? json['dex'].toString()
              : json.valueAsString<String>('dex')),
      gramIn: json.valueAsBigInt<BigInt?>('gram_in'),
      gramOut: json.valueAsBigInt<BigInt?>('gram_out'),
      jettonMasterIn: json.valueTo<JettonPreview?, Map<String, dynamic>>(
        key: 'jetton_master_in',
        parse: (v) => JettonPreview.fromJson(v),
      ),
      jettonMasterOut: json.valueTo<JettonPreview?, Map<String, dynamic>>(
        key: 'jetton_master_out',
        parse: (v) => JettonPreview.fromJson(v),
      ),
      router: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'router',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      tonIn: json.valueAsBigInt<BigInt?>('ton_in'),
      tonOut: json.valueAsBigInt<BigInt?>('ton_out'),
      userWallet: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'user_wallet',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount_in': amountIn,
    'amount_out': amountOut,
    'dex': dex,
    'gram_in': config.encodeBigint(gramIn),
    'gram_out': config.encodeBigint(gramOut),
    'jetton_master_in': jettonMasterIn?.toJson(config: config),
    'jetton_master_out': jettonMasterOut?.toJson(config: config),
    'router': router.toJson(config: config),
    'ton_in': config.encodeBigint(tonIn),
    'ton_out': config.encodeBigint(tonOut),
    'user_wallet': userWallet.toJson(config: config),
  });
}

class JettonTransferAction {
  /// amount in quanta of tokens
  final String amount;
  final String? comment;
  final EncryptedComment? encryptedComment;
  final JettonPreview jetton;
  final AccountAddress? recipient;
  final String recipientsWallet;
  final Refund? refund;
  final AccountAddress? sender;
  final String sendersWallet;

  const JettonTransferAction({
    required this.amount,
    this.comment,
    this.encryptedComment,
    required this.jetton,
    this.recipient,
    required this.recipientsWallet,
    this.refund,
    this.sender,
    required this.sendersWallet,
  });

  factory JettonTransferAction.fromJson(Map<String, dynamic> json) {
    return JettonTransferAction(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      comment:
          (json['comment'] is num
              ? json['comment'].toString()
              : json.valueAsString<String?>('comment')),
      encryptedComment: json.valueTo<EncryptedComment?, Map<String, dynamic>>(
        key: 'encrypted_comment',
        parse: (v) => EncryptedComment.fromJson(v),
      ),
      jetton: json.valueTo<JettonPreview, Map<String, dynamic>>(
        key: 'jetton',
        parse: (v) => JettonPreview.fromJson(v),
      ),
      recipient: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'recipient',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      recipientsWallet:
          (json['recipients_wallet'] is num
              ? json['recipients_wallet'].toString()
              : json.valueAsString<String>('recipients_wallet')),
      refund: json.valueTo<Refund?, Map<String, dynamic>>(
        key: 'refund',
        parse: (v) => Refund.fromJson(v),
      ),
      sender: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'sender',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      sendersWallet:
          (json['senders_wallet'] is num
              ? json['senders_wallet'].toString()
              : json.valueAsString<String>('senders_wallet')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'comment': comment,
    'encrypted_comment': encryptedComment?.toJson(config: config),
    'jetton': jetton.toJson(config: config),
    'recipient': recipient?.toJson(config: config),
    'recipients_wallet': recipientsWallet,
    'refund': refund?.toJson(config: config),
    'sender': sender?.toJson(config: config),
    'senders_wallet': sendersWallet,
  });
}

/// GET /v2/jettons/{jetton_id}/transfer/{account_id}/payload (response)
class JettonTransferPayload {
  /// hex-encoded BoC
  final String? customPayload;

  /// hex-encoded BoC
  final String? stateInit;

  const JettonTransferPayload({this.customPayload, this.stateInit});

  factory JettonTransferPayload.fromJson(Map<String, dynamic> json) {
    return JettonTransferPayload(
      customPayload:
          (json['custom_payload'] is num
              ? json['custom_payload'].toString()
              : json.valueAsString<String?>('custom_payload')),
      stateInit:
          (json['state_init'] is num
              ? json['state_init'].toString()
              : json.valueAsString<String?>('state_init')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'custom_payload': customPayload,
    'state_init': stateInit,
  });
}

/// GET /v2/jettons (response)
/// POST /v2/jettons/_bulk (response)
class Jettons {
  final List<JettonInfo> jettons;

  const Jettons({required this.jettons});

  factory Jettons.fromJson(Map<String, dynamic> json) {
    return Jettons(
      jettons:
          json
              .valueEnsureAsList<Map<String, dynamic>>('jettons')
              .map((e) => JettonInfo.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'jettons': jettons.map((e) => e.toJson(config: config)).toList(),
  });
}

/// GET /v2/accounts/{account_id}/jettons (response)
class JettonsBalances {
  final List<JettonBalance> balances;

  const JettonsBalances({required this.balances});

  factory JettonsBalances.fromJson(Map<String, dynamic> json) {
    return JettonsBalances(
      balances:
          json
              .valueEnsureAsList<Map<String, dynamic>>('balances')
              .map((e) => JettonBalance.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'balances': balances.map((e) => e.toJson(config: config)).toList(),
  });
}

class LiquidityDepositAction {
  final AccountAddress from;
  final Protocol protocol;
  final List<VaultDepositInfo> tokens;

  const LiquidityDepositAction({
    required this.from,
    required this.protocol,
    required this.tokens,
  });

  factory LiquidityDepositAction.fromJson(Map<String, dynamic> json) {
    return LiquidityDepositAction(
      from: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'from',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      protocol: json.valueTo<Protocol, Map<String, dynamic>>(
        key: 'protocol',
        parse: (v) => Protocol.fromJson(v),
      ),
      tokens:
          json
              .valueEnsureAsList<Map<String, dynamic>>('tokens')
              .map((e) => VaultDepositInfo.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'from': from.toJson(config: config),
    'protocol': protocol.toJson(config: config),
    'tokens': tokens.map((e) => e.toJson(config: config)).toList(),
  });
}

class MarketTonRates {
  final BigInt lastDateUpdate;
  final String market;
  final num usdPrice;

  const MarketTonRates({
    required this.lastDateUpdate,
    required this.market,
    required this.usdPrice,
  });

  factory MarketTonRates.fromJson(Map<String, dynamic> json) {
    return MarketTonRates(
      lastDateUpdate: json.valueAsBigInt<BigInt>('last_date_update'),
      market:
          (json['market'] is num
              ? json['market'].toString()
              : json.valueAsString<String>('market')),
      usdPrice: json.valueAsNum<num>('usd_price'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'last_date_update': config.encodeBigint(lastDateUpdate),
    'market': market,
    'usd_price': usdPrice,
  });
}

class Message {
  final bool bounce;
  final bool bounced;
  final BigInt createdAt;
  final BigInt createdLt;
  final dynamic decodedBody;
  final String? decodedOpName;
  final AccountAddress? destination;
  final BigInt fwdFee;
  final String hash;
  final bool ihrDisabled;
  final BigInt ihrFee;
  final BigInt importFee;
  final StateInit? init;
  final MessageMsgType msgType;
  final String? opCode;

  /// hex-encoded BoC with raw message body
  final String? rawBody;
  final AccountAddress? source;
  final BigInt value;
  final List<ExtraCurrency>? valueExtra;

  const Message({
    required this.bounce,
    required this.bounced,
    required this.createdAt,
    required this.createdLt,
    this.decodedBody,
    this.decodedOpName,
    this.destination,
    required this.fwdFee,
    required this.hash,
    required this.ihrDisabled,
    required this.ihrFee,
    required this.importFee,
    this.init,
    required this.msgType,
    this.opCode,
    this.rawBody,
    this.source,
    required this.value,
    this.valueExtra,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      bounce: json.valueAsBool<bool>('bounce'),
      bounced: json.valueAsBool<bool>('bounced'),
      createdAt: json.valueAsBigInt<BigInt>('created_at'),
      createdLt: json.valueAsBigInt<BigInt>('created_lt'),
      decodedBody: json['decoded_body'],
      decodedOpName:
          (json['decoded_op_name'] is num
              ? json['decoded_op_name'].toString()
              : json.valueAsString<String?>('decoded_op_name')),
      destination: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'destination',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      fwdFee: json.valueAsBigInt<BigInt>('fwd_fee'),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String>('hash')),
      ihrDisabled: json.valueAsBool<bool>('ihr_disabled'),
      ihrFee: json.valueAsBigInt<BigInt>('ihr_fee'),
      importFee: json.valueAsBigInt<BigInt>('import_fee'),
      init: json.valueTo<StateInit?, Map<String, dynamic>>(
        key: 'init',
        parse: (v) => StateInit.fromJson(v),
      ),
      msgType: json.valueTo<MessageMsgType, Object>(
        key: 'msg_type',
        parse: (e) => MessageMsgType.fromJson(JsonParser.valueAs(e)),
      ),
      opCode:
          (json['op_code'] is num
              ? json['op_code'].toString()
              : json.valueAsString<String?>('op_code')),
      rawBody:
          (json['raw_body'] is num
              ? json['raw_body'].toString()
              : json.valueAsString<String?>('raw_body')),
      source: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'source',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      value: json.valueAsBigInt<BigInt>('value'),
      valueExtra:
          json.hasValue('value_extra')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('value_extra')
                  .map((e) => ExtraCurrency.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bounce': bounce,
    'bounced': bounced,
    'created_at': config.encodeBigint(createdAt),
    'created_lt': config.encodeBigint(createdLt),
    'decoded_body': decodedBody,
    'decoded_op_name': decodedOpName,
    'destination': destination?.toJson(config: config),
    'fwd_fee': config.encodeBigint(fwdFee),
    'hash': hash,
    'ihr_disabled': ihrDisabled,
    'ihr_fee': config.encodeBigint(ihrFee),
    'import_fee': config.encodeBigint(importFee),
    'init': init?.toJson(config: config),
    'msg_type': msgType.toJson(config: config),
    'op_code': opCode,
    'raw_body': rawBody,
    'source': source?.toJson(config: config),
    'value': config.encodeBigint(value),
    'value_extra': valueExtra?.map((e) => e.toJson(config: config)).toList(),
  });
}

/// Result of emulating a wallet message on the current blockchain state: describes the expected on-chain consequences (trace, high-level AccountEvent, risk) for the signing wallet. For UI display only.
///
/// POST /v2/wallet/emulate (response)
class MessageConsequences {
  final AccountEvent event;
  final Risk risk;
  final Trace trace;

  const MessageConsequences({
    required this.event,
    required this.risk,
    required this.trace,
  });

  factory MessageConsequences.fromJson(Map<String, dynamic> json) {
    return MessageConsequences(
      event: json.valueTo<AccountEvent, Map<String, dynamic>>(
        key: 'event',
        parse: (v) => AccountEvent.fromJson(v),
      ),
      risk: json.valueTo<Risk, Map<String, dynamic>>(
        key: 'risk',
        parse: (v) => Risk.fromJson(v),
      ),
      trace: json.valueTo<Trace, Map<String, dynamic>>(
        key: 'trace',
        parse: (v) => Trace.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'event': event.toJson(config: config),
    'risk': risk.toJson(config: config),
    'trace': trace.toJson(config: config),
  });
}

class Metadata {
  /// hex encoded bytes
  final String? decryptionKey;

  /// hex encoded bytes
  final String encryptedBinary;

  const Metadata({this.decryptionKey, required this.encryptedBinary});

  factory Metadata.fromJson(Map<String, dynamic> json) {
    return Metadata(
      decryptionKey:
          (json['decryption_key'] is num
              ? json['decryption_key'].toString()
              : json.valueAsString<String?>('decryption_key')),
      encryptedBinary:
          (json['encrypted_binary'] is num
              ? json['encrypted_binary'].toString()
              : json.valueAsString<String>('encrypted_binary')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'decryption_key': decryptionKey,
    'encrypted_binary': encryptedBinary,
  });
}

class Method {
  final BigInt id;
  final String method;

  const Method({required this.id, required this.method});

  factory Method.fromJson(Map<String, dynamic> json) {
    return Method(
      id: json.valueAsBigInt<BigInt>('id'),
      method:
          (json['method'] is num
              ? json['method'].toString()
              : json.valueAsString<String>('method')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'id': config.encodeBigint(id),
    'method': method,
  });
}

/// GET /v2/blockchain/accounts/{account_id}/methods/{method_name} (response)
/// POST /v2/blockchain/accounts/{account_id}/methods/{method_name} (response)
class MethodExecutionResult {
  final dynamic decoded;

  /// tvm exit code
  final int exitCode;
  final List<TvmStackRecord> stack;
  final bool success;

  const MethodExecutionResult({
    this.decoded,
    required this.exitCode,
    required this.stack,
    required this.success,
  });

  factory MethodExecutionResult.fromJson(Map<String, dynamic> json) {
    return MethodExecutionResult(
      decoded: json['decoded'],
      exitCode: json.valueAsInt<int>('exit_code'),
      stack:
          json
              .valueEnsureAsList<Map<String, dynamic>>('stack')
              .map((e) => TvmStackRecord.fromJson(e))
              .toList(),
      success: json.valueAsBool<bool>('success'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'decoded': decoded,
    'exit_code': exitCode,
    'stack': stack.map((e) => e.toJson(config: config)).toList(),
    'success': success,
  });
}

class MigrationOutMessage {
  /// base64 BOC of the internal message cell the wallet resends
  final String boc;

  /// send-mode byte (e.g. 3 for a transfer, 128 for the final balance sweep)
  final int mode;

  const MigrationOutMessage({required this.boc, required this.mode});

  factory MigrationOutMessage.fromJson(Map<String, dynamic> json) {
    return MigrationOutMessage(
      boc:
          (json['boc'] is num
              ? json['boc'].toString()
              : json.valueAsString<String>('boc')),
      mode: json.valueAsInt<int>('mode'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'boc': boc, 'mode': mode});
}

/// The prepared migration together with the reason it cannot be executed as-is. Returned with HTTP 409 and error_code 50000 when the source wallet holds migratable assets but not enough TON to cover the transfer gas: the transactions are the ones the migration would consist of once the source holds `details.required`, so a client can show the full preview next to the shortfall instead of re-requesting prepare after the top-up.
///
/// POST /v2/migration/prepare (response)
class MigrationPrepareConflict {
  final String from;
  final String to;

  /// ordered; sign and broadcast in array order, one entry per external message
  final List<MigrationTransaction> transactions;

  /// source wallet version (informational)
  final String walletVersion;
  final InsufficientFunds? details;
  final String error;

  /// same extended code as on a plain error response (50000)
  final BigInt? errorCode;

  const MigrationPrepareConflict({
    required this.from,
    required this.to,
    required this.transactions,
    required this.walletVersion,
    this.details,
    required this.error,
    this.errorCode,
  });

  factory MigrationPrepareConflict.fromJson(Map<String, dynamic> json) {
    return MigrationPrepareConflict(
      from:
          (json['from'] is num
              ? json['from'].toString()
              : json.valueAsString<String>('from')),
      to:
          (json['to'] is num
              ? json['to'].toString()
              : json.valueAsString<String>('to')),
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('transactions')
              .map((e) => MigrationTransaction.fromJson(e))
              .toList(),
      walletVersion:
          (json['wallet_version'] is num
              ? json['wallet_version'].toString()
              : json.valueAsString<String>('wallet_version')),
      details: json.valueTo<InsufficientFunds?, Map<String, dynamic>>(
        key: 'details',
        parse: (v) => InsufficientFunds.fromJson(v),
      ),
      error:
          (json['error'] is num
              ? json['error'].toString()
              : json.valueAsString<String>('error')),
      errorCode: json.valueAsBigInt<BigInt?>('error_code'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'from': from,
    'to': to,
    'transactions': transactions.map((e) => e.toJson(config: config)).toList(),
    'wallet_version': walletVersion,
    'details': details?.toJson(config: config),
    'error': error,
    'error_code': config.encodeBigint(errorCode),
  });
}

/// POST /v2/migration/prepare (request)
class MigrationPrepareRequest {
  /// fiat currency for the preview values
  final String? currency;

  /// legacy source wallet to drain
  final String from;

  /// Master address of jetton that should be used to cover transactions fees. Must be supported by /v2/gasless/config and held by the source wallet.
  final String? gasJettonMaster;

  /// Who pays the gas:
  final MigrationPrepareRequestGasPayer? gasPayer;

  /// hex-encoded ed25519 public key of the source wallet. If `from` wallet is uninitialized, then public_key is used to infer wallet code
  final String? publicKey;

  /// destination wallet TON address
  final String to;

  const MigrationPrepareRequest({
    this.currency,
    required this.from,
    this.gasJettonMaster,
    this.gasPayer,
    this.publicKey,
    required this.to,
  });

  factory MigrationPrepareRequest.fromJson(Map<String, dynamic> json) {
    return MigrationPrepareRequest(
      currency:
          (json['currency'] is num
              ? json['currency'].toString()
              : json.valueAsString<String?>('currency')),
      from:
          (json['from'] is num
              ? json['from'].toString()
              : json.valueAsString<String>('from')),
      gasJettonMaster:
          (json['gas_jetton_master'] is num
              ? json['gas_jetton_master'].toString()
              : json.valueAsString<String?>('gas_jetton_master')),
      gasPayer: json.valueTo<MigrationPrepareRequestGasPayer?, Object>(
        key: 'gas_payer',
        parse:
            (e) =>
                MigrationPrepareRequestGasPayer.fromJson(JsonParser.valueAs(e)),
      ),
      publicKey:
          (json['public_key'] is num
              ? json['public_key'].toString()
              : json.valueAsString<String?>('public_key')),
      to:
          (json['to'] is num
              ? json['to'].toString()
              : json.valueAsString<String>('to')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'currency': currency,
    'from': from,
    'gas_jetton_master': gasJettonMaster,
    'gas_payer': gasPayer?.toJson(config: config),
    'public_key': publicKey,
    'to': to,
  });
}

/// POST /v2/migration/prepare (response)
class MigrationPrepareResponse {
  final String from;
  final String to;

  /// ordered; sign and broadcast in array order, one entry per external message
  final List<MigrationTransaction> transactions;

  /// source wallet version (informational)
  final String walletVersion;

  const MigrationPrepareResponse({
    required this.from,
    required this.to,
    required this.transactions,
    required this.walletVersion,
  });

  factory MigrationPrepareResponse.fromJson(Map<String, dynamic> json) {
    return MigrationPrepareResponse(
      from:
          (json['from'] is num
              ? json['from'].toString()
              : json.valueAsString<String>('from')),
      to:
          (json['to'] is num
              ? json['to'].toString()
              : json.valueAsString<String>('to')),
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('transactions')
              .map((e) => MigrationTransaction.fromJson(e))
              .toList(),
      walletVersion:
          (json['wallet_version'] is num
              ? json['wallet_version'].toString()
              : json.valueAsString<String>('wallet_version')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'from': from,
    'to': to,
    'transactions': transactions.map((e) => e.toJson(config: config)).toList(),
    'wallet_version': walletVersion,
  });
}

class MigrationTransaction {
  /// base64 BOC of the unsigned wallet body. The body type is determined by (wallet_version, sponsored): for v3/v4 it is always the external body — sign its hash, prepend the signature, wrap in an external message; for w5 with sponsored=false it is the external body with the signature appended as the trailing 512 bits; for w5 with sponsored=true it is the internal_signed body — sign and wrap it for /v2/gasless/send as in the gasless flow.
  final String boc;

  /// gasless only; the relay commission in indivisible gas-jetton units, embedded in the boc as a jetton transfer to the relay. Exact for the first transaction; an estimate for later ones (re-running prepare refreshes it).
  final String? commission;
  final MessageConsequences emulation;

  /// TON burned as network fees by this transaction, in nanotons — the sum over every transaction in `emulation.trace`. For a transfer batch this is only part of the gas attached to its messages: the transfers name the destination wallet as response_destination, so the unburned remainder arrives there instead of returning to the source. For the final balance sweep it is the fee deducted from the swept amount. When `sponsored` is true these fees are covered by the relay, which charges `commission` instead.
  final BigInt gasSpent;

  /// ordered raw internal messages carried by this transaction — the cells the wallet resends. These are what populate the payload/actions.
  final List<MigrationOutMessage> messages;

  /// wallet seqno baked into the unsigned body
  final int seqno;

  /// true — the Battery relay pays gas for this transaction; submit it via /v2/gasless/send. false — self-paid; sign and broadcast via /v2/blockchain/message as usual. The final TON sweep is always self-paid, whatever gas_payer says: the relay does not sponsor a TON-only batch, and gasless has no jetton balance left to bill a commission against.
  final bool? sponsored;

  /// base64 BOC of the wallet StateInit (code + data). Present only on the first transaction when the source wallet is not yet initialized
  final String? stateInit;

  const MigrationTransaction({
    required this.boc,
    this.commission,
    required this.emulation,
    required this.gasSpent,
    required this.messages,
    required this.seqno,
    this.sponsored,
    this.stateInit,
  });

  factory MigrationTransaction.fromJson(Map<String, dynamic> json) {
    return MigrationTransaction(
      boc:
          (json['boc'] is num
              ? json['boc'].toString()
              : json.valueAsString<String>('boc')),
      commission:
          (json['commission'] is num
              ? json['commission'].toString()
              : json.valueAsString<String?>('commission')),
      emulation: json.valueTo<MessageConsequences, Map<String, dynamic>>(
        key: 'emulation',
        parse: (v) => MessageConsequences.fromJson(v),
      ),
      gasSpent: json.valueAsBigInt<BigInt>('gas_spent'),
      messages:
          json
              .valueEnsureAsList<Map<String, dynamic>>('messages')
              .map((e) => MigrationOutMessage.fromJson(e))
              .toList(),
      seqno: json.valueAsInt<int>('seqno'),
      sponsored: json.valueAsBool<bool?>('sponsored'),
      stateInit:
          (json['state_init'] is num
              ? json['state_init'].toString()
              : json.valueAsString<String?>('state_init')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'boc': boc,
    'commission': commission,
    'emulation': emulation.toJson(config: config),
    'gas_spent': config.encodeBigint(gasSpent),
    'messages': messages.map((e) => e.toJson(config: config)).toList(),
    'seqno': seqno,
    'sponsored': sponsored,
    'state_init': stateInit,
  });
}

class MigrationWalletValue {
  final String account;

  /// TON balance in nanotons
  final BigInt balance;
  final List<JettonBalance> jettons;

  /// number of NFTs owned by the account
  final int nftCount;
  final AccountStatus status;

  const MigrationWalletValue({
    required this.account,
    required this.balance,
    required this.jettons,
    required this.nftCount,
    required this.status,
  });

  factory MigrationWalletValue.fromJson(Map<String, dynamic> json) {
    return MigrationWalletValue(
      account:
          (json['account'] is num
              ? json['account'].toString()
              : json.valueAsString<String>('account')),
      balance: json.valueAsBigInt<BigInt>('balance'),
      jettons:
          json
              .valueEnsureAsList<Map<String, dynamic>>('jettons')
              .map((e) => JettonBalance.fromJson(e))
              .toList(),
      nftCount: json.valueAsInt<int>('nft_count'),
      status: json.valueTo<AccountStatus, Object>(
        key: 'status',
        parse: (e) => AccountStatus.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'account': account,
    'balance': config.encodeBigint(balance),
    'jettons': jettons.map((e) => e.toJson(config: config)).toList(),
    'nft_count': nftCount,
    'status': status.toJson(config: config),
  });
}

/// POST /v2/migration/wallets (response)
class MigrationWallets {
  final List<MigrationWalletValue> wallets;

  const MigrationWallets({required this.wallets});

  factory MigrationWallets.fromJson(Map<String, dynamic> json) {
    return MigrationWallets(
      wallets:
          json
              .valueEnsureAsList<Map<String, dynamic>>('wallets')
              .map((e) => MigrationWalletValue.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'wallets': wallets.map((e) => e.toJson(config: config)).toList(),
  });
}

class MisbehaviourPunishmentConfig {
  final BigInt defaultFlatFine;
  final BigInt defaultProportionalFine;
  final int longFlatMult;
  final int longInterval;
  final int longProportionalMult;
  final int mediumFlatMult;
  final int mediumInterval;
  final int mediumProportionalMult;
  final int severityFlatMult;
  final int severityProportionalMult;
  final int unpunishableInterval;

  const MisbehaviourPunishmentConfig({
    required this.defaultFlatFine,
    required this.defaultProportionalFine,
    required this.longFlatMult,
    required this.longInterval,
    required this.longProportionalMult,
    required this.mediumFlatMult,
    required this.mediumInterval,
    required this.mediumProportionalMult,
    required this.severityFlatMult,
    required this.severityProportionalMult,
    required this.unpunishableInterval,
  });

  factory MisbehaviourPunishmentConfig.fromJson(Map<String, dynamic> json) {
    return MisbehaviourPunishmentConfig(
      defaultFlatFine: json.valueAsBigInt<BigInt>('default_flat_fine'),
      defaultProportionalFine: json.valueAsBigInt<BigInt>(
        'default_proportional_fine',
      ),
      longFlatMult: json.valueAsInt<int>('long_flat_mult'),
      longInterval: json.valueAsInt<int>('long_interval'),
      longProportionalMult: json.valueAsInt<int>('long_proportional_mult'),
      mediumFlatMult: json.valueAsInt<int>('medium_flat_mult'),
      mediumInterval: json.valueAsInt<int>('medium_interval'),
      mediumProportionalMult: json.valueAsInt<int>('medium_proportional_mult'),
      severityFlatMult: json.valueAsInt<int>('severity_flat_mult'),
      severityProportionalMult: json.valueAsInt<int>(
        'severity_proportional_mult',
      ),
      unpunishableInterval: json.valueAsInt<int>('unpunishable_interval'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'default_flat_fine': config.encodeBigint(defaultFlatFine),
    'default_proportional_fine': config.encodeBigint(defaultProportionalFine),
    'long_flat_mult': longFlatMult,
    'long_interval': longInterval,
    'long_proportional_mult': longProportionalMult,
    'medium_flat_mult': mediumFlatMult,
    'medium_interval': mediumInterval,
    'medium_proportional_mult': mediumProportionalMult,
    'severity_flat_mult': severityFlatMult,
    'severity_proportional_mult': severityProportionalMult,
    'unpunishable_interval': unpunishableInterval,
  });
}

class MsgForwardPrices {
  final BigInt bitPrice;
  final BigInt cellPrice;
  final BigInt firstFrac;
  final BigInt ihrPriceFactor;
  final BigInt lumpPrice;
  final BigInt nextFrac;

  const MsgForwardPrices({
    required this.bitPrice,
    required this.cellPrice,
    required this.firstFrac,
    required this.ihrPriceFactor,
    required this.lumpPrice,
    required this.nextFrac,
  });

  factory MsgForwardPrices.fromJson(Map<String, dynamic> json) {
    return MsgForwardPrices(
      bitPrice: json.valueAsBigInt<BigInt>('bit_price'),
      cellPrice: json.valueAsBigInt<BigInt>('cell_price'),
      firstFrac: json.valueAsBigInt<BigInt>('first_frac'),
      ihrPriceFactor: json.valueAsBigInt<BigInt>('ihr_price_factor'),
      lumpPrice: json.valueAsBigInt<BigInt>('lump_price'),
      nextFrac: json.valueAsBigInt<BigInt>('next_frac'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bit_price': config.encodeBigint(bitPrice),
    'cell_price': config.encodeBigint(cellPrice),
    'first_frac': config.encodeBigint(firstFrac),
    'ihr_price_factor': config.encodeBigint(ihrPriceFactor),
    'lump_price': config.encodeBigint(lumpPrice),
    'next_frac': config.encodeBigint(nextFrac),
  });
}

/// GET /v2/multisig/{account_id} (response)
class Multisig {
  final String address;
  final List<MultisigOrder> orders;
  final List<String> proposers;
  final String seqno;
  final List<String> signers;
  final int threshold;

  const Multisig({
    required this.address,
    required this.orders,
    required this.proposers,
    required this.seqno,
    required this.signers,
    required this.threshold,
  });

  factory Multisig.fromJson(Map<String, dynamic> json) {
    return Multisig(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      orders:
          json
              .valueEnsureAsList<Map<String, dynamic>>('orders')
              .map((e) => MultisigOrder.fromJson(e))
              .toList(),
      proposers: json.valueAsList<List<String>>('proposers'),
      seqno:
          (json['seqno'] is num
              ? json['seqno'].toString()
              : json.valueAsString<String>('seqno')),
      signers: json.valueAsList<List<String>>('signers'),
      threshold: json.valueAsInt<int>('threshold'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'orders': orders.map((e) => e.toJson(config: config)).toList(),
    'proposers': proposers,
    'seqno': seqno,
    'signers': signers,
    'threshold': threshold,
  });
}

/// GET /v2/multisig/order/{account_id} (response)
class MultisigOrder {
  final String address;
  final int approvalsNum;
  final MultisigOrderChangingParameters? changingParameters;
  final BigInt creationDate;
  final BigInt expirationDate;
  final String multisigAddress;
  final String orderSeqno;
  final Risk risk;
  final bool sentForExecution;
  final List<String> signedBy;
  final List<String> signers;
  final int threshold;

  const MultisigOrder({
    required this.address,
    required this.approvalsNum,
    this.changingParameters,
    required this.creationDate,
    required this.expirationDate,
    required this.multisigAddress,
    required this.orderSeqno,
    required this.risk,
    required this.sentForExecution,
    required this.signedBy,
    required this.signers,
    required this.threshold,
  });

  factory MultisigOrder.fromJson(Map<String, dynamic> json) {
    return MultisigOrder(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      approvalsNum: json.valueAsInt<int>('approvals_num'),
      changingParameters: json
          .valueTo<MultisigOrderChangingParameters?, Map<String, dynamic>>(
            key: 'changing_parameters',
            parse: (v) => MultisigOrderChangingParameters.fromJson(v),
          ),
      creationDate: json.valueAsBigInt<BigInt>('creation_date'),
      expirationDate: json.valueAsBigInt<BigInt>('expiration_date'),
      multisigAddress:
          (json['multisig_address'] is num
              ? json['multisig_address'].toString()
              : json.valueAsString<String>('multisig_address')),
      orderSeqno:
          (json['order_seqno'] is num
              ? json['order_seqno'].toString()
              : json.valueAsString<String>('order_seqno')),
      risk: json.valueTo<Risk, Map<String, dynamic>>(
        key: 'risk',
        parse: (v) => Risk.fromJson(v),
      ),
      sentForExecution: json.valueAsBool<bool>('sent_for_execution'),
      signedBy: json.valueAsList<List<String>>('signed_by'),
      signers: json.valueAsList<List<String>>('signers'),
      threshold: json.valueAsInt<int>('threshold'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'approvals_num': approvalsNum,
    'changing_parameters': changingParameters?.toJson(config: config),
    'creation_date': config.encodeBigint(creationDate),
    'expiration_date': config.encodeBigint(expirationDate),
    'multisig_address': multisigAddress,
    'order_seqno': orderSeqno,
    'risk': risk.toJson(config: config),
    'sent_for_execution': sentForExecution,
    'signed_by': signedBy,
    'signers': signers,
    'threshold': threshold,
  });
}

/// GET /v2/accounts/{account_id}/multisigs (response)
class Multisigs {
  final List<Multisig> multisigs;

  const Multisigs({required this.multisigs});

  factory Multisigs.fromJson(Map<String, dynamic> json) {
    return Multisigs(
      multisigs:
          json
              .valueEnsureAsList<Map<String, dynamic>>('multisigs')
              .map((e) => Multisig.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'multisigs': multisigs.map((e) => e.toJson(config: config)).toList(),
  });
}

class NewConsensusConfig {
  final BigInt? firstBlockTimeoutMs;
  final int flags;
  final BigInt? maxLeaderWindowDesync;
  final Map<String, BigInt>? noncriticalParams;
  final BigInt slotsPerLeaderWindow;
  final BigInt? targetRateMs;
  final bool useQuic;

  const NewConsensusConfig({
    this.firstBlockTimeoutMs,
    required this.flags,
    this.maxLeaderWindowDesync,
    this.noncriticalParams,
    required this.slotsPerLeaderWindow,
    this.targetRateMs,
    required this.useQuic,
  });

  factory NewConsensusConfig.fromJson(Map<String, dynamic> json) {
    return NewConsensusConfig(
      firstBlockTimeoutMs: json.valueAsBigInt<BigInt?>(
        'first_block_timeout_ms',
      ),
      flags: json.valueAsInt<int>('flags'),
      maxLeaderWindowDesync: json.valueAsBigInt<BigInt?>(
        'max_leader_window_desync',
      ),
      noncriticalParams:
          json.hasValue('noncritical_params')
              ? json
                  .valueEnsureAsMap<String, dynamic>('noncritical_params')
                  .map(
                    (k, v) => MapEntry(k, JsonParser.valueAsBigInt<BigInt>(v)),
                  )
              : null,
      slotsPerLeaderWindow: json.valueAsBigInt<BigInt>(
        'slots_per_leader_window',
      ),
      targetRateMs: json.valueAsBigInt<BigInt?>('target_rate_ms'),
      useQuic: json.valueAsBool<bool>('use_quic'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'first_block_timeout_ms': config.encodeBigint(firstBlockTimeoutMs),
    'flags': flags,
    'max_leader_window_desync': config.encodeBigint(maxLeaderWindowDesync),
    'noncritical_params': noncriticalParams,
    'slots_per_leader_window': config.encodeBigint(slotsPerLeaderWindow),
    'target_rate_ms': config.encodeBigint(targetRateMs),
    'use_quic': useQuic,
  });
}

/// GET /v2/nfts/collections/{account_id} (response)
class NftCollection {
  final String address;
  final NftApprovedBy approvedBy;
  final Map<String, dynamic>? metadata;
  final NftCollectionMetadataStatus? metadataStatus;
  final BigInt nextItemIndex;
  final AccountAddress? owner;
  final List<ImagePreview>? previews;
  final String rawCollectionContent;
  final TrustType trust;

  const NftCollection({
    required this.address,
    required this.approvedBy,
    this.metadata,
    this.metadataStatus,
    required this.nextItemIndex,
    this.owner,
    this.previews,
    required this.rawCollectionContent,
    required this.trust,
  });

  factory NftCollection.fromJson(Map<String, dynamic> json) {
    return NftCollection(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      approvedBy:
          json
              .valueEnsureAsList<dynamic>('approved_by')
              .map((e) => NftApprovedByItem.fromJson(e))
              .toList(),
      metadata: json.valueAsMap<Map<String, dynamic>?>('metadata'),
      metadataStatus: json
          .valueTo<NftCollectionMetadataStatus?, Map<String, dynamic>>(
            key: 'metadata_status',
            parse: (v) => NftCollectionMetadataStatus.fromJson(v),
          ),
      nextItemIndex: json.valueAsBigInt<BigInt>('next_item_index'),
      owner: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'owner',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      previews:
          json.hasValue('previews')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('previews')
                  .map((e) => ImagePreview.fromJson(e))
                  .toList()
              : null,
      rawCollectionContent:
          (json['raw_collection_content'] is num
              ? json['raw_collection_content'].toString()
              : json.valueAsString<String>('raw_collection_content')),
      trust: json.valueTo<TrustType, Object>(
        key: 'trust',
        parse: (e) => TrustType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'approved_by': approvedBy.map((e) => e.toJson(config: config)).toList(),
    'metadata': metadata,
    'metadata_status': metadataStatus?.toJson(config: config),
    'next_item_index': config.encodeBigint(nextItemIndex),
    'owner': owner?.toJson(config: config),
    'previews': previews?.map((e) => e.toJson(config: config)).toList(),
    'raw_collection_content': rawCollectionContent,
    'trust': trust.toJson(config: config),
  });
}

class NftCollectionMetadataStatus {
  final bool? isBroken;
  final BigInt? lastRefreshSuccess;
  final BigInt? lastRefreshTry;
  final String? url;

  const NftCollectionMetadataStatus({
    this.isBroken,
    this.lastRefreshSuccess,
    this.lastRefreshTry,
    this.url,
  });

  factory NftCollectionMetadataStatus.fromJson(Map<String, dynamic> json) {
    return NftCollectionMetadataStatus(
      isBroken: json.valueAsBool<bool?>('is_broken'),
      lastRefreshSuccess: json.valueAsBigInt<BigInt?>('last_refresh_success'),
      lastRefreshTry: json.valueAsBigInt<BigInt?>('last_refresh_try'),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString<String?>('url')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'is_broken': isBroken,
    'last_refresh_success': config.encodeBigint(lastRefreshSuccess),
    'last_refresh_try': config.encodeBigint(lastRefreshTry),
    'url': url,
  });
}

/// GET /v2/nfts/collections (response)
/// POST /v2/nfts/collections/_bulk (response)
class NftCollections {
  final List<NftCollection> nftCollections;

  const NftCollections({required this.nftCollections});

  factory NftCollections.fromJson(Map<String, dynamic> json) {
    return NftCollections(
      nftCollections:
          json
              .valueEnsureAsList<Map<String, dynamic>>('nft_collections')
              .map((e) => NftCollection.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'nft_collections':
        nftCollections.map((e) => e.toJson(config: config)).toList(),
  });
}

/// GET /v2/nfts/{account_id} (response)
class NftItem {
  final String address;

  /// Please use trust field
  final NftApprovedBy approvedBy;

  /// Hash of the NFT item account code cell (hex)
  final String? codeHash;
  final NftItemCollection? collection;

  /// Hash of the NFT item account data cell (hex)
  final String? dataHash;
  final String? dns;
  final bool? includeCnft;
  final BigInt index;
  final Map<String, dynamic> metadata;
  final AccountAddress? owner;
  final List<ImagePreview>? previews;
  final Sale? sale;
  final TrustType trust;

  /// Collection master contract confirmed that this item is part of collection
  final bool verified;

  const NftItem({
    required this.address,
    required this.approvedBy,
    this.codeHash,
    this.collection,
    this.dataHash,
    this.dns,
    this.includeCnft,
    required this.index,
    required this.metadata,
    this.owner,
    this.previews,
    this.sale,
    required this.trust,
    required this.verified,
  });

  factory NftItem.fromJson(Map<String, dynamic> json) {
    return NftItem(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      approvedBy:
          json
              .valueEnsureAsList<dynamic>('approved_by')
              .map((e) => NftApprovedByItem.fromJson(e))
              .toList(),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String?>('code_hash')),
      collection: json.valueTo<NftItemCollection?, Map<String, dynamic>>(
        key: 'collection',
        parse: (v) => NftItemCollection.fromJson(v),
      ),
      dataHash:
          (json['data_hash'] is num
              ? json['data_hash'].toString()
              : json.valueAsString<String?>('data_hash')),
      dns:
          (json['dns'] is num
              ? json['dns'].toString()
              : json.valueAsString<String?>('dns')),
      includeCnft: json.valueAsBool<bool?>('include_cnft'),
      index: json.valueAsBigInt<BigInt>('index'),
      metadata: json.valueAsMap<Map<String, dynamic>>('metadata'),
      owner: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'owner',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      previews:
          json.hasValue('previews')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('previews')
                  .map((e) => ImagePreview.fromJson(e))
                  .toList()
              : null,
      sale: json.valueTo<Sale?, Map<String, dynamic>>(
        key: 'sale',
        parse: (v) => Sale.fromJson(v),
      ),
      trust: json.valueTo<TrustType, Object>(
        key: 'trust',
        parse: (e) => TrustType.fromJson(JsonParser.valueAs(e)),
      ),
      verified: json.valueAsBool<bool>('verified'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'approved_by': approvedBy.map((e) => e.toJson(config: config)).toList(),
    'code_hash': codeHash,
    'collection': collection?.toJson(config: config),
    'data_hash': dataHash,
    'dns': dns,
    'include_cnft': includeCnft,
    'index': config.encodeBigint(index),
    'metadata': metadata,
    'owner': owner?.toJson(config: config),
    'previews': previews?.map((e) => e.toJson(config: config)).toList(),
    'sale': sale?.toJson(config: config),
    'trust': trust.toJson(config: config),
    'verified': verified,
  });
}

class NftItemTransferAction {
  final String? comment;
  final EncryptedComment? encryptedComment;
  final String nft;

  /// raw hex encoded payload
  final String? payload;
  final AccountAddress? recipient;
  final Refund? refund;
  final AccountAddress? sender;

  const NftItemTransferAction({
    this.comment,
    this.encryptedComment,
    required this.nft,
    this.payload,
    this.recipient,
    this.refund,
    this.sender,
  });

  factory NftItemTransferAction.fromJson(Map<String, dynamic> json) {
    return NftItemTransferAction(
      comment:
          (json['comment'] is num
              ? json['comment'].toString()
              : json.valueAsString<String?>('comment')),
      encryptedComment: json.valueTo<EncryptedComment?, Map<String, dynamic>>(
        key: 'encrypted_comment',
        parse: (v) => EncryptedComment.fromJson(v),
      ),
      nft:
          (json['nft'] is num
              ? json['nft'].toString()
              : json.valueAsString<String>('nft')),
      payload:
          (json['payload'] is num
              ? json['payload'].toString()
              : json.valueAsString<String?>('payload')),
      recipient: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'recipient',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      refund: json.valueTo<Refund?, Map<String, dynamic>>(
        key: 'refund',
        parse: (v) => Refund.fromJson(v),
      ),
      sender: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'sender',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'comment': comment,
    'encrypted_comment': encryptedComment?.toJson(config: config),
    'nft': nft,
    'payload': payload,
    'recipient': recipient?.toJson(config: config),
    'refund': refund?.toJson(config: config),
    'sender': sender?.toJson(config: config),
  });
}

/// GET /v2/accounts/{account_id}/nfts (response)
/// POST /v2/nfts/_bulk (response)
/// GET /v2/nfts/collections/{account_id}/items (response)
class NftItems {
  final List<NftItem> nftItems;

  const NftItems({required this.nftItems});

  factory NftItems.fromJson(Map<String, dynamic> json) {
    return NftItems(
      nftItems:
          json
              .valueEnsureAsList<Map<String, dynamic>>('nft_items')
              .map((e) => NftItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'nft_items': nftItems.map((e) => e.toJson(config: config)).toList(),
  });
}

class NftOperation {
  final AccountAddress? destination;
  final NftItem item;
  final BigInt lt;
  final String operation;
  final AccountAddress? source;
  final String transactionHash;
  final BigInt utime;

  const NftOperation({
    this.destination,
    required this.item,
    required this.lt,
    required this.operation,
    this.source,
    required this.transactionHash,
    required this.utime,
  });

  factory NftOperation.fromJson(Map<String, dynamic> json) {
    return NftOperation(
      destination: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'destination',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      item: json.valueTo<NftItem, Map<String, dynamic>>(
        key: 'item',
        parse: (v) => NftItem.fromJson(v),
      ),
      lt: json.valueAsBigInt<BigInt>('lt'),
      operation:
          (json['operation'] is num
              ? json['operation'].toString()
              : json.valueAsString<String>('operation')),
      source: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'source',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      transactionHash:
          (json['transaction_hash'] is num
              ? json['transaction_hash'].toString()
              : json.valueAsString<String>('transaction_hash')),
      utime: json.valueAsBigInt<BigInt>('utime'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'destination': destination?.toJson(config: config),
    'item': item.toJson(config: config),
    'lt': config.encodeBigint(lt),
    'operation': operation,
    'source': source?.toJson(config: config),
    'transaction_hash': transactionHash,
    'utime': config.encodeBigint(utime),
  });
}

/// GET /v2/accounts/{account_id}/nfts/history (response)
class NftOperations {
  final BigInt? nextFrom;
  final List<NftOperation> operations;

  const NftOperations({this.nextFrom, required this.operations});

  factory NftOperations.fromJson(Map<String, dynamic> json) {
    return NftOperations(
      nextFrom: json.valueAsBigInt<BigInt?>('next_from'),
      operations:
          json
              .valueEnsureAsList<Map<String, dynamic>>('operations')
              .map((e) => NftOperation.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'next_from': config.encodeBigint(nextFrom),
    'operations': operations.map((e) => e.toJson(config: config)).toList(),
  });
}

class NftPurchaseAction {
  final Price amount;
  final AuctionBidActionAuctionType auctionType;
  final AccountAddress buyer;
  final NftItem nft;
  final AccountAddress seller;

  const NftPurchaseAction({
    required this.amount,
    required this.auctionType,
    required this.buyer,
    required this.nft,
    required this.seller,
  });

  factory NftPurchaseAction.fromJson(Map<String, dynamic> json) {
    return NftPurchaseAction(
      amount: json.valueTo<Price, Map<String, dynamic>>(
        key: 'amount',
        parse: (v) => Price.fromJson(v),
      ),
      auctionType: json.valueTo<AuctionBidActionAuctionType, Object>(
        key: 'auction_type',
        parse:
            (e) => AuctionBidActionAuctionType.fromJson(JsonParser.valueAs(e)),
      ),
      buyer: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'buyer',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      nft: json.valueTo<NftItem, Map<String, dynamic>>(
        key: 'nft',
        parse: (v) => NftItem.fromJson(v),
      ),
      seller: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'seller',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount.toJson(config: config),
    'auction_type': auctionType.toJson(config: config),
    'buyer': buyer.toJson(config: config),
    'nft': nft.toJson(config: config),
    'seller': seller.toJson(config: config),
  });
}

class NominatorRewardEntry {
  /// Nominator's wallet address (bounceable, base64url).
  final String address;

  /// amount in nanograms
  final BigInt effectiveStake;

  /// amount in nanograms
  final BigInt reward;

  /// amount in nanograms
  final BigInt stake;

  /// Nominator's share of total nominators' deposit (0–1).
  final double weight;

  const NominatorRewardEntry({
    required this.address,
    required this.effectiveStake,
    required this.reward,
    required this.stake,
    required this.weight,
  });

  factory NominatorRewardEntry.fromJson(Map<String, dynamic> json) {
    return NominatorRewardEntry(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      effectiveStake: json.valueAsBigInt<BigInt>('effective_stake'),
      reward: json.valueAsBigInt<BigInt>('reward'),
      stake: json.valueAsBigInt<BigInt>('stake'),
      weight: json.valueAsDouble<double>('weight'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'effective_stake': config.encodeBigint(effectiveStake),
    'reward': config.encodeBigint(reward),
    'stake': config.encodeBigint(stake),
    'weight': weight,
  });
}

class Oracle {
  final String address;
  final String secpPubkey;

  const Oracle({required this.address, required this.secpPubkey});

  factory Oracle.fromJson(Map<String, dynamic> json) {
    return Oracle(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      secpPubkey:
          (json['secp_pubkey'] is num
              ? json['secp_pubkey'].toString()
              : json.valueAsString<String>('secp_pubkey')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'secp_pubkey': secpPubkey,
  });
}

class OracleBridgeParams {
  final String bridgeAddr;
  final String externalChainAddress;
  final String oracleMultisigAddress;
  final List<Oracle> oracles;

  const OracleBridgeParams({
    required this.bridgeAddr,
    required this.externalChainAddress,
    required this.oracleMultisigAddress,
    required this.oracles,
  });

  factory OracleBridgeParams.fromJson(Map<String, dynamic> json) {
    return OracleBridgeParams(
      bridgeAddr:
          (json['bridge_addr'] is num
              ? json['bridge_addr'].toString()
              : json.valueAsString<String>('bridge_addr')),
      externalChainAddress:
          (json['external_chain_address'] is num
              ? json['external_chain_address'].toString()
              : json.valueAsString<String>('external_chain_address')),
      oracleMultisigAddress:
          (json['oracle_multisig_address'] is num
              ? json['oracle_multisig_address'].toString()
              : json.valueAsString<String>('oracle_multisig_address')),
      oracles:
          json
              .valueEnsureAsList<Map<String, dynamic>>('oracles')
              .map((e) => Oracle.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bridge_addr': bridgeAddr,
    'external_chain_address': externalChainAddress,
    'oracle_multisig_address': oracleMultisigAddress,
    'oracles': oracles.map((e) => e.toJson(config: config)).toList(),
  });
}

class OraclePriceFeed {
  final String displaySymbol;
  final String id;
  final double? rate;

  const OraclePriceFeed({
    required this.displaySymbol,
    required this.id,
    this.rate,
  });

  factory OraclePriceFeed.fromJson(Map<String, dynamic> json) {
    return OraclePriceFeed(
      displaySymbol:
          (json['display_symbol'] is num
              ? json['display_symbol'].toString()
              : json.valueAsString<String>('display_symbol')),
      id:
          (json['id'] is num
              ? json['id'].toString()
              : json.valueAsString<String>('id')),
      rate: json.valueAsDouble<double?>('rate'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'display_symbol': displaySymbol,
    'id': id,
    'rate': rate,
  });
}

class OracleRequestAction {
  final List<OraclePriceFeed> priceFeeds;
  final AccountAddress requester;
  final AccountAddress responseTo;

  const OracleRequestAction({
    required this.priceFeeds,
    required this.requester,
    required this.responseTo,
  });

  factory OracleRequestAction.fromJson(Map<String, dynamic> json) {
    return OracleRequestAction(
      priceFeeds:
          json
              .valueEnsureAsList<Map<String, dynamic>>('price_feeds')
              .map((e) => OraclePriceFeed.fromJson(e))
              .toList(),
      requester: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'requester',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      responseTo: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'response_to',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'price_feeds': priceFeeds.map((e) => e.toJson(config: config)).toList(),
    'requester': requester.toJson(config: config),
    'response_to': responseTo.toJson(config: config),
  });
}

class PictureDNS {
  final String? bagId;
  final PictureDNSType type;

  /// WARNING! This is arbitrary url supplied by domain owner, use it very carefully.
  final String? url;

  const PictureDNS({this.bagId, required this.type, this.url});

  factory PictureDNS.fromJson(Map<String, dynamic> json) {
    return PictureDNS(
      bagId:
          (json['bag_id'] is num
              ? json['bag_id'].toString()
              : json.valueAsString<String?>('bag_id')),
      type: json.valueTo<PictureDNSType, Object>(
        key: 'type',
        parse: (e) => PictureDNSType.fromJson(JsonParser.valueAs(e)),
      ),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString<String?>('url')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bag_id': bagId,
    'type': type.toJson(config: config),
    'url': url,
  });
}

class PoolImplementation {
  final String description;
  final String name;
  final List<String> socials;
  final String url;

  const PoolImplementation({
    required this.description,
    required this.name,
    required this.socials,
    required this.url,
  });

  factory PoolImplementation.fromJson(Map<String, dynamic> json) {
    return PoolImplementation(
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString<String>('description')),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String>('name')),
      socials: json.valueAsList<List<String>>('socials'),
      url:
          (json['url'] is num
              ? json['url'].toString()
              : json.valueAsString<String>('url')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'description': description,
    'name': name,
    'socials': socials,
    'url': url,
  });
}

class PoolInfo {
  final String address;

  /// APY in percent
  final num apy;

  /// current number of nominators
  final int currentNominators;

  /// current nomination cycle ending timestamp
  final BigInt cycleEnd;
  final BigInt? cycleLength;

  /// current nomination cycle beginning timestamp
  final BigInt cycleStart;
  final PoolImplementationType implementation;

  /// for liquid staking master account of jetton
  final String? liquidJettonMaster;

  /// maximum number of nominators
  final int maxNominators;
  final BigInt minStake;
  final String name;

  /// total stake of all nominators
  final BigInt nominatorsStake;
  final BigInt totalAmount;

  /// stake of validator
  final BigInt validatorStake;

  /// this pool has verified source code or managed by trusted company
  final bool verified;

  const PoolInfo({
    required this.address,
    required this.apy,
    required this.currentNominators,
    required this.cycleEnd,
    this.cycleLength,
    required this.cycleStart,
    required this.implementation,
    this.liquidJettonMaster,
    required this.maxNominators,
    required this.minStake,
    required this.name,
    required this.nominatorsStake,
    required this.totalAmount,
    required this.validatorStake,
    required this.verified,
  });

  factory PoolInfo.fromJson(Map<String, dynamic> json) {
    return PoolInfo(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      apy: json.valueAsNum<num>('apy'),
      currentNominators: json.valueAsInt<int>('current_nominators'),
      cycleEnd: json.valueAsBigInt<BigInt>('cycle_end'),
      cycleLength: json.valueAsBigInt<BigInt?>('cycle_length'),
      cycleStart: json.valueAsBigInt<BigInt>('cycle_start'),
      implementation: json.valueTo<PoolImplementationType, Object>(
        key: 'implementation',
        parse: (e) => PoolImplementationType.fromJson(JsonParser.valueAs(e)),
      ),
      liquidJettonMaster:
          (json['liquid_jetton_master'] is num
              ? json['liquid_jetton_master'].toString()
              : json.valueAsString<String?>('liquid_jetton_master')),
      maxNominators: json.valueAsInt<int>('max_nominators'),
      minStake: json.valueAsBigInt<BigInt>('min_stake'),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String>('name')),
      nominatorsStake: json.valueAsBigInt<BigInt>('nominators_stake'),
      totalAmount: json.valueAsBigInt<BigInt>('total_amount'),
      validatorStake: json.valueAsBigInt<BigInt>('validator_stake'),
      verified: json.valueAsBool<bool>('verified'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'apy': apy,
    'current_nominators': currentNominators,
    'cycle_end': config.encodeBigint(cycleEnd),
    'cycle_length': config.encodeBigint(cycleLength),
    'cycle_start': config.encodeBigint(cycleStart),
    'implementation': implementation.toJson(config: config),
    'liquid_jetton_master': liquidJettonMaster,
    'max_nominators': maxNominators,
    'min_stake': config.encodeBigint(minStake),
    'name': name,
    'nominators_stake': config.encodeBigint(nominatorsStake),
    'total_amount': config.encodeBigint(totalAmount),
    'validator_stake': config.encodeBigint(validatorStake),
    'verified': verified,
  });
}

class Price {
  final CurrencyType currencyType;
  final int decimals;
  final String image;
  final String? jetton;
  final String tokenName;
  final String value;
  final TrustType verification;

  const Price({
    required this.currencyType,
    required this.decimals,
    required this.image,
    this.jetton,
    required this.tokenName,
    required this.value,
    required this.verification,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      currencyType: json.valueTo<CurrencyType, Object>(
        key: 'currency_type',
        parse: (e) => CurrencyType.fromJson(JsonParser.valueAs(e)),
      ),
      decimals: json.valueAsInt<int>('decimals'),
      image:
          (json['image'] is num
              ? json['image'].toString()
              : json.valueAsString<String>('image')),
      jetton:
          (json['jetton'] is num
              ? json['jetton'].toString()
              : json.valueAsString<String?>('jetton')),
      tokenName:
          (json['token_name'] is num
              ? json['token_name'].toString()
              : json.valueAsString<String>('token_name')),
      value:
          (json['value'] is num
              ? json['value'].toString()
              : json.valueAsString<String>('value')),
      verification: json.valueTo<TrustType, Object>(
        key: 'verification',
        parse: (e) => TrustType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'currency_type': currencyType.toJson(config: config),
    'decimals': decimals,
    'image': image,
    'jetton': jetton,
    'token_name': tokenName,
    'value': value,
    'verification': verification.toJson(config: config),
  });
}

class Protocol {
  final String? image;
  final String name;

  const Protocol({this.image, required this.name});

  factory Protocol.fromJson(Map<String, dynamic> json) {
    return Protocol(
      image:
          (json['image'] is num
              ? json['image'].toString()
              : json.valueAsString<String?>('image')),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String>('name')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'image': image, 'name': name});
}

class Purchase {
  final Price amount;
  final AccountAddress destination;
  final String eventId;
  final String invoiceId;
  final BigInt lt;
  final Metadata metadata;
  final AccountAddress source;
  final BigInt utime;

  const Purchase({
    required this.amount,
    required this.destination,
    required this.eventId,
    required this.invoiceId,
    required this.lt,
    required this.metadata,
    required this.source,
    required this.utime,
  });

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      amount: json.valueTo<Price, Map<String, dynamic>>(
        key: 'amount',
        parse: (v) => Price.fromJson(v),
      ),
      destination: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'destination',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      eventId:
          (json['event_id'] is num
              ? json['event_id'].toString()
              : json.valueAsString<String>('event_id')),
      invoiceId:
          (json['invoice_id'] is num
              ? json['invoice_id'].toString()
              : json.valueAsString<String>('invoice_id')),
      lt: json.valueAsBigInt<BigInt>('lt'),
      metadata: json.valueTo<Metadata, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
      source: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'source',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      utime: json.valueAsBigInt<BigInt>('utime'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount.toJson(config: config),
    'destination': destination.toJson(config: config),
    'event_id': eventId,
    'invoice_id': invoiceId,
    'lt': config.encodeBigint(lt),
    'metadata': metadata.toJson(config: config),
    'source': source.toJson(config: config),
    'utime': config.encodeBigint(utime),
  });
}

class PurchaseAction {
  final Price amount;
  final AccountAddress destination;
  final String invoiceId;
  final Metadata metadata;
  final AccountAddress source;

  const PurchaseAction({
    required this.amount,
    required this.destination,
    required this.invoiceId,
    required this.metadata,
    required this.source,
  });

  factory PurchaseAction.fromJson(Map<String, dynamic> json) {
    return PurchaseAction(
      amount: json.valueTo<Price, Map<String, dynamic>>(
        key: 'amount',
        parse: (v) => Price.fromJson(v),
      ),
      destination: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'destination',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      invoiceId:
          (json['invoice_id'] is num
              ? json['invoice_id'].toString()
              : json.valueAsString<String>('invoice_id')),
      metadata: json.valueTo<Metadata, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
      source: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'source',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount.toJson(config: config),
    'destination': destination.toJson(config: config),
    'invoice_id': invoiceId,
    'metadata': metadata.toJson(config: config),
    'source': source.toJson(config: config),
  });
}

/// GET /v2/blockchain/config/raw (response)
/// GET /v2/blockchain/masterchain/{masterchain_seqno}/config/raw (response)
class RawBlockchainConfig {
  final Map<String, dynamic> config;

  const RawBlockchainConfig({required this.config});

  factory RawBlockchainConfig.fromJson(Map<String, dynamic> json) {
    return RawBlockchainConfig(
      config: json.valueAsMap<Map<String, dynamic>>('config'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'config': this.config});
}

class ReducedBlock {
  final String? masterRef;
  final List<String> parent;
  final int seqno;
  final String shard;
  final List<String> shardsBlocks;
  final int txQuantity;
  final BigInt utime;
  final int workchainId;

  const ReducedBlock({
    this.masterRef,
    required this.parent,
    required this.seqno,
    required this.shard,
    required this.shardsBlocks,
    required this.txQuantity,
    required this.utime,
    required this.workchainId,
  });

  factory ReducedBlock.fromJson(Map<String, dynamic> json) {
    return ReducedBlock(
      masterRef:
          (json['master_ref'] is num
              ? json['master_ref'].toString()
              : json.valueAsString<String?>('master_ref')),
      parent: json.valueAsList<List<String>>('parent'),
      seqno: json.valueAsInt<int>('seqno'),
      shard:
          (json['shard'] is num
              ? json['shard'].toString()
              : json.valueAsString<String>('shard')),
      shardsBlocks: json.valueAsList<List<String>>('shards_blocks'),
      txQuantity: json.valueAsInt<int>('tx_quantity'),
      utime: json.valueAsBigInt<BigInt>('utime'),
      workchainId: json.valueAsInt<int>('workchain_id'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'master_ref': masterRef,
    'parent': parent,
    'seqno': seqno,
    'shard': shard,
    'shards_blocks': shardsBlocks,
    'tx_quantity': txQuantity,
    'utime': config.encodeBigint(utime),
    'workchain_id': workchainId,
  });
}

/// GET /v2/blockchain/reduced/blocks (response)
class ReducedBlocks {
  final List<ReducedBlock> blocks;

  const ReducedBlocks({required this.blocks});

  factory ReducedBlocks.fromJson(Map<String, dynamic> json) {
    return ReducedBlocks(
      blocks:
          json
              .valueEnsureAsList<Map<String, dynamic>>('blocks')
              .map((e) => ReducedBlock.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'blocks': blocks.map((e) => e.toJson(config: config)).toList(),
  });
}

class Refund {
  final String origin;
  final RefundType type;

  const Refund({required this.origin, required this.type});

  factory Refund.fromJson(Map<String, dynamic> json) {
    return Refund(
      origin:
          (json['origin'] is num
              ? json['origin'].toString()
              : json.valueAsString<String>('origin')),
      type: json.valueTo<RefundType, Object>(
        key: 'type',
        parse: (e) => RefundType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'origin': origin,
    'type': type.toJson(config: config),
  });
}

class RemoveExtensionAction {
  final String extension_;
  final AccountAddress wallet;

  const RemoveExtensionAction({required this.extension_, required this.wallet});

  factory RemoveExtensionAction.fromJson(Map<String, dynamic> json) {
    return RemoveExtensionAction(
      extension_:
          (json['extension'] is num
              ? json['extension'].toString()
              : json.valueAsString<String>('extension')),
      wallet: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'wallet',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'extension': extension_,
    'wallet': wallet.toJson(config: config),
  });
}

/// GET /v2/rewards/stats (response)
class RewardsStats {
  /// Time series of APY values as [timestamp_ms, apy] pairs
  final List<List<double>> apy;

  /// Time series of total stake in Gram as [timestamp_ms, stake] pairs
  final List<List<double>> totalStake;

  const RewardsStats({required this.apy, required this.totalStake});

  factory RewardsStats.fromJson(Map<String, dynamic> json) {
    return RewardsStats(
      apy:
          json
              .valueEnsureAsList<dynamic>('apy')
              .map(
                (e) =>
                    (e as List)
                        .map((e) => JsonParser.valueAsDouble<double>(e))
                        .toList(),
              )
              .toList(),
      totalStake:
          json
              .valueEnsureAsList<dynamic>('total_stake')
              .map(
                (e) =>
                    (e as List)
                        .map((e) => JsonParser.valueAsDouble<double>(e))
                        .toList(),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'apy': apy,
    'total_stake': totalStake,
  });
}

/// Conservative upper bound on assets this wallet may lose if the emulated message is sent and the counterparty behaves maliciously. Values may exceed current balances (e.g. already-authorized future receipts). For UI display only.
class Risk {
  /// Maximum Gram amount that may leave the wallet in the worst case, in nanogram.
  final BigInt gram;

  /// Jetton positions that may be debited from the wallet in the worst case.
  final List<JettonQuantity> jettons;

  /// NFT items that may be transferred out of the wallet in the worst case.
  final List<NftItem> nfts;

  /// this field will gone after Sept. 2026, use gram instead
  final BigInt? ton;

  /// Estimated equivalent of all assets at risk (Gram, jettons, NFTs) in the selected currency from currencyQuery (e.g. USD). Approximate, best-effort UI value.
  final double? totalEquivalent;

  /// True if the message semantics allow sweeping all current and future remaining Gram balance of the wallet (e.g. “send all” / drain patterns).
  final bool transferAllRemainingBalance;

  const Risk({
    required this.gram,
    required this.jettons,
    required this.nfts,
    this.ton,
    this.totalEquivalent,
    required this.transferAllRemainingBalance,
  });

  factory Risk.fromJson(Map<String, dynamic> json) {
    return Risk(
      gram: json.valueAsBigInt<BigInt>('gram'),
      jettons:
          json
              .valueEnsureAsList<Map<String, dynamic>>('jettons')
              .map((e) => JettonQuantity.fromJson(e))
              .toList(),
      nfts:
          json
              .valueEnsureAsList<Map<String, dynamic>>('nfts')
              .map((e) => NftItem.fromJson(e))
              .toList(),
      ton: json.valueAsBigInt<BigInt?>('ton'),
      totalEquivalent: json.valueAsDouble<double?>('total_equivalent'),
      transferAllRemainingBalance: json.valueAsBool<bool>(
        'transfer_all_remaining_balance',
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'gram': config.encodeBigint(gram),
    'jettons': jettons.map((e) => e.toJson(config: config)).toList(),
    'nfts': nfts.map((e) => e.toJson(config: config)).toList(),
    'ton': config.encodeBigint(ton),
    'total_equivalent': totalEquivalent,
    'transfer_all_remaining_balance': transferAllRemainingBalance,
  });
}

class RoundInfo {
  /// Masterchain block seqno at (or nearest to) validation round end.
  final int endBlock;
  final BigInt? endUtime;

  /// Masterchain block seqno at (or nearest to) validation round start.
  final int startBlock;
  final BigInt? startUtime;

  const RoundInfo({
    required this.endBlock,
    this.endUtime,
    required this.startBlock,
    this.startUtime,
  });

  factory RoundInfo.fromJson(Map<String, dynamic> json) {
    return RoundInfo(
      endBlock: json.valueAsInt<int>('end_block'),
      endUtime: json.valueAsBigInt<BigInt?>('end_utime'),
      startBlock: json.valueAsInt<int>('start_block'),
      startUtime: json.valueAsBigInt<BigInt?>('start_utime'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'end_block': endBlock,
    'end_utime': config.encodeBigint(endUtime),
    'start_block': startBlock,
    'start_utime': config.encodeBigint(startUtime),
  });
}

/// GET /v2/rewards/round-rewards (response)
class RoundRewardsResponse {
  /// Election ID (electAt timestamp).
  final BigInt electionId;

  /// Last masterchain block of the round.
  final int endBlock;
  final String? error;

  /// Election ID of the round immediately after this one.
  final BigInt? nextElectionId;

  /// Election ID of the round immediately before this one.
  final BigInt? prevElectionId;

  /// Server-side response time in milliseconds.
  final BigInt responseTimeMs;

  /// Validation round end time.
  final String roundEnd;

  /// Validation round start time.
  final String roundStart;

  /// First masterchain block of the round.
  final int startBlock;

  /// amount in nanograms
  final BigInt totalBonuses;

  /// amount in nanograms
  final BigInt totalStake;
  final List<ValidatorRewardEntry> validators;

  const RoundRewardsResponse({
    required this.electionId,
    required this.endBlock,
    this.error,
    this.nextElectionId,
    this.prevElectionId,
    required this.responseTimeMs,
    required this.roundEnd,
    required this.roundStart,
    required this.startBlock,
    required this.totalBonuses,
    required this.totalStake,
    required this.validators,
  });

  factory RoundRewardsResponse.fromJson(Map<String, dynamic> json) {
    return RoundRewardsResponse(
      electionId: json.valueAsBigInt<BigInt>('election_id'),
      endBlock: json.valueAsInt<int>('end_block'),
      error:
          (json['error'] is num
              ? json['error'].toString()
              : json.valueAsString<String?>('error')),
      nextElectionId: json.valueAsBigInt<BigInt?>('next_election_id'),
      prevElectionId: json.valueAsBigInt<BigInt?>('prev_election_id'),
      responseTimeMs: json.valueAsBigInt<BigInt>('response_time_ms'),
      roundEnd:
          (json['round_end'] is num
              ? json['round_end'].toString()
              : json.valueAsString<String>('round_end')),
      roundStart:
          (json['round_start'] is num
              ? json['round_start'].toString()
              : json.valueAsString<String>('round_start')),
      startBlock: json.valueAsInt<int>('start_block'),
      totalBonuses: json.valueAsBigInt<BigInt>('total_bonuses'),
      totalStake: json.valueAsBigInt<BigInt>('total_stake'),
      validators:
          json
              .valueEnsureAsList<Map<String, dynamic>>('validators')
              .map((e) => ValidatorRewardEntry.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'election_id': config.encodeBigint(electionId),
    'end_block': endBlock,
    'error': error,
    'next_election_id': config.encodeBigint(nextElectionId),
    'prev_election_id': config.encodeBigint(prevElectionId),
    'response_time_ms': config.encodeBigint(responseTimeMs),
    'round_end': roundEnd,
    'round_start': roundStart,
    'start_block': startBlock,
    'total_bonuses': config.encodeBigint(totalBonuses),
    'total_stake': config.encodeBigint(totalStake),
    'validators': validators.map((e) => e.toJson(config: config)).toList(),
  });
}

class Sale {
  final String address;
  final AccountAddress market;
  final AccountAddress? owner;
  final Price price;

  const Sale({
    required this.address,
    required this.market,
    this.owner,
    required this.price,
  });

  factory Sale.fromJson(Map<String, dynamic> json) {
    return Sale(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      market: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'market',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      owner: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'owner',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      price: json.valueTo<Price, Map<String, dynamic>>(
        key: 'price',
        parse: (v) => Price.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'market': market.toJson(config: config),
    'owner': owner?.toJson(config: config),
    'price': price.toJson(config: config),
  });
}

class ScaledUI {
  final String denominator;
  final String numerator;

  const ScaledUI({required this.denominator, required this.numerator});

  factory ScaledUI.fromJson(Map<String, dynamic> json) {
    return ScaledUI(
      denominator:
          (json['denominator'] is num
              ? json['denominator'].toString()
              : json.valueAsString<String>('denominator')),
      numerator:
          (json['numerator'] is num
              ? json['numerator'].toString()
              : json.valueAsString<String>('numerator')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'denominator': denominator,
    'numerator': numerator,
  });
}

/// GET /v2/wallet/{account_id}/seqno (response)
class Seqno {
  final int seqno;

  const Seqno({required this.seqno});

  factory Seqno.fromJson(Map<String, dynamic> json) {
    return Seqno(seqno: json.valueAsInt<int>('seqno'));
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'seqno': seqno});
}

/// GET /v2/status (response)
class ServiceStatus {
  final int indexingLatency;
  final int lastKnownMasterchainSeqno;
  final bool restOnline;

  const ServiceStatus({
    required this.indexingLatency,
    required this.lastKnownMasterchainSeqno,
    required this.restOnline,
  });

  factory ServiceStatus.fromJson(Map<String, dynamic> json) {
    return ServiceStatus(
      indexingLatency: json.valueAsInt<int>('indexing_latency'),
      lastKnownMasterchainSeqno: json.valueAsInt<int>(
        'last_known_masterchain_seqno',
      ),
      restOnline: json.valueAsBool<bool>('rest_online'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'indexing_latency': indexingLatency,
    'last_known_masterchain_seqno': lastKnownMasterchainSeqno,
    'rest_online': restOnline,
  });
}

class SetSignatureAllowedAction {
  final bool allowed;
  final AccountAddress wallet;

  const SetSignatureAllowedAction({
    required this.allowed,
    required this.wallet,
  });

  factory SetSignatureAllowedAction.fromJson(Map<String, dynamic> json) {
    return SetSignatureAllowedAction(
      allowed: json.valueAsBool<bool>('allowed'),
      wallet: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'wallet',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'allowed': allowed,
    'wallet': wallet.toJson(config: config),
  });
}

class SignRawMessage {
  final String address;

  /// Number of nanocoins to send. Decimal string.
  final String amount;

  /// Raw one-cell BoC encoded in hex.
  final String? payload;

  /// Raw once-cell BoC encoded in hex.
  final String? stateInit;

  const SignRawMessage({
    required this.address,
    required this.amount,
    this.payload,
    this.stateInit,
  });

  factory SignRawMessage.fromJson(Map<String, dynamic> json) {
    return SignRawMessage(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      payload:
          (json['payload'] is num
              ? json['payload'].toString()
              : json.valueAsString<String?>('payload')),
      stateInit:
          (json['stateInit'] is num
              ? json['stateInit'].toString()
              : json.valueAsString<String?>('stateInit')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'amount': amount,
    'payload': payload,
    'stateInit': stateInit,
  });
}

/// POST /v2/gasless/estimate/{master_id} (response)
class SignRawParams {
  /// Commission for the transaction. In nanocoins.
  final String commission;
  final MessageConsequences? emulation;
  final String from;
  final List<SignRawMessage> messages;
  final String protocolName;
  final String relayAddress;
  final BigInt validUntil;

  const SignRawParams({
    required this.commission,
    this.emulation,
    required this.from,
    required this.messages,
    required this.protocolName,
    required this.relayAddress,
    required this.validUntil,
  });

  factory SignRawParams.fromJson(Map<String, dynamic> json) {
    return SignRawParams(
      commission:
          (json['commission'] is num
              ? json['commission'].toString()
              : json.valueAsString<String>('commission')),
      emulation: json.valueTo<MessageConsequences?, Map<String, dynamic>>(
        key: 'emulation',
        parse: (v) => MessageConsequences.fromJson(v),
      ),
      from:
          (json['from'] is num
              ? json['from'].toString()
              : json.valueAsString<String>('from')),
      messages:
          json
              .valueEnsureAsList<Map<String, dynamic>>('messages')
              .map((e) => SignRawMessage.fromJson(e))
              .toList(),
      protocolName:
          (json['protocol_name'] is num
              ? json['protocol_name'].toString()
              : json.valueAsString<String>('protocol_name')),
      relayAddress:
          (json['relay_address'] is num
              ? json['relay_address'].toString()
              : json.valueAsString<String>('relay_address')),
      validUntil: json.valueAsBigInt<BigInt>('valid_until'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'commission': commission,
    'emulation': emulation?.toJson(config: config),
    'from': from,
    'messages': messages.map((e) => e.toJson(config: config)).toList(),
    'protocol_name': protocolName,
    'relay_address': relayAddress,
    'valid_until': config.encodeBigint(validUntil),
  });
}

class SizeLimitsConfig {
  final BigInt? maxAccStateBits;
  final BigInt? maxAccStateCells;
  final int maxExtMsgDepth;
  final BigInt maxExtMsgSize;
  final BigInt maxLibraryCells;
  final BigInt maxMsgBits;
  final BigInt maxMsgCells;
  final int maxVmDataDepth;

  const SizeLimitsConfig({
    this.maxAccStateBits,
    this.maxAccStateCells,
    required this.maxExtMsgDepth,
    required this.maxExtMsgSize,
    required this.maxLibraryCells,
    required this.maxMsgBits,
    required this.maxMsgCells,
    required this.maxVmDataDepth,
  });

  factory SizeLimitsConfig.fromJson(Map<String, dynamic> json) {
    return SizeLimitsConfig(
      maxAccStateBits: json.valueAsBigInt<BigInt?>('max_acc_state_bits'),
      maxAccStateCells: json.valueAsBigInt<BigInt?>('max_acc_state_cells'),
      maxExtMsgDepth: json.valueAsInt<int>('max_ext_msg_depth'),
      maxExtMsgSize: json.valueAsBigInt<BigInt>('max_ext_msg_size'),
      maxLibraryCells: json.valueAsBigInt<BigInt>('max_library_cells'),
      maxMsgBits: json.valueAsBigInt<BigInt>('max_msg_bits'),
      maxMsgCells: json.valueAsBigInt<BigInt>('max_msg_cells'),
      maxVmDataDepth: json.valueAsInt<int>('max_vm_data_depth'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'max_acc_state_bits': config.encodeBigint(maxAccStateBits),
    'max_acc_state_cells': config.encodeBigint(maxAccStateCells),
    'max_ext_msg_depth': maxExtMsgDepth,
    'max_ext_msg_size': config.encodeBigint(maxExtMsgSize),
    'max_library_cells': config.encodeBigint(maxLibraryCells),
    'max_msg_bits': config.encodeBigint(maxMsgBits),
    'max_msg_cells': config.encodeBigint(maxMsgCells),
    'max_vm_data_depth': maxVmDataDepth,
  });
}

class SmartContractAction {
  final AccountAddress contract;
  final AccountAddress executor;

  /// amount in nanograms
  final BigInt gramAttached;
  final String operation;
  final String? payload;
  final Refund? refund;

  /// amount in nanograms
  final BigInt? tonAttached;

  const SmartContractAction({
    required this.contract,
    required this.executor,
    required this.gramAttached,
    required this.operation,
    this.payload,
    this.refund,
    this.tonAttached,
  });

  factory SmartContractAction.fromJson(Map<String, dynamic> json) {
    return SmartContractAction(
      contract: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'contract',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      executor: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'executor',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      gramAttached: json.valueAsBigInt<BigInt>('gram_attached'),
      operation:
          (json['operation'] is num
              ? json['operation'].toString()
              : json.valueAsString<String>('operation')),
      payload:
          (json['payload'] is num
              ? json['payload'].toString()
              : json.valueAsString<String?>('payload')),
      refund: json.valueTo<Refund?, Map<String, dynamic>>(
        key: 'refund',
        parse: (v) => Refund.fromJson(v),
      ),
      tonAttached: json.valueAsBigInt<BigInt?>('ton_attached'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'contract': contract.toJson(config: config),
    'executor': executor.toJson(config: config),
    'gram_attached': config.encodeBigint(gramAttached),
    'operation': operation,
    'payload': payload,
    'refund': refund?.toJson(config: config),
    'ton_attached': config.encodeBigint(tonAttached),
  });
}

class Source {
  final List<SourceFile> files;

  const Source({required this.files});

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      files:
          json
              .valueEnsureAsList<Map<String, dynamic>>('files')
              .map((e) => SourceFile.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'files': files.map((e) => e.toJson(config: config)).toList(),
  });
}

class SourceFile {
  final String content;
  final bool includeInCommand;
  final bool isEntrypoint;
  final bool isStdLib;
  final String name;

  const SourceFile({
    required this.content,
    required this.includeInCommand,
    required this.isEntrypoint,
    required this.isStdLib,
    required this.name,
  });

  factory SourceFile.fromJson(Map<String, dynamic> json) {
    return SourceFile(
      content:
          (json['content'] is num
              ? json['content'].toString()
              : json.valueAsString<String>('content')),
      includeInCommand: json.valueAsBool<bool>('include_in_command'),
      isEntrypoint: json.valueAsBool<bool>('is_entrypoint'),
      isStdLib: json.valueAsBool<bool>('is_std_lib'),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String>('name')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'content': content,
    'include_in_command': includeInCommand,
    'is_entrypoint': isEntrypoint,
    'is_std_lib': isStdLib,
    'name': name,
  });
}

class StateInit {
  final String boc;
  final List<String> interfaces;

  const StateInit({required this.boc, required this.interfaces});

  factory StateInit.fromJson(Map<String, dynamic> json) {
    return StateInit(
      boc:
          (json['boc'] is num
              ? json['boc'].toString()
              : json.valueAsString<String>('boc')),
      interfaces: json.valueAsList<List<String>>('interfaces'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) =>
      config.encodeMap(<String, dynamic>{'boc': boc, 'interfaces': interfaces});
}

class StoragePhase {
  final BigInt feesCollected;
  final BigInt? feesDue;
  final AccStatusChange statusChange;

  const StoragePhase({
    required this.feesCollected,
    this.feesDue,
    required this.statusChange,
  });

  factory StoragePhase.fromJson(Map<String, dynamic> json) {
    return StoragePhase(
      feesCollected: json.valueAsBigInt<BigInt>('fees_collected'),
      feesDue: json.valueAsBigInt<BigInt?>('fees_due'),
      statusChange: json.valueTo<AccStatusChange, Object>(
        key: 'status_change',
        parse: (e) => AccStatusChange.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'fees_collected': config.encodeBigint(feesCollected),
    'fees_due': config.encodeBigint(feesDue),
    'status_change': statusChange.toJson(config: config),
  });
}

class StorageProvider {
  final bool acceptNewContracts;
  final String address;
  final BigInt maxSpan;
  final BigInt maximalFileSize;
  final BigInt minimalFileSize;
  final BigInt ratePerMbDay;

  const StorageProvider({
    required this.acceptNewContracts,
    required this.address,
    required this.maxSpan,
    required this.maximalFileSize,
    required this.minimalFileSize,
    required this.ratePerMbDay,
  });

  factory StorageProvider.fromJson(Map<String, dynamic> json) {
    return StorageProvider(
      acceptNewContracts: json.valueAsBool<bool>('accept_new_contracts'),
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      maxSpan: json.valueAsBigInt<BigInt>('max_span'),
      maximalFileSize: json.valueAsBigInt<BigInt>('maximal_file_size'),
      minimalFileSize: json.valueAsBigInt<BigInt>('minimal_file_size'),
      ratePerMbDay: json.valueAsBigInt<BigInt>('rate_per_mb_day'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'accept_new_contracts': acceptNewContracts,
    'address': address,
    'max_span': config.encodeBigint(maxSpan),
    'maximal_file_size': config.encodeBigint(maximalFileSize),
    'minimal_file_size': config.encodeBigint(minimalFileSize),
    'rate_per_mb_day': config.encodeBigint(ratePerMbDay),
  });
}

class Subscription {
  final String? address;
  final AccountAddress? admin;
  final AccountAddress? beneficiary;
  final Metadata metadata;
  final BigInt nextChargeAt;
  final Price paymentPerPeriod;

  /// payment period in seconds
  final BigInt period;
  final SubscriptionStatus status;

  /// common identifier
  final String subscriptionId;

  /// type of subscription
  final String type;
  final AccountAddress wallet;

  const Subscription({
    this.address,
    this.admin,
    this.beneficiary,
    required this.metadata,
    required this.nextChargeAt,
    required this.paymentPerPeriod,
    required this.period,
    required this.status,
    required this.subscriptionId,
    required this.type,
    required this.wallet,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      admin: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'admin',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      beneficiary: json.valueTo<AccountAddress?, Map<String, dynamic>>(
        key: 'beneficiary',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      metadata: json.valueTo<Metadata, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
      nextChargeAt: json.valueAsBigInt<BigInt>('next_charge_at'),
      paymentPerPeriod: json.valueTo<Price, Map<String, dynamic>>(
        key: 'payment_per_period',
        parse: (v) => Price.fromJson(v),
      ),
      period: json.valueAsBigInt<BigInt>('period'),
      status: json.valueTo<SubscriptionStatus, Object>(
        key: 'status',
        parse: (e) => SubscriptionStatus.fromJson(JsonParser.valueAs(e)),
      ),
      subscriptionId:
          (json['subscription_id'] is num
              ? json['subscription_id'].toString()
              : json.valueAsString<String>('subscription_id')),
      type:
          (json['type'] is num
              ? json['type'].toString()
              : json.valueAsString<String>('type')),
      wallet: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'wallet',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'admin': admin?.toJson(config: config),
    'beneficiary': beneficiary?.toJson(config: config),
    'metadata': metadata.toJson(config: config),
    'next_charge_at': config.encodeBigint(nextChargeAt),
    'payment_per_period': paymentPerPeriod.toJson(config: config),
    'period': config.encodeBigint(period),
    'status': status.toJson(config: config),
    'subscription_id': subscriptionId,
    'type': type,
    'wallet': wallet.toJson(config: config),
  });
}

class SubscriptionAction {
  final AccountAddress admin;
  final BigInt? amount;
  final AccountAddress beneficiary;
  final bool initial;
  final Price price;
  final AccountAddress subscriber;
  final String subscription;

  const SubscriptionAction({
    required this.admin,
    this.amount,
    required this.beneficiary,
    required this.initial,
    required this.price,
    required this.subscriber,
    required this.subscription,
  });

  factory SubscriptionAction.fromJson(Map<String, dynamic> json) {
    return SubscriptionAction(
      admin: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'admin',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      amount: json.valueAsBigInt<BigInt?>('amount'),
      beneficiary: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'beneficiary',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      initial: json.valueAsBool<bool>('initial'),
      price: json.valueTo<Price, Map<String, dynamic>>(
        key: 'price',
        parse: (v) => Price.fromJson(v),
      ),
      subscriber: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'subscriber',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      subscription:
          (json['subscription'] is num
              ? json['subscription'].toString()
              : json.valueAsString<String>('subscription')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'admin': admin.toJson(config: config),
    'amount': config.encodeBigint(amount),
    'beneficiary': beneficiary.toJson(config: config),
    'initial': initial,
    'price': price.toJson(config: config),
    'subscriber': subscriber.toJson(config: config),
    'subscription': subscription,
  });
}

/// GET /v2/accounts/{account_id}/subscriptions (response)
class Subscriptions {
  final List<Subscription> subscriptions;

  const Subscriptions({required this.subscriptions});

  factory Subscriptions.fromJson(Map<String, dynamic> json) {
    return Subscriptions(
      subscriptions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('subscriptions')
              .map((e) => Subscription.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'subscriptions':
        subscriptions.map((e) => e.toJson(config: config)).toList(),
  });
}

class TokenRates {
  final Map<String, String>? diff24h;
  final Map<String, String>? diff30d;
  final Map<String, String>? diff7d;
  final Map<String, num>? prices;

  const TokenRates({this.diff24h, this.diff30d, this.diff7d, this.prices});

  factory TokenRates.fromJson(Map<String, dynamic> json) {
    return TokenRates(
      diff24h:
          json.hasValue('diff_24h')
              ? json
                  .valueEnsureAsMap<String, dynamic>('diff_24h')
                  .map(
                    (k, v) => MapEntry(
                      k,
                      (v is num
                          ? v.toString()
                          : JsonParser.valueAsString<String>(v)),
                    ),
                  )
              : null,
      diff30d:
          json.hasValue('diff_30d')
              ? json
                  .valueEnsureAsMap<String, dynamic>('diff_30d')
                  .map(
                    (k, v) => MapEntry(
                      k,
                      (v is num
                          ? v.toString()
                          : JsonParser.valueAsString<String>(v)),
                    ),
                  )
              : null,
      diff7d:
          json.hasValue('diff_7d')
              ? json
                  .valueEnsureAsMap<String, dynamic>('diff_7d')
                  .map(
                    (k, v) => MapEntry(
                      k,
                      (v is num
                          ? v.toString()
                          : JsonParser.valueAsString<String>(v)),
                    ),
                  )
              : null,
      prices:
          json.hasValue('prices')
              ? json
                  .valueEnsureAsMap<String, dynamic>('prices')
                  .map((k, v) => MapEntry(k, JsonParser.valueAsNum<num>(v)))
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'diff_24h': diff24h,
    'diff_30d': diff30d,
    'diff_7d': diff7d,
    'prices': prices,
  });
}

class TonTransferAction {
  /// amount in nanograms
  final BigInt amount;
  final String? comment;
  final EncryptedComment? encryptedComment;
  final AccountAddress recipient;
  final Refund? refund;
  final AccountAddress sender;

  const TonTransferAction({
    required this.amount,
    this.comment,
    this.encryptedComment,
    required this.recipient,
    this.refund,
    required this.sender,
  });

  factory TonTransferAction.fromJson(Map<String, dynamic> json) {
    return TonTransferAction(
      amount: json.valueAsBigInt<BigInt>('amount'),
      comment:
          (json['comment'] is num
              ? json['comment'].toString()
              : json.valueAsString<String?>('comment')),
      encryptedComment: json.valueTo<EncryptedComment?, Map<String, dynamic>>(
        key: 'encrypted_comment',
        parse: (v) => EncryptedComment.fromJson(v),
      ),
      recipient: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'recipient',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      refund: json.valueTo<Refund?, Map<String, dynamic>>(
        key: 'refund',
        parse: (v) => Refund.fromJson(v),
      ),
      sender: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'sender',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': config.encodeBigint(amount),
    'comment': comment,
    'encrypted_comment': encryptedComment?.toJson(config: config),
    'recipient': recipient.toJson(config: config),
    'refund': refund?.toJson(config: config),
    'sender': sender.toJson(config: config),
  });
}

/// POST /v2/traces/emulate (response)
/// GET /v2/traces/{trace_id} (response)
class Trace {
  final List<Trace>? children;
  final bool? emulated;
  final List<String> interfaces;
  final Transaction transaction;

  const Trace({
    this.children,
    this.emulated,
    required this.interfaces,
    required this.transaction,
  });

  factory Trace.fromJson(Map<String, dynamic> json) {
    return Trace(
      children:
          json.hasValue('children')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('children')
                  .map((e) => Trace.fromJson(e))
                  .toList()
              : null,
      emulated: json.valueAsBool<bool?>('emulated'),
      interfaces: json.valueAsList<List<String>>('interfaces'),
      transaction: json.valueTo<Transaction, Map<String, dynamic>>(
        key: 'transaction',
        parse: (v) => Transaction.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'children': children?.map((e) => e.toJson(config: config)).toList(),
    'emulated': emulated,
    'interfaces': interfaces,
    'transaction': transaction.toJson(config: config),
  });
}

class TraceID {
  final String id;
  final BigInt utime;

  const TraceID({required this.id, required this.utime});

  factory TraceID.fromJson(Map<String, dynamic> json) {
    return TraceID(
      id:
          (json['id'] is num
              ? json['id'].toString()
              : json.valueAsString<String>('id')),
      utime: json.valueAsBigInt<BigInt>('utime'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'id': id,
    'utime': config.encodeBigint(utime),
  });
}

/// GET /v2/accounts/{account_id}/traces (response)
class TraceIDs {
  final List<TraceID> traces;

  const TraceIDs({required this.traces});

  factory TraceIDs.fromJson(Map<String, dynamic> json) {
    return TraceIDs(
      traces:
          json
              .valueEnsureAsList<Map<String, dynamic>>('traces')
              .map((e) => TraceID.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'traces': traces.map((e) => e.toJson(config: config)).toList(),
  });
}

/// GET /v2/blockchain/messages/{msg_id}/transaction (response)
/// GET /v2/blockchain/transactions/{transaction_id} (response)
class Transaction {
  final bool aborted;
  final AccountAddress account;
  final ActionPhase? actionPhase;
  final String block;
  final BouncePhaseType? bouncePhase;
  final ComputePhase? computePhase;
  final CreditPhase? creditPhase;
  final bool destroyed;
  final BigInt endBalance;
  final AccountStatus endStatus;
  final String hash;
  final Message? inMsg;
  final BigInt lt;
  final AccountStatus origStatus;
  final List<Message> outMsgs;
  final String? prevTransHash;
  final BigInt? prevTransLt;

  /// hex encoded boc with raw transaction
  final String raw;
  final String stateUpdateNew;
  final String stateUpdateOld;
  final StoragePhase? storagePhase;
  final bool success;
  final BigInt totalFees;
  final TransactionType transactionType;
  final BigInt utime;

  const Transaction({
    required this.aborted,
    required this.account,
    this.actionPhase,
    required this.block,
    this.bouncePhase,
    this.computePhase,
    this.creditPhase,
    required this.destroyed,
    required this.endBalance,
    required this.endStatus,
    required this.hash,
    this.inMsg,
    required this.lt,
    required this.origStatus,
    required this.outMsgs,
    this.prevTransHash,
    this.prevTransLt,
    required this.raw,
    required this.stateUpdateNew,
    required this.stateUpdateOld,
    this.storagePhase,
    required this.success,
    required this.totalFees,
    required this.transactionType,
    required this.utime,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      aborted: json.valueAsBool<bool>('aborted'),
      account: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'account',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      actionPhase: json.valueTo<ActionPhase?, Map<String, dynamic>>(
        key: 'action_phase',
        parse: (v) => ActionPhase.fromJson(v),
      ),
      block:
          (json['block'] is num
              ? json['block'].toString()
              : json.valueAsString<String>('block')),
      bouncePhase: json.valueTo<BouncePhaseType?, Object>(
        key: 'bounce_phase',
        parse: (e) => BouncePhaseType.fromJson(JsonParser.valueAs(e)),
      ),
      computePhase: json.valueTo<ComputePhase?, Map<String, dynamic>>(
        key: 'compute_phase',
        parse: (v) => ComputePhase.fromJson(v),
      ),
      creditPhase: json.valueTo<CreditPhase?, Map<String, dynamic>>(
        key: 'credit_phase',
        parse: (v) => CreditPhase.fromJson(v),
      ),
      destroyed: json.valueAsBool<bool>('destroyed'),
      endBalance: json.valueAsBigInt<BigInt>('end_balance'),
      endStatus: json.valueTo<AccountStatus, Object>(
        key: 'end_status',
        parse: (e) => AccountStatus.fromJson(JsonParser.valueAs(e)),
      ),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String>('hash')),
      inMsg: json.valueTo<Message?, Map<String, dynamic>>(
        key: 'in_msg',
        parse: (v) => Message.fromJson(v),
      ),
      lt: json.valueAsBigInt<BigInt>('lt'),
      origStatus: json.valueTo<AccountStatus, Object>(
        key: 'orig_status',
        parse: (e) => AccountStatus.fromJson(JsonParser.valueAs(e)),
      ),
      outMsgs:
          json
              .valueEnsureAsList<Map<String, dynamic>>('out_msgs')
              .map((e) => Message.fromJson(e))
              .toList(),
      prevTransHash:
          (json['prev_trans_hash'] is num
              ? json['prev_trans_hash'].toString()
              : json.valueAsString<String?>('prev_trans_hash')),
      prevTransLt: json.valueAsBigInt<BigInt?>('prev_trans_lt'),
      raw:
          (json['raw'] is num
              ? json['raw'].toString()
              : json.valueAsString<String>('raw')),
      stateUpdateNew:
          (json['state_update_new'] is num
              ? json['state_update_new'].toString()
              : json.valueAsString<String>('state_update_new')),
      stateUpdateOld:
          (json['state_update_old'] is num
              ? json['state_update_old'].toString()
              : json.valueAsString<String>('state_update_old')),
      storagePhase: json.valueTo<StoragePhase?, Map<String, dynamic>>(
        key: 'storage_phase',
        parse: (v) => StoragePhase.fromJson(v),
      ),
      success: json.valueAsBool<bool>('success'),
      totalFees: json.valueAsBigInt<BigInt>('total_fees'),
      transactionType: json.valueTo<TransactionType, Object>(
        key: 'transaction_type',
        parse: (e) => TransactionType.fromJson(JsonParser.valueAs(e)),
      ),
      utime: json.valueAsBigInt<BigInt>('utime'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'aborted': aborted,
    'account': account.toJson(config: config),
    'action_phase': actionPhase?.toJson(config: config),
    'block': block,
    'bounce_phase': bouncePhase?.toJson(config: config),
    'compute_phase': computePhase?.toJson(config: config),
    'credit_phase': creditPhase?.toJson(config: config),
    'destroyed': destroyed,
    'end_balance': config.encodeBigint(endBalance),
    'end_status': endStatus.toJson(config: config),
    'hash': hash,
    'in_msg': inMsg?.toJson(config: config),
    'lt': config.encodeBigint(lt),
    'orig_status': origStatus.toJson(config: config),
    'out_msgs': outMsgs.map((e) => e.toJson(config: config)).toList(),
    'prev_trans_hash': prevTransHash,
    'prev_trans_lt': config.encodeBigint(prevTransLt),
    'raw': raw,
    'state_update_new': stateUpdateNew,
    'state_update_old': stateUpdateOld,
    'storage_phase': storagePhase?.toJson(config: config),
    'success': success,
    'total_fees': config.encodeBigint(totalFees),
    'transaction_type': transactionType.toJson(config: config),
    'utime': config.encodeBigint(utime),
  });
}

/// GET /v2/blockchain/accounts/{account_id}/transactions (response)
/// GET /v2/blockchain/blocks/{block_id}/transactions (response)
/// GET /v2/blockchain/masterchain/{masterchain_seqno}/transactions (response)
class Transactions {
  final List<Transaction> transactions;

  const Transactions({required this.transactions});

  factory Transactions.fromJson(Map<String, dynamic> json) {
    return Transactions(
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('transactions')
              .map((e) => Transaction.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'transactions': transactions.map((e) => e.toJson(config: config)).toList(),
  });
}

class TvmStackRecord {
  final String? cell;
  final String? num_;
  final String? slice;
  final List<TvmStackRecord>? tuple;
  final TvmStackRecordType type;

  const TvmStackRecord({
    this.cell,
    this.num_,
    this.slice,
    this.tuple,
    required this.type,
  });

  factory TvmStackRecord.fromJson(Map<String, dynamic> json) {
    return TvmStackRecord(
      cell:
          (json['cell'] is num
              ? json['cell'].toString()
              : json.valueAsString<String?>('cell')),
      num_:
          (json['num'] is num
              ? json['num'].toString()
              : json.valueAsString<String?>('num')),
      slice:
          (json['slice'] is num
              ? json['slice'].toString()
              : json.valueAsString<String?>('slice')),
      tuple:
          json.hasValue('tuple')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('tuple')
                  .map((e) => TvmStackRecord.fromJson(e))
                  .toList()
              : null,
      type: json.valueTo<TvmStackRecordType, Object>(
        key: 'type',
        parse: (e) => TvmStackRecordType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'cell': cell,
    'num': num_,
    'slice': slice,
    'tuple': tuple?.map((e) => e.toJson(config: config)).toList(),
    'type': type.toJson(config: config),
  });
}

class UnSubscriptionAction {
  final AccountAddress admin;
  final AccountAddress beneficiary;
  final AccountAddress subscriber;
  final String subscription;

  const UnSubscriptionAction({
    required this.admin,
    required this.beneficiary,
    required this.subscriber,
    required this.subscription,
  });

  factory UnSubscriptionAction.fromJson(Map<String, dynamic> json) {
    return UnSubscriptionAction(
      admin: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'admin',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      beneficiary: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'beneficiary',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      subscriber: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'subscriber',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      subscription:
          (json['subscription'] is num
              ? json['subscription'].toString()
              : json.valueAsString<String>('subscription')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'admin': admin.toJson(config: config),
    'beneficiary': beneficiary.toJson(config: config),
    'subscriber': subscriber.toJson(config: config),
    'subscription': subscription,
  });
}

class ValidationRound {
  /// Total rewards the elector pays for the round. Omitted if round hasn't finished.
  final BigInt? bonuses;

  /// Election ID (electAt timestamp).
  final BigInt electionId;

  /// Masterchain block seqno at (or nearest to) round end. Omitted if round hasn't finished.
  final int? endBlock;
  final BigInt? endUtime;

  /// Whether the validation round is complete.
  final bool finished;

  /// Election ID of the round immediately after this one. Omitted when this round is not yet finished (next round not known).
  final BigInt? nextElectionId;

  /// Election ID of the round immediately before this one.
  final BigInt? prevElectionId;

  /// Masterchain block seqno at (or nearest to) round start.
  final int startBlock;
  final BigInt? startUtime;

  /// Total stake locked in the round.
  final BigInt? totalStake;

  const ValidationRound({
    this.bonuses,
    required this.electionId,
    this.endBlock,
    this.endUtime,
    required this.finished,
    this.nextElectionId,
    this.prevElectionId,
    required this.startBlock,
    this.startUtime,
    this.totalStake,
  });

  factory ValidationRound.fromJson(Map<String, dynamic> json) {
    return ValidationRound(
      bonuses: json.valueAsBigInt<BigInt?>('bonuses'),
      electionId: json.valueAsBigInt<BigInt>('election_id'),
      endBlock: json.valueAsInt<int?>('end_block'),
      endUtime: json.valueAsBigInt<BigInt?>('end_utime'),
      finished: json.valueAsBool<bool>('finished'),
      nextElectionId: json.valueAsBigInt<BigInt?>('next_election_id'),
      prevElectionId: json.valueAsBigInt<BigInt?>('prev_election_id'),
      startBlock: json.valueAsInt<int>('start_block'),
      startUtime: json.valueAsBigInt<BigInt?>('start_utime'),
      totalStake: json.valueAsBigInt<BigInt?>('total_stake'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bonuses': config.encodeBigint(bonuses),
    'election_id': config.encodeBigint(electionId),
    'end_block': endBlock,
    'end_utime': config.encodeBigint(endUtime),
    'finished': finished,
    'next_election_id': config.encodeBigint(nextElectionId),
    'prev_election_id': config.encodeBigint(prevElectionId),
    'start_block': startBlock,
    'start_utime': config.encodeBigint(startUtime),
    'total_stake': config.encodeBigint(totalStake),
  });
}

/// GET /v2/rewards/validation-rounds (response)
class ValidationRoundsResponse {
  /// Server-side response time in milliseconds.
  final BigInt responseTimeMs;
  final List<ValidationRound> rounds;

  const ValidationRoundsResponse({
    required this.responseTimeMs,
    required this.rounds,
  });

  factory ValidationRoundsResponse.fromJson(Map<String, dynamic> json) {
    return ValidationRoundsResponse(
      responseTimeMs: json.valueAsBigInt<BigInt>('response_time_ms'),
      rounds:
          json
              .valueEnsureAsList<Map<String, dynamic>>('rounds')
              .map((e) => ValidationRound.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'response_time_ms': config.encodeBigint(responseTimeMs),
    'rounds': rounds.map((e) => e.toJson(config: config)).toList(),
  });
}

class Validator {
  final String address;
  final String adnlAddress;
  final BigInt maxFactor;
  final BigInt stake;

  const Validator({
    required this.address,
    required this.adnlAddress,
    required this.maxFactor,
    required this.stake,
  });

  factory Validator.fromJson(Map<String, dynamic> json) {
    return Validator(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      adnlAddress:
          (json['adnl_address'] is num
              ? json['adnl_address'].toString()
              : json.valueAsString<String>('adnl_address')),
      maxFactor: json.valueAsBigInt<BigInt>('max_factor'),
      stake: json.valueAsBigInt<BigInt>('stake'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'adnl_address': adnlAddress,
    'max_factor': config.encodeBigint(maxFactor),
    'stake': config.encodeBigint(stake),
  });
}

class ValidatorRewardEntry {
  /// amount in nanograms
  final BigInt effectiveStake;
  final List<NominatorRewardEntry>? nominators;
  final int? nominatorsCount;

  /// amount in nanograms
  final BigInt? nominatorsStake;
  final String? ownerAddress;

  /// Pool smart contract address (bounceable, base64url).
  final String? pool;

  /// Contract type detected by code hash.
  final ValidatorRewardEntryPoolType? poolType;

  /// Validator's public key (hex-encoded Ed25519).
  final String publicKey;

  /// Position sorted by effective stake (descending).
  final int rank;

  /// amount in nanograms
  final BigInt reward;

  /// Total funds deposited by the pool: effective_stake + credit (leftover balance kept in the elector contract after election).
  final BigInt? totalStake;
  final String? validatorAddress;

  /// Fraction of staking rewards kept by the validator (0.3 = 30%).
  final double? validatorRewardShare;

  /// amount in nanograms
  final BigInt? validatorStake;

  /// Fraction of total effective stake (0–1).
  final double weight;

  const ValidatorRewardEntry({
    required this.effectiveStake,
    this.nominators,
    this.nominatorsCount,
    this.nominatorsStake,
    this.ownerAddress,
    this.pool,
    this.poolType,
    required this.publicKey,
    required this.rank,
    required this.reward,
    this.totalStake,
    this.validatorAddress,
    this.validatorRewardShare,
    this.validatorStake,
    required this.weight,
  });

  factory ValidatorRewardEntry.fromJson(Map<String, dynamic> json) {
    return ValidatorRewardEntry(
      effectiveStake: json.valueAsBigInt<BigInt>('effective_stake'),
      nominators:
          json.hasValue('nominators')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('nominators')
                  .map((e) => NominatorRewardEntry.fromJson(e))
                  .toList()
              : null,
      nominatorsCount: json.valueAsInt<int?>('nominators_count'),
      nominatorsStake: json.valueAsBigInt<BigInt?>('nominators_stake'),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString<String?>('owner_address')),
      pool:
          (json['pool'] is num
              ? json['pool'].toString()
              : json.valueAsString<String?>('pool')),
      poolType: json.valueTo<ValidatorRewardEntryPoolType?, Object>(
        key: 'pool_type',
        parse:
            (e) => ValidatorRewardEntryPoolType.fromJson(JsonParser.valueAs(e)),
      ),
      publicKey:
          (json['public_key'] is num
              ? json['public_key'].toString()
              : json.valueAsString<String>('public_key')),
      rank: json.valueAsInt<int>('rank'),
      reward: json.valueAsBigInt<BigInt>('reward'),
      totalStake: json.valueAsBigInt<BigInt?>('total_stake'),
      validatorAddress:
          (json['validator_address'] is num
              ? json['validator_address'].toString()
              : json.valueAsString<String?>('validator_address')),
      validatorRewardShare: json.valueAsDouble<double?>(
        'validator_reward_share',
      ),
      validatorStake: json.valueAsBigInt<BigInt?>('validator_stake'),
      weight: json.valueAsDouble<double>('weight'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'effective_stake': config.encodeBigint(effectiveStake),
    'nominators': nominators?.map((e) => e.toJson(config: config)).toList(),
    'nominators_count': nominatorsCount,
    'nominators_stake': config.encodeBigint(nominatorsStake),
    'owner_address': ownerAddress,
    'pool': pool,
    'pool_type': poolType?.toJson(config: config),
    'public_key': publicKey,
    'rank': rank,
    'reward': config.encodeBigint(reward),
    'total_stake': config.encodeBigint(totalStake),
    'validator_address': validatorAddress,
    'validator_reward_share': validatorRewardShare,
    'validator_stake': config.encodeBigint(validatorStake),
    'weight': weight,
  });
}

/// GET /v2/blockchain/validators (response)
class Validators {
  final BigInt electAt;
  final BigInt electClose;
  final BigInt minStake;
  final BigInt totalStake;
  final List<Validator> validators;

  const Validators({
    required this.electAt,
    required this.electClose,
    required this.minStake,
    required this.totalStake,
    required this.validators,
  });

  factory Validators.fromJson(Map<String, dynamic> json) {
    return Validators(
      electAt: json.valueAsBigInt<BigInt>('elect_at'),
      electClose: json.valueAsBigInt<BigInt>('elect_close'),
      minStake: json.valueAsBigInt<BigInt>('min_stake'),
      totalStake: json.valueAsBigInt<BigInt>('total_stake'),
      validators:
          json
              .valueEnsureAsList<Map<String, dynamic>>('validators')
              .map((e) => Validator.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'elect_at': config.encodeBigint(electAt),
    'elect_close': config.encodeBigint(electClose),
    'min_stake': config.encodeBigint(minStake),
    'total_stake': config.encodeBigint(totalStake),
    'validators': validators.map((e) => e.toJson(config: config)).toList(),
  });
}

/// GET /v2/rewards/validators (response)
class ValidatorsResponse {
  final BlockInfo block;

  /// Current election ID (electAt timestamp).
  final BigInt electionId;

  /// amount in nanograms
  final BigInt electorBalance;

  /// Election ID of the round immediately after this one. Omitted when the current round is not yet finished (next round not known).
  final BigInt? nextElectionId;

  /// Election ID of the round immediately before this one.
  final BigInt? prevElectionId;

  /// Server-side response time in milliseconds.
  final BigInt responseTimeMs;

  /// amount in nanograms
  final BigInt rewardPerBlock;

  /// amount in nanograms
  final BigInt totalStake;
  final RoundInfo validationRound;
  final List<ValidatorRewardEntry> validators;

  const ValidatorsResponse({
    required this.block,
    required this.electionId,
    required this.electorBalance,
    this.nextElectionId,
    this.prevElectionId,
    required this.responseTimeMs,
    required this.rewardPerBlock,
    required this.totalStake,
    required this.validationRound,
    required this.validators,
  });

  factory ValidatorsResponse.fromJson(Map<String, dynamic> json) {
    return ValidatorsResponse(
      block: json.valueTo<BlockInfo, Map<String, dynamic>>(
        key: 'block',
        parse: (v) => BlockInfo.fromJson(v),
      ),
      electionId: json.valueAsBigInt<BigInt>('election_id'),
      electorBalance: json.valueAsBigInt<BigInt>('elector_balance'),
      nextElectionId: json.valueAsBigInt<BigInt?>('next_election_id'),
      prevElectionId: json.valueAsBigInt<BigInt?>('prev_election_id'),
      responseTimeMs: json.valueAsBigInt<BigInt>('response_time_ms'),
      rewardPerBlock: json.valueAsBigInt<BigInt>('reward_per_block'),
      totalStake: json.valueAsBigInt<BigInt>('total_stake'),
      validationRound: json.valueTo<RoundInfo, Map<String, dynamic>>(
        key: 'validation_round',
        parse: (v) => RoundInfo.fromJson(v),
      ),
      validators:
          json
              .valueEnsureAsList<Map<String, dynamic>>('validators')
              .map((e) => ValidatorRewardEntry.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'block': block.toJson(config: config),
    'election_id': config.encodeBigint(electionId),
    'elector_balance': config.encodeBigint(electorBalance),
    'next_election_id': config.encodeBigint(nextElectionId),
    'prev_election_id': config.encodeBigint(prevElectionId),
    'response_time_ms': config.encodeBigint(responseTimeMs),
    'reward_per_block': config.encodeBigint(rewardPerBlock),
    'total_stake': config.encodeBigint(totalStake),
    'validation_round': validationRound.toJson(config: config),
    'validators': validators.map((e) => e.toJson(config: config)).toList(),
  });
}

class ValidatorsSet {
  final List<ValidatorsSetListItem> list;
  final int main;
  final int total;
  final String? totalWeight;
  final int utimeSince;
  final int utimeUntil;

  const ValidatorsSet({
    required this.list,
    required this.main,
    required this.total,
    this.totalWeight,
    required this.utimeSince,
    required this.utimeUntil,
  });

  factory ValidatorsSet.fromJson(Map<String, dynamic> json) {
    return ValidatorsSet(
      list:
          json
              .valueEnsureAsList<Map<String, dynamic>>('list')
              .map((e) => ValidatorsSetListItem.fromJson(e))
              .toList(),
      main: json.valueAsInt<int>('main'),
      total: json.valueAsInt<int>('total'),
      totalWeight:
          (json['total_weight'] is num
              ? json['total_weight'].toString()
              : json.valueAsString<String?>('total_weight')),
      utimeSince: json.valueAsInt<int>('utime_since'),
      utimeUntil: json.valueAsInt<int>('utime_until'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'list': list.map((e) => e.toJson(config: config)).toList(),
    'main': main,
    'total': total,
    'total_weight': totalWeight,
    'utime_since': utimeSince,
    'utime_until': utimeUntil,
  });
}

class ValueFlow {
  final AccountAddress account;
  final BigInt fees;
  final BigInt gram;
  final List<ValueFlowJettonsItem>? jettons;

  /// this field will gone after Sept. 2026, use gram instead
  final BigInt? ton;

  const ValueFlow({
    required this.account,
    required this.fees,
    required this.gram,
    this.jettons,
    this.ton,
  });

  factory ValueFlow.fromJson(Map<String, dynamic> json) {
    return ValueFlow(
      account: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'account',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      fees: json.valueAsBigInt<BigInt>('fees'),
      gram: json.valueAsBigInt<BigInt>('gram'),
      jettons:
          json.hasValue('jettons')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('jettons')
                  .map((e) => ValueFlowJettonsItem.fromJson(e))
                  .toList()
              : null,
      ton: json.valueAsBigInt<BigInt?>('ton'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'account': account.toJson(config: config),
    'fees': config.encodeBigint(fees),
    'gram': config.encodeBigint(gram),
    'jettons': jettons?.map((e) => e.toJson(config: config)).toList(),
    'ton': config.encodeBigint(ton),
  });
}

class VaultDepositInfo {
  final Price price;
  final String vault;

  const VaultDepositInfo({required this.price, required this.vault});

  factory VaultDepositInfo.fromJson(Map<String, dynamic> json) {
    return VaultDepositInfo(
      price: json.valueTo<Price, Map<String, dynamic>>(
        key: 'price',
        parse: (v) => Price.fromJson(v),
      ),
      vault:
          (json['vault'] is num
              ? json['vault'].toString()
              : json.valueAsString<String>('vault')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'price': price.toJson(config: config),
    'vault': vault,
  });
}

/// GET /v2/wallet/{account_id} (response)
class Wallet {
  final String address;
  final BigInt balance;
  final List<String> getMethods;
  final String? icon;
  final List<String>? interfaces;
  final bool? isSuspended;
  final bool isWallet;

  /// unix timestamp
  final BigInt lastActivity;
  final BigInt lastLt;
  final String? name;
  final List<WalletPlugin> plugins;
  final bool? signatureDisabled;
  final WalletStats stats;
  final AccountStatus status;

  const Wallet({
    required this.address,
    required this.balance,
    required this.getMethods,
    this.icon,
    this.interfaces,
    this.isSuspended,
    required this.isWallet,
    required this.lastActivity,
    required this.lastLt,
    this.name,
    required this.plugins,
    this.signatureDisabled,
    required this.stats,
    required this.status,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) {
    return Wallet(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      balance: json.valueAsBigInt<BigInt>('balance'),
      getMethods: json.valueAsList<List<String>>('get_methods'),
      icon:
          (json['icon'] is num
              ? json['icon'].toString()
              : json.valueAsString<String?>('icon')),
      interfaces: json.valueAsList<List<String>?>('interfaces'),
      isSuspended: json.valueAsBool<bool?>('is_suspended'),
      isWallet: json.valueAsBool<bool>('is_wallet'),
      lastActivity: json.valueAsBigInt<BigInt>('last_activity'),
      lastLt: json.valueAsBigInt<BigInt>('last_lt'),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String?>('name')),
      plugins:
          json
              .valueEnsureAsList<Map<String, dynamic>>('plugins')
              .map((e) => WalletPlugin.fromJson(e))
              .toList(),
      signatureDisabled: json.valueAsBool<bool?>('signature_disabled'),
      stats: json.valueTo<WalletStats, Map<String, dynamic>>(
        key: 'stats',
        parse: (v) => WalletStats.fromJson(v),
      ),
      status: json.valueTo<AccountStatus, Object>(
        key: 'status',
        parse: (e) => AccountStatus.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'balance': config.encodeBigint(balance),
    'get_methods': getMethods,
    'icon': icon,
    'interfaces': interfaces,
    'is_suspended': isSuspended,
    'is_wallet': isWallet,
    'last_activity': config.encodeBigint(lastActivity),
    'last_lt': config.encodeBigint(lastLt),
    'name': name,
    'plugins': plugins.map((e) => e.toJson(config: config)).toList(),
    'signature_disabled': signatureDisabled,
    'stats': stats.toJson(config: config),
    'status': status.toJson(config: config),
  });
}

class WalletDNS {
  final AccountAddress account;
  final String address;
  final bool hasMethodPubkey;
  final bool hasMethodSeqno;
  final bool isWallet;
  final List<String> names;

  const WalletDNS({
    required this.account,
    required this.address,
    required this.hasMethodPubkey,
    required this.hasMethodSeqno,
    required this.isWallet,
    required this.names,
  });

  factory WalletDNS.fromJson(Map<String, dynamic> json) {
    return WalletDNS(
      account: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'account',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      hasMethodPubkey: json.valueAsBool<bool>('has_method_pubkey'),
      hasMethodSeqno: json.valueAsBool<bool>('has_method_seqno'),
      isWallet: json.valueAsBool<bool>('is_wallet'),
      names: json.valueAsList<List<String>>('names'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'account': account.toJson(config: config),
    'address': address,
    'has_method_pubkey': hasMethodPubkey,
    'has_method_seqno': hasMethodSeqno,
    'is_wallet': isWallet,
    'names': names,
  });
}

class WalletPlugin {
  final String address;
  final AccountStatus status;
  final String type;

  const WalletPlugin({
    required this.address,
    required this.status,
    required this.type,
  });

  factory WalletPlugin.fromJson(Map<String, dynamic> json) {
    return WalletPlugin(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      status: json.valueTo<AccountStatus, Object>(
        key: 'status',
        parse: (e) => AccountStatus.fromJson(JsonParser.valueAs(e)),
      ),
      type:
          (json['type'] is num
              ? json['type'].toString()
              : json.valueAsString<String>('type')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'status': status.toJson(config: config),
    'type': type,
  });
}

class WalletStats {
  final int jettonsCount;
  final int multisigCount;
  final int nftsCount;
  final int stakingCount;

  const WalletStats({
    required this.jettonsCount,
    required this.multisigCount,
    required this.nftsCount,
    required this.stakingCount,
  });

  factory WalletStats.fromJson(Map<String, dynamic> json) {
    return WalletStats(
      jettonsCount: json.valueAsInt<int>('jettons_count'),
      multisigCount: json.valueAsInt<int>('multisig_count'),
      nftsCount: json.valueAsInt<int>('nfts_count'),
      stakingCount: json.valueAsInt<int>('staking_count'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'jettons_count': jettonsCount,
    'multisig_count': multisigCount,
    'nfts_count': nftsCount,
    'staking_count': stakingCount,
  });
}

/// GET /v2/pubkeys/{public_key}/wallets (response)
class Wallets {
  final List<Wallet> accounts;

  const Wallets({required this.accounts});

  factory Wallets.fromJson(Map<String, dynamic> json) {
    return Wallets(
      accounts:
          json
              .valueEnsureAsList<Map<String, dynamic>>('accounts')
              .map((e) => Wallet.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'accounts': accounts.map((e) => e.toJson(config: config)).toList(),
  });
}

class WalletsByPublicKey {
  /// hex-encoded ed25519 public key
  final String publicKey;
  final List<Wallet> wallets;

  const WalletsByPublicKey({required this.publicKey, required this.wallets});

  factory WalletsByPublicKey.fromJson(Map<String, dynamic> json) {
    return WalletsByPublicKey(
      publicKey:
          (json['public_key'] is num
              ? json['public_key'].toString()
              : json.valueAsString<String>('public_key')),
      wallets:
          json
              .valueEnsureAsList<Map<String, dynamic>>('wallets')
              .map((e) => Wallet.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'public_key': publicKey,
    'wallets': wallets.map((e) => e.toJson(config: config)).toList(),
  });
}

/// POST /v2/pubkeys/wallets/_bulk (response)
class WalletsByPublicKeys {
  /// Wallets grouped by the originating public key
  final List<WalletsByPublicKey> items;

  const WalletsByPublicKeys({required this.items});

  factory WalletsByPublicKeys.fromJson(Map<String, dynamic> json) {
    return WalletsByPublicKeys(
      items:
          json
              .valueEnsureAsList<Map<String, dynamic>>('items')
              .map((e) => WalletsByPublicKey.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'items': items.map((e) => e.toJson(config: config)).toList(),
  });
}

/// validator's participation in elections
class WithdrawStakeAction {
  final BigInt amount;
  final PoolImplementationType implementation;
  final AccountAddress pool;
  final AccountAddress staker;

  const WithdrawStakeAction({
    required this.amount,
    required this.implementation,
    required this.pool,
    required this.staker,
  });

  factory WithdrawStakeAction.fromJson(Map<String, dynamic> json) {
    return WithdrawStakeAction(
      amount: json.valueAsBigInt<BigInt>('amount'),
      implementation: json.valueTo<PoolImplementationType, Object>(
        key: 'implementation',
        parse: (e) => PoolImplementationType.fromJson(JsonParser.valueAs(e)),
      ),
      pool: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'pool',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      staker: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'staker',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': config.encodeBigint(amount),
    'implementation': implementation.toJson(config: config),
    'pool': pool.toJson(config: config),
    'staker': staker.toJson(config: config),
  });
}

/// validator's participation in elections
class WithdrawStakeRequestAction {
  final BigInt? amount;
  final PoolImplementationType implementation;
  final AccountAddress pool;

  /// If present, should be used instead of amount
  final Price? stakeMeta;
  final AccountAddress staker;

  const WithdrawStakeRequestAction({
    this.amount,
    required this.implementation,
    required this.pool,
    this.stakeMeta,
    required this.staker,
  });

  factory WithdrawStakeRequestAction.fromJson(Map<String, dynamic> json) {
    return WithdrawStakeRequestAction(
      amount: json.valueAsBigInt<BigInt?>('amount'),
      implementation: json.valueTo<PoolImplementationType, Object>(
        key: 'implementation',
        parse: (e) => PoolImplementationType.fromJson(JsonParser.valueAs(e)),
      ),
      pool: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'pool',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      stakeMeta: json.valueTo<Price?, Map<String, dynamic>>(
        key: 'stake_meta',
        parse: (v) => Price.fromJson(v),
      ),
      staker: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'staker',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': config.encodeBigint(amount),
    'implementation': implementation.toJson(config: config),
    'pool': pool.toJson(config: config),
    'stake_meta': stakeMeta?.toJson(config: config),
    'staker': staker.toJson(config: config),
  });
}

class WithdrawTokenStakeRequestAction {
  final Protocol protocol;
  final Price? stakeMeta;
  final AccountAddress staker;

  const WithdrawTokenStakeRequestAction({
    required this.protocol,
    this.stakeMeta,
    required this.staker,
  });

  factory WithdrawTokenStakeRequestAction.fromJson(Map<String, dynamic> json) {
    return WithdrawTokenStakeRequestAction(
      protocol: json.valueTo<Protocol, Map<String, dynamic>>(
        key: 'protocol',
        parse: (v) => Protocol.fromJson(v),
      ),
      stakeMeta: json.valueTo<Price?, Map<String, dynamic>>(
        key: 'stake_meta',
        parse: (v) => Price.fromJson(v),
      ),
      staker: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'staker',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'protocol': protocol.toJson(config: config),
    'stake_meta': stakeMeta?.toJson(config: config),
    'staker': staker.toJson(config: config),
  });
}

class WithdrawXTRAction {
  final String amount;
  final AccountAddress user;

  const WithdrawXTRAction({required this.amount, required this.user});

  factory WithdrawXTRAction.fromJson(Map<String, dynamic> json) {
    return WithdrawXTRAction(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      user: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'user',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'user': user.toJson(config: config),
  });
}

class WorkchainDescr {
  final bool acceptMsgs;
  final bool active;
  final int actualMinSplit;
  final int basic;
  final BigInt enabledSince;
  final int flags;
  final int maxSplit;
  final int minSplit;
  final BigInt version;
  final int workchain;
  final String zerostateFileHash;
  final String zerostateRootHash;

  const WorkchainDescr({
    required this.acceptMsgs,
    required this.active,
    required this.actualMinSplit,
    required this.basic,
    required this.enabledSince,
    required this.flags,
    required this.maxSplit,
    required this.minSplit,
    required this.version,
    required this.workchain,
    required this.zerostateFileHash,
    required this.zerostateRootHash,
  });

  factory WorkchainDescr.fromJson(Map<String, dynamic> json) {
    return WorkchainDescr(
      acceptMsgs: json.valueAsBool<bool>('accept_msgs'),
      active: json.valueAsBool<bool>('active'),
      actualMinSplit: json.valueAsInt<int>('actual_min_split'),
      basic: json.valueAsInt<int>('basic'),
      enabledSince: json.valueAsBigInt<BigInt>('enabled_since'),
      flags: json.valueAsInt<int>('flags'),
      maxSplit: json.valueAsInt<int>('max_split'),
      minSplit: json.valueAsInt<int>('min_split'),
      version: json.valueAsBigInt<BigInt>('version'),
      workchain: json.valueAsInt<int>('workchain'),
      zerostateFileHash:
          (json['zerostate_file_hash'] is num
              ? json['zerostate_file_hash'].toString()
              : json.valueAsString<String>('zerostate_file_hash')),
      zerostateRootHash:
          (json['zerostate_root_hash'] is num
              ? json['zerostate_root_hash'].toString()
              : json.valueAsString<String>('zerostate_root_hash')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'accept_msgs': acceptMsgs,
    'active': active,
    'actual_min_split': actualMinSplit,
    'basic': basic,
    'enabled_since': config.encodeBigint(enabledSince),
    'flags': flags,
    'max_split': maxSplit,
    'min_split': minSplit,
    'version': config.encodeBigint(version),
    'workchain': workchain,
    'zerostate_file_hash': zerostateFileHash,
    'zerostate_root_hash': zerostateRootHash,
  });
}

class BlockCurrencyCollectionOtherItem {
  final BigInt id;
  final String value;

  const BlockCurrencyCollectionOtherItem({
    required this.id,
    required this.value,
  });

  factory BlockCurrencyCollectionOtherItem.fromJson(Map<String, dynamic> json) {
    return BlockCurrencyCollectionOtherItem(
      id: json.valueAsBigInt<BigInt>('id'),
      value:
          (json['value'] is num
              ? json['value'].toString()
              : json.valueAsString<String>('value')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'id': config.encodeBigint(id),
    'value': value,
  });
}

class BlockchainBlockShardsShardsItem {
  final BlockchainBlock lastKnownBlock;
  final String lastKnownBlockId;

  const BlockchainBlockShardsShardsItem({
    required this.lastKnownBlock,
    required this.lastKnownBlockId,
  });

  factory BlockchainBlockShardsShardsItem.fromJson(Map<String, dynamic> json) {
    return BlockchainBlockShardsShardsItem(
      lastKnownBlock: json.valueTo<BlockchainBlock, Map<String, dynamic>>(
        key: 'last_known_block',
        parse: (v) => BlockchainBlock.fromJson(v),
      ),
      lastKnownBlockId:
          (json['last_known_block_id'] is num
              ? json['last_known_block_id'].toString()
              : json.valueAsString<String>('last_known_block_id')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'last_known_block': lastKnownBlock.toJson(config: config),
    'last_known_block_id': lastKnownBlockId,
  });
}

/// List of critical TON parameters, the change of which significantly affects the network, so more voting rounds are held.
class BlockchainConfign10 {
  final List<int> criticalParams;

  const BlockchainConfign10({required this.criticalParams});

  factory BlockchainConfign10.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign10(
      criticalParams: json.valueAsList<List<int>>('critical_params'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'critical_params': criticalParams});
}

/// This parameter indicates under what conditions proposals to change the TON configuration are accepted.
class BlockchainConfign11 {
  final ConfigProposalSetup criticalParams;
  final ConfigProposalSetup normalParams;

  const BlockchainConfign11({
    required this.criticalParams,
    required this.normalParams,
  });

  factory BlockchainConfign11.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign11(
      criticalParams: json.valueTo<ConfigProposalSetup, Map<String, dynamic>>(
        key: 'critical_params',
        parse: (v) => ConfigProposalSetup.fromJson(v),
      ),
      normalParams: json.valueTo<ConfigProposalSetup, Map<String, dynamic>>(
        key: 'normal_params',
        parse: (v) => ConfigProposalSetup.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'critical_params': criticalParams.toJson(config: config),
    'normal_params': normalParams.toJson(config: config),
  });
}

/// Workchains in the TON Blockchain
class BlockchainConfign12 {
  final List<WorkchainDescr> workchains;

  const BlockchainConfign12({required this.workchains});

  factory BlockchainConfign12.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign12(
      workchains:
          json
              .valueEnsureAsList<Map<String, dynamic>>('workchains')
              .map((e) => WorkchainDescr.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'workchains': workchains.map((e) => e.toJson(config: config)).toList(),
  });
}

/// The cost of filing complaints about incorrect operation of validators.
class BlockchainConfign13 {
  final BigInt bitPrice;
  final BigInt cellPrice;
  final BigInt deposit;

  const BlockchainConfign13({
    required this.bitPrice,
    required this.cellPrice,
    required this.deposit,
  });

  factory BlockchainConfign13.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign13(
      bitPrice: json.valueAsBigInt<BigInt>('bit_price'),
      cellPrice: json.valueAsBigInt<BigInt>('cell_price'),
      deposit: json.valueAsBigInt<BigInt>('deposit'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bit_price': config.encodeBigint(bitPrice),
    'cell_price': config.encodeBigint(cellPrice),
    'deposit': config.encodeBigint(deposit),
  });
}

/// The reward in nanoGram for block creation in the TON blockchain.
class BlockchainConfign14 {
  final BigInt basechainBlockFee;
  final BigInt masterchainBlockFee;

  const BlockchainConfign14({
    required this.basechainBlockFee,
    required this.masterchainBlockFee,
  });

  factory BlockchainConfign14.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign14(
      basechainBlockFee: json.valueAsBigInt<BigInt>('basechain_block_fee'),
      masterchainBlockFee: json.valueAsBigInt<BigInt>('masterchain_block_fee'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'basechain_block_fee': config.encodeBigint(basechainBlockFee),
    'masterchain_block_fee': config.encodeBigint(masterchainBlockFee),
  });
}

/// The reward in nanograms for block creation in the TON blockchain.
class BlockchainConfign15 {
  final BigInt electionsEndBefore;
  final BigInt electionsStartBefore;
  final BigInt stakeHeldFor;
  final BigInt validatorsElectedFor;

  const BlockchainConfign15({
    required this.electionsEndBefore,
    required this.electionsStartBefore,
    required this.stakeHeldFor,
    required this.validatorsElectedFor,
  });

  factory BlockchainConfign15.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign15(
      electionsEndBefore: json.valueAsBigInt<BigInt>('elections_end_before'),
      electionsStartBefore: json.valueAsBigInt<BigInt>(
        'elections_start_before',
      ),
      stakeHeldFor: json.valueAsBigInt<BigInt>('stake_held_for'),
      validatorsElectedFor: json.valueAsBigInt<BigInt>(
        'validators_elected_for',
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'elections_end_before': config.encodeBigint(electionsEndBefore),
    'elections_start_before': config.encodeBigint(electionsStartBefore),
    'stake_held_for': config.encodeBigint(stakeHeldFor),
    'validators_elected_for': config.encodeBigint(validatorsElectedFor),
  });
}

/// The limits on the number of validators in the TON blockchain.
class BlockchainConfign16 {
  final int maxMainValidators;
  final int maxValidators;
  final int minValidators;

  const BlockchainConfign16({
    required this.maxMainValidators,
    required this.maxValidators,
    required this.minValidators,
  });

  factory BlockchainConfign16.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign16(
      maxMainValidators: json.valueAsInt<int>('max_main_validators'),
      maxValidators: json.valueAsInt<int>('max_validators'),
      minValidators: json.valueAsInt<int>('min_validators'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'max_main_validators': maxMainValidators,
    'max_validators': maxValidators,
    'min_validators': minValidators,
  });
}

/// The stake parameters configuration in the TON blockchain.
class BlockchainConfign17 {
  final String maxStake;
  final BigInt maxStakeFactor;
  final String minStake;
  final String minTotalStake;

  const BlockchainConfign17({
    required this.maxStake,
    required this.maxStakeFactor,
    required this.minStake,
    required this.minTotalStake,
  });

  factory BlockchainConfign17.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign17(
      maxStake:
          (json['max_stake'] is num
              ? json['max_stake'].toString()
              : json.valueAsString<String>('max_stake')),
      maxStakeFactor: json.valueAsBigInt<BigInt>('max_stake_factor'),
      minStake:
          (json['min_stake'] is num
              ? json['min_stake'].toString()
              : json.valueAsString<String>('min_stake')),
      minTotalStake:
          (json['min_total_stake'] is num
              ? json['min_total_stake'].toString()
              : json.valueAsString<String>('min_total_stake')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'max_stake': maxStake,
    'max_stake_factor': config.encodeBigint(maxStakeFactor),
    'min_stake': minStake,
    'min_total_stake': minTotalStake,
  });
}

/// The prices for data storage.
class BlockchainConfign18 {
  final List<BlockchainConfign18StoragePricesItem> storagePrices;

  const BlockchainConfign18({required this.storagePrices});

  factory BlockchainConfign18.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign18(
      storagePrices:
          json
              .valueEnsureAsList<Map<String, dynamic>>('storage_prices')
              .map((e) => BlockchainConfign18StoragePricesItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'storage_prices':
        storagePrices.map((e) => e.toJson(config: config)).toList(),
  });
}

class BlockchainConfign18StoragePricesItem {
  final BigInt bitPricePs;
  final BigInt cellPricePs;
  final BigInt mcBitPricePs;
  final BigInt mcCellPricePs;
  final BigInt utimeSince;

  const BlockchainConfign18StoragePricesItem({
    required this.bitPricePs,
    required this.cellPricePs,
    required this.mcBitPricePs,
    required this.mcCellPricePs,
    required this.utimeSince,
  });

  factory BlockchainConfign18StoragePricesItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return BlockchainConfign18StoragePricesItem(
      bitPricePs: json.valueAsBigInt<BigInt>('bit_price_ps'),
      cellPricePs: json.valueAsBigInt<BigInt>('cell_price_ps'),
      mcBitPricePs: json.valueAsBigInt<BigInt>('mc_bit_price_ps'),
      mcCellPricePs: json.valueAsBigInt<BigInt>('mc_cell_price_ps'),
      utimeSince: json.valueAsBigInt<BigInt>('utime_since'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bit_price_ps': config.encodeBigint(bitPricePs),
    'cell_price_ps': config.encodeBigint(cellPricePs),
    'mc_bit_price_ps': config.encodeBigint(mcBitPricePs),
    'mc_cell_price_ps': config.encodeBigint(mcCellPricePs),
    'utime_since': config.encodeBigint(utimeSince),
  });
}

/// The cost of computations in the masterchain. The complexity of any computation is estimated in gas units.
class BlockchainConfign20 {
  final GasLimitPrices gasLimitsPrices;

  const BlockchainConfign20({required this.gasLimitsPrices});

  factory BlockchainConfign20.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign20(
      gasLimitsPrices: json.valueTo<GasLimitPrices, Map<String, dynamic>>(
        key: 'gas_limits_prices',
        parse: (v) => GasLimitPrices.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'gas_limits_prices': gasLimitsPrices.toJson(config: config),
  });
}

/// The limits on the block in the masterchain, upon reaching which the block is finalized and the callback of the remaining messages (if any) is carried over to the next block.
class BlockchainConfign22 {
  final BlockLimits blockLimits;

  const BlockchainConfign22({required this.blockLimits});

  factory BlockchainConfign22.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign22(
      blockLimits: json.valueTo<BlockLimits, Map<String, dynamic>>(
        key: 'block_limits',
        parse: (v) => BlockLimits.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'block_limits': blockLimits.toJson(config: config),
  });
}

/// The cost of sending messages in the masterchain of the TON blockchain.
class BlockchainConfign24 {
  final MsgForwardPrices msgForwardPrices;

  const BlockchainConfign24({required this.msgForwardPrices});

  factory BlockchainConfign24.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign24(
      msgForwardPrices: json.valueTo<MsgForwardPrices, Map<String, dynamic>>(
        key: 'msg_forward_prices',
        parse: (v) => MsgForwardPrices.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'msg_forward_prices': msgForwardPrices.toJson(config: config),
  });
}

/// The configuration for the Catchain protocol.
class BlockchainConfign28 {
  final int? flags;
  final BigInt mcCatchainLifetime;
  final BigInt shardCatchainLifetime;
  final BigInt shardValidatorsLifetime;
  final BigInt shardValidatorsNum;
  final bool? shuffleMcValidators;

  const BlockchainConfign28({
    this.flags,
    required this.mcCatchainLifetime,
    required this.shardCatchainLifetime,
    required this.shardValidatorsLifetime,
    required this.shardValidatorsNum,
    this.shuffleMcValidators,
  });

  factory BlockchainConfign28.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign28(
      flags: json.valueAsInt<int?>('flags'),
      mcCatchainLifetime: json.valueAsBigInt<BigInt>('mc_catchain_lifetime'),
      shardCatchainLifetime: json.valueAsBigInt<BigInt>(
        'shard_catchain_lifetime',
      ),
      shardValidatorsLifetime: json.valueAsBigInt<BigInt>(
        'shard_validators_lifetime',
      ),
      shardValidatorsNum: json.valueAsBigInt<BigInt>('shard_validators_num'),
      shuffleMcValidators: json.valueAsBool<bool?>('shuffle_mc_validators'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'flags': flags,
    'mc_catchain_lifetime': config.encodeBigint(mcCatchainLifetime),
    'shard_catchain_lifetime': config.encodeBigint(shardCatchainLifetime),
    'shard_validators_lifetime': config.encodeBigint(shardValidatorsLifetime),
    'shard_validators_num': config.encodeBigint(shardValidatorsNum),
    'shuffle_mc_validators': shuffleMcValidators,
  });
}

/// The configuration for the consensus protocol above catchain.
class BlockchainConfign29 {
  final BigInt attemptDuration;
  final BigInt? catchainMaxBlocksCoeff;
  final BigInt catchainMaxDeps;
  final BigInt consensusTimeoutMs;
  final BigInt fastAttempts;
  final int? flags;
  final BigInt maxBlockBytes;
  final BigInt maxCollatedBytes;
  final bool? newCatchainIds;
  final BigInt nextCandidateDelayMs;
  final BigInt? protoVersion;
  final BigInt roundCandidates;

  const BlockchainConfign29({
    required this.attemptDuration,
    this.catchainMaxBlocksCoeff,
    required this.catchainMaxDeps,
    required this.consensusTimeoutMs,
    required this.fastAttempts,
    this.flags,
    required this.maxBlockBytes,
    required this.maxCollatedBytes,
    this.newCatchainIds,
    required this.nextCandidateDelayMs,
    this.protoVersion,
    required this.roundCandidates,
  });

  factory BlockchainConfign29.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign29(
      attemptDuration: json.valueAsBigInt<BigInt>('attempt_duration'),
      catchainMaxBlocksCoeff: json.valueAsBigInt<BigInt?>(
        'catchain_max_blocks_coeff',
      ),
      catchainMaxDeps: json.valueAsBigInt<BigInt>('catchain_max_deps'),
      consensusTimeoutMs: json.valueAsBigInt<BigInt>('consensus_timeout_ms'),
      fastAttempts: json.valueAsBigInt<BigInt>('fast_attempts'),
      flags: json.valueAsInt<int?>('flags'),
      maxBlockBytes: json.valueAsBigInt<BigInt>('max_block_bytes'),
      maxCollatedBytes: json.valueAsBigInt<BigInt>('max_collated_bytes'),
      newCatchainIds: json.valueAsBool<bool?>('new_catchain_ids'),
      nextCandidateDelayMs: json.valueAsBigInt<BigInt>(
        'next_candidate_delay_ms',
      ),
      protoVersion: json.valueAsBigInt<BigInt?>('proto_version'),
      roundCandidates: json.valueAsBigInt<BigInt>('round_candidates'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'attempt_duration': config.encodeBigint(attemptDuration),
    'catchain_max_blocks_coeff': config.encodeBigint(catchainMaxBlocksCoeff),
    'catchain_max_deps': config.encodeBigint(catchainMaxDeps),
    'consensus_timeout_ms': config.encodeBigint(consensusTimeoutMs),
    'fast_attempts': config.encodeBigint(fastAttempts),
    'flags': flags,
    'max_block_bytes': config.encodeBigint(maxBlockBytes),
    'max_collated_bytes': config.encodeBigint(maxCollatedBytes),
    'new_catchain_ids': newCatchainIds,
    'next_candidate_delay_ms': config.encodeBigint(nextCandidateDelayMs),
    'proto_version': config.encodeBigint(protoVersion),
    'round_candidates': config.encodeBigint(roundCandidates),
  });
}

/// The configuration for the new consensus protocol. Each chain can have its own optional configuration.
class BlockchainConfign30 {
  final NewConsensusConfig? mc;
  final NewConsensusConfig? shard;

  const BlockchainConfign30({this.mc, this.shard});

  factory BlockchainConfign30.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign30(
      mc: json.valueTo<NewConsensusConfig?, Map<String, dynamic>>(
        key: 'mc',
        parse: (v) => NewConsensusConfig.fromJson(v),
      ),
      shard: json.valueTo<NewConsensusConfig?, Map<String, dynamic>>(
        key: 'shard',
        parse: (v) => NewConsensusConfig.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'mc': mc?.toJson(config: config),
    'shard': shard?.toJson(config: config),
  });
}

/// The configuration for the consensus protocol above catchain.
class BlockchainConfign31 {
  final List<String> fundamentalSmcAddr;

  const BlockchainConfign31({required this.fundamentalSmcAddr});

  factory BlockchainConfign31.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign31(
      fundamentalSmcAddr: json.valueAsList<List<String>>(
        'fundamental_smc_addr',
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'fundamental_smc_addr': fundamentalSmcAddr,
  });
}

/// The configuration for punishment for improper behavior (non-validation). In the absence of the parameter, the default fine size is 101 Gram
class BlockchainConfign40 {
  final MisbehaviourPunishmentConfig misbehaviourPunishmentConfig;

  const BlockchainConfign40({required this.misbehaviourPunishmentConfig});

  factory BlockchainConfign40.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign40(
      misbehaviourPunishmentConfig: json
          .valueTo<MisbehaviourPunishmentConfig, Map<String, dynamic>>(
            key: 'misbehaviour_punishment_config',
            parse: (v) => MisbehaviourPunishmentConfig.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'misbehaviour_punishment_config': misbehaviourPunishmentConfig.toJson(
      config: config,
    ),
  });
}

/// The size limits and some other characteristics of accounts and messages.
class BlockchainConfign43 {
  final SizeLimitsConfig sizeLimitsConfig;

  const BlockchainConfign43({required this.sizeLimitsConfig});

  factory BlockchainConfign43.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign43(
      sizeLimitsConfig: json.valueTo<SizeLimitsConfig, Map<String, dynamic>>(
        key: 'size_limits_config',
        parse: (v) => SizeLimitsConfig.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'size_limits_config': sizeLimitsConfig.toJson(config: config),
  });
}

/// suspended accounts
class BlockchainConfign44 {
  final List<String> accounts;
  final int suspendedUntil;

  const BlockchainConfign44({
    required this.accounts,
    required this.suspendedUntil,
  });

  factory BlockchainConfign44.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign44(
      accounts: json.valueAsList<List<String>>('accounts'),
      suspendedUntil: json.valueAsInt<int>('suspended_until'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'accounts': accounts,
    'suspended_until': suspendedUntil,
  });
}

/// precompiled contracts
class BlockchainConfign45 {
  final List<BlockchainConfign45ContractsItem> contracts;

  const BlockchainConfign45({required this.contracts});

  factory BlockchainConfign45.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign45(
      contracts:
          json
              .valueEnsureAsList<Map<String, dynamic>>('contracts')
              .map((e) => BlockchainConfign45ContractsItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'contracts': contracts.map((e) => e.toJson(config: config)).toList(),
  });
}

class BlockchainConfign45ContractsItem {
  final String codeHash;
  final BigInt gasUsage;

  const BlockchainConfign45ContractsItem({
    required this.codeHash,
    required this.gasUsage,
  });

  factory BlockchainConfign45ContractsItem.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign45ContractsItem(
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String>('code_hash')),
      gasUsage: json.valueAsBigInt<BigInt>('gas_usage'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'code_hash': codeHash,
    'gas_usage': config.encodeBigint(gasUsage),
  });
}

class BlockchainConfign5 {
  final String? blackholeAddr;
  final BigInt feeBurnDenom;
  final BigInt feeBurnNom;

  const BlockchainConfign5({
    this.blackholeAddr,
    required this.feeBurnDenom,
    required this.feeBurnNom,
  });

  factory BlockchainConfign5.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign5(
      blackholeAddr:
          (json['blackhole_addr'] is num
              ? json['blackhole_addr'].toString()
              : json.valueAsString<String?>('blackhole_addr')),
      feeBurnDenom: json.valueAsBigInt<BigInt>('fee_burn_denom'),
      feeBurnNom: json.valueAsBigInt<BigInt>('fee_burn_nom'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'blackhole_addr': blackholeAddr,
    'fee_burn_denom': config.encodeBigint(feeBurnDenom),
    'fee_burn_nom': config.encodeBigint(feeBurnNom),
  });
}

/// Minting fees of new currencies.
class BlockchainConfign6 {
  final BigInt mintAddPrice;
  final BigInt mintNewPrice;

  const BlockchainConfign6({
    required this.mintAddPrice,
    required this.mintNewPrice,
  });

  factory BlockchainConfign6.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign6(
      mintAddPrice: json.valueAsBigInt<BigInt>('mint_add_price'),
      mintNewPrice: json.valueAsBigInt<BigInt>('mint_new_price'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'mint_add_price': config.encodeBigint(mintAddPrice),
    'mint_new_price': config.encodeBigint(mintNewPrice),
  });
}

/// The volume of each of the additional currencies in circulation.
class BlockchainConfign7 {
  final List<BlockchainConfign7CurrenciesItem> currencies;

  const BlockchainConfign7({required this.currencies});

  factory BlockchainConfign7.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign7(
      currencies:
          json
              .valueEnsureAsList<Map<String, dynamic>>('currencies')
              .map((e) => BlockchainConfign7CurrenciesItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'currencies': currencies.map((e) => e.toJson(config: config)).toList(),
  });
}

/// Bridge parameters for wrapping TON in other networks.
class BlockchainConfign71 {
  final OracleBridgeParams oracleBridgeParams;

  const BlockchainConfign71({required this.oracleBridgeParams});

  factory BlockchainConfign71.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign71(
      oracleBridgeParams: json
          .valueTo<OracleBridgeParams, Map<String, dynamic>>(
            key: 'oracle_bridge_params',
            parse: (v) => OracleBridgeParams.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'oracle_bridge_params': oracleBridgeParams.toJson(config: config),
  });
}

/// Bridge parameters for wrapping tokens from other networks into tokens on the TON network.
class BlockchainConfign79 {
  final JettonBridgeParams jettonBridgeParams;

  const BlockchainConfign79({required this.jettonBridgeParams});

  factory BlockchainConfign79.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign79(
      jettonBridgeParams: json
          .valueTo<JettonBridgeParams, Map<String, dynamic>>(
            key: 'jetton_bridge_params',
            parse: (v) => JettonBridgeParams.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'jetton_bridge_params': jettonBridgeParams.toJson(config: config),
  });
}

class BlockchainConfign7CurrenciesItem {
  final String amount;
  final BigInt currencyId;

  const BlockchainConfign7CurrenciesItem({
    required this.amount,
    required this.currencyId,
  });

  factory BlockchainConfign7CurrenciesItem.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign7CurrenciesItem(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      currencyId: json.valueAsBigInt<BigInt>('currency_id'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'currency_id': config.encodeBigint(currencyId),
  });
}

/// The network version and additional capabilities supported by the validators.
class BlockchainConfign8 {
  final BigInt capabilities;
  final BigInt version;

  const BlockchainConfign8({required this.capabilities, required this.version});

  factory BlockchainConfign8.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign8(
      capabilities: json.valueAsBigInt<BigInt>('capabilities'),
      version: json.valueAsBigInt<BigInt>('version'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'capabilities': config.encodeBigint(capabilities),
    'version': config.encodeBigint(version),
  });
}

/// List of mandatory parameters of the blockchain config.
class BlockchainConfign9 {
  final List<int> mandatoryParams;

  const BlockchainConfign9({required this.mandatoryParams});

  factory BlockchainConfign9.fromJson(Map<String, dynamic> json) {
    return BlockchainConfign9(
      mandatoryParams: json.valueAsList<List<int>>('mandatory_params'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) =>
      config.encodeMap(<String, dynamic>{'mandatory_params': mandatoryParams});
}

class BlockchainRawAccountLibrariesItem {
  final bool public;
  final String root;

  const BlockchainRawAccountLibrariesItem({
    required this.public,
    required this.root,
  });

  factory BlockchainRawAccountLibrariesItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return BlockchainRawAccountLibrariesItem(
      public: json.valueAsBool<bool>('public'),
      root:
          (json['root'] is num
              ? json['root'].toString()
              : json.valueAsString<String>('root')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'public': public, 'root': root});
}

class DecodedMessageExtInMsgDecoded {
  final DecodedMessageExtInMsgDecodedWalletHighloadV2? walletHighloadV2;
  final DecodedMessageExtInMsgDecodedWalletV3? walletV3;
  final DecodedMessageExtInMsgDecodedWalletV4? walletV4;
  final DecodedMessageExtInMsgDecodedWalletV5? walletV5;

  const DecodedMessageExtInMsgDecoded({
    this.walletHighloadV2,
    this.walletV3,
    this.walletV4,
    this.walletV5,
  });

  factory DecodedMessageExtInMsgDecoded.fromJson(Map<String, dynamic> json) {
    return DecodedMessageExtInMsgDecoded(
      walletHighloadV2: json.valueTo<
        DecodedMessageExtInMsgDecodedWalletHighloadV2?,
        Map<String, dynamic>
      >(
        key: 'wallet_highload_v2',
        parse: (v) => DecodedMessageExtInMsgDecodedWalletHighloadV2.fromJson(v),
      ),
      walletV3: json.valueTo<
        DecodedMessageExtInMsgDecodedWalletV3?,
        Map<String, dynamic>
      >(
        key: 'wallet_v3',
        parse: (v) => DecodedMessageExtInMsgDecodedWalletV3.fromJson(v),
      ),
      walletV4: json.valueTo<
        DecodedMessageExtInMsgDecodedWalletV4?,
        Map<String, dynamic>
      >(
        key: 'wallet_v4',
        parse: (v) => DecodedMessageExtInMsgDecodedWalletV4.fromJson(v),
      ),
      walletV5: json.valueTo<
        DecodedMessageExtInMsgDecodedWalletV5?,
        Map<String, dynamic>
      >(
        key: 'wallet_v5',
        parse: (v) => DecodedMessageExtInMsgDecodedWalletV5.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'wallet_highload_v2': walletHighloadV2?.toJson(config: config),
    'wallet_v3': walletV3?.toJson(config: config),
    'wallet_v4': walletV4?.toJson(config: config),
    'wallet_v5': walletV5?.toJson(config: config),
  });
}

class DecodedMessageExtInMsgDecodedWalletHighloadV2 {
  final String boundedQueryId;
  final List<DecodedRawMessage> rawMessages;
  final BigInt subwalletId;

  const DecodedMessageExtInMsgDecodedWalletHighloadV2({
    required this.boundedQueryId,
    required this.rawMessages,
    required this.subwalletId,
  });

  factory DecodedMessageExtInMsgDecodedWalletHighloadV2.fromJson(
    Map<String, dynamic> json,
  ) {
    return DecodedMessageExtInMsgDecodedWalletHighloadV2(
      boundedQueryId:
          (json['bounded_query_id'] is num
              ? json['bounded_query_id'].toString()
              : json.valueAsString<String>('bounded_query_id')),
      rawMessages:
          json
              .valueEnsureAsList<Map<String, dynamic>>('raw_messages')
              .map((e) => DecodedRawMessage.fromJson(e))
              .toList(),
      subwalletId: json.valueAsBigInt<BigInt>('subwallet_id'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bounded_query_id': boundedQueryId,
    'raw_messages': rawMessages.map((e) => e.toJson(config: config)).toList(),
    'subwallet_id': config.encodeBigint(subwalletId),
  });
}

class DecodedMessageExtInMsgDecodedWalletV3 {
  final List<DecodedRawMessage> rawMessages;
  final BigInt seqno;
  final BigInt subwalletId;
  final BigInt validUntil;

  const DecodedMessageExtInMsgDecodedWalletV3({
    required this.rawMessages,
    required this.seqno,
    required this.subwalletId,
    required this.validUntil,
  });

  factory DecodedMessageExtInMsgDecodedWalletV3.fromJson(
    Map<String, dynamic> json,
  ) {
    return DecodedMessageExtInMsgDecodedWalletV3(
      rawMessages:
          json
              .valueEnsureAsList<Map<String, dynamic>>('raw_messages')
              .map((e) => DecodedRawMessage.fromJson(e))
              .toList(),
      seqno: json.valueAsBigInt<BigInt>('seqno'),
      subwalletId: json.valueAsBigInt<BigInt>('subwallet_id'),
      validUntil: json.valueAsBigInt<BigInt>('valid_until'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'raw_messages': rawMessages.map((e) => e.toJson(config: config)).toList(),
    'seqno': config.encodeBigint(seqno),
    'subwallet_id': config.encodeBigint(subwalletId),
    'valid_until': config.encodeBigint(validUntil),
  });
}

class DecodedMessageExtInMsgDecodedWalletV4 {
  final int op;
  final List<DecodedRawMessage> rawMessages;
  final BigInt seqno;
  final BigInt subwalletId;
  final BigInt validUntil;

  const DecodedMessageExtInMsgDecodedWalletV4({
    required this.op,
    required this.rawMessages,
    required this.seqno,
    required this.subwalletId,
    required this.validUntil,
  });

  factory DecodedMessageExtInMsgDecodedWalletV4.fromJson(
    Map<String, dynamic> json,
  ) {
    return DecodedMessageExtInMsgDecodedWalletV4(
      op: json.valueAsInt<int>('op'),
      rawMessages:
          json
              .valueEnsureAsList<Map<String, dynamic>>('raw_messages')
              .map((e) => DecodedRawMessage.fromJson(e))
              .toList(),
      seqno: json.valueAsBigInt<BigInt>('seqno'),
      subwalletId: json.valueAsBigInt<BigInt>('subwallet_id'),
      validUntil: json.valueAsBigInt<BigInt>('valid_until'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'op': op,
    'raw_messages': rawMessages.map((e) => e.toJson(config: config)).toList(),
    'seqno': config.encodeBigint(seqno),
    'subwallet_id': config.encodeBigint(subwalletId),
    'valid_until': config.encodeBigint(validUntil),
  });
}

class DecodedMessageExtInMsgDecodedWalletV5 {
  final List<DecodedRawMessage> rawMessages;
  final BigInt validUntil;

  const DecodedMessageExtInMsgDecodedWalletV5({
    required this.rawMessages,
    required this.validUntil,
  });

  factory DecodedMessageExtInMsgDecodedWalletV5.fromJson(
    Map<String, dynamic> json,
  ) {
    return DecodedMessageExtInMsgDecodedWalletV5(
      rawMessages:
          json
              .valueEnsureAsList<Map<String, dynamic>>('raw_messages')
              .map((e) => DecodedRawMessage.fromJson(e))
              .toList(),
      validUntil: json.valueAsBigInt<BigInt>('valid_until'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'raw_messages': rawMessages.map((e) => e.toJson(config: config)).toList(),
    'valid_until': config.encodeBigint(validUntil),
  });
}

class DecodedRawMessageMessage {
  final String boc;

  final dynamic decodedBody;
  final String? decodedOpName;
  final String? opCode;

  const DecodedRawMessageMessage({
    required this.boc,
    this.decodedBody,
    this.decodedOpName,
    this.opCode,
  });

  factory DecodedRawMessageMessage.fromJson(Map<String, dynamic> json) {
    return DecodedRawMessageMessage(
      boc:
          (json['boc'] is num
              ? json['boc'].toString()
              : json.valueAsString<String>('boc')),
      decodedBody: json['decoded_body'],
      decodedOpName:
          (json['decoded_op_name'] is num
              ? json['decoded_op_name'].toString()
              : json.valueAsString<String?>('decoded_op_name')),
      opCode:
          (json['op_code'] is num
              ? json['op_code'].toString()
              : json.valueAsString<String?>('op_code')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'boc': boc,
    'decoded_body': decodedBody,
    'decoded_op_name': decodedOpName,
    'op_code': opCode,
  });
}

class DnsExpiringItemsItem {
  final NftItem? dnsItem;
  final BigInt expiringAt;
  final String name;

  const DnsExpiringItemsItem({
    this.dnsItem,
    required this.expiringAt,
    required this.name,
  });

  factory DnsExpiringItemsItem.fromJson(Map<String, dynamic> json) {
    return DnsExpiringItemsItem(
      dnsItem: json.valueTo<NftItem?, Map<String, dynamic>>(
        key: 'dns_item',
        parse: (v) => NftItem.fromJson(v),
      ),
      expiringAt: json.valueAsBigInt<BigInt>('expiring_at'),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String>('name')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'dns_item': dnsItem?.toJson(config: config),
    'expiring_at': config.encodeBigint(expiringAt),
    'name': name,
  });
}

class EmulateMessageToAccountEventBody {
  final String boc;

  const EmulateMessageToAccountEventBody({required this.boc});

  factory EmulateMessageToAccountEventBody.fromJson(Map<String, dynamic> json) {
    return EmulateMessageToAccountEventBody(
      boc:
          (json['boc'] is num
              ? json['boc'].toString()
              : json.valueAsString<String>('boc')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'boc': boc});
}

class EmulateMessageToWalletBody {
  /// Override the destination wallet address extracted from the BoC. Useful when the BoC was signed with a throwaway key and the real wallet address must be emulated against.
  final String? addressOverride;
  final String boc;

  /// additional per account configuration
  final List<EmulateMessageToWalletBodyParamsItem>? params;

  const EmulateMessageToWalletBody({
    this.addressOverride,
    required this.boc,
    this.params,
  });

  factory EmulateMessageToWalletBody.fromJson(Map<String, dynamic> json) {
    return EmulateMessageToWalletBody(
      addressOverride:
          (json['address_override'] is num
              ? json['address_override'].toString()
              : json.valueAsString<String?>('address_override')),
      boc:
          (json['boc'] is num
              ? json['boc'].toString()
              : json.valueAsString<String>('boc')),
      params:
          json.hasValue('params')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('params')
                  .map((e) => EmulateMessageToWalletBodyParamsItem.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_override': addressOverride,
    'boc': boc,
    'params': params?.map((e) => e.toJson(config: config)).toList(),
  });
}

class EmulateMessageToWalletBodyParamsItem {
  final String address;
  final BigInt? balance;

  const EmulateMessageToWalletBodyParamsItem({
    required this.address,
    this.balance,
  });

  factory EmulateMessageToWalletBodyParamsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return EmulateMessageToWalletBodyParamsItem(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      balance: json.valueAsBigInt<BigInt?>('balance'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'balance': config.encodeBigint(balance),
  });
}

class ExecGetMethodWithBodyForBlockchainAccountBody {
  final List<ExecGetMethodArg> args;

  const ExecGetMethodWithBodyForBlockchainAccountBody({required this.args});

  factory ExecGetMethodWithBodyForBlockchainAccountBody.fromJson(
    Map<String, dynamic> json,
  ) {
    return ExecGetMethodWithBodyForBlockchainAccountBody(
      args:
          json
              .valueEnsureAsList<Map<String, dynamic>>('args')
              .map((e) => ExecGetMethodArg.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'args': args.map((e) => e.toJson(config: config)).toList(),
  });
}

class FoundAccountsAddressesItem {
  final String address;
  final String name;
  final String preview;
  final TrustType trust;

  const FoundAccountsAddressesItem({
    required this.address,
    required this.name,
    required this.preview,
    required this.trust,
  });

  factory FoundAccountsAddressesItem.fromJson(Map<String, dynamic> json) {
    return FoundAccountsAddressesItem(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String>('name')),
      preview:
          (json['preview'] is num
              ? json['preview'].toString()
              : json.valueAsString<String>('preview')),
      trust: json.valueTo<TrustType, Object>(
        key: 'trust',
        parse: (e) => TrustType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'name': name,
    'preview': preview,
    'trust': trust.toJson(config: config),
  });
}

class GaslessConfigGasJettonsItem {
  final String masterId;

  const GaslessConfigGasJettonsItem({required this.masterId});

  factory GaslessConfigGasJettonsItem.fromJson(Map<String, dynamic> json) {
    return GaslessConfigGasJettonsItem(
      masterId:
          (json['master_id'] is num
              ? json['master_id'].toString()
              : json.valueAsString<String>('master_id')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'master_id': masterId});
}

class GaslessEstimateBody {
  final List<EmulateMessageToAccountEventBody> messages;
  final bool? returnEmulation;

  /// TONAPI verifies that the account has enough jettons to pay the commission and make a transfer.
  final bool? throwErrorIfNotEnoughJettons;
  final String walletAddress;
  final String walletPublicKey;

  const GaslessEstimateBody({
    required this.messages,
    this.returnEmulation,
    this.throwErrorIfNotEnoughJettons,
    required this.walletAddress,
    required this.walletPublicKey,
  });

  factory GaslessEstimateBody.fromJson(Map<String, dynamic> json) {
    return GaslessEstimateBody(
      messages:
          json
              .valueEnsureAsList<Map<String, dynamic>>('messages')
              .map((e) => EmulateMessageToAccountEventBody.fromJson(e))
              .toList(),
      returnEmulation: json.valueAsBool<bool?>('return_emulation'),
      throwErrorIfNotEnoughJettons: json.valueAsBool<bool?>(
        'throw_error_if_not_enough_jettons',
      ),
      walletAddress:
          (json['wallet_address'] is num
              ? json['wallet_address'].toString()
              : json.valueAsString<String>('wallet_address')),
      walletPublicKey:
          (json['wallet_public_key'] is num
              ? json['wallet_public_key'].toString()
              : json.valueAsString<String>('wallet_public_key')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'messages': messages.map((e) => e.toJson(config: config)).toList(),
    'return_emulation': returnEmulation,
    'throw_error_if_not_enough_jettons': throwErrorIfNotEnoughJettons,
    'wallet_address': walletAddress,
    'wallet_public_key': walletPublicKey,
  });
}

class GaslessSendBody {
  final String boc;

  /// hex encoded public key
  final String? walletPublicKey;

  const GaslessSendBody({required this.boc, this.walletPublicKey});

  factory GaslessSendBody.fromJson(Map<String, dynamic> json) {
    return GaslessSendBody(
      boc:
          (json['boc'] is num
              ? json['boc'].toString()
              : json.valueAsString<String>('boc')),
      walletPublicKey:
          (json['wallet_public_key'] is num
              ? json['wallet_public_key'].toString()
              : json.valueAsString<String?>('wallet_public_key')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'boc': boc,
    'wallet_public_key': walletPublicKey,
  });
}

class GetAccountInfoByStateInitBody {
  final String stateInit;

  const GetAccountInfoByStateInitBody({required this.stateInit});

  factory GetAccountInfoByStateInitBody.fromJson(Map<String, dynamic> json) {
    return GetAccountInfoByStateInitBody(
      stateInit:
          (json['state_init'] is num
              ? json['state_init'].toString()
              : json.valueAsString<String>('state_init')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'state_init': stateInit});
}

class GetAccountsBody {
  final List<String> accountIds;

  const GetAccountsBody({required this.accountIds});

  factory GetAccountsBody.fromJson(Map<String, dynamic> json) {
    return GetAccountsBody(
      accountIds: json.valueAsList<List<String>>('account_ids'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'account_ids': accountIds});
}

class GetWalletsByPublicKeyBulkBody {
  final List<String> publicKeys;

  const GetWalletsByPublicKeyBulkBody({required this.publicKeys});

  factory GetWalletsByPublicKeyBulkBody.fromJson(Map<String, dynamic> json) {
    return GetWalletsByPublicKeyBulkBody(
      publicKeys: json.valueAsList<List<String>>('public_keys'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'public_keys': publicKeys});
}

class JettonBalanceLock {
  final String amount;
  final BigInt till;

  const JettonBalanceLock({required this.amount, required this.till});

  factory JettonBalanceLock.fromJson(Map<String, dynamic> json) {
    return JettonBalanceLock(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
      till: json.valueAsBigInt<BigInt>('till'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'till': config.encodeBigint(till),
  });
}

class JettonHoldersAddressesItem {
  final String address;

  /// balance in the smallest jetton's units
  final String balance;
  final AccountAddress owner;

  const JettonHoldersAddressesItem({
    required this.address,
    required this.balance,
    required this.owner,
  });

  factory JettonHoldersAddressesItem.fromJson(Map<String, dynamic> json) {
    return JettonHoldersAddressesItem(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String>('balance')),
      owner: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'owner',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'balance': balance,
    'owner': owner.toJson(config: config),
  });
}

class MultisigOrderChangingParameters {
  final List<String> proposers;
  final List<String> signers;
  final int threshold;

  const MultisigOrderChangingParameters({
    required this.proposers,
    required this.signers,
    required this.threshold,
  });

  factory MultisigOrderChangingParameters.fromJson(Map<String, dynamic> json) {
    return MultisigOrderChangingParameters(
      proposers: json.valueAsList<List<String>>('proposers'),
      signers: json.valueAsList<List<String>>('signers'),
      threshold: json.valueAsInt<int>('threshold'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'proposers': proposers,
    'signers': signers,
    'threshold': threshold,
  });
}

class NftItemCollection {
  final String address;
  final String description;
  final String name;

  const NftItemCollection({
    required this.address,
    required this.description,
    required this.name,
  });

  factory NftItemCollection.fromJson(Map<String, dynamic> json) {
    return NftItemCollection(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString<String>('description')),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String>('name')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'description': description,
    'name': name,
  });
}

class ResponseAddressParse {
  final ResponseAddressParseBounceable bounceable;
  final String givenType;
  final ResponseAddressParseBounceable nonBounceable;
  final String rawForm;
  final bool testOnly;

  const ResponseAddressParse({
    required this.bounceable,
    required this.givenType,
    required this.nonBounceable,
    required this.rawForm,
    required this.testOnly,
  });

  factory ResponseAddressParse.fromJson(Map<String, dynamic> json) {
    return ResponseAddressParse(
      bounceable: json
          .valueTo<ResponseAddressParseBounceable, Map<String, dynamic>>(
            key: 'bounceable',
            parse: (v) => ResponseAddressParseBounceable.fromJson(v),
          ),
      givenType:
          (json['given_type'] is num
              ? json['given_type'].toString()
              : json.valueAsString<String>('given_type')),
      nonBounceable: json
          .valueTo<ResponseAddressParseBounceable, Map<String, dynamic>>(
            key: 'non_bounceable',
            parse: (v) => ResponseAddressParseBounceable.fromJson(v),
          ),
      rawForm:
          (json['raw_form'] is num
              ? json['raw_form'].toString()
              : json.valueAsString<String>('raw_form')),
      testOnly: json.valueAsBool<bool>('test_only'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bounceable': bounceable.toJson(config: config),
    'given_type': givenType,
    'non_bounceable': nonBounceable.toJson(config: config),
    'raw_form': rawForm,
    'test_only': testOnly,
  });
}

class ResponseAddressParseBounceable {
  final String b64;
  final String b64url;

  const ResponseAddressParseBounceable({
    required this.b64,
    required this.b64url,
  });

  factory ResponseAddressParseBounceable.fromJson(Map<String, dynamic> json) {
    return ResponseAddressParseBounceable(
      b64:
          (json['b64'] is num
              ? json['b64'].toString()
              : json.valueAsString<String>('b64')),
      b64url:
          (json['b64url'] is num
              ? json['b64url'].toString()
              : json.valueAsString<String>('b64url')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'b64': b64, 'b64url': b64url});
}

class ResponseGetAccountDiff {
  final BigInt balanceChange;

  const ResponseGetAccountDiff({required this.balanceChange});

  factory ResponseGetAccountDiff.fromJson(Map<String, dynamic> json) {
    return ResponseGetAccountDiff(
      balanceChange: json.valueAsBigInt<BigInt>('balance_change'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'balance_change': config.encodeBigint(balanceChange),
  });
}

class ResponseGetAccountPublicKey {
  final String publicKey;

  const ResponseGetAccountPublicKey({required this.publicKey});

  factory ResponseGetAccountPublicKey.fromJson(Map<String, dynamic> json) {
    return ResponseGetAccountPublicKey(
      publicKey:
          (json['public_key'] is num
              ? json['public_key'].toString()
              : json.valueAsString<String>('public_key')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'public_key': publicKey});
}

class ResponseGetAllRawShardsInfo {
  final String data;
  final BlockRaw id;
  final String proof;

  const ResponseGetAllRawShardsInfo({
    required this.data,
    required this.id,
    required this.proof,
  });

  factory ResponseGetAllRawShardsInfo.fromJson(Map<String, dynamic> json) {
    return ResponseGetAllRawShardsInfo(
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString<String>('data')),
      id: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      proof:
          (json['proof'] is num
              ? json['proof'].toString()
              : json.valueAsString<String>('proof')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'data': data,
    'id': id.toJson(config: config),
    'proof': proof,
  });
}

class ResponseGetChartRates {
  final ChartPoints points;

  const ResponseGetChartRates({required this.points});

  factory ResponseGetChartRates.fromJson(Map<String, dynamic> json) {
    return ResponseGetChartRates(
      points:
          json
              .valueEnsureAsList<dynamic>('points')
              .map(
                (e) =>
                    (e as List)
                        .map((e) => JsonParser.valueAsNum<num>(e))
                        .toList(),
              )
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'points': points});
}

class ResponseGetMarketsRates {
  final List<MarketTonRates> markets;

  const ResponseGetMarketsRates({required this.markets});

  factory ResponseGetMarketsRates.fromJson(Map<String, dynamic> json) {
    return ResponseGetMarketsRates(
      markets:
          json
              .valueEnsureAsList<Map<String, dynamic>>('markets')
              .map((e) => MarketTonRates.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'markets': markets.map((e) => e.toJson(config: config)).toList(),
  });
}

class ResponseGetOutMsgQueueSizes {
  final int extMsgQueueSizeLimit;
  final List<ResponseGetOutMsgQueueSizesShardsItem> shards;

  const ResponseGetOutMsgQueueSizes({
    required this.extMsgQueueSizeLimit,
    required this.shards,
  });

  factory ResponseGetOutMsgQueueSizes.fromJson(Map<String, dynamic> json) {
    return ResponseGetOutMsgQueueSizes(
      extMsgQueueSizeLimit: json.valueAsInt<int>('ext_msg_queue_size_limit'),
      shards:
          json
              .valueEnsureAsList<Map<String, dynamic>>('shards')
              .map((e) => ResponseGetOutMsgQueueSizesShardsItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'ext_msg_queue_size_limit': extMsgQueueSizeLimit,
    'shards': shards.map((e) => e.toJson(config: config)).toList(),
  });
}

class ResponseGetOutMsgQueueSizesShardsItem {
  final BlockRaw id;
  final int size;

  const ResponseGetOutMsgQueueSizesShardsItem({
    required this.id,
    required this.size,
  });

  factory ResponseGetOutMsgQueueSizesShardsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseGetOutMsgQueueSizesShardsItem(
      id: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      size: json.valueAsInt<int>('size'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'id': id.toJson(config: config),
    'size': size,
  });
}

class ResponseGetRates {
  final Map<String, TokenRates> rates;

  const ResponseGetRates({required this.rates});

  factory ResponseGetRates.fromJson(Map<String, dynamic> json) {
    return ResponseGetRates(
      rates: json
          .valueEnsureAsMap<String, dynamic>('rates')
          .map(
            (k, v) =>
                MapEntry(k, TokenRates.fromJson(v as Map<String, dynamic>)),
          ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'rates': rates.map((k, v) => MapEntry(k, v.toJson(config: config))),
  });
}

class ResponseGetRawAccountState {
  final BlockRaw id;
  final String proof;
  final String shardProof;
  final BlockRaw shardblk;
  final String state;

  const ResponseGetRawAccountState({
    required this.id,
    required this.proof,
    required this.shardProof,
    required this.shardblk,
    required this.state,
  });

  factory ResponseGetRawAccountState.fromJson(Map<String, dynamic> json) {
    return ResponseGetRawAccountState(
      id: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      proof:
          (json['proof'] is num
              ? json['proof'].toString()
              : json.valueAsString<String>('proof')),
      shardProof:
          (json['shard_proof'] is num
              ? json['shard_proof'].toString()
              : json.valueAsString<String>('shard_proof')),
      shardblk: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'shardblk',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      state:
          (json['state'] is num
              ? json['state'].toString()
              : json.valueAsString<String>('state')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'id': id.toJson(config: config),
    'proof': proof,
    'shard_proof': shardProof,
    'shardblk': shardblk.toJson(config: config),
    'state': state,
  });
}

class ResponseGetRawBlockProof {
  final bool complete;
  final BlockRaw from;
  final List<ResponseGetRawBlockProofStepsItem> steps;
  final BlockRaw to;

  const ResponseGetRawBlockProof({
    required this.complete,
    required this.from,
    required this.steps,
    required this.to,
  });

  factory ResponseGetRawBlockProof.fromJson(Map<String, dynamic> json) {
    return ResponseGetRawBlockProof(
      complete: json.valueAsBool<bool>('complete'),
      from: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'from',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      steps:
          json
              .valueEnsureAsList<Map<String, dynamic>>('steps')
              .map((e) => ResponseGetRawBlockProofStepsItem.fromJson(e))
              .toList(),
      to: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'to',
        parse: (v) => BlockRaw.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'complete': complete,
    'from': from.toJson(config: config),
    'steps': steps.map((e) => e.toJson(config: config)).toList(),
    'to': to.toJson(config: config),
  });
}

class ResponseGetRawBlockProofStepsItem {
  final ResponseGetRawBlockProofStepsItemLiteServerBlockLinkBack
  liteServerBlockLinkBack;
  final ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForward
  liteServerBlockLinkForward;

  const ResponseGetRawBlockProofStepsItem({
    required this.liteServerBlockLinkBack,
    required this.liteServerBlockLinkForward,
  });

  factory ResponseGetRawBlockProofStepsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseGetRawBlockProofStepsItem(
      liteServerBlockLinkBack: json.valueTo<
        ResponseGetRawBlockProofStepsItemLiteServerBlockLinkBack,
        Map<String, dynamic>
      >(
        key: 'lite_server_block_link_back',
        parse:
            (v) =>
                ResponseGetRawBlockProofStepsItemLiteServerBlockLinkBack.fromJson(
                  v,
                ),
      ),
      liteServerBlockLinkForward: json.valueTo<
        ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForward,
        Map<String, dynamic>
      >(
        key: 'lite_server_block_link_forward',
        parse:
            (v) =>
                ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForward.fromJson(
                  v,
                ),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'lite_server_block_link_back': liteServerBlockLinkBack.toJson(
      config: config,
    ),
    'lite_server_block_link_forward': liteServerBlockLinkForward.toJson(
      config: config,
    ),
  });
}

class ResponseGetRawBlockProofStepsItemLiteServerBlockLinkBack {
  final String destProof;
  final BlockRaw from;
  final String proof;
  final String stateProof;
  final BlockRaw to;
  final bool toKeyBlock;

  const ResponseGetRawBlockProofStepsItemLiteServerBlockLinkBack({
    required this.destProof,
    required this.from,
    required this.proof,
    required this.stateProof,
    required this.to,
    required this.toKeyBlock,
  });

  factory ResponseGetRawBlockProofStepsItemLiteServerBlockLinkBack.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseGetRawBlockProofStepsItemLiteServerBlockLinkBack(
      destProof:
          (json['dest_proof'] is num
              ? json['dest_proof'].toString()
              : json.valueAsString<String>('dest_proof')),
      from: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'from',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      proof:
          (json['proof'] is num
              ? json['proof'].toString()
              : json.valueAsString<String>('proof')),
      stateProof:
          (json['state_proof'] is num
              ? json['state_proof'].toString()
              : json.valueAsString<String>('state_proof')),
      to: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'to',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      toKeyBlock: json.valueAsBool<bool>('to_key_block'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'dest_proof': destProof,
    'from': from.toJson(config: config),
    'proof': proof,
    'state_proof': stateProof,
    'to': to.toJson(config: config),
    'to_key_block': toKeyBlock,
  });
}

class ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForward {
  final String configProof;
  final String destProof;
  final BlockRaw from;
  final ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForwardSignatures
  signatures;
  final BlockRaw to;
  final bool toKeyBlock;

  const ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForward({
    required this.configProof,
    required this.destProof,
    required this.from,
    required this.signatures,
    required this.to,
    required this.toKeyBlock,
  });

  factory ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForward.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForward(
      configProof:
          (json['config_proof'] is num
              ? json['config_proof'].toString()
              : json.valueAsString<String>('config_proof')),
      destProof:
          (json['dest_proof'] is num
              ? json['dest_proof'].toString()
              : json.valueAsString<String>('dest_proof')),
      from: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'from',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      signatures: json.valueTo<
        ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForwardSignatures,
        Map<String, dynamic>
      >(
        key: 'signatures',
        parse:
            (v) =>
                ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForwardSignatures.fromJson(
                  v,
                ),
      ),
      to: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'to',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      toKeyBlock: json.valueAsBool<bool>('to_key_block'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'config_proof': configProof,
    'dest_proof': destProof,
    'from': from.toJson(config: config),
    'signatures': signatures.toJson(config: config),
    'to': to.toJson(config: config),
    'to_key_block': toKeyBlock,
  });
}

class ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForwardSignatures {
  final int catchainSeqno;
  final List<
    ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesSignaturesItem
  >
  signatures;
  final BigInt validatorSetHash;

  const ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForwardSignatures({
    required this.catchainSeqno,
    required this.signatures,
    required this.validatorSetHash,
  });

  factory ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForwardSignatures.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForwardSignatures(
      catchainSeqno: json.valueAsInt<int>('catchain_seqno'),
      signatures:
          json
              .valueEnsureAsList<Map<String, dynamic>>('signatures')
              .map(
                (e) =>
                    ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesSignaturesItem.fromJson(
                      e,
                    ),
              )
              .toList(),
      validatorSetHash: json.valueAsBigInt<BigInt>('validator_set_hash'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'catchain_seqno': catchainSeqno,
    'signatures': signatures.map((e) => e.toJson(config: config)).toList(),
    'validator_set_hash': config.encodeBigint(validatorSetHash),
  });
}

class ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesSignaturesItem {
  final String nodeIdShort;
  final String signature;

  const ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesSignaturesItem({
    required this.nodeIdShort,
    required this.signature,
  });

  factory ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesSignaturesItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseGetRawBlockProofStepsItemLiteServerBlockLinkForwardSignaturesSignaturesItem(
      nodeIdShort:
          (json['node_id_short'] is num
              ? json['node_id_short'].toString()
              : json.valueAsString<String>('node_id_short')),
      signature:
          (json['signature'] is num
              ? json['signature'].toString()
              : json.valueAsString<String>('signature')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'node_id_short': nodeIdShort,
    'signature': signature,
  });
}

class ResponseGetRawBlockchainBlock {
  final String data;
  final BlockRaw id;

  const ResponseGetRawBlockchainBlock({required this.data, required this.id});

  factory ResponseGetRawBlockchainBlock.fromJson(Map<String, dynamic> json) {
    return ResponseGetRawBlockchainBlock(
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString<String>('data')),
      id: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => BlockRaw.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'data': data,
    'id': id.toJson(config: config),
  });
}

class ResponseGetRawBlockchainBlockHeader {
  final String headerProof;
  final BlockRaw id;
  final int mode;

  const ResponseGetRawBlockchainBlockHeader({
    required this.headerProof,
    required this.id,
    required this.mode,
  });

  factory ResponseGetRawBlockchainBlockHeader.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseGetRawBlockchainBlockHeader(
      headerProof:
          (json['header_proof'] is num
              ? json['header_proof'].toString()
              : json.valueAsString<String>('header_proof')),
      id: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      mode: json.valueAsInt<int>('mode'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'header_proof': headerProof,
    'id': id.toJson(config: config),
    'mode': mode,
  });
}

class ResponseGetRawBlockchainBlockState {
  final String data;
  final String fileHash;
  final BlockRaw id;
  final String rootHash;

  const ResponseGetRawBlockchainBlockState({
    required this.data,
    required this.fileHash,
    required this.id,
    required this.rootHash,
  });

  factory ResponseGetRawBlockchainBlockState.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseGetRawBlockchainBlockState(
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString<String>('data')),
      fileHash:
          (json['file_hash'] is num
              ? json['file_hash'].toString()
              : json.valueAsString<String>('file_hash')),
      id: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      rootHash:
          (json['root_hash'] is num
              ? json['root_hash'].toString()
              : json.valueAsString<String>('root_hash')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'data': data,
    'file_hash': fileHash,
    'id': id.toJson(config: config),
    'root_hash': rootHash,
  });
}

class ResponseGetRawConfig {
  final String configProof;
  final BlockRaw id;
  final int mode;
  final String stateProof;

  const ResponseGetRawConfig({
    required this.configProof,
    required this.id,
    required this.mode,
    required this.stateProof,
  });

  factory ResponseGetRawConfig.fromJson(Map<String, dynamic> json) {
    return ResponseGetRawConfig(
      configProof:
          (json['config_proof'] is num
              ? json['config_proof'].toString()
              : json.valueAsString<String>('config_proof')),
      id: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      mode: json.valueAsInt<int>('mode'),
      stateProof:
          (json['state_proof'] is num
              ? json['state_proof'].toString()
              : json.valueAsString<String>('state_proof')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'config_proof': configProof,
    'id': id.toJson(config: config),
    'mode': mode,
    'state_proof': stateProof,
  });
}

class ResponseGetRawListBlockTransactions {
  final BlockRaw id;
  final List<ResponseGetRawListBlockTransactionsIdsItem> ids;
  final bool incomplete;
  final String proof;
  final int reqCount;

  const ResponseGetRawListBlockTransactions({
    required this.id,
    required this.ids,
    required this.incomplete,
    required this.proof,
    required this.reqCount,
  });

  factory ResponseGetRawListBlockTransactions.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseGetRawListBlockTransactions(
      id: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      ids:
          json
              .valueEnsureAsList<Map<String, dynamic>>('ids')
              .map(
                (e) => ResponseGetRawListBlockTransactionsIdsItem.fromJson(e),
              )
              .toList(),
      incomplete: json.valueAsBool<bool>('incomplete'),
      proof:
          (json['proof'] is num
              ? json['proof'].toString()
              : json.valueAsString<String>('proof')),
      reqCount: json.valueAsInt<int>('req_count'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'id': id.toJson(config: config),
    'ids': ids.map((e) => e.toJson(config: config)).toList(),
    'incomplete': incomplete,
    'proof': proof,
    'req_count': reqCount,
  });
}

class ResponseGetRawListBlockTransactionsIdsItem {
  final String? account;
  final String? hash;
  final BigInt? lt;
  final int mode;

  const ResponseGetRawListBlockTransactionsIdsItem({
    this.account,
    this.hash,
    this.lt,
    required this.mode,
  });

  factory ResponseGetRawListBlockTransactionsIdsItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseGetRawListBlockTransactionsIdsItem(
      account:
          (json['account'] is num
              ? json['account'].toString()
              : json.valueAsString<String?>('account')),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String?>('hash')),
      lt: json.valueAsBigInt<BigInt?>('lt'),
      mode: json.valueAsInt<int>('mode'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'account': account,
    'hash': hash,
    'lt': config.encodeBigint(lt),
    'mode': mode,
  });
}

class ResponseGetRawMasterchainInfo {
  final InitStateRaw init;
  final BlockRaw last;
  final String stateRootHash;

  const ResponseGetRawMasterchainInfo({
    required this.init,
    required this.last,
    required this.stateRootHash,
  });

  factory ResponseGetRawMasterchainInfo.fromJson(Map<String, dynamic> json) {
    return ResponseGetRawMasterchainInfo(
      init: json.valueTo<InitStateRaw, Map<String, dynamic>>(
        key: 'init',
        parse: (v) => InitStateRaw.fromJson(v),
      ),
      last: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'last',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      stateRootHash:
          (json['state_root_hash'] is num
              ? json['state_root_hash'].toString()
              : json.valueAsString<String>('state_root_hash')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'init': init.toJson(config: config),
    'last': last.toJson(config: config),
    'state_root_hash': stateRootHash,
  });
}

class ResponseGetRawMasterchainInfoExt {
  final BigInt capabilities;
  final InitStateRaw init;
  final BlockRaw last;
  final int lastUtime;
  final int mode;
  final int now;
  final String stateRootHash;
  final int version;

  const ResponseGetRawMasterchainInfoExt({
    required this.capabilities,
    required this.init,
    required this.last,
    required this.lastUtime,
    required this.mode,
    required this.now,
    required this.stateRootHash,
    required this.version,
  });

  factory ResponseGetRawMasterchainInfoExt.fromJson(Map<String, dynamic> json) {
    return ResponseGetRawMasterchainInfoExt(
      capabilities: json.valueAsBigInt<BigInt>('capabilities'),
      init: json.valueTo<InitStateRaw, Map<String, dynamic>>(
        key: 'init',
        parse: (v) => InitStateRaw.fromJson(v),
      ),
      last: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'last',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      lastUtime: json.valueAsInt<int>('last_utime'),
      mode: json.valueAsInt<int>('mode'),
      now: json.valueAsInt<int>('now'),
      stateRootHash:
          (json['state_root_hash'] is num
              ? json['state_root_hash'].toString()
              : json.valueAsString<String>('state_root_hash')),
      version: json.valueAsInt<int>('version'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'capabilities': config.encodeBigint(capabilities),
    'init': init.toJson(config: config),
    'last': last.toJson(config: config),
    'last_utime': lastUtime,
    'mode': mode,
    'now': now,
    'state_root_hash': stateRootHash,
    'version': version,
  });
}

class ResponseGetRawShardBlockProof {
  final List<ResponseGetRawShardBlockProofLinksItem> links;
  final BlockRaw masterchainId;

  const ResponseGetRawShardBlockProof({
    required this.links,
    required this.masterchainId,
  });

  factory ResponseGetRawShardBlockProof.fromJson(Map<String, dynamic> json) {
    return ResponseGetRawShardBlockProof(
      links:
          json
              .valueEnsureAsList<Map<String, dynamic>>('links')
              .map((e) => ResponseGetRawShardBlockProofLinksItem.fromJson(e))
              .toList(),
      masterchainId: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'masterchain_id',
        parse: (v) => BlockRaw.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'links': links.map((e) => e.toJson(config: config)).toList(),
    'masterchain_id': masterchainId.toJson(config: config),
  });
}

class ResponseGetRawShardBlockProofLinksItem {
  final BlockRaw id;
  final String proof;

  const ResponseGetRawShardBlockProofLinksItem({
    required this.id,
    required this.proof,
  });

  factory ResponseGetRawShardBlockProofLinksItem.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseGetRawShardBlockProofLinksItem(
      id: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      proof:
          (json['proof'] is num
              ? json['proof'].toString()
              : json.valueAsString<String>('proof')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'id': id.toJson(config: config),
    'proof': proof,
  });
}

class ResponseGetRawShardInfo {
  final BlockRaw id;
  final String shardDescr;
  final String shardProof;
  final BlockRaw shardblk;

  const ResponseGetRawShardInfo({
    required this.id,
    required this.shardDescr,
    required this.shardProof,
    required this.shardblk,
  });

  factory ResponseGetRawShardInfo.fromJson(Map<String, dynamic> json) {
    return ResponseGetRawShardInfo(
      id: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => BlockRaw.fromJson(v),
      ),
      shardDescr:
          (json['shard_descr'] is num
              ? json['shard_descr'].toString()
              : json.valueAsString<String>('shard_descr')),
      shardProof:
          (json['shard_proof'] is num
              ? json['shard_proof'].toString()
              : json.valueAsString<String>('shard_proof')),
      shardblk: json.valueTo<BlockRaw, Map<String, dynamic>>(
        key: 'shardblk',
        parse: (v) => BlockRaw.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'id': id.toJson(config: config),
    'shard_descr': shardDescr,
    'shard_proof': shardProof,
    'shardblk': shardblk.toJson(config: config),
  });
}

class ResponseGetRawTime {
  final int time;

  const ResponseGetRawTime({required this.time});

  factory ResponseGetRawTime.fromJson(Map<String, dynamic> json) {
    return ResponseGetRawTime(time: json.valueAsInt<int>('time'));
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'time': time});
}

class ResponseGetRawTransactions {
  final List<BlockRaw> ids;
  final String transactions;

  const ResponseGetRawTransactions({
    required this.ids,
    required this.transactions,
  });

  factory ResponseGetRawTransactions.fromJson(Map<String, dynamic> json) {
    return ResponseGetRawTransactions(
      ids:
          json
              .valueEnsureAsList<Map<String, dynamic>>('ids')
              .map((e) => BlockRaw.fromJson(e))
              .toList(),
      transactions:
          (json['transactions'] is num
              ? json['transactions'].toString()
              : json.valueAsString<String>('transactions')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'ids': ids.map((e) => e.toJson(config: config)).toList(),
    'transactions': transactions,
  });
}

class ResponseGetStakingPoolHistory {
  final List<ApyHistory> apy;

  const ResponseGetStakingPoolHistory({required this.apy});

  factory ResponseGetStakingPoolHistory.fromJson(Map<String, dynamic> json) {
    return ResponseGetStakingPoolHistory(
      apy:
          json
              .valueEnsureAsList<Map<String, dynamic>>('apy')
              .map((e) => ApyHistory.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'apy': apy.map((e) => e.toJson(config: config)).toList(),
  });
}

class ResponseGetStakingPoolInfo {
  final PoolImplementation implementation;
  final PoolInfo pool;

  const ResponseGetStakingPoolInfo({
    required this.implementation,
    required this.pool,
  });

  factory ResponseGetStakingPoolInfo.fromJson(Map<String, dynamic> json) {
    return ResponseGetStakingPoolInfo(
      implementation: json.valueTo<PoolImplementation, Map<String, dynamic>>(
        key: 'implementation',
        parse: (v) => PoolImplementation.fromJson(v),
      ),
      pool: json.valueTo<PoolInfo, Map<String, dynamic>>(
        key: 'pool',
        parse: (v) => PoolInfo.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'implementation': implementation.toJson(config: config),
    'pool': pool.toJson(config: config),
  });
}

class ResponseGetStakingPools {
  final Map<String, PoolImplementation> implementations;
  final List<PoolInfo> pools;

  const ResponseGetStakingPools({
    required this.implementations,
    required this.pools,
  });

  factory ResponseGetStakingPools.fromJson(Map<String, dynamic> json) {
    return ResponseGetStakingPools(
      implementations: json
          .valueEnsureAsMap<String, dynamic>('implementations')
          .map(
            (k, v) => MapEntry(
              k,
              PoolImplementation.fromJson(v as Map<String, dynamic>),
            ),
          ),
      pools:
          json
              .valueEnsureAsList<Map<String, dynamic>>('pools')
              .map((e) => PoolInfo.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'implementations': implementations.map(
      (k, v) => MapEntry(k, v.toJson(config: config)),
    ),
    'pools': pools.map((e) => e.toJson(config: config)).toList(),
  });
}

class ResponseGetStorageProviders {
  final List<StorageProvider> providers;

  const ResponseGetStorageProviders({required this.providers});

  factory ResponseGetStorageProviders.fromJson(Map<String, dynamic> json) {
    return ResponseGetStorageProviders(
      providers:
          json
              .valueEnsureAsList<Map<String, dynamic>>('providers')
              .map((e) => StorageProvider.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'providers': providers.map((e) => e.toJson(config: config)).toList(),
  });
}

class ResponseGetTonConnectPayload {
  final String payload;

  const ResponseGetTonConnectPayload({required this.payload});

  factory ResponseGetTonConnectPayload.fromJson(Map<String, dynamic> json) {
    return ResponseGetTonConnectPayload(
      payload:
          (json['payload'] is num
              ? json['payload'].toString()
              : json.valueAsString<String>('payload')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'payload': payload});
}

class ResponseSendRawMessage {
  final int code;

  const ResponseSendRawMessage({required this.code});

  factory ResponseSendRawMessage.fromJson(Map<String, dynamic> json) {
    return ResponseSendRawMessage(code: json.valueAsInt<int>('code'));
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'code': code});
}

class ResponseTonConnectProof {
  final String token;

  const ResponseTonConnectProof({required this.token});

  factory ResponseTonConnectProof.fromJson(Map<String, dynamic> json) {
    return ResponseTonConnectProof(
      token:
          (json['token'] is num
              ? json['token'].toString()
              : json.valueAsString<String>('token')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'token': token});
}

class SendBlockchainMessageBody {
  final List<String>? batch;
  final String? boc;
  final Map<String, String>? meta;

  const SendBlockchainMessageBody({this.batch, this.boc, this.meta});

  factory SendBlockchainMessageBody.fromJson(Map<String, dynamic> json) {
    return SendBlockchainMessageBody(
      batch: json.valueAsList<List<String>?>('batch'),
      boc:
          (json['boc'] is num
              ? json['boc'].toString()
              : json.valueAsString<String?>('boc')),
      meta:
          json.hasValue('meta')
              ? json
                  .valueEnsureAsMap<String, dynamic>('meta')
                  .map(
                    (k, v) => MapEntry(
                      k,
                      (v is num
                          ? v.toString()
                          : JsonParser.valueAsString<String>(v)),
                    ),
                  )
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'batch': batch,
    'boc': boc,
    'meta': meta,
  });
}

class SendRawMessageBody {
  final String body;

  const SendRawMessageBody({required this.body});

  factory SendRawMessageBody.fromJson(Map<String, dynamic> json) {
    return SendRawMessageBody(
      body:
          (json['body'] is num
              ? json['body'].toString()
              : json.valueAsString<String>('body')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'body': body});
}

class TonConnectProofBody {
  final String address;
  final TonConnectProofBodyProof proof;

  const TonConnectProofBody({required this.address, required this.proof});

  factory TonConnectProofBody.fromJson(Map<String, dynamic> json) {
    return TonConnectProofBody(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      proof: json.valueTo<TonConnectProofBodyProof, Map<String, dynamic>>(
        key: 'proof',
        parse: (v) => TonConnectProofBodyProof.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'proof': proof.toJson(config: config),
  });
}

class TonConnectProofBodyProof {
  final TonConnectProofBodyProofDomain domain;
  final String payload;
  final String signature;
  final String? stateInit;
  final BigInt timestamp;

  const TonConnectProofBodyProof({
    required this.domain,
    required this.payload,
    required this.signature,
    this.stateInit,
    required this.timestamp,
  });

  factory TonConnectProofBodyProof.fromJson(Map<String, dynamic> json) {
    return TonConnectProofBodyProof(
      domain: json
          .valueTo<TonConnectProofBodyProofDomain, Map<String, dynamic>>(
            key: 'domain',
            parse: (v) => TonConnectProofBodyProofDomain.fromJson(v),
          ),
      payload:
          (json['payload'] is num
              ? json['payload'].toString()
              : json.valueAsString<String>('payload')),
      signature:
          (json['signature'] is num
              ? json['signature'].toString()
              : json.valueAsString<String>('signature')),
      stateInit:
          (json['state_init'] is num
              ? json['state_init'].toString()
              : json.valueAsString<String?>('state_init')),
      timestamp: json.valueAsBigInt<BigInt>('timestamp'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'domain': domain.toJson(config: config),
    'payload': payload,
    'signature': signature,
    'state_init': stateInit,
    'timestamp': config.encodeBigint(timestamp),
  });
}

class TonConnectProofBodyProofDomain {
  final int? lengthBytes;
  final String value;

  const TonConnectProofBodyProofDomain({this.lengthBytes, required this.value});

  factory TonConnectProofBodyProofDomain.fromJson(Map<String, dynamic> json) {
    return TonConnectProofBodyProofDomain(
      lengthBytes: json.valueAsInt<int?>('length_bytes'),
      value:
          (json['value'] is num
              ? json['value'].toString()
              : json.valueAsString<String>('value')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'length_bytes': lengthBytes,
    'value': value,
  });
}

class ValidatorsSetListItem {
  final String? adnlAddr;
  final String publicKey;
  final BigInt weight;

  const ValidatorsSetListItem({
    this.adnlAddr,
    required this.publicKey,
    required this.weight,
  });

  factory ValidatorsSetListItem.fromJson(Map<String, dynamic> json) {
    return ValidatorsSetListItem(
      adnlAddr:
          (json['adnl_addr'] is num
              ? json['adnl_addr'].toString()
              : json.valueAsString<String?>('adnl_addr')),
      publicKey:
          (json['public_key'] is num
              ? json['public_key'].toString()
              : json.valueAsString<String>('public_key')),
      weight: json.valueAsBigInt<BigInt>('weight'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'adnl_addr': adnlAddr,
    'public_key': publicKey,
    'weight': config.encodeBigint(weight),
  });
}

class ValueFlowJettonsItem {
  final AccountAddress account;
  final JettonPreview jetton;
  final String qty;
  final BigInt quantity;

  const ValueFlowJettonsItem({
    required this.account,
    required this.jetton,
    required this.qty,
    required this.quantity,
  });

  factory ValueFlowJettonsItem.fromJson(Map<String, dynamic> json) {
    return ValueFlowJettonsItem(
      account: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'account',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      jetton: json.valueTo<JettonPreview, Map<String, dynamic>>(
        key: 'jetton',
        parse: (v) => JettonPreview.fromJson(v),
      ),
      qty:
          (json['qty'] is num
              ? json['qty'].toString()
              : json.valueAsString<String>('qty')),
      quantity: json.valueAsBigInt<BigInt>('quantity'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'account': account.toJson(config: config),
    'jetton': jetton.toJson(config: config),
    'qty': qty,
    'quantity': config.encodeBigint(quantity),
  });
}
