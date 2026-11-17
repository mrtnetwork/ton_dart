// GENERATED CODE - DO NOT MODIFY BY HAND
// Source: OpenAPI 3.1.1
// TON HTTP API C++ v2.1.17-d745df7
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

typedef AddressBalanceRequest = AddressWithSeqnoRequest;

typedef AddressInformationRequest = AddressWithSeqnoRequest;

typedef AddressState = AccountStateEnum;

typedef AddressStateRequest = AddressWithSeqnoRequest;

typedef BlockTransactionsExtRequest = BlockTransactionsRequest;

typedef ConsensusBlockRequest = EmptyRequest;

typedef DetectAddressRequest = AddressRequest;

typedef ExtendedAddressInformationRequest = AddressWithSeqnoRequest;

typedef LegacyStackEntry = List<LegacyStackEntryItem>;

typedef LookupBlock = TonBlockIdExt;

typedef MasterchainBlockSignaturesRequest = SeqnoRequest;

typedef MasterchainInfoRequest = EmptyRequest;

typedef OutMsgQueueSizeRequest = EmptyRequest;

typedef PackAddressRequest = AddressRequest;

typedef ShardAccountCellRequest = AddressWithSeqnoRequest;

typedef ShardsRequest = SeqnoRequest;

typedef TokenDataRequest = AddressWithSeqnoRequest;

typedef Transactions = List<Transaction>;

typedef TryLocateResultTxRequest = TryLocateTxRequest;

typedef TryLocateSourceTxRequest = TryLocateTxRequest;

typedef UnpackAddressRequest = AddressRequest;

typedef WalletInformationRequest = AddressWithSeqnoRequest;

sealed class AccountState {
  const AccountState();

  factory AccountState.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['@type'] == "rwallet.accountState" &&
          map.hasValue('wallet_id') &&
          map.hasValue('seqno') &&
          map.hasValue('unlocked_balance') &&
          map.hasValue('config')) {
        return AccountStateAccountStateRWallet(
          AccountStateRWallet.fromJson(map),
        );
      }
      if (map['@type'] == "raw.accountState" &&
          map.hasValue('code') &&
          map.hasValue('data') &&
          map.hasValue('frozen_hash')) {
        return AccountStateAccountStateRaw(AccountStateRaw.fromJson(map));
      }
      if (map['@type'] == "pchan.accountState" &&
          map.hasValue('config') &&
          map.hasValue('state') &&
          map.hasValue('description')) {
        return AccountStateAccountStatePChan(AccountStatePChan.fromJson(map));
      }
      if (map['@type'] == "wallet.v3.accountState" &&
          map.hasValue('wallet_id') &&
          map.hasValue('seqno')) {
        return AccountStateAccountStateWalletV3(
          AccountStateWalletV3.fromJson(map),
        );
      }
      if (map['@type'] == "wallet.v4.accountState" &&
          map.hasValue('wallet_id') &&
          map.hasValue('seqno')) {
        return AccountStateAccountStateWalletV4(
          AccountStateWalletV4.fromJson(map),
        );
      }
      if (map['@type'] == "wallet.highload.v1.accountState" &&
          map.hasValue('wallet_id') &&
          map.hasValue('seqno')) {
        return AccountStateAccountStateWalletHighloadV1(
          AccountStateWalletHighloadV1.fromJson(map),
        );
      }
      if (map['@type'] == "wallet.highload.v2.accountState" &&
          map.hasValue('wallet_id')) {
        return AccountStateAccountStateWalletHighloadV2(
          AccountStateWalletHighloadV2.fromJson(map),
        );
      }
      if (map['@type'] == "dns.accountState" && map.hasValue('wallet_id')) {
        return AccountStateAccountStateDns(AccountStateDns.fromJson(map));
      }
      if (map['@type'] == "uninited.accountState" &&
          map.hasValue('frozen_hash')) {
        return AccountStateAccountStateUninited(
          AccountStateUninited.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'AccountState',
      reason: 'Cannot parse AccountState from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class AccountStateAccountStateRaw extends AccountState {
  final AccountStateRaw value;
  const AccountStateAccountStateRaw(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class AccountStateAccountStateWalletV3 extends AccountState {
  final AccountStateWalletV3 value;
  const AccountStateAccountStateWalletV3(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class AccountStateAccountStateWalletV4 extends AccountState {
  final AccountStateWalletV4 value;
  const AccountStateAccountStateWalletV4(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class AccountStateAccountStateWalletHighloadV1 extends AccountState {
  final AccountStateWalletHighloadV1 value;
  const AccountStateAccountStateWalletHighloadV1(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class AccountStateAccountStateWalletHighloadV2 extends AccountState {
  final AccountStateWalletHighloadV2 value;
  const AccountStateAccountStateWalletHighloadV2(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class AccountStateAccountStateDns extends AccountState {
  final AccountStateDns value;
  const AccountStateAccountStateDns(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class AccountStateAccountStateRWallet extends AccountState {
  final AccountStateRWallet value;
  const AccountStateAccountStateRWallet(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class AccountStateAccountStatePChan extends AccountState {
  final AccountStatePChan value;
  const AccountStateAccountStatePChan(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class AccountStateAccountStateUninited extends AccountState {
  final AccountStateUninited value;
  const AccountStateAccountStateUninited(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

/// Account lifecycle state: `uninitialized` (no contract deployed), `active` (contract deployed), or `frozen` (contract state frozen).
enum AccountStateEnum {
  uninitialized("uninitialized"),
  active("active"),
  frozen("frozen");

  final String value;
  const AccountStateEnum(this.value);

  static AccountStateEnum fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching AccountStateEnum found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

sealed class DnsEntryData {
  const DnsEntryData();

  factory DnsEntryData.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['@type'] == "dns.entryDataUnknown" && map.hasValue('bytes')) {
        return DnsEntryDataDnsEntryDataUnknown(
          DnsEntryDataUnknown.fromJson(map),
        );
      }
      if (map['@type'] == "dns.entryDataText" && map.hasValue('text')) {
        return DnsEntryDataDnsEntryDataText(DnsEntryDataText.fromJson(map));
      }
      if (map['@type'] == "dns.entryDataNextResolver" &&
          map.hasValue('resolver')) {
        return DnsEntryDataDnsEntryDataNextResolver(
          DnsEntryDataNextResolver.fromJson(map),
        );
      }
      if (map['@type'] == "dns.entryDataSmcAddress" &&
          map.hasValue('smc_address')) {
        return DnsEntryDataDnsEntryDataSmcAddress(
          DnsEntryDataSmcAddress.fromJson(map),
        );
      }
      if (map['@type'] == "dns.entryDataAdnlAddress" &&
          map.hasValue('adnl_address')) {
        return DnsEntryDataDnsEntryDataAdnlAddress(
          DnsEntryDataAdnlAddress.fromJson(map),
        );
      }
      if (map['@type'] == "dns.entryDataStorageAddress" &&
          map.hasValue('bag_id')) {
        return DnsEntryDataDnsEntryDataStorageAddress(
          DnsEntryDataStorageAddress.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'DnsEntryData',
      reason: 'Cannot parse DnsEntryData from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class DnsEntryDataDnsEntryDataUnknown extends DnsEntryData {
  final DnsEntryDataUnknown value;
  const DnsEntryDataDnsEntryDataUnknown(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class DnsEntryDataDnsEntryDataText extends DnsEntryData {
  final DnsEntryDataText value;
  const DnsEntryDataDnsEntryDataText(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class DnsEntryDataDnsEntryDataNextResolver extends DnsEntryData {
  final DnsEntryDataNextResolver value;
  const DnsEntryDataDnsEntryDataNextResolver(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class DnsEntryDataDnsEntryDataSmcAddress extends DnsEntryData {
  final DnsEntryDataSmcAddress value;
  const DnsEntryDataDnsEntryDataSmcAddress(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class DnsEntryDataDnsEntryDataAdnlAddress extends DnsEntryData {
  final DnsEntryDataAdnlAddress value;
  const DnsEntryDataDnsEntryDataAdnlAddress(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class DnsEntryDataDnsEntryDataStorageAddress extends DnsEntryData {
  final DnsEntryDataStorageAddress value;
  const DnsEntryDataDnsEntryDataStorageAddress(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

sealed class DnsRecord {
  const DnsRecord();

  factory DnsRecord.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['@type'] == "dns_storage_address" && map.hasValue('bag_id')) {
        return DnsRecordDnsRecordStorageAddress(
          DnsRecordStorageAddress.fromJson(map),
        );
      }
      if (map['@type'] == "dns_smc_address" && map.hasValue('smc_addr')) {
        return DnsRecordDnsRecordSmcAddress(DnsRecordSmcAddress.fromJson(map));
      }
      if (map['@type'] == "dns_adnl_address" && map.hasValue('adnl_addr')) {
        return DnsRecordDnsRecordAdnlAddress(
          DnsRecordAdnlAddress.fromJson(map),
        );
      }
      if (map['@type'] == "dns_next_resolver" && map.hasValue('resolver')) {
        return DnsRecordDnsRecordNextResolver(
          DnsRecordNextResolver.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'DnsRecord',
      reason: 'Cannot parse DnsRecord from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class DnsRecordDnsRecordStorageAddress extends DnsRecord {
  final DnsRecordStorageAddress value;
  const DnsRecordDnsRecordStorageAddress(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class DnsRecordDnsRecordSmcAddress extends DnsRecord {
  final DnsRecordSmcAddress value;
  const DnsRecordDnsRecordSmcAddress(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class DnsRecordDnsRecordAdnlAddress extends DnsRecord {
  final DnsRecordAdnlAddress value;
  const DnsRecordDnsRecordAdnlAddress(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class DnsRecordDnsRecordNextResolver extends DnsRecord {
  final DnsRecordNextResolver value;
  const DnsRecordDnsRecordNextResolver(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

sealed class MasterchainBlockSignatures {
  const MasterchainBlockSignatures();

  factory MasterchainBlockSignatures.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['@type'] == "blocks.blockSignatures.simplex" &&
          map.hasValue('id') &&
          map.hasValue('signatures') &&
          map.hasValue('session_id') &&
          map.hasValue('slot') &&
          map.hasValue('candidate')) {
        return MasterchainBlockSignaturesBlockSignaturesSimplex(
          BlockSignaturesSimplex.fromJson(map),
        );
      }
      if (map['@type'] == "blocks.blockSignatures" &&
          map.hasValue('id') &&
          map.hasValue('signatures')) {
        return MasterchainBlockSignaturesBlockSignatures(
          BlockSignatures.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'MasterchainBlockSignatures',
      reason: 'Cannot parse MasterchainBlockSignatures from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class MasterchainBlockSignaturesBlockSignatures
    extends MasterchainBlockSignatures {
  final BlockSignatures value;
  const MasterchainBlockSignaturesBlockSignatures(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class MasterchainBlockSignaturesBlockSignaturesSimplex
    extends MasterchainBlockSignatures {
  final BlockSignaturesSimplex value;
  const MasterchainBlockSignaturesBlockSignaturesSimplex(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

sealed class MsgData {
  const MsgData();

  factory MsgData.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['@type'] == "msg.dataRaw") {
        return MsgDataMsgDataRaw(MsgDataRaw.fromJson(map));
      }
      if (map['@type'] == "msg.dataText") {
        return MsgDataMsgDataText(MsgDataText.fromJson(map));
      }
      if (map['@type'] == "msg.dataDecryptedText") {
        return MsgDataMsgDataDecryptedText(MsgDataDecryptedText.fromJson(map));
      }
      if (map['@type'] == "msg.dataEncryptedText") {
        return MsgDataMsgDataEncryptedText(MsgDataEncryptedText.fromJson(map));
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'MsgData',
      reason: 'Cannot parse MsgData from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class MsgDataMsgDataRaw extends MsgData {
  final MsgDataRaw value;
  const MsgDataMsgDataRaw(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class MsgDataMsgDataText extends MsgData {
  final MsgDataText value;
  const MsgDataMsgDataText(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class MsgDataMsgDataDecryptedText extends MsgData {
  final MsgDataDecryptedText value;
  const MsgDataMsgDataDecryptedText(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class MsgDataMsgDataEncryptedText extends MsgData {
  final MsgDataEncryptedText value;
  const MsgDataMsgDataEncryptedText(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

sealed class PChanState {
  const PChanState();

  factory PChanState.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['@type'] == "pchan.stateInit" &&
          map.hasValue('signed_A') &&
          map.hasValue('signed_B') &&
          map.hasValue('min_A') &&
          map.hasValue('min_B') &&
          map.hasValue('expire_at') &&
          map.hasValue('A') &&
          map.hasValue('B')) {
        return PChanStatePChanStateInit(PChanStateInit.fromJson(map));
      }
      if (map['@type'] == "pchan.stateClose" &&
          map.hasValue('signed_A') &&
          map.hasValue('signed_B') &&
          map.hasValue('min_A') &&
          map.hasValue('min_B') &&
          map.hasValue('expire_at') &&
          map.hasValue('A') &&
          map.hasValue('B')) {
        return PChanStatePChanStateClose(PChanStateClose.fromJson(map));
      }
      if (map['@type'] == "pchan.statePayout" &&
          map.hasValue('A') &&
          map.hasValue('B')) {
        return PChanStatePChanStatePayout(PChanStatePayout.fromJson(map));
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'PChanState',
      reason: 'Cannot parse PChanState from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class PChanStatePChanStateInit extends PChanState {
  final PChanStateInit value;
  const PChanStatePChanStateInit(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class PChanStatePChanStateClose extends PChanState {
  final PChanStateClose value;
  const PChanStatePChanStateClose(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class PChanStatePChanStatePayout extends PChanState {
  final PChanStatePayout value;
  const PChanStatePChanStatePayout(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

sealed class SendBocResult {
  const SendBocResult();

  factory SendBocResult.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if ((map['@type'] == "ext.messageInfo" ||
              map['@type'] == "raw.extMessageInfo") &&
          map.hasValue('hash') &&
          map.hasValue('hash_norm')) {
        return SendBocResultExtMessageInfo(ExtMessageInfo.fromJson(map));
      }
      if (map['@type'] == "ok") {
        return SendBocResultResultOk(ResultOk.fromJson(map));
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'SendBocResult',
      reason: 'Cannot parse SendBocResult from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class SendBocResultResultOk extends SendBocResult {
  final ResultOk value;
  const SendBocResultResultOk(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class SendBocResultExtMessageInfo extends SendBocResult {
  final ExtMessageInfo value;
  const SendBocResultExtMessageInfo(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

/// Token metadata returned by getTokenData. Can be a Jetton master, Jetton wallet, NFT collection, or NFT item depending on which contract was queried.
sealed class TokenData {
  const TokenData();

  factory TokenData.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['@type'] == "ext.tokens.jettonMasterData" &&
          map.hasValue('address') &&
          map.hasValue('contract_type') &&
          map.hasValue('total_supply') &&
          map.hasValue('mintable') &&
          map.hasValue('jetton_content') &&
          map.hasValue('jetton_wallet_code')) {
        return TokenDataJettonMasterData(JettonMasterData.fromJson(map));
      }
      if (map['@type'] == "ext.tokens.jettonWalletData" &&
          map.hasValue('address') &&
          map.hasValue('contract_type') &&
          map.hasValue('balance') &&
          map.hasValue('owner') &&
          map.hasValue('jetton') &&
          map.hasValue('jetton_wallet_code')) {
        return TokenDataJettonWalletData(JettonWalletData.fromJson(map));
      }
      if (map['@type'] == "ext.tokens.nftItemData" &&
          map.hasValue('address') &&
          map.hasValue('contract_type') &&
          map.hasValue('init') &&
          map.hasValue('index') &&
          map.hasValue('content')) {
        return TokenDataNftItemData(NftItemData.fromJson(map));
      }
      if (map['@type'] == "ext.tokens.nftCollectionData" &&
          map.hasValue('address') &&
          map.hasValue('contract_type') &&
          map.hasValue('next_item_index') &&
          map.hasValue('collection_content')) {
        return TokenDataNftCollectionData(NftCollectionData.fromJson(map));
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TokenData',
      reason: 'Cannot parse TokenData from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class TokenDataJettonMasterData extends TokenData {
  final JettonMasterData value;
  const TokenDataJettonMasterData(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TokenDataJettonWalletData extends TokenData {
  final JettonWalletData value;
  const TokenDataJettonWalletData(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TokenDataNftCollectionData extends TokenData {
  final NftCollectionData value;
  const TokenDataNftCollectionData(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TokenDataNftItemData extends TokenData {
  final NftItemData value;
  const TokenDataNftItemData(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

sealed class TonlibObject {
  const TonlibObject();

  factory TonlibObject.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['@type'] == "blocks.header" &&
          map.hasValue('id') &&
          map.hasValue('global_id') &&
          map.hasValue('version') &&
          map.hasValue('after_merge') &&
          map.hasValue('after_split') &&
          map.hasValue('before_split') &&
          map.hasValue('want_merge') &&
          map.hasValue('want_split') &&
          map.hasValue('validator_list_hash_short') &&
          map.hasValue('catchain_seqno') &&
          map.hasValue('min_ref_mc_seqno') &&
          map.hasValue('is_key_block') &&
          map.hasValue('prev_key_block_seqno') &&
          map.hasValue('start_lt') &&
          map.hasValue('end_lt') &&
          map.hasValue('gen_utime') &&
          map.hasValue('prev_blocks')) {
        return TonlibObjectBlockHeader(BlockHeader.fromJson(map));
      }
      if (map['@type'] == "raw.fullAccountState" &&
          map.hasValue('balance') &&
          map.hasValue('extra_currencies') &&
          map.hasValue('code') &&
          map.hasValue('data') &&
          map.hasValue('last_transaction_id') &&
          map.hasValue('block_id') &&
          map.hasValue('frozen_hash') &&
          map.hasValue('sync_utime') &&
          map.hasValue('state')) {
        return TonlibObjectAddressInformation(AddressInformation.fromJson(map));
      }
      if (map['@type'] == "ext.transaction" &&
          map.hasValue('address') &&
          map.hasValue('account') &&
          map.hasValue('utime') &&
          map.hasValue('data') &&
          map.hasValue('transaction_id') &&
          map.hasValue('fee') &&
          map.hasValue('storage_fee') &&
          map.hasValue('other_fee') &&
          map.hasValue('out_msgs')) {
        return TonlibObjectTransaction(Transaction.fromJson(map));
      }
      if (map['@type'] == "fullAccountState" &&
          map.hasValue('address') &&
          map.hasValue('balance') &&
          map.hasValue('extra_currencies') &&
          map.hasValue('last_transaction_id') &&
          map.hasValue('block_id') &&
          map.hasValue('sync_utime') &&
          map.hasValue('account_state') &&
          map.hasValue('revision')) {
        return TonlibObjectExtendedAddressInformation(
          ExtendedAddressInformation.fromJson(map),
        );
      }
      if (map['@type'] == "ext.tokens.jettonMasterData" &&
          map.hasValue('address') &&
          map.hasValue('contract_type') &&
          map.hasValue('total_supply') &&
          map.hasValue('mintable') &&
          map.hasValue('jetton_content') &&
          map.hasValue('jetton_wallet_code')) {
        return TonlibObjectJettonMasterData(JettonMasterData.fromJson(map));
      }
      if (map['@type'] == "ext.tokens.jettonWalletData" &&
          map.hasValue('address') &&
          map.hasValue('contract_type') &&
          map.hasValue('balance') &&
          map.hasValue('owner') &&
          map.hasValue('jetton') &&
          map.hasValue('jetton_wallet_code')) {
        return TonlibObjectJettonWalletData(JettonWalletData.fromJson(map));
      }
      if ((map['@type'] == "ext.utils.detectAddress" ||
              map['@type'] == "ext.utils.detectedAddress") &&
          map.hasValue('raw_form') &&
          map.hasValue('bounceable') &&
          map.hasValue('non_bounceable') &&
          map.hasValue('given_type') &&
          map.hasValue('test_only')) {
        return TonlibObjectDetectAddress(DetectAddress.fromJson(map));
      }
      if (map['@type'] == "ext.tokens.nftItemData" &&
          map.hasValue('address') &&
          map.hasValue('contract_type') &&
          map.hasValue('init') &&
          map.hasValue('index') &&
          map.hasValue('content')) {
        return TonlibObjectNftItemData(NftItemData.fromJson(map));
      }
      if (map['@type'] == "blocks.blockSignatures.simplex" &&
          map.hasValue('id') &&
          map.hasValue('signatures') &&
          map.hasValue('session_id') &&
          map.hasValue('slot') &&
          map.hasValue('candidate')) {
        return TonlibObjectBlockSignaturesSimplex(
          BlockSignaturesSimplex.fromJson(map),
        );
      }
      if (map['@type'] == "ton.blockIdExt" &&
          map.hasValue('workchain') &&
          map.hasValue('shard') &&
          map.hasValue('seqno') &&
          map.hasValue('root_hash') &&
          map.hasValue('file_hash')) {
        return TonlibObjectTonBlockIdExt(TonBlockIdExt.fromJson(map));
      }
      if (map['@type'] == "ext.runResult" &&
          map.hasValue('gas_used') &&
          map.hasValue('stack') &&
          map.hasValue('exit_code') &&
          map.hasValue('block_id') &&
          map.hasValue('last_transaction_id')) {
        return TonlibObjectRunGetMethodResult(RunGetMethodResult.fromJson(map));
      }
      if (map['@type'] == "ext.accounts.walletInformation" &&
          map.hasValue('wallet') &&
          map.hasValue('balance') &&
          map.hasValue('account_state') &&
          map.hasValue('last_transaction_id')) {
        return TonlibObjectWalletInformation(WalletInformation.fromJson(map));
      }
      if (map['@type'] == "ext.tokens.nftCollectionData" &&
          map.hasValue('address') &&
          map.hasValue('contract_type') &&
          map.hasValue('next_item_index') &&
          map.hasValue('collection_content')) {
        return TonlibObjectNftCollectionData(NftCollectionData.fromJson(map));
      }
      if (map['@type'] == "blocks.shardBlockProof" &&
          map.hasValue('from') &&
          map.hasValue('mc_id') &&
          map.hasValue('links') &&
          map.hasValue('mc_proof')) {
        return TonlibObjectShardBlockProof(ShardBlockProof.fromJson(map));
      }
      if (map['@type'] == "blocks.transactions" &&
          map.hasValue('id') &&
          map.hasValue('req_count') &&
          map.hasValue('incomplete') &&
          map.hasValue('transactions')) {
        return TonlibObjectBlockTransactions(BlockTransactions.fromJson(map));
      }
      if (map['@type'] == "blocks.transactionsExt" &&
          map.hasValue('id') &&
          map.hasValue('req_count') &&
          map.hasValue('incomplete') &&
          map.hasValue('transactions')) {
        return TonlibObjectBlockTransactionsExt(
          BlockTransactionsExt.fromJson(map),
        );
      }
      if (map['@type'] == "ext.utils.detectedHash" &&
          map.hasValue('b64') &&
          map.hasValue('b64url') &&
          map.hasValue('hex')) {
        return TonlibObjectDetectHash(DetectHash.fromJson(map));
      }
      if (map['@type'] == "blocks.masterchainInfo" &&
          map.hasValue('last') &&
          map.hasValue('state_root_hash') &&
          map.hasValue('init')) {
        return TonlibObjectMasterchainInfo(MasterchainInfo.fromJson(map));
      }
      if (map['@type'] == "smc.runResult" &&
          map.hasValue('gas_used') &&
          map.hasValue('stack') &&
          map.hasValue('exit_code')) {
        return TonlibObjectRunGetMethodStdResult(
          RunGetMethodStdResult.fromJson(map),
        );
      }
      if (map['@type'] == "blocks.blockSignatures" &&
          map.hasValue('id') &&
          map.hasValue('signatures')) {
        return TonlibObjectBlockSignatures(BlockSignatures.fromJson(map));
      }
      if (map['@type'] == "ext.blocks.consensusBlock" &&
          map.hasValue('consensus_block') &&
          map.hasValue('timestamp')) {
        return TonlibObjectConsensusBlock(ConsensusBlock.fromJson(map));
      }
      if (map['@type'] == "blocks.blockData" &&
          map.hasValue('id') &&
          map.hasValue('data')) {
        return TonlibObjectBlockData(BlockData.fromJson(map));
      }
      if (map['@type'] == "blocks.outMsgQueueSizes" &&
          map.hasValue('shards') &&
          map.hasValue('ext_msg_queue_size_limit')) {
        return TonlibObjectOutMsgQueueSizes(OutMsgQueueSizes.fromJson(map));
      }
      if (map['@type'] == "raw.transactions" &&
          map.hasValue('transactions') &&
          map.hasValue('previous_transaction_id')) {
        return TonlibObjectTransactionsStd(TransactionsStd.fromJson(map));
      }
      if (map['@type'] == "query.fees" &&
          map.hasValue('source_fees') &&
          map.hasValue('destination_fees')) {
        return TonlibObjectQueryFees(QueryFees.fromJson(map));
      }
      if ((map['@type'] == "raw.extMessageInfo" ||
              map['@type'] == "ext.messageInfo") &&
          map.hasValue('hash') &&
          map.hasValue('hash_norm')) {
        return TonlibObjectExtMessageInfo(ExtMessageInfo.fromJson(map));
      }
      if (map['@type'] == "dns.resolved" && map.hasValue('entries')) {
        return TonlibObjectDnsResolved(DnsResolved.fromJson(map));
      }
      if (map['@type'] == "blocks.shards" && map.hasValue('shards')) {
        return TonlibObjectShards(Shards.fromJson(map));
      }
      if (map['@type'] == "configInfo" && map.hasValue('config')) {
        return TonlibObjectConfigInfo(ConfigInfo.fromJson(map));
      }
      if (map['@type'] == "smc.libraryResult" && map.hasValue('result')) {
        return TonlibObjectLibraryResult(LibraryResult.fromJson(map));
      }
      if (map['@type'] == "tvm.cell" && map.hasValue('bytes')) {
        return TonlibObjectTvmCell(TvmCell.fromJson(map));
      }
      if (map['@type'] == "ok") {
        return TonlibObjectResultOk(ResultOk.fromJson(map));
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TonlibObject',
      reason: 'Cannot parse TonlibObject from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class TonlibObjectDetectAddress extends TonlibObject {
  final DetectAddress value;
  const TonlibObjectDetectAddress(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectDetectHash extends TonlibObject {
  final DetectHash value;
  const TonlibObjectDetectHash(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectAddressInformation extends TonlibObject {
  final AddressInformation value;
  const TonlibObjectAddressInformation(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectExtendedAddressInformation extends TonlibObject {
  final ExtendedAddressInformation value;
  const TonlibObjectExtendedAddressInformation(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectWalletInformation extends TonlibObject {
  final WalletInformation value;
  const TonlibObjectWalletInformation(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectJettonMasterData extends TonlibObject {
  final JettonMasterData value;
  const TonlibObjectJettonMasterData(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectJettonWalletData extends TonlibObject {
  final JettonWalletData value;
  const TonlibObjectJettonWalletData(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectNftCollectionData extends TonlibObject {
  final NftCollectionData value;
  const TonlibObjectNftCollectionData(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectNftItemData extends TonlibObject {
  final NftItemData value;
  const TonlibObjectNftItemData(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectDnsResolved extends TonlibObject {
  final DnsResolved value;
  const TonlibObjectDnsResolved(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectMasterchainInfo extends TonlibObject {
  final MasterchainInfo value;
  const TonlibObjectMasterchainInfo(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectBlockSignatures extends TonlibObject {
  final BlockSignatures value;
  const TonlibObjectBlockSignatures(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectBlockSignaturesSimplex extends TonlibObject {
  final BlockSignaturesSimplex value;
  const TonlibObjectBlockSignaturesSimplex(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectShardBlockProof extends TonlibObject {
  final ShardBlockProof value;
  const TonlibObjectShardBlockProof(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectConsensusBlock extends TonlibObject {
  final ConsensusBlock value;
  const TonlibObjectConsensusBlock(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectTonBlockIdExt extends TonlibObject {
  final TonBlockIdExt value;
  const TonlibObjectTonBlockIdExt(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectShards extends TonlibObject {
  final Shards value;
  const TonlibObjectShards(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectBlockData extends TonlibObject {
  final BlockData value;
  const TonlibObjectBlockData(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectBlockHeader extends TonlibObject {
  final BlockHeader value;
  const TonlibObjectBlockHeader(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectOutMsgQueueSizes extends TonlibObject {
  final OutMsgQueueSizes value;
  const TonlibObjectOutMsgQueueSizes(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectBlockTransactions extends TonlibObject {
  final BlockTransactions value;
  const TonlibObjectBlockTransactions(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectBlockTransactionsExt extends TonlibObject {
  final BlockTransactionsExt value;
  const TonlibObjectBlockTransactionsExt(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectTransaction extends TonlibObject {
  final Transaction value;
  const TonlibObjectTransaction(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectTransactionsStd extends TonlibObject {
  final TransactionsStd value;
  const TonlibObjectTransactionsStd(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectConfigInfo extends TonlibObject {
  final ConfigInfo value;
  const TonlibObjectConfigInfo(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectLibraryResult extends TonlibObject {
  final LibraryResult value;
  const TonlibObjectLibraryResult(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectQueryFees extends TonlibObject {
  final QueryFees value;
  const TonlibObjectQueryFees(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectExtMessageInfo extends TonlibObject {
  final ExtMessageInfo value;
  const TonlibObjectExtMessageInfo(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectResultOk extends TonlibObject {
  final ResultOk value;
  const TonlibObjectResultOk(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectRunGetMethodStdResult extends TonlibObject {
  final RunGetMethodStdResult value;
  const TonlibObjectRunGetMethodStdResult(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectRunGetMethodResult extends TonlibObject {
  final RunGetMethodResult value;
  const TonlibObjectRunGetMethodResult(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class TonlibObjectTvmCell extends TonlibObject {
  final TvmCell value;
  const TonlibObjectTvmCell(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

/// TonLib type identifier for account address objects.
enum AccountAddressType {
  accountAddress("accountAddress");

  final String value;
  const AccountAddressType(this.value);

  static AccountAddressType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching AccountAddressType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for DNS resolver contracts.
enum AccountStateDnsType {
  dnsAccountState("dns.accountState");

  final String value;
  const AccountStateDnsType(this.value);

  static AccountStateDnsType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching AccountStateDnsType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for payment channel contracts.
enum AccountStatePChanType {
  pchanAccountState("pchan.accountState");

  final String value;
  const AccountStatePChanType(this.value);

  static AccountStatePChanType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching AccountStatePChanType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for restricted wallet contracts.
enum AccountStateRWalletType {
  rwalletAccountState("rwallet.accountState");

  final String value;
  const AccountStateRWalletType(this.value);

  static AccountStateRWalletType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching AccountStateRWalletType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for raw (unrecognized) contract states.
enum AccountStateRawType {
  rawAccountState("raw.accountState");

  final String value;
  const AccountStateRawType(this.value);

  static AccountStateRawType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching AccountStateRawType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for uninitialized accounts.
enum AccountStateUninitedType {
  uninitedAccountState("uninited.accountState");

  final String value;
  const AccountStateUninitedType(this.value);

  static AccountStateUninitedType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching AccountStateUninitedType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for Highload Wallet v1 contracts.
enum AccountStateWalletHighloadV1Type {
  walletHighloadV1AccountState("wallet.highload.v1.accountState");

  final String value;
  const AccountStateWalletHighloadV1Type(this.value);

  static AccountStateWalletHighloadV1Type fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching AccountStateWalletHighloadV1Type found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for Highload Wallet v2 contracts.
enum AccountStateWalletHighloadV2Type {
  walletHighloadV2AccountState("wallet.highload.v2.accountState");

  final String value;
  const AccountStateWalletHighloadV2Type(this.value);

  static AccountStateWalletHighloadV2Type fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching AccountStateWalletHighloadV2Type found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for Wallet v3 contracts.
enum AccountStateWalletV3Type {
  walletV3AccountState("wallet.v3.accountState");

  final String value;
  const AccountStateWalletV3Type(this.value);

  static AccountStateWalletV3Type fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching AccountStateWalletV3Type found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for Wallet v4 contracts.
enum AccountStateWalletV4Type {
  walletV4AccountState("wallet.v4.accountState");

  final String value;
  const AccountStateWalletV4Type(this.value);

  static AccountStateWalletV4Type fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching AccountStateWalletV4Type found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for full account state responses.
enum AddressInformationType {
  rawFullAccountState("raw.fullAccountState");

  final String value;
  const AddressInformationType(this.value);

  static AddressInformationType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching AddressInformationType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// Masterchain block sequence number. Query the account state as it was at this block height. If omitted, returns the current state.
sealed class AddressWithSeqnoRequestSeqno {
  const AddressWithSeqnoRequestSeqno();

  factory AddressWithSeqnoRequestSeqno.fromJson(dynamic json) {
    if (json is String) return AddressWithSeqnoRequestSeqnoStringValue(json);
    if (json is num) return AddressWithSeqnoRequestSeqnoInteger(json.toInt());
    throw CoreErrors.invalidOperationArguments(
      'AddressWithSeqnoRequestSeqno',
      reason: 'Cannot parse AddressWithSeqnoRequestSeqno from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class AddressWithSeqnoRequestSeqnoStringValue
    extends AddressWithSeqnoRequestSeqno {
  final String value;
  const AddressWithSeqnoRequestSeqnoStringValue(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

class AddressWithSeqnoRequestSeqnoInteger extends AddressWithSeqnoRequestSeqno {
  final int value;
  const AddressWithSeqnoRequestSeqnoInteger(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum AdnlAddressType {
  adnlAddress("adnlAddress");

  final String value;
  const AdnlAddressType(this.value);

  static AdnlAddressType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching AdnlAddressType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

sealed class BlockDataRequestArchival {
  const BlockDataRequestArchival();

  factory BlockDataRequestArchival.fromJson(dynamic json) {
    if (json is String) return BlockDataRequestArchivalStringValue(json);
    if (json is num) return BlockDataRequestArchivalInteger(json.toInt());
    if (json is bool) return BlockDataRequestArchivalBoolean(json);
    throw CoreErrors.invalidOperationArguments(
      'BlockDataRequestArchival',
      reason: 'Cannot parse BlockDataRequestArchival from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class BlockDataRequestArchivalStringValue extends BlockDataRequestArchival {
  final String value;
  const BlockDataRequestArchivalStringValue(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

class BlockDataRequestArchivalInteger extends BlockDataRequestArchival {
  final int value;
  const BlockDataRequestArchivalInteger(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

class BlockDataRequestArchivalBoolean extends BlockDataRequestArchival {
  final bool value;
  const BlockDataRequestArchivalBoolean(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum BlockDataType {
  blocksBlockData("blocks.blockData");

  final String value;
  const BlockDataType(this.value);

  static BlockDataType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching BlockDataType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for block header objects.
enum BlockHeaderType {
  blocksHeader("blocks.header");

  final String value;
  const BlockHeaderType(this.value);

  static BlockHeaderType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching BlockHeaderType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for backward block link proofs.
enum BlockLinkBackType {
  blocksBlockLinkBack("blocks.blockLinkBack");

  final String value;
  const BlockLinkBackType(this.value);

  static BlockLinkBackType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching BlockLinkBackType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for validator signature objects.
enum BlockSignatureType {
  blocksSignature("blocks.signature");

  final String value;
  const BlockSignatureType(this.value);

  static BlockSignatureType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching BlockSignatureType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum BlockSignaturesSimplexType {
  blocksBlockSignaturesSimplex("blocks.blockSignatures.simplex");

  final String value;
  const BlockSignaturesSimplexType(this.value);

  static BlockSignaturesSimplexType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching BlockSignaturesSimplexType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum BlockSignaturesType {
  blocksBlockSignatures("blocks.blockSignatures");

  final String value;
  const BlockSignaturesType(this.value);

  static BlockSignaturesType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching BlockSignaturesType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for extended block transaction listings.
enum BlockTransactionsExtType {
  blocksTransactionsExt("blocks.transactionsExt");

  final String value;
  const BlockTransactionsExtType(this.value);

  static BlockTransactionsExtType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching BlockTransactionsExtType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for block transaction listings.
enum BlockTransactionsType {
  blocksTransactions("blocks.transactions");

  final String value;
  const BlockTransactionsType(this.value);

  static BlockTransactionsType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching BlockTransactionsType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for blockchain configuration responses.
enum ConfigInfoType {
  configInfo("configInfo");

  final String value;
  const ConfigInfoType(this.value);

  static ConfigInfoType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching ConfigInfoType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for consensus block info.
enum ConsensusBlockType {
  extBlocksConsensusBlock("ext.blocks.consensusBlock");

  final String value;
  const ConsensusBlockType(this.value);

  static ConsensusBlockType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching ConsensusBlockType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for base64 address encoding variants.
enum DetectAddressBase64VariantType {
  extUtilsDetectedAddressVariant("ext.utils.detectedAddressVariant");

  final String value;
  const DetectAddressBase64VariantType(this.value);

  static DetectAddressBase64VariantType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound,
                "No matching DetectAddressBase64VariantType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// The encoding format of the address as provided in the request (e.g., `raw_form`, `dns`, `friendly_bounceable`, `friendly_non_bounceable`).
enum DetectAddressGivenType {
  rawForm("raw_form"),
  friendlyBounceable("friendly_bounceable"),
  friendlyNonBounceable("friendly_non_bounceable");

  final String value;
  const DetectAddressGivenType(this.value);

  static DetectAddressGivenType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching DetectAddressGivenType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for address detection results.
enum DetectAddressType {
  extUtilsDetectedAddress("ext.utils.detectedAddress"),

  /// Alternate spelling used by the TonlibObject discriminator in the spec.
  extUtilsDetectAddress("ext.utils.detectAddress");

  final String value;
  const DetectAddressType(this.value);

  static DetectAddressType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching DetectAddressType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for hash detection results.
enum DetectHashType {
  extUtilsDetectedHash("ext.utils.detectedHash");

  final String value;
  const DetectHashType(this.value);

  static DetectHashType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching DetectHashType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum DnsEntryDataAdnlAddressType {
  dnsEntryDataAdnlAddress("dns.entryDataAdnlAddress");

  final String value;
  const DnsEntryDataAdnlAddressType(this.value);

  static DnsEntryDataAdnlAddressType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching DnsEntryDataAdnlAddressType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum DnsEntryDataNextResolverType {
  dnsEntryDataNextResolver("dns.entryDataNextResolver");

  final String value;
  const DnsEntryDataNextResolverType(this.value);

  static DnsEntryDataNextResolverType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching DnsEntryDataNextResolverType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum DnsEntryDataSmcAddressType {
  dnsEntryDataSmcAddress("dns.entryDataSmcAddress");

  final String value;
  const DnsEntryDataSmcAddressType(this.value);

  static DnsEntryDataSmcAddressType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching DnsEntryDataSmcAddressType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum DnsEntryDataStorageAddressType {
  dnsEntryDataStorageAddress("dns.entryDataStorageAddress");

  final String value;
  const DnsEntryDataStorageAddressType(this.value);

  static DnsEntryDataStorageAddressType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching DnsEntryDataStorageAddressType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum DnsEntryDataTextType {
  dnsEntryDataText("dns.entryDataText");

  final String value;
  const DnsEntryDataTextType(this.value);

  static DnsEntryDataTextType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching DnsEntryDataTextType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum DnsEntryDataUnknownType {
  dnsEntryDataUnknown("dns.entryDataUnknown");

  final String value;
  const DnsEntryDataUnknownType(this.value);

  static DnsEntryDataUnknownType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching DnsEntryDataUnknownType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum DnsEntryType {
  dnsEntry("dns.entry");

  final String value;
  const DnsEntryType(this.value);

  static DnsEntryType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching DnsEntryType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for ADNL address DNS records.
enum DnsRecordAdnlAddressType {
  dnsAdnlAddress("dns_adnl_address");

  final String value;
  const DnsRecordAdnlAddressType(this.value);

  static DnsRecordAdnlAddressType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching DnsRecordAdnlAddressType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for next-resolver DNS records.
enum DnsRecordNextResolverType {
  dnsNextResolver("dns_next_resolver");

  final String value;
  const DnsRecordNextResolverType(this.value);

  static DnsRecordNextResolverType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching DnsRecordNextResolverType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for smart contract address DNS records.
enum DnsRecordSmcAddressType {
  dnsSmcAddress("dns_smc_address");

  final String value;
  const DnsRecordSmcAddressType(this.value);

  static DnsRecordSmcAddressType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching DnsRecordSmcAddressType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for TON Storage DNS records.
enum DnsRecordStorageAddressType {
  dnsStorageAddress("dns_storage_address");

  final String value;
  const DnsRecordStorageAddressType(this.value);

  static DnsRecordStorageAddressType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching DnsRecordStorageAddressType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

enum DnsResolvedType {
  dnsResolved("dns.resolved");

  final String value;
  const DnsResolvedType(this.value);

  static DnsResolvedType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching DnsResolvedType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for external message info after broadcast.
enum ExtMessageInfoType {
  rawExtMessageInfo("raw.extMessageInfo"),

  /// Alternate spelling used by the SendBocResult discriminator in the spec.
  extMessageInfo("ext.messageInfo");

  final String value;
  const ExtMessageInfoType(this.value);

  static ExtMessageInfoType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching ExtMessageInfoType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for extended account state responses.
enum ExtendedAddressInformationType {
  fullAccountState("fullAccountState");

  final String value;
  const ExtendedAddressInformationType(this.value);

  static ExtendedAddressInformationType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching ExtendedAddressInformationType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for extra currency balance entries.
enum ExtraCurrencyBalanceType {
  extraCurrency("extraCurrency");

  final String value;
  const ExtraCurrencyBalanceType(this.value);

  static ExtraCurrencyBalanceType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching ExtraCurrencyBalanceType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for fee breakdown objects.
enum FeesType {
  fees("fees");

  final String value;
  const FeesType(this.value);

  static FeesType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching FeesType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for transaction ID references.
enum InternalTransactionIdType {
  internalTransactionId("internal.transactionId");

  final String value;
  const InternalTransactionIdType(this.value);

  static InternalTransactionIdType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching InternalTransactionIdType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// Type of token contract: jetton_master, jetton_wallet, nft_collection, or nft_item.
enum JettonMasterDataContractType {
  jettonMaster("jetton_master");

  final String value;
  const JettonMasterDataContractType(this.value);

  static JettonMasterDataContractType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching JettonMasterDataContractType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for Jetton master contract data.
enum JettonMasterDataType {
  extTokensJettonMasterData("ext.tokens.jettonMasterData");

  final String value;
  const JettonMasterDataType(this.value);

  static JettonMasterDataType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching JettonMasterDataType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// Type of token contract: jetton_master, jetton_wallet, nft_collection, or nft_item.
enum JettonWalletDataContractType {
  jettonWallet("jetton_wallet");

  final String value;
  const JettonWalletDataContractType(this.value);

  static JettonWalletDataContractType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching JettonWalletDataContractType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for Jetton wallet contract data.
enum JettonWalletDataType {
  extTokensJettonWalletData("ext.tokens.jettonWalletData");

  final String value;
  const JettonWalletDataType(this.value);

  static JettonWalletDataType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching JettonWalletDataType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// The method return value. The structure depends on the method called; see individual method documentation for response schemas. Only present when `ok` is `true`.
sealed class JsonRpcResponseResult {
  const JsonRpcResponseResult();

  factory JsonRpcResponseResult.fromJson(dynamic json) {
    if (json is String) return JsonRpcResponseResultStringValue(json);
    if (json is List) {
      return JsonRpcResponseResultList3(
        json.map((e) => TonlibObject.fromJson(e)).toList(),
      );
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      try {
        return JsonRpcResponseResultTonlibObject(TonlibObject.fromJson(map));
      } catch (_) {}
      try {
        return JsonRpcResponseResultAccountStateEnum(
          AccountStateEnum.fromJson(map),
        );
      } catch (_) {}
    }
    try {
      return JsonRpcResponseResultAccountStateEnum(
        AccountStateEnum.fromJson(json),
      );
    } catch (_) {}
    try {
      return JsonRpcResponseResultTonlibObject(TonlibObject.fromJson(json));
    } catch (_) {}
    throw CoreErrors.invalidOperationArguments(
      'JsonRpcResponseResult',
      reason: 'Cannot parse JsonRpcResponseResult from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class JsonRpcResponseResultStringValue extends JsonRpcResponseResult {
  final String value;
  const JsonRpcResponseResultStringValue(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

class JsonRpcResponseResultAccountStateEnum extends JsonRpcResponseResult {
  final AccountStateEnum value;
  const JsonRpcResponseResultAccountStateEnum(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class JsonRpcResponseResultTonlibObject extends JsonRpcResponseResult {
  final TonlibObject value;
  const JsonRpcResponseResultTonlibObject(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class JsonRpcResponseResultList3 extends JsonRpcResponseResult {
  final List<TonlibObject> value;
  const JsonRpcResponseResultList3(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.map((e) => e.toJson(config: config)).toList();
}

sealed class LegacyStackEntryItem {
  const LegacyStackEntryItem();

  factory LegacyStackEntryItem.fromJson(dynamic json) {
    if (json is String) return LegacyStackEntryItemStringValue(json);
    if (json is num) {
      return LegacyStackEntryItemInteger(BigInt.from(json.toInt()));
    }
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['@type'] == "tvm.tuple" && map.hasValue('elements')) {
        return LegacyStackEntryItemTypeElements.fromJson(map);
      }
      if (map['@type'] == "tvm.list" && map.hasValue('elements')) {
        return LegacyStackEntryItemTypeElements2.fromJson(map);
      }
      if (map.hasValue('bytes')) {
        return LegacyStackEntryItemLegacyStackEntryCell(
          LegacyStackEntryCell.fromJson(map),
        );
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'LegacyStackEntryItem',
      reason: 'Cannot parse LegacyStackEntryItem from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class LegacyStackEntryItemStringValue extends LegacyStackEntryItem {
  final String value;
  const LegacyStackEntryItemStringValue(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

class LegacyStackEntryItemInteger extends LegacyStackEntryItem {
  final BigInt value;
  const LegacyStackEntryItemInteger(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeBigint(value);
}

class LegacyStackEntryItemLegacyStackEntryCell extends LegacyStackEntryItem {
  final LegacyStackEntryCell value;
  const LegacyStackEntryItemLegacyStackEntryCell(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class LegacyStackEntryItemTypeElements extends LegacyStackEntryItem {
  /// TonLib type identifier for TVM tuple structures.
  final TvmTupleType type;

  /// Ordered tuple of TVM stack entries. Each element is a typed object with `@type` discriminator (`tvm.stackEntryNumber`, `tvm.stackEntryCell`, `tvm.stackEntrySlice`, `tvm.stackEntryTuple`, or `tvm.stackEntryList`).
  final List<RunGetMethodStdResultStackItem> elements;

  const LegacyStackEntryItemTypeElements({
    required this.type,
    required this.elements,
  });

  factory LegacyStackEntryItemTypeElements.fromJson(Map<String, dynamic> json) {
    return LegacyStackEntryItemTypeElements(
      type: json.valueTo<TvmTupleType, Object>(
        key: '@type',
        parse: (e) => TvmTupleType.fromJson(JsonParser.valueAs(e)),
      ),
      elements:
          json
              .valueEnsureAsList<dynamic>('elements')
              .map((e) => RunGetMethodStdResultStackItem.fromJson(e))
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'elements': elements.map((e) => e.toJson(config: config)).toList(),
  });
}

class LegacyStackEntryItemTypeElements2 extends LegacyStackEntryItem {
  /// TonLib type identifier for TVM list structures.
  final TvmListType type;

  /// Ordered list of TVM stack entries. Each element is a typed object with `@type` discriminator (`tvm.stackEntryNumber`, `tvm.stackEntryCell`, `tvm.stackEntrySlice`, `tvm.stackEntryTuple`, or `tvm.stackEntryList`).
  final List<RunGetMethodStdResultStackItem> elements;

  const LegacyStackEntryItemTypeElements2({
    required this.type,
    required this.elements,
  });

  factory LegacyStackEntryItemTypeElements2.fromJson(
    Map<String, dynamic> json,
  ) {
    return LegacyStackEntryItemTypeElements2(
      type: json.valueTo<TvmListType, Object>(
        key: '@type',
        parse: (e) => TvmListType.fromJson(JsonParser.valueAs(e)),
      ),
      elements:
          json
              .valueEnsureAsList<dynamic>('elements')
              .map((e) => RunGetMethodStdResultStackItem.fromJson(e))
              .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'elements': elements.map((e) => e.toJson(config: config)).toList(),
  });
}

/// TonLib type identifier for shared library cell entries.
enum LibraryEntryType {
  smcLibraryEntry("smc.libraryEntry");

  final String value;
  const LibraryEntryType(this.value);

  static LibraryEntryType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching LibraryEntryType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for library lookup results.
enum LibraryResultType {
  smcLibraryResult("smc.libraryResult");

  final String value;
  const LibraryResultType(this.value);

  static LibraryResultType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching LibraryResultType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for masterchain state info.
enum MasterchainInfoType {
  blocksMasterchainInfo("blocks.masterchainInfo");

  final String value;
  const MasterchainInfoType(this.value);

  static MasterchainInfoType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching MasterchainInfoType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for raw message objects.
enum MessageStdType {
  rawMessage("raw.message");

  final String value;
  const MessageStdType(this.value);

  static MessageStdType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching MessageStdType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for extended message objects with decoded comments.
enum MessageType {
  extMessage("ext.message");

  final String value;
  const MessageType(this.value);

  static MessageType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching MessageType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for decrypted text message bodies.
enum MsgDataDecryptedTextType {
  msgDataDecryptedText("msg.dataDecryptedText");

  final String value;
  const MsgDataDecryptedTextType(this.value);

  static MsgDataDecryptedTextType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching MsgDataDecryptedTextType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for encrypted text message bodies.
enum MsgDataEncryptedTextType {
  msgDataEncryptedText("msg.dataEncryptedText");

  final String value;
  const MsgDataEncryptedTextType(this.value);

  static MsgDataEncryptedTextType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching MsgDataEncryptedTextType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for raw (binary) message bodies.
enum MsgDataRawType {
  msgDataRaw("msg.dataRaw");

  final String value;
  const MsgDataRawType(this.value);

  static MsgDataRawType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching MsgDataRawType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for plain text comment message bodies.
enum MsgDataTextType {
  msgDataText("msg.dataText");

  final String value;
  const MsgDataTextType(this.value);

  static MsgDataTextType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching MsgDataTextType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// Type of token contract: jetton_master, jetton_wallet, nft_collection, or nft_item.
enum NftCollectionDataContractType {
  nftCollection("nft_collection");

  final String value;
  const NftCollectionDataContractType(this.value);

  static NftCollectionDataContractType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching NftCollectionDataContractType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for NFT collection contract data.
enum NftCollectionDataType {
  extTokensNftCollectionData("ext.tokens.nftCollectionData");

  final String value;
  const NftCollectionDataType(this.value);

  static NftCollectionDataType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching NftCollectionDataType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// NFT item metadata and content (name, description, image URL).
sealed class NftItemDataContent {
  const NftItemDataContent();

  factory NftItemDataContent.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map.hasValue('type') && map.hasValue('data')) {
        return NftItemDataContentTokenContent(TokenContent.fromJson(map));
      }
      if (map.hasValue('domain') && map.hasValue('data')) {
        return NftItemDataContentDnsContent(DnsContent.fromJson(map));
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'NftItemDataContent',
      reason: 'Cannot parse NftItemDataContent from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class NftItemDataContentTokenContent extends NftItemDataContent {
  final TokenContent value;
  const NftItemDataContentTokenContent(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

class NftItemDataContentDnsContent extends NftItemDataContent {
  final DnsContent value;
  const NftItemDataContentDnsContent(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

/// Type of token contract: jetton_master, jetton_wallet, nft_collection, or nft_item.
enum NftItemDataContractType {
  nftItem("nft_item");

  final String value;
  const NftItemDataContractType(this.value);

  static NftItemDataContractType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching NftItemDataContractType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for NFT item contract data.
enum NftItemDataType {
  extTokensNftItemData("ext.tokens.nftItemData");

  final String value;
  const NftItemDataType(this.value);

  static NftItemDataType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching NftItemDataType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for per-shard queue size entries.
enum OutMsgQueueSizeType {
  blocksOutMsgQueueSize("blocks.outMsgQueueSize");

  final String value;
  const OutMsgQueueSizeType(this.value);

  static OutMsgQueueSizeType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching OutMsgQueueSizeType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for outgoing message queue size responses.
enum OutMsgQueueSizesType {
  blocksOutMsgQueueSizes("blocks.outMsgQueueSizes");

  final String value;
  const OutMsgQueueSizesType(this.value);

  static OutMsgQueueSizesType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching OutMsgQueueSizesType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for payment channel configuration.
enum PChanConfigType {
  pchanConfig("pchan.config");

  final String value;
  const PChanConfigType(this.value);

  static PChanConfigType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching PChanConfigType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for payment channels in the closing phase.
enum PChanStateCloseType {
  pchanStateClose("pchan.stateClose");

  final String value;
  const PChanStateCloseType(this.value);

  static PChanStateCloseType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching PChanStateCloseType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for payment channels in the initialization phase.
enum PChanStateInitType {
  pchanStateInit("pchan.stateInit");

  final String value;
  const PChanStateInitType(this.value);

  static PChanStateInitType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching PChanStateInitType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for payment channels in the payout phase.
enum PChanStatePayoutType {
  pchanStatePayout("pchan.statePayout");

  final String value;
  const PChanStatePayoutType(this.value);

  static PChanStatePayoutType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching PChanStatePayoutType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for fee estimation results.
enum QueryFeesType {
  queryFees("query.fees");

  final String value;
  const QueryFeesType(this.value);

  static QueryFeesType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching QueryFeesType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for restricted wallet configuration.
enum RWalletConfigType {
  rwalletConfig("rwallet.config");

  final String value;
  const RWalletConfigType(this.value);

  static RWalletConfigType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching RWalletConfigType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for restricted wallet spending limit rules.
enum RWalletLimitType {
  rwalletLimit("rwallet.limit");

  final String value;
  const RWalletLimitType(this.value);

  static RWalletLimitType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching RWalletLimitType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for successful operations with no return data.
enum ResultOkType {
  ok("ok");

  final String value;
  const ResultOkType(this.value);

  static ResultOkType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching ResultOkType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// The get method name (e.g., `seqno`, `get_wallet_data`) or its numeric ID.
sealed class RunGetMethodRequestMethod {
  const RunGetMethodRequestMethod();

  factory RunGetMethodRequestMethod.fromJson(dynamic json) {
    if (json is String) return RunGetMethodRequestMethodStringValue(json);
    if (json is num) return RunGetMethodRequestMethodInteger(json.toInt());
    throw CoreErrors.invalidOperationArguments(
      'RunGetMethodRequestMethod',
      reason: 'Cannot parse RunGetMethodRequestMethod from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class RunGetMethodRequestMethodStringValue extends RunGetMethodRequestMethod {
  final String value;
  const RunGetMethodRequestMethodStringValue(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

class RunGetMethodRequestMethodInteger extends RunGetMethodRequestMethod {
  final int value;
  const RunGetMethodRequestMethodInteger(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

sealed class RunGetMethodStdResultStackItem {
  const RunGetMethodStdResultStackItem();

  factory RunGetMethodStdResultStackItem.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['@type'] == "tvm.stackEntrySlice" && map.hasValue('slice')) {
        return RunGetMethodStdResultStackItemTypeSlice.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryCell" && map.hasValue('cell')) {
        return RunGetMethodStdResultStackItemTypeCell.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryNumber" && map.hasValue('number')) {
        return RunGetMethodStdResultStackItemTypeNumber.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryTuple" && map.hasValue('tuple')) {
        return RunGetMethodStdResultStackItemTypeTuple.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryList" && map.hasValue('list')) {
        return RunGetMethodStdResultStackItemTypeList.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryUnsupported") {
        return RunGetMethodStdResultStackItemType.fromJson(map);
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'RunGetMethodStdResultStackItem',
      reason: 'Cannot parse RunGetMethodStdResultStackItem from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class RunGetMethodStdResultStackItemTypeSlice
    extends RunGetMethodStdResultStackItem {
  /// TonLib type identifier for slice-typed stack entries.
  final RunGetMethodStdResultStackItemTypeSliceType type;

  /// The TVM slice value.
  final TvmSlice slice;

  const RunGetMethodStdResultStackItemTypeSlice({
    required this.type,
    required this.slice,
  });

  factory RunGetMethodStdResultStackItemTypeSlice.fromJson(
    Map<String, dynamic> json,
  ) {
    return RunGetMethodStdResultStackItemTypeSlice(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeSliceType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeSliceType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      slice: json.valueTo<TvmSlice, Map<String, dynamic>>(
        key: 'slice',
        parse: (v) => TvmSlice.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'slice': slice.toJson(config: config),
  });
}

class RunGetMethodStdResultStackItemTypeCell
    extends RunGetMethodStdResultStackItem {
  /// TonLib type identifier for cell-typed stack entries.
  final RunGetMethodStdResultStackItemTypeCellType type;

  /// The TVM cell value.
  final TvmCell cell;

  const RunGetMethodStdResultStackItemTypeCell({
    required this.type,
    required this.cell,
  });

  factory RunGetMethodStdResultStackItemTypeCell.fromJson(
    Map<String, dynamic> json,
  ) {
    return RunGetMethodStdResultStackItemTypeCell(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeCellType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeCellType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      cell: json.valueTo<TvmCell, Map<String, dynamic>>(
        key: 'cell',
        parse: (v) => TvmCell.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'cell': cell.toJson(config: config),
  });
}

class RunGetMethodStdResultStackItemTypeNumber
    extends RunGetMethodStdResultStackItem {
  /// TonLib type identifier for number-typed stack entries.
  final RunGetMethodStdResultStackItemTypeNumberType type;

  /// The TVM number value (arbitrary-precision decimal).
  final TvmNumberDecimal number;

  const RunGetMethodStdResultStackItemTypeNumber({
    required this.type,
    required this.number,
  });

  factory RunGetMethodStdResultStackItemTypeNumber.fromJson(
    Map<String, dynamic> json,
  ) {
    return RunGetMethodStdResultStackItemTypeNumber(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeNumberType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeNumberType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      number: json.valueTo<TvmNumberDecimal, Map<String, dynamic>>(
        key: 'number',
        parse: (v) => TvmNumberDecimal.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'number': number.toJson(config: config),
  });
}

class RunGetMethodStdResultStackItemTypeTuple
    extends RunGetMethodStdResultStackItem {
  /// TonLib type identifier for tuple-typed stack entries.
  final RunGetMethodStdResultStackItemTypeTupleType type;

  /// The TVM tuple value.
  final TvmTuple tuple;

  const RunGetMethodStdResultStackItemTypeTuple({
    required this.type,
    required this.tuple,
  });

  factory RunGetMethodStdResultStackItemTypeTuple.fromJson(
    Map<String, dynamic> json,
  ) {
    return RunGetMethodStdResultStackItemTypeTuple(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeTupleType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeTupleType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      tuple: json.valueTo<TvmTuple, Map<String, dynamic>>(
        key: 'tuple',
        parse: (v) => TvmTuple.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'tuple': tuple.toJson(config: config),
  });
}

class RunGetMethodStdResultStackItemTypeList
    extends RunGetMethodStdResultStackItem {
  /// TonLib type identifier for list-typed stack entries.
  final TvmTupleElementsItemTypeListType type;

  /// The TVM list value.
  final TvmList list;

  const RunGetMethodStdResultStackItemTypeList({
    required this.type,
    required this.list,
  });

  factory RunGetMethodStdResultStackItemTypeList.fromJson(
    Map<String, dynamic> json,
  ) {
    return RunGetMethodStdResultStackItemTypeList(
      type: json.valueTo<TvmTupleElementsItemTypeListType, Object>(
        key: '@type',
        parse:
            (e) => TvmTupleElementsItemTypeListType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      list: json.valueTo<TvmList, Map<String, dynamic>>(
        key: 'list',
        parse: (v) => TvmList.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'list': list.toJson(config: config),
  });
}

class RunGetMethodStdResultStackItemType
    extends RunGetMethodStdResultStackItem {
  /// TonLib type identifier for stack entries with unsupported types.
  final TvmListElementsItemTypeType type;

  const RunGetMethodStdResultStackItemType({required this.type});

  factory RunGetMethodStdResultStackItemType.fromJson(
    Map<String, dynamic> json,
  ) {
    return RunGetMethodStdResultStackItemType(
      type: json.valueTo<TvmListElementsItemTypeType, Object>(
        key: '@type',
        parse:
            (e) => TvmListElementsItemTypeType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) =>
      config.encodeMap(<String, dynamic>{'@type': type.toJson(config: config)});
}

/// TonLib type identifier for cell-typed stack entries.
enum RunGetMethodStdResultStackItemTypeCellType {
  tvmStackEntryCell("tvm.stackEntryCell");

  final String value;
  const RunGetMethodStdResultStackItemTypeCellType(this.value);

  static RunGetMethodStdResultStackItemTypeCellType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching RunGetMethodStdResultStackItemTypeCellType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for number-typed stack entries.
enum RunGetMethodStdResultStackItemTypeNumberType {
  tvmStackEntryNumber("tvm.stackEntryNumber");

  final String value;
  const RunGetMethodStdResultStackItemTypeNumberType(this.value);

  static RunGetMethodStdResultStackItemTypeNumberType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching RunGetMethodStdResultStackItemTypeNumberType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for slice-typed stack entries.
enum RunGetMethodStdResultStackItemTypeSliceType {
  tvmStackEntrySlice("tvm.stackEntrySlice");

  final String value;
  const RunGetMethodStdResultStackItemTypeSliceType(this.value);

  static RunGetMethodStdResultStackItemTypeSliceType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching RunGetMethodStdResultStackItemTypeSliceType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for tuple-typed stack entries.
enum RunGetMethodStdResultStackItemTypeTupleType {
  tvmStackEntryTuple("tvm.stackEntryTuple");

  final String value;
  const RunGetMethodStdResultStackItemTypeTupleType(this.value);

  static RunGetMethodStdResultStackItemTypeTupleType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching RunGetMethodStdResultStackItemTypeTupleType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for standardized get method execution results.
enum RunGetMethodStdResultType {
  smcRunResult("smc.runResult"),

  /// runGetMethod responses carry `ext.runResult` (see the TonlibObject
  /// discriminator in the spec); both spellings share this enum because the
  /// generator emits a single type for both run-result models.
  extRunResult("ext.runResult");

  final String value;
  const RunGetMethodStdResultType(this.value);

  static RunGetMethodStdResultType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () => throw BuError(DefaultErrorType.notFound, "No matching RunGetMethodStdResultType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for shard-to-masterchain proof links.
enum ShardBlockLinkType {
  blocksShardBlockLink("blocks.shardBlockLink");

  final String value;
  const ShardBlockLinkType(this.value);

  static ShardBlockLinkType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching ShardBlockLinkType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for shard block proof chains.
enum ShardBlockProofType {
  blocksShardBlockProof("blocks.shardBlockProof");

  final String value;
  const ShardBlockProofType(this.value);

  static ShardBlockProofType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching ShardBlockProofType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for shard listing responses.
enum ShardsType {
  blocksShards("blocks.shards");

  final String value;
  const ShardsType(this.value);

  static ShardsType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching ShardsType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for compact transaction references.
enum ShortTxIdType {
  blocksShortTxId("blocks.shortTxId");

  final String value;
  const ShortTxIdType(this.value);

  static ShortTxIdType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching ShortTxIdType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for standard smart contract addresses.
enum SmcAddrType {
  addrStd("addr_std");

  final String value;
  const SmcAddrType(this.value);

  static SmcAddrType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching SmcAddrType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// Token metadata key-value pairs (name, symbol, decimals, image, description).
sealed class TokenContentData {
  const TokenContentData();

  factory TokenContentData.fromJson(dynamic json) {
    if (json is String) return TokenContentDataStringValue(json);
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      return TokenContentDataTokenContentDict(TokenContentDict.fromJson(map));
    }
    throw CoreErrors.invalidOperationArguments(
      'TokenContentData',
      reason: 'Cannot parse TokenContentData from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class TokenContentDataStringValue extends TokenContentData {
  final String value;
  const TokenContentDataStringValue(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

class TokenContentDataTokenContentDict extends TokenContentData {
  final TokenContentDict value;
  const TokenContentDataTokenContentDict(this.value);

  @override
  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value.toJson(config: config);
}

/// Storage method for token (jetton) metadata content: `onchain` (stored in contract data) or `offchain` (external URI).
enum TokenContentType {
  onchain("onchain"),
  offchain("offchain");

  final String value;
  const TokenContentType(this.value);

  static TokenContentType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching TokenContentType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for full block identifiers.
enum TonBlockIdExtType {
  tonBlockIdExt("ton.blockIdExt");

  final String value;
  const TonBlockIdExtType(this.value);

  static TonBlockIdExtType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching TonBlockIdExtType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// Object type identifier.
enum TransactionExtType {
  rawTransactionExt("raw.transactionExt");

  final String value;
  const TransactionExtType(this.value);

  static TransactionExtType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching TransactionExtType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for raw transaction objects.
enum TransactionStdType {
  rawTransaction("raw.transaction");

  final String value;
  const TransactionStdType(this.value);

  static TransactionStdType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching TransactionStdType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for extended transaction objects with decoded messages.
enum TransactionType {
  extTransaction("ext.transaction");

  final String value;
  const TransactionType(this.value);

  static TransactionType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching TransactionType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for paginated raw transaction lists.
enum TransactionsStdType {
  rawTransactions("raw.transactions");

  final String value;
  const TransactionsStdType(this.value);

  static TransactionsStdType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching TransactionsStdType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for TVM cell values.
enum TvmCellType {
  tvmCell("tvm.cell");

  final String value;
  const TvmCellType(this.value);

  static TvmCellType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching TvmCellType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

sealed class TvmListElementsItem {
  const TvmListElementsItem();

  factory TvmListElementsItem.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['@type'] == "tvm.stackEntrySlice" && map.hasValue('slice')) {
        return TvmListElementsItemTypeSlice.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryCell" && map.hasValue('cell')) {
        return TvmListElementsItemTypeCell.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryNumber" && map.hasValue('number')) {
        return TvmListElementsItemTypeNumber.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryTuple" && map.hasValue('tuple')) {
        return TvmListElementsItemTypeTuple.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryList" && map.hasValue('list')) {
        return TvmListElementsItemTypeList.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryUnsupported") {
        return TvmListElementsItemType.fromJson(map);
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TvmListElementsItem',
      reason: 'Cannot parse TvmListElementsItem from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class TvmListElementsItemTypeSlice extends TvmListElementsItem {
  /// TonLib type identifier for slice-typed stack entries.
  final RunGetMethodStdResultStackItemTypeSliceType type;

  /// The TVM slice value.
  final TvmSlice slice;

  const TvmListElementsItemTypeSlice({required this.type, required this.slice});

  factory TvmListElementsItemTypeSlice.fromJson(Map<String, dynamic> json) {
    return TvmListElementsItemTypeSlice(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeSliceType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeSliceType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      slice: json.valueTo<TvmSlice, Map<String, dynamic>>(
        key: 'slice',
        parse: (v) => TvmSlice.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'slice': slice.toJson(config: config),
  });
}

class TvmListElementsItemTypeCell extends TvmListElementsItem {
  /// TonLib type identifier for cell-typed stack entries.
  final RunGetMethodStdResultStackItemTypeCellType type;

  /// The TVM cell value.
  final TvmCell cell;

  const TvmListElementsItemTypeCell({required this.type, required this.cell});

  factory TvmListElementsItemTypeCell.fromJson(Map<String, dynamic> json) {
    return TvmListElementsItemTypeCell(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeCellType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeCellType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      cell: json.valueTo<TvmCell, Map<String, dynamic>>(
        key: 'cell',
        parse: (v) => TvmCell.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'cell': cell.toJson(config: config),
  });
}

class TvmListElementsItemTypeNumber extends TvmListElementsItem {
  /// TonLib type identifier for number-typed stack entries.
  final RunGetMethodStdResultStackItemTypeNumberType type;

  /// The TVM number value (arbitrary-precision decimal).
  final TvmNumberDecimal number;

  const TvmListElementsItemTypeNumber({
    required this.type,
    required this.number,
  });

  factory TvmListElementsItemTypeNumber.fromJson(Map<String, dynamic> json) {
    return TvmListElementsItemTypeNumber(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeNumberType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeNumberType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      number: json.valueTo<TvmNumberDecimal, Map<String, dynamic>>(
        key: 'number',
        parse: (v) => TvmNumberDecimal.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'number': number.toJson(config: config),
  });
}

class TvmListElementsItemTypeTuple extends TvmListElementsItem {
  /// TonLib type identifier for tuple-typed stack entries.
  final RunGetMethodStdResultStackItemTypeTupleType type;

  /// The TVM tuple value.
  final TvmTuple tuple;

  const TvmListElementsItemTypeTuple({required this.type, required this.tuple});

  factory TvmListElementsItemTypeTuple.fromJson(Map<String, dynamic> json) {
    return TvmListElementsItemTypeTuple(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeTupleType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeTupleType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      tuple: json.valueTo<TvmTuple, Map<String, dynamic>>(
        key: 'tuple',
        parse: (v) => TvmTuple.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'tuple': tuple.toJson(config: config),
  });
}

class TvmListElementsItemTypeList extends TvmListElementsItem {
  /// TonLib type identifier for list-typed stack entries.
  final TvmTupleElementsItemTypeListType type;

  /// The TVM list value.
  final TvmList list;

  const TvmListElementsItemTypeList({required this.type, required this.list});

  factory TvmListElementsItemTypeList.fromJson(Map<String, dynamic> json) {
    return TvmListElementsItemTypeList(
      type: json.valueTo<TvmTupleElementsItemTypeListType, Object>(
        key: '@type',
        parse:
            (e) => TvmTupleElementsItemTypeListType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      list: json.valueTo<TvmList, Map<String, dynamic>>(
        key: 'list',
        parse: (v) => TvmList.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'list': list.toJson(config: config),
  });
}

class TvmListElementsItemType extends TvmListElementsItem {
  /// TonLib type identifier for stack entries with unsupported types.
  final TvmListElementsItemTypeType type;

  const TvmListElementsItemType({required this.type});

  factory TvmListElementsItemType.fromJson(Map<String, dynamic> json) {
    return TvmListElementsItemType(
      type: json.valueTo<TvmListElementsItemTypeType, Object>(
        key: '@type',
        parse:
            (e) => TvmListElementsItemTypeType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) =>
      config.encodeMap(<String, dynamic>{'@type': type.toJson(config: config)});
}

/// TonLib type identifier for stack entries with unsupported types.
enum TvmListElementsItemTypeType {
  tvmStackEntryUnsupported("tvm.stackEntryUnsupported");

  final String value;
  const TvmListElementsItemTypeType(this.value);

  static TvmListElementsItemTypeType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching TvmListElementsItemTypeType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for TVM list structures.
enum TvmListType {
  tvmList("tvm.list");

  final String value;
  const TvmListType(this.value);

  static TvmListType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching TvmListType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for TVM decimal number values.
enum TvmNumberDecimalType {
  tvmNumberDecimal("tvm.numberDecimal");

  final String value;
  const TvmNumberDecimalType(this.value);

  static TvmNumberDecimalType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching TvmNumberDecimalType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for TVM slice values.
enum TvmSliceType {
  tvmSlice("tvm.slice");

  final String value;
  const TvmSliceType(this.value);

  static TvmSliceType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching TvmSliceType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

sealed class TvmTupleElementsItem {
  const TvmTupleElementsItem();

  factory TvmTupleElementsItem.fromJson(dynamic json) {
    if (json is Map) {
      final map =
          json is Map<String, dynamic> ? json : Map<String, dynamic>.from(json);
      if (map['@type'] == "tvm.stackEntrySlice" && map.hasValue('slice')) {
        return TvmTupleElementsItemTypeSlice.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryCell" && map.hasValue('cell')) {
        return TvmTupleElementsItemTypeCell.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryNumber" && map.hasValue('number')) {
        return TvmTupleElementsItemTypeNumber.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryTuple" && map.hasValue('tuple')) {
        return TvmTupleElementsItemTypeTuple.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryList" && map.hasValue('list')) {
        return TvmTupleElementsItemTypeList.fromJson(map);
      }
      if (map['@type'] == "tvm.stackEntryUnsupported") {
        return TvmTupleElementsItemType.fromJson(map);
      }
    }
    throw CoreErrors.invalidOperationArguments(
      'TvmTupleElementsItem',
      reason: 'Cannot parse TvmTupleElementsItem from $json',
    );
  }

  dynamic toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig});
}

class TvmTupleElementsItemTypeSlice extends TvmTupleElementsItem {
  /// TonLib type identifier for slice-typed stack entries.
  final RunGetMethodStdResultStackItemTypeSliceType type;

  /// The TVM slice value.
  final TvmSlice slice;

  const TvmTupleElementsItemTypeSlice({
    required this.type,
    required this.slice,
  });

  factory TvmTupleElementsItemTypeSlice.fromJson(Map<String, dynamic> json) {
    return TvmTupleElementsItemTypeSlice(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeSliceType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeSliceType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      slice: json.valueTo<TvmSlice, Map<String, dynamic>>(
        key: 'slice',
        parse: (v) => TvmSlice.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'slice': slice.toJson(config: config),
  });
}

class TvmTupleElementsItemTypeCell extends TvmTupleElementsItem {
  /// TonLib type identifier for cell-typed stack entries.
  final RunGetMethodStdResultStackItemTypeCellType type;

  /// The TVM cell value.
  final TvmCell cell;

  const TvmTupleElementsItemTypeCell({required this.type, required this.cell});

  factory TvmTupleElementsItemTypeCell.fromJson(Map<String, dynamic> json) {
    return TvmTupleElementsItemTypeCell(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeCellType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeCellType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      cell: json.valueTo<TvmCell, Map<String, dynamic>>(
        key: 'cell',
        parse: (v) => TvmCell.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'cell': cell.toJson(config: config),
  });
}

class TvmTupleElementsItemTypeNumber extends TvmTupleElementsItem {
  /// TonLib type identifier for number-typed stack entries.
  final RunGetMethodStdResultStackItemTypeNumberType type;

  /// The TVM number value (arbitrary-precision decimal).
  final TvmNumberDecimal number;

  const TvmTupleElementsItemTypeNumber({
    required this.type,
    required this.number,
  });

  factory TvmTupleElementsItemTypeNumber.fromJson(Map<String, dynamic> json) {
    return TvmTupleElementsItemTypeNumber(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeNumberType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeNumberType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      number: json.valueTo<TvmNumberDecimal, Map<String, dynamic>>(
        key: 'number',
        parse: (v) => TvmNumberDecimal.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'number': number.toJson(config: config),
  });
}

class TvmTupleElementsItemTypeTuple extends TvmTupleElementsItem {
  /// TonLib type identifier for tuple-typed stack entries.
  final RunGetMethodStdResultStackItemTypeTupleType type;

  /// The TVM tuple value.
  final TvmTuple tuple;

  const TvmTupleElementsItemTypeTuple({
    required this.type,
    required this.tuple,
  });

  factory TvmTupleElementsItemTypeTuple.fromJson(Map<String, dynamic> json) {
    return TvmTupleElementsItemTypeTuple(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeTupleType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeTupleType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      tuple: json.valueTo<TvmTuple, Map<String, dynamic>>(
        key: 'tuple',
        parse: (v) => TvmTuple.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'tuple': tuple.toJson(config: config),
  });
}

class TvmTupleElementsItemTypeList extends TvmTupleElementsItem {
  /// TonLib type identifier for list-typed stack entries.
  final TvmTupleElementsItemTypeListType type;

  /// The TVM list value.
  final TvmList list;

  const TvmTupleElementsItemTypeList({required this.type, required this.list});

  factory TvmTupleElementsItemTypeList.fromJson(Map<String, dynamic> json) {
    return TvmTupleElementsItemTypeList(
      type: json.valueTo<TvmTupleElementsItemTypeListType, Object>(
        key: '@type',
        parse:
            (e) => TvmTupleElementsItemTypeListType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      list: json.valueTo<TvmList, Map<String, dynamic>>(
        key: 'list',
        parse: (v) => TvmList.fromJson(v),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'list': list.toJson(config: config),
  });
}

class TvmTupleElementsItemType extends TvmTupleElementsItem {
  /// TonLib type identifier for stack entries with unsupported types.
  final TvmListElementsItemTypeType type;

  const TvmTupleElementsItemType({required this.type});

  factory TvmTupleElementsItemType.fromJson(Map<String, dynamic> json) {
    return TvmTupleElementsItemType(
      type: json.valueTo<TvmListElementsItemTypeType, Object>(
        key: '@type',
        parse:
            (e) => TvmListElementsItemTypeType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  @override
  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) =>
      config.encodeMap(<String, dynamic>{'@type': type.toJson(config: config)});
}

/// TonLib type identifier for list-typed stack entries.
enum TvmTupleElementsItemTypeListType {
  tvmStackEntryList("tvm.stackEntryList");

  final String value;
  const TvmTupleElementsItemTypeListType(this.value);

  static TvmTupleElementsItemTypeListType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching TvmTupleElementsItemTypeListType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for TVM tuple structures.
enum TvmTupleType {
  tvmTuple("tvm.tuple");

  final String value;
  const TvmTupleType(this.value);

  static TvmTupleType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching TvmTupleType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// TonLib type identifier for wallet info responses.
enum WalletInformationType {
  extAccountsWalletInformation("ext.accounts.walletInformation");

  final String value;
  const WalletInformationType(this.value);

  static WalletInformationType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse: () => throw BuError(DefaultErrorType.notFound, "No matching WalletInformationType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// Recognized wallet contract type, such as `wallet v4 r2`, `wallet v5 r1`, or `tg-wallet`.
enum WalletInformationWalletType {
  walletV1R1("wallet v1 r1"),
  walletV1R2("wallet v1 r2"),
  walletV1R3("wallet v1 r3"),
  walletV2R1("wallet v2 r1"),
  walletV2R2("wallet v2 r2"),
  walletV3R1("wallet v3 r1"),
  walletV3R2("wallet v3 r2"),
  walletV4R1("wallet v4 r1"),
  walletV4R2("wallet v4 r2"),
  walletV5Beta("wallet v5 beta"),
  walletV5R1("wallet v5 r1"),
  tgWallet("tg-wallet");

  final String value;
  const WalletInformationWalletType(this.value);

  static WalletInformationWalletType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(DefaultErrorType.notFound, "No matching WalletInformationWalletType found for the given value. null"),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

class AccountAddress {
  /// TonLib type identifier for account address objects.
  final AccountAddressType type;

  /// The account address in raw format (`workchain:hex`), e.g. `0:abc123...`. Use the pack address endpoint to convert to user-friendly base64 format.
  final String accountAddress;

  const AccountAddress({required this.type, required this.accountAddress});

  factory AccountAddress.fromJson(Map<String, dynamic> json) {
    return AccountAddress(
      type: json.valueTo<AccountAddressType, Object>(
        key: '@type',
        parse: (e) => AccountAddressType.fromJson(JsonParser.valueAs(e)),
      ),
      accountAddress:
          (json['account_address'] is num
              ? json['account_address'].toString()
              : json.valueAsString<String>('account_address')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'account_address': accountAddress,
  });
}

/// TON DNS contract state. Identified by `@type: dns.accountState`. Used by contracts that resolve TON domain names.
class AccountStateDns {
  /// TonLib type identifier for DNS resolver contracts.
  final AccountStateDnsType type;
  final BigInt walletId;

  const AccountStateDns({required this.type, required this.walletId});

  factory AccountStateDns.fromJson(Map<String, dynamic> json) {
    return AccountStateDns(
      type: json.valueTo<AccountStateDnsType, Object>(
        key: '@type',
        parse: (e) => AccountStateDnsType.fromJson(JsonParser.valueAs(e)),
      ),
      walletId: json.valueAsBigInt<BigInt>('wallet_id'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'wallet_id': config.encodeBigint(walletId),
  });
}

/// Payment channel contract state. Identified by `@type: pchan.accountState`. Used for off-chain payment channels between two parties.
class AccountStatePChan {
  /// TonLib type identifier for payment channel contracts.
  final AccountStatePChanType type;

  /// Payment channel configuration (parties, timeouts, keys).
  final PChanConfig config;

  /// Current payment channel state (init, close, or payout phase).
  final PChanState state;

  /// Human-readable payment channel description.
  final String description;

  const AccountStatePChan({
    required this.type,
    required this.config,
    required this.state,
    required this.description,
  });

  factory AccountStatePChan.fromJson(Map<String, dynamic> json) {
    return AccountStatePChan(
      type: json.valueTo<AccountStatePChanType, Object>(
        key: '@type',
        parse: (e) => AccountStatePChanType.fromJson(JsonParser.valueAs(e)),
      ),
      config: json.valueTo<PChanConfig, Map<String, dynamic>>(
        key: 'config',
        parse: (v) => PChanConfig.fromJson(v),
      ),
      state: json.valueTo<PChanState, Object>(
        key: 'state',
        parse: (e) => PChanState.fromJson(JsonParser.valueAs(e)),
      ),
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString<String>('description')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'config': this.config.toJson(config: config),
    'state': state.toJson(config: config),
    'description': description,
  });
}

/// Restricted wallet contract state. Identified by `@type: rwallet.accountState`. Used for wallets with vesting or transfer restrictions.
class AccountStateRWallet {
  /// TonLib type identifier for restricted wallet contracts.
  final AccountStateRWalletType type;

  /// Subwallet identifier. Allows creating multiple wallets from one key.
  final BigInt walletId;

  /// Wallet contract sequence number. Used for replay protection: each outgoing transaction must include the current `seqno` and increments it by 1. Fetch the current value before sending a transaction.
  final int seqno;

  /// Balance available for immediate withdrawal, in nanotons.
  final BigInt unlockedBalance;

  /// Spending limits and restrictions configuration.
  final RWalletConfig config;

  const AccountStateRWallet({
    required this.type,
    required this.walletId,
    required this.seqno,
    required this.unlockedBalance,
    required this.config,
  });

  factory AccountStateRWallet.fromJson(Map<String, dynamic> json) {
    return AccountStateRWallet(
      type: json.valueTo<AccountStateRWalletType, Object>(
        key: '@type',
        parse: (e) => AccountStateRWalletType.fromJson(JsonParser.valueAs(e)),
      ),
      walletId: json.valueAsBigInt<BigInt>('wallet_id'),
      seqno: json.valueAsInt<int>('seqno'),
      unlockedBalance: json.valueAsBigInt<BigInt>('unlocked_balance'),
      config: json.valueTo<RWalletConfig, Map<String, dynamic>>(
        key: 'config',
        parse: (v) => RWalletConfig.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'wallet_id': config.encodeBigint(walletId),
    'seqno': seqno,
    'unlocked_balance': config.encodeBigint(unlockedBalance),
    'config': this.config.toJson(config: config),
  });
}

/// Unrecognized or non-wallet contract state. Identified by `@type: raw.accountState`. Returned when TonLib cannot parse the contract as a known type.
class AccountStateRaw {
  /// TonLib type identifier for raw (unrecognized) contract states.
  final AccountStateRawType type;

  /// Smart contract code in BoC format, base64 encoded. Empty if account is uninitialized.
  final String code;

  /// Smart contract persistent storage in BoC format, base64 encoded.
  final String data;
  final String frozenHash;

  const AccountStateRaw({
    required this.type,
    required this.code,
    required this.data,
    required this.frozenHash,
  });

  factory AccountStateRaw.fromJson(Map<String, dynamic> json) {
    return AccountStateRaw(
      type: json.valueTo<AccountStateRawType, Object>(
        key: '@type',
        parse: (e) => AccountStateRawType.fromJson(JsonParser.valueAs(e)),
      ),
      code:
          (json['code'] is num
              ? json['code'].toString()
              : json.valueAsString<String>('code')),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString<String>('data')),
      frozenHash:
          (json['frozen_hash'] is num
              ? json['frozen_hash'].toString()
              : json.valueAsString<String>('frozen_hash')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'code': code,
    'data': data,
    'frozen_hash': frozenHash,
  });
}

/// Account exists on-chain but has no deployed contract. Identified by `@type: uninited.accountState`. The address has received TON but no code has been deployed yet.
class AccountStateUninited {
  /// TonLib type identifier for uninitialized accounts.
  final AccountStateUninitedType type;
  final String frozenHash;

  const AccountStateUninited({required this.type, required this.frozenHash});

  factory AccountStateUninited.fromJson(Map<String, dynamic> json) {
    return AccountStateUninited(
      type: json.valueTo<AccountStateUninitedType, Object>(
        key: '@type',
        parse: (e) => AccountStateUninitedType.fromJson(JsonParser.valueAs(e)),
      ),
      frozenHash:
          (json['frozen_hash'] is num
              ? json['frozen_hash'].toString()
              : json.valueAsString<String>('frozen_hash')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'frozen_hash': frozenHash,
  });
}

/// High-throughput wallet contract version 1. Identified by `@type: wallet.highload.v1.accountState`. Designed for sending many transactions in a single block.
class AccountStateWalletHighloadV1 {
  /// TonLib type identifier for Highload Wallet v1 contracts.
  final AccountStateWalletHighloadV1Type type;

  /// Subwallet identifier. Allows creating multiple wallets from one key.
  final BigInt walletId;

  /// Wallet contract sequence number. Used for replay protection: each outgoing transaction must include the current `seqno` and increments it by 1. Fetch the current value before sending a transaction.
  final int seqno;

  const AccountStateWalletHighloadV1({
    required this.type,
    required this.walletId,
    required this.seqno,
  });

  factory AccountStateWalletHighloadV1.fromJson(Map<String, dynamic> json) {
    return AccountStateWalletHighloadV1(
      type: json.valueTo<AccountStateWalletHighloadV1Type, Object>(
        key: '@type',
        parse:
            (e) => AccountStateWalletHighloadV1Type.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      walletId: json.valueAsBigInt<BigInt>('wallet_id'),
      seqno: json.valueAsInt<int>('seqno'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'wallet_id': config.encodeBigint(walletId),
    'seqno': seqno,
  });
}

/// High-throughput wallet contract version 2. Identified by `@type: wallet.highload.v2.accountState`. Improved version of highload v1 with better replay protection.
class AccountStateWalletHighloadV2 {
  /// TonLib type identifier for Highload Wallet v2 contracts.
  final AccountStateWalletHighloadV2Type type;

  /// Subwallet identifier. Allows creating multiple wallets from one key.
  final BigInt walletId;

  const AccountStateWalletHighloadV2({
    required this.type,
    required this.walletId,
  });

  factory AccountStateWalletHighloadV2.fromJson(Map<String, dynamic> json) {
    return AccountStateWalletHighloadV2(
      type: json.valueTo<AccountStateWalletHighloadV2Type, Object>(
        key: '@type',
        parse:
            (e) => AccountStateWalletHighloadV2Type.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      walletId: json.valueAsBigInt<BigInt>('wallet_id'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'wallet_id': config.encodeBigint(walletId),
  });
}

/// Standard wallet contract version 3. Identified by `@type: wallet.v3.accountState`. The most widely deployed wallet type prior to v4.
class AccountStateWalletV3 {
  /// TonLib type identifier for Wallet v3 contracts.
  final AccountStateWalletV3Type type;

  /// Subwallet identifier. Allows creating multiple wallets from one key.
  final BigInt walletId;

  /// Wallet contract sequence number. Used for replay protection: each outgoing transaction must include the current `seqno` and increments it by 1. Fetch the current value before sending a transaction.
  final int seqno;

  const AccountStateWalletV3({
    required this.type,
    required this.walletId,
    required this.seqno,
  });

  factory AccountStateWalletV3.fromJson(Map<String, dynamic> json) {
    return AccountStateWalletV3(
      type: json.valueTo<AccountStateWalletV3Type, Object>(
        key: '@type',
        parse: (e) => AccountStateWalletV3Type.fromJson(JsonParser.valueAs(e)),
      ),
      walletId: json.valueAsBigInt<BigInt>('wallet_id'),
      seqno: json.valueAsInt<int>('seqno'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'wallet_id': config.encodeBigint(walletId),
    'seqno': seqno,
  });
}

/// Standard wallet contract version 4. Identified by `@type: wallet.v4.accountState`. Adds plugin support over v3.
class AccountStateWalletV4 {
  /// TonLib type identifier for Wallet v4 contracts.
  final AccountStateWalletV4Type type;

  /// Subwallet identifier. Allows creating multiple wallets from one key.
  final BigInt walletId;

  /// Wallet contract sequence number. Used for replay protection: each outgoing transaction must include the current `seqno` and increments it by 1. Fetch the current value before sending a transaction.
  final int seqno;

  const AccountStateWalletV4({
    required this.type,
    required this.walletId,
    required this.seqno,
  });

  factory AccountStateWalletV4.fromJson(Map<String, dynamic> json) {
    return AccountStateWalletV4(
      type: json.valueTo<AccountStateWalletV4Type, Object>(
        key: '@type',
        parse: (e) => AccountStateWalletV4Type.fromJson(JsonParser.valueAs(e)),
      ),
      walletId: json.valueAsBigInt<BigInt>('wallet_id'),
      seqno: json.valueAsInt<int>('seqno'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'wallet_id': config.encodeBigint(walletId),
    'seqno': seqno,
  });
}

/// Raw account state including balance, code, data, and status. The code and data fields contain the smart contract in BoC format.
class AddressInformation {
  /// TonLib type identifier for full account state responses.
  final AddressInformationType type;

  /// Account balance in nanotons as a decimal string. 1 TON = 1,000,000,000 nanotons.
  final String balance;

  /// Array of non-TON currency balances held by this account. Each entry contains a currency ID (integer) and balance amount (decimal string). Empty array if the account holds no extra currencies.
  final List<ExtraCurrencyBalance> extraCurrencies;

  /// Reference to the most recent transaction. Use as starting point for getTransactions.
  final InternalTransactionId lastTransactionId;

  /// Full block identifier where this event occurred.
  final TonBlockIdExt blockId;

  /// Smart contract code in BoC format, base64 encoded.
  final String code;

  /// Smart contract persistent storage in BoC format, base64 encoded.
  final String data;
  final String frozenHash;

  /// Unix timestamp of the block from which this data was read.
  final BigInt syncUtime;

  /// Account state: uninitialized, active, or frozen.
  final AccountStateEnum state;
  final bool? suspended;

  const AddressInformation({
    required this.type,
    required this.balance,
    required this.extraCurrencies,
    required this.lastTransactionId,
    required this.blockId,
    required this.code,
    required this.data,
    required this.frozenHash,
    required this.syncUtime,
    required this.state,
    this.suspended,
  });

  factory AddressInformation.fromJson(Map<String, dynamic> json) {
    return AddressInformation(
      type: json.valueTo<AddressInformationType, Object>(
        key: '@type',
        parse: (e) => AddressInformationType.fromJson(JsonParser.valueAs(e)),
      ),
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String>('balance')),
      extraCurrencies:
          json
              .valueEnsureAsList<Map<String, dynamic>>('extra_currencies')
              .map((e) => ExtraCurrencyBalance.fromJson(e))
              .toList(),
      lastTransactionId: json
          .valueTo<InternalTransactionId, Map<String, dynamic>>(
            key: 'last_transaction_id',
            parse: (v) => InternalTransactionId.fromJson(v),
          ),
      blockId: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'block_id',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      code:
          (json['code'] is num
              ? json['code'].toString()
              : json.valueAsString<String>('code')),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString<String>('data')),
      frozenHash:
          (json['frozen_hash'] is num
              ? json['frozen_hash'].toString()
              : json.valueAsString<String>('frozen_hash')),
      syncUtime: json.valueAsBigInt<BigInt>('sync_utime'),
      state: json.valueTo<AccountStateEnum, Object>(
        key: 'state',
        parse: (e) => AccountStateEnum.fromJson(JsonParser.valueAs(e)),
      ),
      suspended: json.valueAsBool<bool?>('suspended'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'balance': balance,
    'extra_currencies':
        extraCurrencies.map((e) => e.toJson(config: config)).toList(),
    'last_transaction_id': lastTransactionId.toJson(config: config),
    'block_id': blockId.toJson(config: config),
    'code': code,
    'data': data,
    'frozen_hash': frozenHash,
    'sync_utime': config.encodeBigint(syncUtime),
    'state': state.toJson(config: config),
    'suspended': suspended,
  });
}

/// Request containing a single address parameter.
class AddressRequest {
  final String address;

  const AddressRequest({required this.address});

  factory AddressRequest.fromJson(Map<String, dynamic> json) {
    return AddressRequest(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'address': address});
}

class AddressWithSeqnoRequest {
  final String address;

  /// Masterchain block sequence number. Query the account state as it was at this block height. If omitted, returns the current state.
  final AddressWithSeqnoRequestSeqno? seqno;

  const AddressWithSeqnoRequest({required this.address, this.seqno});

  factory AddressWithSeqnoRequest.fromJson(Map<String, dynamic> json) {
    return AddressWithSeqnoRequest(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      seqno: json.valueTo<AddressWithSeqnoRequestSeqno?, Object>(
        key: 'seqno',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'seqno': seqno?.toJson(config: config),
  });
}

class AdnlAddress {
  final AdnlAddressType type;
  final String adnlAddress;

  const AdnlAddress({required this.type, required this.adnlAddress});

  factory AdnlAddress.fromJson(Map<String, dynamic> json) {
    return AdnlAddress(
      type: json.valueTo<AdnlAddressType, Object>(
        key: '@type',
        parse: (e) => AdnlAddressType.fromJson(JsonParser.valueAs(e)),
      ),
      adnlAddress:
          (json['adnl_address'] is num
              ? json['adnl_address'].toString()
              : json.valueAsString<String>('adnl_address')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'adnl_address': adnlAddress,
  });
}

/// Raw block data returned by a LiteServer.
class BlockData {
  final BlockDataType type;

  /// Extended identifier of the returned block.
  final TonBlockIdExt id;

  /// Full block BOC encoded as base64.
  final String data;

  const BlockData({required this.type, required this.id, required this.data});

  factory BlockData.fromJson(Map<String, dynamic> json) {
    return BlockData(
      type: json.valueTo<BlockDataType, Object>(
        key: '@type',
        parse: (e) => BlockDataType.fromJson(JsonParser.valueAs(e)),
      ),
      id: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString<String>('data')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'id': id.toJson(config: config),
    'data': data,
  });
}

/// POST /api/v2/getBlock (request)
class BlockDataRequest {
  /// Workchain ID: `-1` for masterchain, `0` for basechain. Most user transactions are on workchain `0`.
  final AddressWithSeqnoRequestSeqno workchain;

  /// Shard identifier. A signed 64-bit integer. Masterchain uses -9223372036854775808.
  final BigInt shard;
  final AddressWithSeqnoRequestSeqno seqno;
  final String? rootHash;
  final String? fileHash;
  final BlockDataRequestArchival? archival;

  const BlockDataRequest({
    required this.workchain,
    required this.shard,
    required this.seqno,
    this.rootHash,
    this.fileHash,
    this.archival,
  });

  factory BlockDataRequest.fromJson(Map<String, dynamic> json) {
    return BlockDataRequest(
      workchain: json.valueTo<AddressWithSeqnoRequestSeqno, Object>(
        key: 'workchain',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
      shard: json.valueAsBigInt<BigInt>('shard'),
      seqno: json.valueTo<AddressWithSeqnoRequestSeqno, Object>(
        key: 'seqno',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
      rootHash:
          (json['root_hash'] is num
              ? json['root_hash'].toString()
              : json.valueAsString<String?>('root_hash')),
      fileHash:
          (json['file_hash'] is num
              ? json['file_hash'].toString()
              : json.valueAsString<String?>('file_hash')),
      archival: json.valueTo<BlockDataRequestArchival?, Object>(
        key: 'archival',
        parse: (e) => BlockDataRequestArchival.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'workchain': workchain.toJson(config: config),
    'shard': config.encodeBigint(shard),
    'seqno': seqno.toJson(config: config),
    'root_hash': rootHash,
    'file_hash': fileHash,
    'archival': archival?.toJson(config: config),
  });
}

/// Block metadata including creation time, validator info, and links to previous blocks. Does not include the transactions themselves.
class BlockHeader {
  /// TonLib type identifier for block header objects.
  final BlockHeaderType type;

  /// Full block identifier including workchain, shard, `seqno`, and hashes.
  final TonBlockIdExt id;

  /// Global network identifier.
  final int globalId;

  /// Block format version number.
  final int version;

  /// Returns `true` if this block was created immediately after a shard merge; otherwise `false`.
  final bool afterMerge;

  /// Returns `true` if this block was created immediately after a shard split; otherwise `false`.
  final bool afterSplit;

  /// Returns `true` if this shard will split after this block; otherwise `false`.
  final bool beforeSplit;

  /// Returns `true` if validators have signaled a preference to merge this shard; otherwise `false`.
  final bool wantMerge;

  /// Returns `true` if validators have signaled a preference to split this shard; otherwise `false`.
  final bool wantSplit;

  /// Short hash of the validator set active during this block.
  final int validatorListHashShort;

  /// Catchain sequence number used for validator consensus.
  final int catchainSeqno;

  /// Minimum masterchain block `seqno` referenced by this block.
  final int minRefMcSeqno;

  /// Returns `true` if this is a key block containing validator set changes or config updates; otherwise `false`.
  final bool isKeyBlock;

  /// Sequence number of the previous key block.
  final int prevKeyBlockSeqno;

  /// Logical time at the start of this block.
  final String startLt;

  /// Ending logical time.
  final String endLt;

  /// Unix timestamp when this block was generated.
  final int genUtime;

  /// Array of previous block identifiers (`workchain`, `shard`, `seqno`, `root_hash`, `file_hash`). Usually contains one entry, but two after a shard merge.
  final List<TonBlockIdExt> prevBlocks;

  const BlockHeader({
    required this.type,
    required this.id,
    required this.globalId,
    required this.version,
    required this.afterMerge,
    required this.afterSplit,
    required this.beforeSplit,
    required this.wantMerge,
    required this.wantSplit,
    required this.validatorListHashShort,
    required this.catchainSeqno,
    required this.minRefMcSeqno,
    required this.isKeyBlock,
    required this.prevKeyBlockSeqno,
    required this.startLt,
    required this.endLt,
    required this.genUtime,
    required this.prevBlocks,
  });

  factory BlockHeader.fromJson(Map<String, dynamic> json) {
    return BlockHeader(
      type: json.valueTo<BlockHeaderType, Object>(
        key: '@type',
        parse: (e) => BlockHeaderType.fromJson(JsonParser.valueAs(e)),
      ),
      id: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      globalId: json.valueAsInt<int>('global_id'),
      version: json.valueAsInt<int>('version'),
      afterMerge: json.valueAsBool<bool>('after_merge'),
      afterSplit: json.valueAsBool<bool>('after_split'),
      beforeSplit: json.valueAsBool<bool>('before_split'),
      wantMerge: json.valueAsBool<bool>('want_merge'),
      wantSplit: json.valueAsBool<bool>('want_split'),
      validatorListHashShort: json.valueAsInt<int>('validator_list_hash_short'),
      catchainSeqno: json.valueAsInt<int>('catchain_seqno'),
      minRefMcSeqno: json.valueAsInt<int>('min_ref_mc_seqno'),
      isKeyBlock: json.valueAsBool<bool>('is_key_block'),
      prevKeyBlockSeqno: json.valueAsInt<int>('prev_key_block_seqno'),
      startLt:
          (json['start_lt'] is num
              ? json['start_lt'].toString()
              : json.valueAsString<String>('start_lt')),
      endLt:
          (json['end_lt'] is num
              ? json['end_lt'].toString()
              : json.valueAsString<String>('end_lt')),
      genUtime: json.valueAsInt<int>('gen_utime'),
      prevBlocks:
          json
              .valueEnsureAsList<Map<String, dynamic>>('prev_blocks')
              .map((e) => TonBlockIdExt.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'id': id.toJson(config: config),
    'global_id': globalId,
    'version': version,
    'after_merge': afterMerge,
    'after_split': afterSplit,
    'before_split': beforeSplit,
    'want_merge': wantMerge,
    'want_split': wantSplit,
    'validator_list_hash_short': validatorListHashShort,
    'catchain_seqno': catchainSeqno,
    'min_ref_mc_seqno': minRefMcSeqno,
    'is_key_block': isKeyBlock,
    'prev_key_block_seqno': prevKeyBlockSeqno,
    'start_lt': startLt,
    'end_lt': endLt,
    'gen_utime': genUtime,
    'prev_blocks': prevBlocks.map((e) => e.toJson(config: config)).toList(),
  });
}

/// POST /api/v2/getBlockHeader (request)
class BlockHeaderRequest {
  final AddressWithSeqnoRequestSeqno workchain;
  final BigInt shard;
  final AddressWithSeqnoRequestSeqno seqno;

  /// Root hash of the block. Together with `file_hash`, uniquely identifies a block.
  final String? rootHash;

  /// Hash of the serialized block data. Together with `root_hash`, uniquely identifies a block.
  final String? fileHash;

  const BlockHeaderRequest({
    required this.workchain,
    required this.shard,
    required this.seqno,
    this.rootHash,
    this.fileHash,
  });

  factory BlockHeaderRequest.fromJson(Map<String, dynamic> json) {
    return BlockHeaderRequest(
      workchain: json.valueTo<AddressWithSeqnoRequestSeqno, Object>(
        key: 'workchain',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
      shard: json.valueAsBigInt<BigInt>('shard'),
      seqno: json.valueTo<AddressWithSeqnoRequestSeqno, Object>(
        key: 'seqno',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
      rootHash:
          (json['root_hash'] is num
              ? json['root_hash'].toString()
              : json.valueAsString<String?>('root_hash')),
      fileHash:
          (json['file_hash'] is num
              ? json['file_hash'].toString()
              : json.valueAsString<String?>('file_hash')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'workchain': workchain.toJson(config: config),
    'shard': config.encodeBigint(shard),
    'seqno': seqno.toJson(config: config),
    'root_hash': rootHash,
    'file_hash': fileHash,
  });
}

class BlockLinkBack {
  /// TonLib type identifier for backward block link proofs.
  final BlockLinkBackType type;

  /// Returns `true` if the destination block is a key block; otherwise `false`.
  final bool toKeyBlock;

  /// Source block in the proof chain.
  final TonBlockIdExt from;

  /// Destination block in the proof chain.
  final TonBlockIdExt to;

  /// Cryptographic proof for the destination block.
  final String destProof;

  /// Merkle proof linking the two blocks.
  final String proof;

  /// State proof validating the block link.
  final String stateProof;

  const BlockLinkBack({
    required this.type,
    required this.toKeyBlock,
    required this.from,
    required this.to,
    required this.destProof,
    required this.proof,
    required this.stateProof,
  });

  factory BlockLinkBack.fromJson(Map<String, dynamic> json) {
    return BlockLinkBack(
      type: json.valueTo<BlockLinkBackType, Object>(
        key: '@type',
        parse: (e) => BlockLinkBackType.fromJson(JsonParser.valueAs(e)),
      ),
      toKeyBlock: json.valueAsBool<bool>('to_key_block'),
      from: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'from',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      to: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'to',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      destProof:
          (json['dest_proof'] is num
              ? json['dest_proof'].toString()
              : json.valueAsString<String>('dest_proof')),
      proof:
          (json['proof'] is num
              ? json['proof'].toString()
              : json.valueAsString<String>('proof')),
      stateProof:
          (json['state_proof'] is num
              ? json['state_proof'].toString()
              : json.valueAsString<String>('state_proof')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'to_key_block': toKeyBlock,
    'from': from.toJson(config: config),
    'to': to.toJson(config: config),
    'dest_proof': destProof,
    'proof': proof,
    'state_proof': stateProof,
  });
}

class BlockSignature {
  /// TonLib type identifier for validator signature objects.
  final BlockSignatureType type;

  /// Short public key hash of the validator node that produced this signature.
  final String nodeIdShort;

  /// Ed25519 signature of the block by this validator, base64 encoded.
  final String signature;

  const BlockSignature({
    required this.type,
    required this.nodeIdShort,
    required this.signature,
  });

  factory BlockSignature.fromJson(Map<String, dynamic> json) {
    return BlockSignature(
      type: json.valueTo<BlockSignatureType, Object>(
        key: '@type',
        parse: (e) => BlockSignatureType.fromJson(JsonParser.valueAs(e)),
      ),
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
    '@type': type.toJson(config: config),
    'node_id_short': nodeIdShort,
    'signature': signature,
  });
}

class BlockSignatures {
  final BlockSignaturesType type;
  final TonBlockIdExt id;
  final List<BlockSignature> signatures;

  const BlockSignatures({
    required this.type,
    required this.id,
    required this.signatures,
  });

  factory BlockSignatures.fromJson(Map<String, dynamic> json) {
    return BlockSignatures(
      type: json.valueTo<BlockSignaturesType, Object>(
        key: '@type',
        parse: (e) => BlockSignaturesType.fromJson(JsonParser.valueAs(e)),
      ),
      id: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      signatures:
          json
              .valueEnsureAsList<Map<String, dynamic>>('signatures')
              .map((e) => BlockSignature.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'id': id.toJson(config: config),
    'signatures': signatures.map((e) => e.toJson(config: config)).toList(),
  });
}

class BlockSignaturesSimplex {
  final BlockSignaturesSimplexType type;
  final TonBlockIdExt id;
  final List<BlockSignature> signatures;
  final String sessionId;
  final int slot;
  final String candidate;

  const BlockSignaturesSimplex({
    required this.type,
    required this.id,
    required this.signatures,
    required this.sessionId,
    required this.slot,
    required this.candidate,
  });

  factory BlockSignaturesSimplex.fromJson(Map<String, dynamic> json) {
    return BlockSignaturesSimplex(
      type: json.valueTo<BlockSignaturesSimplexType, Object>(
        key: '@type',
        parse:
            (e) => BlockSignaturesSimplexType.fromJson(JsonParser.valueAs(e)),
      ),
      id: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      signatures:
          json
              .valueEnsureAsList<Map<String, dynamic>>('signatures')
              .map((e) => BlockSignature.fromJson(e))
              .toList(),
      sessionId:
          (json['session_id'] is num
              ? json['session_id'].toString()
              : json.valueAsString<String>('session_id')),
      slot: json.valueAsInt<int>('slot'),
      candidate:
          (json['candidate'] is num
              ? json['candidate'].toString()
              : json.valueAsString<String>('candidate')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'id': id.toJson(config: config),
    'signatures': signatures.map((e) => e.toJson(config: config)).toList(),
    'session_id': sessionId,
    'slot': slot,
    'candidate': candidate,
  });
}

/// List of short transaction identifiers found in a specific block, with a flag indicating whether more transactions are available for pagination.
class BlockTransactions {
  /// TonLib type identifier for block transaction listings.
  final BlockTransactionsType type;

  /// Full block identifier for the queried block.
  final TonBlockIdExt id;

  /// The maximum number of transactions requested, as specified by the `count` request parameter. If `incomplete` is `true`, more transactions exist beyond this limit.
  final int reqCount;

  /// Returns `true` if there are more transactions in this block; otherwise `false`. Use the last transaction as cursor for pagination.
  final bool incomplete;

  /// Array of compact transaction references. Each entry contains the account address (string), logical time (string), and transaction hash (base64 or hex).
  final List<ShortTxId> transactions;

  const BlockTransactions({
    required this.type,
    required this.id,
    required this.reqCount,
    required this.incomplete,
    required this.transactions,
  });

  factory BlockTransactions.fromJson(Map<String, dynamic> json) {
    return BlockTransactions(
      type: json.valueTo<BlockTransactionsType, Object>(
        key: '@type',
        parse: (e) => BlockTransactionsType.fromJson(JsonParser.valueAs(e)),
      ),
      id: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      reqCount: json.valueAsInt<int>('req_count'),
      incomplete: json.valueAsBool<bool>('incomplete'),
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('transactions')
              .map((e) => ShortTxId.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'id': id.toJson(config: config),
    'req_count': reqCount,
    'incomplete': incomplete,
    'transactions': transactions.map((e) => e.toJson(config: config)).toList(),
  });
}

/// List of full transaction objects found in a specific block, with a flag indicating whether more transactions are available for pagination.
class BlockTransactionsExt {
  /// TonLib type identifier for extended block transaction listings.
  final BlockTransactionsExtType type;

  /// Full block identifier for the queried block.
  final TonBlockIdExt id;

  /// The maximum number of transactions requested, as specified by the `count` request parameter. If `incomplete` is `true`, more transactions exist beyond this limit.
  final int reqCount;

  /// Returns `true` if there are more transactions in this block; otherwise `false`. Use the last transaction as cursor for pagination.
  final bool incomplete;

  /// Array of full transaction objects. Each entry contains the account address, timestamps, inbound/outbound messages, fees (in nanotons), and the raw transaction BoC (base64).
  final List<TransactionExt> transactions;

  const BlockTransactionsExt({
    required this.type,
    required this.id,
    required this.reqCount,
    required this.incomplete,
    required this.transactions,
  });

  factory BlockTransactionsExt.fromJson(Map<String, dynamic> json) {
    return BlockTransactionsExt(
      type: json.valueTo<BlockTransactionsExtType, Object>(
        key: '@type',
        parse: (e) => BlockTransactionsExtType.fromJson(JsonParser.valueAs(e)),
      ),
      id: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      reqCount: json.valueAsInt<int>('req_count'),
      incomplete: json.valueAsBool<bool>('incomplete'),
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('transactions')
              .map((e) => TransactionExt.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'id': id.toJson(config: config),
    'req_count': reqCount,
    'incomplete': incomplete,
    'transactions': transactions.map((e) => e.toJson(config: config)).toList(),
  });
}

/// Request to fetch transactions from a specific block with optional pagination.
///
/// POST /api/v2/getBlockTransactions (request)
class BlockTransactionsRequest {
  /// Workchain ID: `-1` for masterchain, `0` for basechain. Most user transactions are on workchain `0`.
  final AddressWithSeqnoRequestSeqno workchain;

  /// Shard identifier. A signed 64-bit integer. Masterchain uses -9223372036854775808.
  final BigInt shard;
  final AddressWithSeqnoRequestSeqno seqno;

  /// Root hash of the block. Together with `file_hash`, uniquely identifies a block.
  final String? rootHash;

  /// Hash of the serialized block data. Together with `root_hash`, uniquely identifies a block.
  final String? fileHash;

  /// Return items after this logical time (for pagination).
  final BigInt? afterLt;

  /// Return items after this hash (for pagination within same `lt`).
  final String? afterHash;

  /// Maximum number of items to return.
  final BigInt? count;

  const BlockTransactionsRequest({
    required this.workchain,
    required this.shard,
    required this.seqno,
    this.rootHash,
    this.fileHash,
    this.afterLt,
    this.afterHash,
    this.count,
  });

  factory BlockTransactionsRequest.fromJson(Map<String, dynamic> json) {
    return BlockTransactionsRequest(
      workchain: json.valueTo<AddressWithSeqnoRequestSeqno, Object>(
        key: 'workchain',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
      shard: json.valueAsBigInt<BigInt>('shard'),
      seqno: json.valueTo<AddressWithSeqnoRequestSeqno, Object>(
        key: 'seqno',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
      rootHash:
          (json['root_hash'] is num
              ? json['root_hash'].toString()
              : json.valueAsString<String?>('root_hash')),
      fileHash:
          (json['file_hash'] is num
              ? json['file_hash'].toString()
              : json.valueAsString<String?>('file_hash')),
      afterLt: json.valueAsBigInt<BigInt?>('after_lt'),
      afterHash:
          (json['after_hash'] is num
              ? json['after_hash'].toString()
              : json.valueAsString<String?>('after_hash')),
      count: json.valueAsBigInt<BigInt?>('count'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'workchain': workchain.toJson(config: config),
    'shard': config.encodeBigint(shard),
    'seqno': seqno.toJson(config: config),
    'root_hash': rootHash,
    'file_hash': fileHash,
    'after_lt': config.encodeBigint(afterLt),
    'after_hash': afterHash,
    'count': config.encodeBigint(count),
  });
}

/// POST /api/v2/getConfigAll (request)
class ConfigAllRequest {
  /// Masterchain block sequence number (block height). Used to query blockchain config at a specific block. If omitted, the latest masterchain block is used.
  final AddressWithSeqnoRequestSeqno? seqno;

  const ConfigAllRequest({this.seqno});

  factory ConfigAllRequest.fromJson(Map<String, dynamic> json) {
    return ConfigAllRequest(
      seqno: json.valueTo<AddressWithSeqnoRequestSeqno?, Object>(
        key: 'seqno',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'seqno': seqno?.toJson(config: config),
  });
}

/// Blockchain configuration data. Contains one or more config parameters as requested. Each parameter controls different aspects of network operation.
class ConfigInfo {
  /// TonLib type identifier for blockchain configuration responses.
  final ConfigInfoType type;

  /// The requested configuration parameter value as a TVM cell.
  final TvmCell config;

  const ConfigInfo({required this.type, required this.config});

  factory ConfigInfo.fromJson(Map<String, dynamic> json) {
    return ConfigInfo(
      type: json.valueTo<ConfigInfoType, Object>(
        key: '@type',
        parse: (e) => ConfigInfoType.fromJson(JsonParser.valueAs(e)),
      ),
      config: json.valueTo<TvmCell, Map<String, dynamic>>(
        key: 'config',
        parse: (v) => TvmCell.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'config': this.config.toJson(config: config),
  });
}

/// POST /api/v2/getConfigParam (request)
class ConfigParamRequest {
  /// Configuration parameter number. Each number controls different blockchain settings.
  final AddressWithSeqnoRequestSeqno? configId;
  final AddressWithSeqnoRequestSeqno? param;

  /// Masterchain block sequence number (block height). Used to query blockchain config at a specific block. If omitted, the latest masterchain block is used.
  final AddressWithSeqnoRequestSeqno? seqno;

  const ConfigParamRequest({this.configId, this.param, this.seqno});

  factory ConfigParamRequest.fromJson(Map<String, dynamic> json) {
    return ConfigParamRequest(
      configId: json.valueTo<AddressWithSeqnoRequestSeqno?, Object>(
        key: 'config_id',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
      param: json.valueTo<AddressWithSeqnoRequestSeqno?, Object>(
        key: 'param',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
      seqno: json.valueTo<AddressWithSeqnoRequestSeqno?, Object>(
        key: 'seqno',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'config_id': configId?.toJson(config: config),
    'param': param?.toJson(config: config),
    'seqno': seqno?.toJson(config: config),
  });
}

class ConsensusBlock {
  /// TonLib type identifier for consensus block info.
  final ConsensusBlockType type;

  /// Sequence number of the latest consensus block.
  final int consensusBlock;
  final int timestamp;

  const ConsensusBlock({
    required this.type,
    required this.consensusBlock,
    required this.timestamp,
  });

  factory ConsensusBlock.fromJson(Map<String, dynamic> json) {
    return ConsensusBlock(
      type: json.valueTo<ConsensusBlockType, Object>(
        key: '@type',
        parse: (e) => ConsensusBlockType.fromJson(JsonParser.valueAs(e)),
      ),
      consensusBlock: json.valueAsInt<int>('consensus_block'),
      timestamp: json.valueAsInt<int>('timestamp'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'consensus_block': consensusBlock,
    'timestamp': timestamp,
  });
}

/// Detected address in all supported formats. Contains the raw on-chain form, bounceable and non-bounceable user-friendly representations (each in base64 and URL-safe base64), the format type of the original input, and the testnet-only flag from the user-friendly encoding.
class DetectAddress {
  /// TonLib type identifier for address detection results.
  final DetectAddressType type;

  /// Raw address in `workchain_id:account_id` hex format (e.g., `0:abc...def`). This is the canonical on-chain representation without flags or checksum.
  final String rawForm;

  /// Bounceable form of the address in standard base64 and URL-safe base64. Bounceable addresses (prefix `E...`) instruct wallet software to set the bounce flag on outgoing messages, so funds are returned if the destination contract cannot process them.
  final DetectAddressBase64Variant bounceable;

  /// Non-bounceable form of the address in standard base64 and URL-safe base64. Non-bounceable addresses (prefix `U...`) instruct wallet software to clear the bounce flag, ensuring funds are credited even if the recipient has no deployed contract.
  final DetectAddressBase64Variant nonBounceable;

  /// The encoding format of the address as provided in the request (e.g., `raw_form`, `dns`, `friendly_bounceable`, `friendly_non_bounceable`).
  final DetectAddressGivenType givenType;

  /// Returns `true` if the user-friendly address has the testnet-only flag set (`0x80`); otherwise `false`. This is a flag in the address encoding that tells wallet software to reject this address on mainnet. The underlying account itself can exist on both networks.
  final bool testOnly;

  const DetectAddress({
    required this.type,
    required this.rawForm,
    required this.bounceable,
    required this.nonBounceable,
    required this.givenType,
    required this.testOnly,
  });

  factory DetectAddress.fromJson(Map<String, dynamic> json) {
    return DetectAddress(
      type: json.valueTo<DetectAddressType, Object>(
        key: '@type',
        parse: (e) => DetectAddressType.fromJson(JsonParser.valueAs(e)),
      ),
      rawForm:
          (json['raw_form'] is num
              ? json['raw_form'].toString()
              : json.valueAsString<String>('raw_form')),
      bounceable: json
          .valueTo<DetectAddressBase64Variant, Map<String, dynamic>>(
            key: 'bounceable',
            parse: (v) => DetectAddressBase64Variant.fromJson(v),
          ),
      nonBounceable: json
          .valueTo<DetectAddressBase64Variant, Map<String, dynamic>>(
            key: 'non_bounceable',
            parse: (v) => DetectAddressBase64Variant.fromJson(v),
          ),
      givenType: json.valueTo<DetectAddressGivenType, Object>(
        key: 'given_type',
        parse: (e) => DetectAddressGivenType.fromJson(JsonParser.valueAs(e)),
      ),
      testOnly: json.valueAsBool<bool>('test_only'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'raw_form': rawForm,
    'bounceable': bounceable.toJson(config: config),
    'non_bounceable': nonBounceable.toJson(config: config),
    'given_type': givenType.toJson(config: config),
    'test_only': testOnly,
  });
}

/// User-friendly address in both standard base64 and URL-safe base64 encodings.
class DetectAddressBase64Variant {
  /// TonLib type identifier for base64 address encoding variants.
  final DetectAddressBase64VariantType type;

  /// Address in standard base64 encoding (48 characters, uses `+` and `/`).
  final String b64;

  /// Address in URL-safe base64 encoding (48 characters, uses `-` and `_` instead of `+` and `/`).
  final String b64url;

  const DetectAddressBase64Variant({
    required this.type,
    required this.b64,
    required this.b64url,
  });

  factory DetectAddressBase64Variant.fromJson(Map<String, dynamic> json) {
    return DetectAddressBase64Variant(
      type: json.valueTo<DetectAddressBase64VariantType, Object>(
        key: '@type',
        parse:
            (e) =>
                DetectAddressBase64VariantType.fromJson(JsonParser.valueAs(e)),
      ),
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
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'b64': b64,
    'b64url': b64url,
  });
}

/// Detected hash in all supported encoding formats: hex (64 characters), standard base64 (44 characters), and URL-safe base64.
class DetectHash {
  /// TonLib type identifier for hash detection results.
  final DetectHashType type;

  /// Hash in standard base64 encoding (44 characters, uses `+` and `/`).
  final String b64;

  /// Hash in URL-safe base64 encoding (44 characters, uses `-` and `_` instead of `+` and `/`).
  final String b64url;

  /// Hash in lowercase hexadecimal encoding (64 characters).
  final String hex;

  const DetectHash({
    required this.type,
    required this.b64,
    required this.b64url,
    required this.hex,
  });

  factory DetectHash.fromJson(Map<String, dynamic> json) {
    return DetectHash(
      type: json.valueTo<DetectHashType, Object>(
        key: '@type',
        parse: (e) => DetectHashType.fromJson(JsonParser.valueAs(e)),
      ),
      b64:
          (json['b64'] is num
              ? json['b64'].toString()
              : json.valueAsString<String>('b64')),
      b64url:
          (json['b64url'] is num
              ? json['b64url'].toString()
              : json.valueAsString<String>('b64url')),
      hex:
          (json['hex'] is num
              ? json['hex'].toString()
              : json.valueAsString<String>('hex')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'b64': b64,
    'b64url': b64url,
    'hex': hex,
  });
}

/// POST /api/v2/detectHash (request)
class DetectHashRequest {
  /// Hash value to detect encoding formats for.
  final String hash;

  const DetectHashRequest({required this.hash});

  factory DetectHashRequest.fromJson(Map<String, dynamic> json) {
    return DetectHashRequest(
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String>('hash')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'hash': hash});
}

class DnsContent {
  /// The resolved domain name.
  final String domain;

  /// Parsed DNS records for this domain.
  final DnsRecordSet data;

  const DnsContent({required this.domain, required this.data});

  factory DnsContent.fromJson(Map<String, dynamic> json) {
    return DnsContent(
      domain:
          (json['domain'] is num
              ? json['domain'].toString()
              : json.valueAsString<String>('domain')),
      data: json.valueTo<DnsRecordSet, Map<String, dynamic>>(
        key: 'data',
        parse: (v) => DnsRecordSet.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'domain': domain,
    'data': data.toJson(config: config),
  });
}

class DnsEntry {
  final DnsEntryType type;
  final String name;
  final String category;
  final DnsEntryData entry;

  const DnsEntry({
    required this.type,
    required this.name,
    required this.category,
    required this.entry,
  });

  factory DnsEntry.fromJson(Map<String, dynamic> json) {
    return DnsEntry(
      type: json.valueTo<DnsEntryType, Object>(
        key: '@type',
        parse: (e) => DnsEntryType.fromJson(JsonParser.valueAs(e)),
      ),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String>('name')),
      category:
          (json['category'] is num
              ? json['category'].toString()
              : json.valueAsString<String>('category')),
      entry: json.valueTo<DnsEntryData, Object>(
        key: 'entry',
        parse: (e) => DnsEntryData.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'name': name,
    'category': category,
    'entry': entry.toJson(config: config),
  });
}

class DnsEntryDataAdnlAddress {
  final DnsEntryDataAdnlAddressType type;
  final AdnlAddress adnlAddress;

  const DnsEntryDataAdnlAddress({
    required this.type,
    required this.adnlAddress,
  });

  factory DnsEntryDataAdnlAddress.fromJson(Map<String, dynamic> json) {
    return DnsEntryDataAdnlAddress(
      type: json.valueTo<DnsEntryDataAdnlAddressType, Object>(
        key: '@type',
        parse:
            (e) => DnsEntryDataAdnlAddressType.fromJson(JsonParser.valueAs(e)),
      ),
      adnlAddress: json.valueTo<AdnlAddress, Map<String, dynamic>>(
        key: 'adnl_address',
        parse: (v) => AdnlAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'adnl_address': adnlAddress.toJson(config: config),
  });
}

class DnsEntryDataNextResolver {
  final DnsEntryDataNextResolverType type;
  final AccountAddress resolver;

  const DnsEntryDataNextResolver({required this.type, required this.resolver});

  factory DnsEntryDataNextResolver.fromJson(Map<String, dynamic> json) {
    return DnsEntryDataNextResolver(
      type: json.valueTo<DnsEntryDataNextResolverType, Object>(
        key: '@type',
        parse:
            (e) => DnsEntryDataNextResolverType.fromJson(JsonParser.valueAs(e)),
      ),
      resolver: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'resolver',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'resolver': resolver.toJson(config: config),
  });
}

class DnsEntryDataSmcAddress {
  final DnsEntryDataSmcAddressType type;
  final AccountAddress smcAddress;

  const DnsEntryDataSmcAddress({required this.type, required this.smcAddress});

  factory DnsEntryDataSmcAddress.fromJson(Map<String, dynamic> json) {
    return DnsEntryDataSmcAddress(
      type: json.valueTo<DnsEntryDataSmcAddressType, Object>(
        key: '@type',
        parse:
            (e) => DnsEntryDataSmcAddressType.fromJson(JsonParser.valueAs(e)),
      ),
      smcAddress: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'smc_address',
        parse: (v) => AccountAddress.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'smc_address': smcAddress.toJson(config: config),
  });
}

class DnsEntryDataStorageAddress {
  final DnsEntryDataStorageAddressType type;
  final String bagId;

  const DnsEntryDataStorageAddress({required this.type, required this.bagId});

  factory DnsEntryDataStorageAddress.fromJson(Map<String, dynamic> json) {
    return DnsEntryDataStorageAddress(
      type: json.valueTo<DnsEntryDataStorageAddressType, Object>(
        key: '@type',
        parse:
            (e) =>
                DnsEntryDataStorageAddressType.fromJson(JsonParser.valueAs(e)),
      ),
      bagId:
          (json['bag_id'] is num
              ? json['bag_id'].toString()
              : json.valueAsString<String>('bag_id')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'bag_id': bagId,
  });
}

class DnsEntryDataText {
  final DnsEntryDataTextType type;
  final String text;

  const DnsEntryDataText({required this.type, required this.text});

  factory DnsEntryDataText.fromJson(Map<String, dynamic> json) {
    return DnsEntryDataText(
      type: json.valueTo<DnsEntryDataTextType, Object>(
        key: '@type',
        parse: (e) => DnsEntryDataTextType.fromJson(JsonParser.valueAs(e)),
      ),
      text:
          (json['text'] is num
              ? json['text'].toString()
              : json.valueAsString<String>('text')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'text': text,
  });
}

class DnsEntryDataUnknown {
  final DnsEntryDataUnknownType type;
  final String bytes;

  const DnsEntryDataUnknown({required this.type, required this.bytes});

  factory DnsEntryDataUnknown.fromJson(Map<String, dynamic> json) {
    return DnsEntryDataUnknown(
      type: json.valueTo<DnsEntryDataUnknownType, Object>(
        key: '@type',
        parse: (e) => DnsEntryDataUnknownType.fromJson(JsonParser.valueAs(e)),
      ),
      bytes:
          (json['bytes'] is num
              ? json['bytes'].toString()
              : json.valueAsString<String>('bytes')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'bytes': bytes,
  });
}

class DnsRecordAdnlAddress {
  /// TonLib type identifier for ADNL address DNS records.
  final DnsRecordAdnlAddressType type;

  /// ADNL (Abstract Datagram Network Layer) address in hex, used for TON Sites and services.
  final String adnlAddr;

  const DnsRecordAdnlAddress({required this.type, required this.adnlAddr});

  factory DnsRecordAdnlAddress.fromJson(Map<String, dynamic> json) {
    return DnsRecordAdnlAddress(
      type: json.valueTo<DnsRecordAdnlAddressType, Object>(
        key: '@type',
        parse: (e) => DnsRecordAdnlAddressType.fromJson(JsonParser.valueAs(e)),
      ),
      adnlAddr:
          (json['adnl_addr'] is num
              ? json['adnl_addr'].toString()
              : json.valueAsString<String>('adnl_addr')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'adnl_addr': adnlAddr,
  });
}

class DnsRecordNextResolver {
  /// TonLib type identifier for next-resolver DNS records.
  final DnsRecordNextResolverType type;

  /// Smart contract address of the next DNS resolver in the chain.
  final SmcAddr resolver;

  const DnsRecordNextResolver({required this.type, required this.resolver});

  factory DnsRecordNextResolver.fromJson(Map<String, dynamic> json) {
    return DnsRecordNextResolver(
      type: json.valueTo<DnsRecordNextResolverType, Object>(
        key: '@type',
        parse: (e) => DnsRecordNextResolverType.fromJson(JsonParser.valueAs(e)),
      ),
      resolver: json.valueTo<SmcAddr, Map<String, dynamic>>(
        key: 'resolver',
        parse: (v) => SmcAddr.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'resolver': resolver.toJson(config: config),
  });
}

class DnsRecordSet {
  /// Next resolver contract for subdomain lookups.
  final DnsRecord? dnsNextResolver;

  /// Wallet address associated with this domain.
  final DnsRecord? wallet;

  /// Site hosting address (ADNL or TON Storage).
  final DnsRecord? site;

  /// TON Storage bag ID for files hosted under this domain.
  final DnsRecord? storage;

  const DnsRecordSet({
    this.dnsNextResolver,
    this.wallet,
    this.site,
    this.storage,
  });

  factory DnsRecordSet.fromJson(Map<String, dynamic> json) {
    return DnsRecordSet(
      dnsNextResolver: json.valueTo<DnsRecord?, Object>(
        key: 'dns_next_resolver',
        parse: (e) => DnsRecord.fromJson(JsonParser.valueAs(e)),
      ),
      wallet: json.valueTo<DnsRecord?, Object>(
        key: 'wallet',
        parse: (e) => DnsRecord.fromJson(JsonParser.valueAs(e)),
      ),
      site: json.valueTo<DnsRecord?, Object>(
        key: 'site',
        parse: (e) => DnsRecord.fromJson(JsonParser.valueAs(e)),
      ),
      storage: json.valueTo<DnsRecord?, Object>(
        key: 'storage',
        parse: (e) => DnsRecord.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'dns_next_resolver': dnsNextResolver?.toJson(config: config),
    'wallet': wallet?.toJson(config: config),
    'site': site?.toJson(config: config),
    'storage': storage?.toJson(config: config),
  });
}

class DnsRecordSmcAddress {
  /// TonLib type identifier for smart contract address DNS records.
  final DnsRecordSmcAddressType type;

  /// Smart contract address associated with this DNS record.
  final SmcAddr smcAddr;

  const DnsRecordSmcAddress({required this.type, required this.smcAddr});

  factory DnsRecordSmcAddress.fromJson(Map<String, dynamic> json) {
    return DnsRecordSmcAddress(
      type: json.valueTo<DnsRecordSmcAddressType, Object>(
        key: '@type',
        parse: (e) => DnsRecordSmcAddressType.fromJson(JsonParser.valueAs(e)),
      ),
      smcAddr: json.valueTo<SmcAddr, Map<String, dynamic>>(
        key: 'smc_addr',
        parse: (v) => SmcAddr.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'smc_addr': smcAddr.toJson(config: config),
  });
}

class DnsRecordStorageAddress {
  /// TonLib type identifier for TON Storage DNS records.
  final DnsRecordStorageAddressType type;

  /// TON Storage bag identifier in hex, pointing to distributed file storage.
  final String bagId;

  const DnsRecordStorageAddress({required this.type, required this.bagId});

  factory DnsRecordStorageAddress.fromJson(Map<String, dynamic> json) {
    return DnsRecordStorageAddress(
      type: json.valueTo<DnsRecordStorageAddressType, Object>(
        key: '@type',
        parse:
            (e) => DnsRecordStorageAddressType.fromJson(JsonParser.valueAs(e)),
      ),
      bagId:
          (json['bag_id'] is num
              ? json['bag_id'].toString()
              : json.valueAsString<String>('bag_id')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'bag_id': bagId,
  });
}

/// POST /api/v2/dnsResolve (request)
class DnsResolveRequest {
  /// Domain to resolve; relative to resolver_address when supplied. Case-insensitive; a trailing dot is accepted.
  final String domain;
  final String? resolverAddress;

  /// Masterchain block for root discovery and every resolver call. Defaults to current state.
  final int? seqno;

  const DnsResolveRequest({
    required this.domain,
    this.resolverAddress,
    this.seqno,
  });

  factory DnsResolveRequest.fromJson(Map<String, dynamic> json) {
    return DnsResolveRequest(
      domain:
          (json['domain'] is num
              ? json['domain'].toString()
              : json.valueAsString<String>('domain')),
      resolverAddress:
          (json['resolver_address'] is num
              ? json['resolver_address'].toString()
              : json.valueAsString<String?>('resolver_address')),
      seqno: json.valueAsInt<int?>('seqno'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'domain': domain,
    'resolver_address': resolverAddress,
    'seqno': seqno,
  });
}

class DnsResolved {
  final DnsResolvedType type;
  final List<DnsEntry> entries;

  const DnsResolved({required this.type, required this.entries});

  factory DnsResolved.fromJson(Map<String, dynamic> json) {
    return DnsResolved(
      type: json.valueTo<DnsResolvedType, Object>(
        key: '@type',
        parse: (e) => DnsResolvedType.fromJson(JsonParser.valueAs(e)),
      ),
      entries:
          json
              .valueEnsureAsList<Map<String, dynamic>>('entries')
              .map((e) => DnsEntry.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'entries': entries.map((e) => e.toJson(config: config)).toList(),
  });
}

/// Empty request body for endpoints that require no parameters.
class EmptyRequest {
  final Map<String, dynamic> values;
  const EmptyRequest(this.values);

  factory EmptyRequest.fromJson(Map<String, dynamic> json) =>
      EmptyRequest(json.map((k, v) => MapEntry(k, v)));

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(values.map((k, v) => MapEntry(k, v)));
}

/// Request to estimate transaction fees. Include the target address, message body, and optionally init code/data for contract deployment.
///
/// POST /api/v2/estimateFee (request)
class EstimateFeeRequest {
  final String address;

  /// Message body in BoC format, base64 encoded.
  final String body;

  /// Contract code for deployment messages, BoC format, base64 encoded. Omit for regular transfers.
  final String? initCode;

  /// Initial contract storage for deployment, BoC format, base64 encoded. Omit for regular transfers.
  final String? initData;

  /// Set to `true` to skip signature verification during fee estimation; otherwise `false`. Useful when a real signature is not yet available.
  final bool? ignoreChksig;

  const EstimateFeeRequest({
    required this.address,
    required this.body,
    this.initCode,
    this.initData,
    this.ignoreChksig,
  });

  factory EstimateFeeRequest.fromJson(Map<String, dynamic> json) {
    return EstimateFeeRequest(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      body:
          (json['body'] is num
              ? json['body'].toString()
              : json.valueAsString<String>('body')),
      initCode:
          (json['init_code'] is num
              ? json['init_code'].toString()
              : json.valueAsString<String?>('init_code')),
      initData:
          (json['init_data'] is num
              ? json['init_data'].toString()
              : json.valueAsString<String?>('init_data')),
      ignoreChksig: json.valueAsBool<bool?>('ignore_chksig'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'body': body,
    'init_code': initCode,
    'init_data': initData,
    'ignore_chksig': ignoreChksig,
  });
}

/// Information about a broadcast external message. Contains the message hash which can be used to track processing.
class ExtMessageInfo {
  /// TonLib type identifier for external message info after broadcast.
  final ExtMessageInfoType type;

  /// SHA-256 hash of the external message as accepted by the network.
  final String hash;
  final String hashNorm;

  const ExtMessageInfo({
    required this.type,
    required this.hash,
    required this.hashNorm,
  });

  factory ExtMessageInfo.fromJson(Map<String, dynamic> json) {
    return ExtMessageInfo(
      type: json.valueTo<ExtMessageInfoType, Object>(
        key: '@type',
        parse: (e) => ExtMessageInfoType.fromJson(JsonParser.valueAs(e)),
      ),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String>('hash')),
      hashNorm:
          (json['hash_norm'] is num
              ? json['hash_norm'].toString()
              : json.valueAsString<String>('hash_norm')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'hash': hash,
    'hash_norm': hashNorm,
  });
}

class ExtendedAddressInformation {
  /// TonLib type identifier for extended account state responses.
  final ExtendedAddressInformationType type;

  /// Account address object.
  final AccountAddress address;

  /// Account balance in nanotons as a decimal string. 1 TON = 1,000,000,000 nanotons.
  final String balance;

  /// Array of non-TON currency balances held by this account. Each entry contains a currency ID (integer) and balance amount (decimal string). Empty array if the account holds no extra currencies.
  final List<ExtraCurrencyBalance> extraCurrencies;

  /// Reference to the most recent transaction. Use as starting point for getTransactions.
  final InternalTransactionId lastTransactionId;

  /// Full block identifier where this event occurred.
  final TonBlockIdExt blockId;

  /// Unix timestamp of the block from which this data was read.
  final BigInt syncUtime;

  /// Detailed account state including contract type and internal data.
  final AccountState accountState;

  /// Contract revision number. Different revisions may have different behavior.
  final int revision;

  const ExtendedAddressInformation({
    required this.type,
    required this.address,
    required this.balance,
    required this.extraCurrencies,
    required this.lastTransactionId,
    required this.blockId,
    required this.syncUtime,
    required this.accountState,
    required this.revision,
  });

  factory ExtendedAddressInformation.fromJson(Map<String, dynamic> json) {
    return ExtendedAddressInformation(
      type: json.valueTo<ExtendedAddressInformationType, Object>(
        key: '@type',
        parse:
            (e) =>
                ExtendedAddressInformationType.fromJson(JsonParser.valueAs(e)),
      ),
      address: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'address',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String>('balance')),
      extraCurrencies:
          json
              .valueEnsureAsList<Map<String, dynamic>>('extra_currencies')
              .map((e) => ExtraCurrencyBalance.fromJson(e))
              .toList(),
      lastTransactionId: json
          .valueTo<InternalTransactionId, Map<String, dynamic>>(
            key: 'last_transaction_id',
            parse: (v) => InternalTransactionId.fromJson(v),
          ),
      blockId: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'block_id',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      syncUtime: json.valueAsBigInt<BigInt>('sync_utime'),
      accountState: json.valueTo<AccountState, Object>(
        key: 'account_state',
        parse: (e) => AccountState.fromJson(JsonParser.valueAs(e)),
      ),
      revision: json.valueAsInt<int>('revision'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'address': address.toJson(config: config),
    'balance': balance,
    'extra_currencies':
        extraCurrencies.map((e) => e.toJson(config: config)).toList(),
    'last_transaction_id': lastTransactionId.toJson(config: config),
    'block_id': blockId.toJson(config: config),
    'sync_utime': config.encodeBigint(syncUtime),
    'account_state': accountState.toJson(config: config),
    'revision': revision,
  });
}

class ExtraCurrencyBalance {
  /// TonLib type identifier for extra currency balance entries.
  final ExtraCurrencyBalanceType type;
  final int id;

  /// Currency balance amount as a decimal string.
  final String amount;

  const ExtraCurrencyBalance({
    required this.type,
    required this.id,
    required this.amount,
  });

  factory ExtraCurrencyBalance.fromJson(Map<String, dynamic> json) {
    return ExtraCurrencyBalance(
      type: json.valueTo<ExtraCurrencyBalanceType, Object>(
        key: '@type',
        parse: (e) => ExtraCurrencyBalanceType.fromJson(JsonParser.valueAs(e)),
      ),
      id: json.valueAsInt<int>('id'),
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String>('amount')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'id': id,
    'amount': amount,
  });
}

class Fees {
  /// TonLib type identifier for fee breakdown objects.
  final FeesType type;

  /// Fee for importing this inbound message, in nanotons.
  final BigInt inFwdFee;

  /// Storage fee charged for keeping the contract state on-chain, in nanotons.
  final BigInt storageFee;

  /// Computation gas fee for executing contract code, in nanotons.
  final BigInt gasFee;

  /// Fee for forwarding outbound messages created by this transaction, in nanotons.
  final BigInt fwdFee;

  const Fees({
    required this.type,
    required this.inFwdFee,
    required this.storageFee,
    required this.gasFee,
    required this.fwdFee,
  });

  factory Fees.fromJson(Map<String, dynamic> json) {
    return Fees(
      type: json.valueTo<FeesType, Object>(
        key: '@type',
        parse: (e) => FeesType.fromJson(JsonParser.valueAs(e)),
      ),
      inFwdFee: json.valueAsBigInt<BigInt>('in_fwd_fee'),
      storageFee: json.valueAsBigInt<BigInt>('storage_fee'),
      gasFee: json.valueAsBigInt<BigInt>('gas_fee'),
      fwdFee: json.valueAsBigInt<BigInt>('fwd_fee'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'in_fwd_fee': config.encodeBigint(inFwdFee),
    'storage_fee': config.encodeBigint(storageFee),
    'gas_fee': config.encodeBigint(gasFee),
    'fwd_fee': config.encodeBigint(fwdFee),
  });
}

/// A reference to a specific transaction. The combination of `lt` (logical time) and `hash` uniquely identifies any transaction. Use these values for pagination and lookups.
class InternalTransactionId {
  /// TonLib type identifier for transaction ID references.
  final InternalTransactionIdType type;

  /// Logical time of the transaction. Use together with its hash for pagination and lookups.
  final String lt;

  /// SHA-256 hash of this transaction, encoded in base64.
  final String hash;

  const InternalTransactionId({
    required this.type,
    required this.lt,
    required this.hash,
  });

  factory InternalTransactionId.fromJson(Map<String, dynamic> json) {
    return InternalTransactionId(
      type: json.valueTo<InternalTransactionIdType, Object>(
        key: '@type',
        parse: (e) => InternalTransactionIdType.fromJson(JsonParser.valueAs(e)),
      ),
      lt:
          (json['lt'] is num
              ? json['lt'].toString()
              : json.valueAsString<String>('lt')),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String>('hash')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'lt': lt,
    'hash': hash,
  });
}

/// Jetton (fungible token) master contract data. Contains total supply, whether minting is allowed, admin address, and token metadata (name, symbol, decimals). This is the central contract that tracks the token.
class JettonMasterData {
  /// TonLib type identifier for Jetton master contract data.
  final JettonMasterDataType type;

  /// Contract address of this Jetton master.
  final String address;

  /// Type of token contract: jetton_master, jetton_wallet, nft_collection, or nft_item.
  final JettonMasterDataContractType contractType;

  /// Total tokens in circulation, in the smallest unit. Divide by 10^decimals for human-readable amount.
  final String totalSupply;

  /// Whether new tokens can currently be minted.
  final bool mintable;

  /// Admin address that can mint tokens or update metadata. Empty if admin rights were revoked.
  final String? adminAddress;

  /// Token metadata: name, symbol, decimals, description, and image URL.
  final TokenContent jettonContent;

  /// Code used to deploy individual user wallets for this token. Used to verify wallet authenticity.
  final String jettonWalletCode;

  const JettonMasterData({
    required this.type,
    required this.address,
    required this.contractType,
    required this.totalSupply,
    required this.mintable,
    this.adminAddress,
    required this.jettonContent,
    required this.jettonWalletCode,
  });

  factory JettonMasterData.fromJson(Map<String, dynamic> json) {
    return JettonMasterData(
      type: json.valueTo<JettonMasterDataType, Object>(
        key: '@type',
        parse: (e) => JettonMasterDataType.fromJson(JsonParser.valueAs(e)),
      ),
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      contractType: json.valueTo<JettonMasterDataContractType, Object>(
        key: 'contract_type',
        parse:
            (e) => JettonMasterDataContractType.fromJson(JsonParser.valueAs(e)),
      ),
      totalSupply:
          (json['total_supply'] is num
              ? json['total_supply'].toString()
              : json.valueAsString<String>('total_supply')),
      mintable: json.valueAsBool<bool>('mintable'),
      adminAddress:
          (json['admin_address'] is num
              ? json['admin_address'].toString()
              : json.valueAsString<String?>('admin_address')),
      jettonContent: json.valueTo<TokenContent, Map<String, dynamic>>(
        key: 'jetton_content',
        parse: (v) => TokenContent.fromJson(v),
      ),
      jettonWalletCode:
          (json['jetton_wallet_code'] is num
              ? json['jetton_wallet_code'].toString()
              : json.valueAsString<String>('jetton_wallet_code')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'address': address,
    'contract_type': contractType.toJson(config: config),
    'total_supply': totalSupply,
    'mintable': mintable,
    'admin_address': adminAddress,
    'jetton_content': jettonContent.toJson(config: config),
    'jetton_wallet_code': jettonWalletCode,
  });
}

/// Jetton wallet contract data. Each user has a separate wallet contract for each token they hold. Contains the token balance, owner address, and reference to the master contract.
class JettonWalletData {
  /// TonLib type identifier for Jetton wallet contract data.
  final JettonWalletDataType type;

  /// Contract address of this Jetton wallet.
  final String address;

  /// Type of token contract: jetton_master, jetton_wallet, nft_collection, or nft_item.
  final JettonWalletDataContractType contractType;

  /// The token balance in the Jetton's base units (smallest denomination). To get the human-readable amount, divide by 10^decimals, where `decimals` is a metadata field on the Jetton master contract (commonly 9, but varies per token). Refer to the Jetton overview for how Jetton decimals are defined.
  final String balance;

  /// Wallet owner's address (the user who holds these tokens).
  final String owner;

  /// Address of the Jetton master contract this wallet belongs to.
  final String jetton;

  /// Returns `true` if the mintless jetton allocation has been claimed; otherwise `false`.
  final bool? mintlessIsClaimed;

  /// Wallet contract code. Should match the master contract's wallet code to verify authenticity.
  final String jettonWalletCode;

  const JettonWalletData({
    required this.type,
    required this.address,
    required this.contractType,
    required this.balance,
    required this.owner,
    required this.jetton,
    this.mintlessIsClaimed,
    required this.jettonWalletCode,
  });

  factory JettonWalletData.fromJson(Map<String, dynamic> json) {
    return JettonWalletData(
      type: json.valueTo<JettonWalletDataType, Object>(
        key: '@type',
        parse: (e) => JettonWalletDataType.fromJson(JsonParser.valueAs(e)),
      ),
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      contractType: json.valueTo<JettonWalletDataContractType, Object>(
        key: 'contract_type',
        parse:
            (e) => JettonWalletDataContractType.fromJson(JsonParser.valueAs(e)),
      ),
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String>('balance')),
      owner:
          (json['owner'] is num
              ? json['owner'].toString()
              : json.valueAsString<String>('owner')),
      jetton:
          (json['jetton'] is num
              ? json['jetton'].toString()
              : json.valueAsString<String>('jetton')),
      mintlessIsClaimed: json.valueAsBool<bool?>('mintless_is_claimed'),
      jettonWalletCode:
          (json['jetton_wallet_code'] is num
              ? json['jetton_wallet_code'].toString()
              : json.valueAsString<String>('jetton_wallet_code')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'address': address,
    'contract_type': contractType.toJson(config: config),
    'balance': balance,
    'owner': owner,
    'jetton': jetton,
    'mintless_is_claimed': mintlessIsClaimed,
    'jetton_wallet_code': jettonWalletCode,
  });
}

/// The `ok` field is always false, `code` contains the HTTP status, and `error` describes what went wrong.
class JsonRpcErrorResponse {
  final String jsonrpc;
  final String id;

  /// Always `false` for error responses.
  final bool ok;

  /// Error message explaining what went wrong.
  final String error;

  /// HTTP status code. Common values: 404 (not found), 409 (conflict), 422 (validation error), 429 (rate limit), 500 (server error), 504 (timeout), 542 (liteserver error).
  final int code;
  final String? extra;

  const JsonRpcErrorResponse({
    required this.jsonrpc,
    required this.id,
    required this.ok,
    required this.error,
    required this.code,
    this.extra,
  });

  factory JsonRpcErrorResponse.fromJson(Map<String, dynamic> json) {
    return JsonRpcErrorResponse(
      jsonrpc:
          (json['jsonrpc'] is num
              ? json['jsonrpc'].toString()
              : json.valueAsString<String>('jsonrpc')),
      id:
          (json['id'] is num
              ? json['id'].toString()
              : json.valueAsString<String>('id')),
      ok: json.valueAsBool<bool>('ok'),
      error:
          (json['error'] is num
              ? json['error'].toString()
              : json.valueAsString<String>('error')),
      code: json.valueAsInt<int>('code'),
      extra:
          (json['@extra'] is num
              ? json['@extra'].toString()
              : json.valueAsString<String?>('@extra')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'jsonrpc': jsonrpc,
    'id': id,
    'ok': ok,
    'error': error,
    'code': code,
    '@extra': extra,
  });
}

/// Request to the JSON-RPC endpoint. Set `method` to the API method name (e.g., `getWalletInformation`) and `params` to a dictionary of parameters.
///
/// POST /api/v2/jsonRPC (request)
class JsonRpcRequest {
  /// JSON-RPC protocol version identifier.
  final String jsonrpc;
  final String id;

  /// API method name to invoke (e.g., `getMasterchainInfo`, `getAddressBalance`).
  final String method;

  /// Method parameters as a JSON object with key-value pairs.
  final Map<String, dynamic> params;

  const JsonRpcRequest({
    required this.jsonrpc,
    required this.id,
    required this.method,
    required this.params,
  });

  factory JsonRpcRequest.fromJson(Map<String, dynamic> json) {
    return JsonRpcRequest(
      jsonrpc:
          (json['jsonrpc'] is num
              ? json['jsonrpc'].toString()
              : json.valueAsString<String>('jsonrpc')),
      id:
          (json['id'] is num
              ? json['id'].toString()
              : json.valueAsString<String>('id')),
      method:
          (json['method'] is num
              ? json['method'].toString()
              : json.valueAsString<String>('method')),
      params: json.valueAsMap<Map<String, dynamic>>('params'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'jsonrpc': jsonrpc,
    'id': id,
    'method': method,
    'params': params,
  });
}

class JsonRpcResponse {
  /// JSON-RPC protocol version identifier.
  final String jsonrpc;
  final String id;

  /// Returns `true` if the request succeeded; otherwise `false`. See the `error` field for details.
  final bool ok;

  /// The method return value. The structure depends on the method called; see individual method documentation for response schemas. Only present when `ok` is `true`.
  final JsonRpcResponseResult result;
  final String extra;

  const JsonRpcResponse({
    required this.jsonrpc,
    required this.id,
    required this.ok,
    required this.result,
    required this.extra,
  });

  factory JsonRpcResponse.fromJson(Map<String, dynamic> json) {
    return JsonRpcResponse(
      jsonrpc:
          (json['jsonrpc'] is num
              ? json['jsonrpc'].toString()
              : json.valueAsString<String>('jsonrpc')),
      id:
          (json['id'] is num
              ? json['id'].toString()
              : json.valueAsString<String>('id')),
      ok: json.valueAsBool<bool>('ok'),
      result: json.valueTo<JsonRpcResponseResult, Object>(
        key: 'result',
        parse: (e) => JsonRpcResponseResult.fromJson(JsonParser.valueAs(e)),
      ),
      extra:
          (json['@extra'] is num
              ? json['@extra'].toString()
              : json.valueAsString<String>('@extra')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'jsonrpc': jsonrpc,
    'id': id,
    'ok': ok,
    'result': result.toJson(config: config),
    '@extra': extra,
  });
}

class LegacyStackEntryCell {
  /// Raw cell bytes in base64.
  final String bytes;

  /// Parsed cell object with data, refs, and type info.
  final LegacyTvmCell? object;

  const LegacyStackEntryCell({required this.bytes, this.object});

  factory LegacyStackEntryCell.fromJson(Map<String, dynamic> json) {
    return LegacyStackEntryCell(
      bytes:
          (json['bytes'] is num
              ? json['bytes'].toString()
              : json.valueAsString<String>('bytes')),
      object: json.valueTo<LegacyTvmCell?, Map<String, dynamic>>(
        key: 'object',
        parse: (v) => LegacyTvmCell.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'bytes': bytes,
    'object': object?.toJson(config: config),
  });
}

class LegacyTvmCell {
  /// Cell binary data.
  final LegacyTvmCellData data;

  /// Array of child cell references, forming a directed acyclic graph (DAG). Each child is a TVM cell object with its own data (base64), refs, and special flag.
  final List<LegacyTvmCell> refs;

  /// Returns `true` if this is a special (exotic) cell type such as a Merkle proof or library reference; otherwise `false`.
  final bool special;

  const LegacyTvmCell({
    required this.data,
    required this.refs,
    required this.special,
  });

  factory LegacyTvmCell.fromJson(Map<String, dynamic> json) {
    return LegacyTvmCell(
      data: json.valueTo<LegacyTvmCellData, Map<String, dynamic>>(
        key: 'data',
        parse: (v) => LegacyTvmCellData.fromJson(v),
      ),
      refs:
          json
              .valueEnsureAsList<Map<String, dynamic>>('refs')
              .map((e) => LegacyTvmCell.fromJson(e))
              .toList(),
      special: json.valueAsBool<bool>('special'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'data': data.toJson(config: config),
    'refs': refs.map((e) => e.toJson(config: config)).toList(),
    'special': special,
  });
}

/// POST /api/v2/getLibraries (request)
class LibrariesRequest {
  /// Array of library cell hashes to retrieve. Each hash is a 256-bit value in hex (64 chars) or base64 (44 chars) format.
  final List<String>? libraries;

  const LibrariesRequest({this.libraries});

  factory LibrariesRequest.fromJson(Map<String, dynamic> json) {
    return LibrariesRequest(
      libraries: json.valueAsList<List<String>?>('libraries'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'libraries': libraries});
}

class LibraryEntry {
  /// TonLib type identifier for shared library cell entries.
  final LibraryEntryType type;

  /// Library cell hash.
  final String hash;

  /// Library cell code in BoC format, base64 encoded.
  final String data;

  const LibraryEntry({
    required this.type,
    required this.hash,
    required this.data,
  });

  factory LibraryEntry.fromJson(Map<String, dynamic> json) {
    return LibraryEntry(
      type: json.valueTo<LibraryEntryType, Object>(
        key: '@type',
        parse: (e) => LibraryEntryType.fromJson(JsonParser.valueAs(e)),
      ),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String>('hash')),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString<String>('data')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'hash': hash,
    'data': data,
  });
}

/// Library code fetched by hash. Contains the actual code cells for shared libraries referenced by smart contracts.
class LibraryResult {
  /// TonLib type identifier for library lookup results.
  final LibraryResultType type;

  /// Array of library entries. Each entry contains a hash (base64 or hex) identifying the library and a data field with the library code in BoC format (base64).
  final List<LibraryEntry> result;

  const LibraryResult({required this.type, required this.result});

  factory LibraryResult.fromJson(Map<String, dynamic> json) {
    return LibraryResult(
      type: json.valueTo<LibraryResultType, Object>(
        key: '@type',
        parse: (e) => LibraryResultType.fromJson(JsonParser.valueAs(e)),
      ),
      result:
          json
              .valueEnsureAsList<Map<String, dynamic>>('result')
              .map((e) => LibraryEntry.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'result': result.map((e) => e.toJson(config: config)).toList(),
  });
}

/// Request to find a block by workchain, shard, and either `seqno`, lt, or unixtime.
///
/// POST /api/v2/lookupBlock (request)
class LookupBlockRequest {
  /// Workchain ID: `-1` for masterchain, `0` for basechain. Most user transactions are on workchain `0`.
  final AddressWithSeqnoRequestSeqno workchain;

  /// Shard identifier. A signed 64-bit integer. Masterchain uses -9223372036854775808.
  final BigInt shard;
  final AddressWithSeqnoRequestSeqno? seqno;

  /// Logical time of the transaction. Use together with its hash for pagination and lookups.
  final BigInt? lt;

  /// Unix timestamp to look up.
  final AddressWithSeqnoRequestSeqno? unixtime;

  const LookupBlockRequest({
    required this.workchain,
    required this.shard,
    this.seqno,
    this.lt,
    this.unixtime,
  });

  factory LookupBlockRequest.fromJson(Map<String, dynamic> json) {
    return LookupBlockRequest(
      workchain: json.valueTo<AddressWithSeqnoRequestSeqno, Object>(
        key: 'workchain',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
      shard: json.valueAsBigInt<BigInt>('shard'),
      seqno: json.valueTo<AddressWithSeqnoRequestSeqno?, Object>(
        key: 'seqno',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
      lt: json.valueAsBigInt<BigInt?>('lt'),
      unixtime: json.valueTo<AddressWithSeqnoRequestSeqno?, Object>(
        key: 'unixtime',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'workchain': workchain.toJson(config: config),
    'shard': config.encodeBigint(shard),
    'seqno': seqno?.toJson(config: config),
    'lt': config.encodeBigint(lt),
    'unixtime': unixtime?.toJson(config: config),
  });
}

/// Information about the latest masterchain block.
class MasterchainInfo {
  /// TonLib type identifier for masterchain state info.
  final MasterchainInfoType type;

  /// The most recent masterchain block.
  final TonBlockIdExt last;
  final String stateRootHash;
  final TonBlockIdExt init;

  const MasterchainInfo({
    required this.type,
    required this.last,
    required this.stateRootHash,
    required this.init,
  });

  factory MasterchainInfo.fromJson(Map<String, dynamic> json) {
    return MasterchainInfo(
      type: json.valueTo<MasterchainInfoType, Object>(
        key: '@type',
        parse: (e) => MasterchainInfoType.fromJson(JsonParser.valueAs(e)),
      ),
      last: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'last',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      stateRootHash:
          (json['state_root_hash'] is num
              ? json['state_root_hash'].toString()
              : json.valueAsString<String>('state_root_hash')),
      init: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'init',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'last': last.toJson(config: config),
    'state_root_hash': stateRootHash,
    'init': init.toJson(config: config),
  });
}

/// A message between accounts. Contains sender, recipient, TON amount transferred, message creation logical time, and the message body.
class Message {
  /// TonLib type identifier for extended message objects with decoded comments.
  final MessageType type;

  /// SHA-256 hash of this message, encoded in base64.
  final String hash;

  /// Sender address. Empty for external inbound messages.
  final String source;

  /// Recipient address.
  final String destination;

  /// TON amount transferred with this message, in nanotons.
  final String value;

  /// Array of extra currencies (native blockchain-level tokens, distinct from Jettons) transferred in this message. Each entry contains a currency ID (integer) and amount (decimal string). Empty array if no extra currencies were transferred.
  final List<ExtraCurrencyBalance> extraCurrencies;

  /// Forwarding fee deducted from the message value, in nanotons.
  final String fwdFee;

  /// Instant Hypercube Routing (IHR) fee in nanotons.
  final String ihrFee;

  /// Logical time when this message was created.
  final String createdLt;

  /// Hash of the message body. Useful for verifying content without the full payload.
  final String bodyHash;

  /// Message body payload (raw, text comment, or encrypted).
  final MsgData msgData;

  /// Decoded UTF-8 text comment from the message body. Present only when the message body is a plain text comment (opcode `0x00000000`). Empty string otherwise.
  final String? message;

  /// Error description if the message body could not be decoded as a text comment.
  final String? messageDecodeError;

  const Message({
    required this.type,
    required this.hash,
    required this.source,
    required this.destination,
    required this.value,
    required this.extraCurrencies,
    required this.fwdFee,
    required this.ihrFee,
    required this.createdLt,
    required this.bodyHash,
    required this.msgData,
    this.message,
    this.messageDecodeError,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      type: json.valueTo<MessageType, Object>(
        key: '@type',
        parse: (e) => MessageType.fromJson(JsonParser.valueAs(e)),
      ),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String>('hash')),
      source:
          (json['source'] is num
              ? json['source'].toString()
              : json.valueAsString<String>('source')),
      destination:
          (json['destination'] is num
              ? json['destination'].toString()
              : json.valueAsString<String>('destination')),
      value:
          (json['value'] is num
              ? json['value'].toString()
              : json.valueAsString<String>('value')),
      extraCurrencies:
          json
              .valueEnsureAsList<Map<String, dynamic>>('extra_currencies')
              .map((e) => ExtraCurrencyBalance.fromJson(e))
              .toList(),
      fwdFee:
          (json['fwd_fee'] is num
              ? json['fwd_fee'].toString()
              : json.valueAsString<String>('fwd_fee')),
      ihrFee:
          (json['ihr_fee'] is num
              ? json['ihr_fee'].toString()
              : json.valueAsString<String>('ihr_fee')),
      createdLt:
          (json['created_lt'] is num
              ? json['created_lt'].toString()
              : json.valueAsString<String>('created_lt')),
      bodyHash:
          (json['body_hash'] is num
              ? json['body_hash'].toString()
              : json.valueAsString<String>('body_hash')),
      msgData: json.valueTo<MsgData, Object>(
        key: 'msg_data',
        parse: (e) => MsgData.fromJson(JsonParser.valueAs(e)),
      ),
      message:
          (json['message'] is num
              ? json['message'].toString()
              : json.valueAsString<String?>('message')),
      messageDecodeError:
          (json['message_decode_error'] is num
              ? json['message_decode_error'].toString()
              : json.valueAsString<String?>('message_decode_error')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'hash': hash,
    'source': source,
    'destination': destination,
    'value': value,
    'extra_currencies':
        extraCurrencies.map((e) => e.toJson(config: config)).toList(),
    'fwd_fee': fwdFee,
    'ihr_fee': ihrFee,
    'created_lt': createdLt,
    'body_hash': bodyHash,
    'msg_data': msgData.toJson(config: config),
    'message': message,
    'message_decode_error': messageDecodeError,
  });
}

class MessageStd {
  /// TonLib type identifier for raw message objects.
  final MessageStdType type;

  /// SHA-256 hash of this message, encoded in base64.
  final String hash;

  /// Sender account address. Empty for external inbound messages.
  final AccountAddress source;

  /// Recipient account address.
  final AccountAddress destination;

  /// TON amount transferred with this message, in nanotons.
  final String value;

  /// Array of extra currencies (native blockchain-level tokens, distinct from Jettons) transferred in this message. Each entry contains a currency ID (integer) and amount (decimal string). Empty array if no extra currencies were transferred.
  final List<ExtraCurrencyBalance> extraCurrencies;

  /// Forwarding fee deducted from the message value, in nanotons.
  final String fwdFee;

  /// Instant Hypercube Routing (IHR) fee in nanotons.
  final String ihrFee;

  /// Logical time when this message was created.
  final String createdLt;

  /// Hash of the message body.
  final String bodyHash;

  /// Message body payload (raw, text comment, or encrypted).
  final MsgData msgData;

  const MessageStd({
    required this.type,
    required this.hash,
    required this.source,
    required this.destination,
    required this.value,
    required this.extraCurrencies,
    required this.fwdFee,
    required this.ihrFee,
    required this.createdLt,
    required this.bodyHash,
    required this.msgData,
  });

  factory MessageStd.fromJson(Map<String, dynamic> json) {
    return MessageStd(
      type: json.valueTo<MessageStdType, Object>(
        key: '@type',
        parse: (e) => MessageStdType.fromJson(JsonParser.valueAs(e)),
      ),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String>('hash')),
      source: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'source',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      destination: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'destination',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      value:
          (json['value'] is num
              ? json['value'].toString()
              : json.valueAsString<String>('value')),
      extraCurrencies:
          json
              .valueEnsureAsList<Map<String, dynamic>>('extra_currencies')
              .map((e) => ExtraCurrencyBalance.fromJson(e))
              .toList(),
      fwdFee:
          (json['fwd_fee'] is num
              ? json['fwd_fee'].toString()
              : json.valueAsString<String>('fwd_fee')),
      ihrFee:
          (json['ihr_fee'] is num
              ? json['ihr_fee'].toString()
              : json.valueAsString<String>('ihr_fee')),
      createdLt:
          (json['created_lt'] is num
              ? json['created_lt'].toString()
              : json.valueAsString<String>('created_lt')),
      bodyHash:
          (json['body_hash'] is num
              ? json['body_hash'].toString()
              : json.valueAsString<String>('body_hash')),
      msgData: json.valueTo<MsgData, Object>(
        key: 'msg_data',
        parse: (e) => MsgData.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'hash': hash,
    'source': source.toJson(config: config),
    'destination': destination.toJson(config: config),
    'value': value,
    'extra_currencies':
        extraCurrencies.map((e) => e.toJson(config: config)).toList(),
    'fwd_fee': fwdFee,
    'ihr_fee': ihrFee,
    'created_lt': createdLt,
    'body_hash': bodyHash,
    'msg_data': msgData.toJson(config: config),
  });
}

class MsgDataDecryptedText {
  /// TonLib type identifier for decrypted text message bodies.
  final MsgDataDecryptedTextType? type;

  /// Decrypted UTF-8 text content, base64 encoded.
  final String? text;

  const MsgDataDecryptedText({this.type, this.text});

  factory MsgDataDecryptedText.fromJson(Map<String, dynamic> json) {
    return MsgDataDecryptedText(
      type: json.valueTo<MsgDataDecryptedTextType?, Object>(
        key: '@type',
        parse: (e) => MsgDataDecryptedTextType.fromJson(JsonParser.valueAs(e)),
      ),
      text:
          (json['text'] is num
              ? json['text'].toString()
              : json.valueAsString<String?>('text')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type?.toJson(config: config),
    'text': text,
  });
}

class MsgDataEncryptedText {
  /// TonLib type identifier for encrypted text message bodies.
  final MsgDataEncryptedTextType? type;

  /// Encrypted message payload, base64 encoded.
  final String? text;

  const MsgDataEncryptedText({this.type, this.text});

  factory MsgDataEncryptedText.fromJson(Map<String, dynamic> json) {
    return MsgDataEncryptedText(
      type: json.valueTo<MsgDataEncryptedTextType?, Object>(
        key: '@type',
        parse: (e) => MsgDataEncryptedTextType.fromJson(JsonParser.valueAs(e)),
      ),
      text:
          (json['text'] is num
              ? json['text'].toString()
              : json.valueAsString<String?>('text')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type?.toJson(config: config),
    'text': text,
  });
}

class MsgDataRaw {
  /// TonLib type identifier for raw (binary) message bodies.
  final MsgDataRawType? type;

  /// Raw message body in BoC format, base64 encoded.
  final String? body;
  final String? initState;

  const MsgDataRaw({this.type, this.body, this.initState});

  factory MsgDataRaw.fromJson(Map<String, dynamic> json) {
    return MsgDataRaw(
      type: json.valueTo<MsgDataRawType?, Object>(
        key: '@type',
        parse: (e) => MsgDataRawType.fromJson(JsonParser.valueAs(e)),
      ),
      body:
          (json['body'] is num
              ? json['body'].toString()
              : json.valueAsString<String?>('body')),
      initState:
          (json['init_state'] is num
              ? json['init_state'].toString()
              : json.valueAsString<String?>('init_state')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type?.toJson(config: config),
    'body': body,
    'init_state': initState,
  });
}

class MsgDataText {
  /// TonLib type identifier for plain text comment message bodies.
  final MsgDataTextType? type;

  /// UTF-8 text comment, base64 encoded.
  final String? text;

  const MsgDataText({this.type, this.text});

  factory MsgDataText.fromJson(Map<String, dynamic> json) {
    return MsgDataText(
      type: json.valueTo<MsgDataTextType?, Object>(
        key: '@type',
        parse: (e) => MsgDataTextType.fromJson(JsonParser.valueAs(e)),
      ),
      text:
          (json['text'] is num
              ? json['text'].toString()
              : json.valueAsString<String?>('text')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type?.toJson(config: config),
    'text': text,
  });
}

/// NFT collection contract data. Contains the number of items minted, collection owner, and collection metadata (name, description, image).
class NftCollectionData {
  /// TonLib type identifier for NFT collection contract data.
  final NftCollectionDataType type;

  /// Contract address of this NFT collection.
  final String address;

  /// Type of token contract: jetton_master, jetton_wallet, nft_collection, or nft_item.
  final NftCollectionDataContractType contractType;

  /// Index that will be assigned to the next minted NFT. Also indicates total items if minted sequentially.
  final String nextItemIndex;

  /// Collection owner's address. Controls minting and metadata updates.
  final String? ownerAddress;

  /// Collection metadata: name, description, and cover image.
  final TokenContent collectionContent;

  const NftCollectionData({
    required this.type,
    required this.address,
    required this.contractType,
    required this.nextItemIndex,
    this.ownerAddress,
    required this.collectionContent,
  });

  factory NftCollectionData.fromJson(Map<String, dynamic> json) {
    return NftCollectionData(
      type: json.valueTo<NftCollectionDataType, Object>(
        key: '@type',
        parse: (e) => NftCollectionDataType.fromJson(JsonParser.valueAs(e)),
      ),
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      contractType: json.valueTo<NftCollectionDataContractType, Object>(
        key: 'contract_type',
        parse:
            (e) =>
                NftCollectionDataContractType.fromJson(JsonParser.valueAs(e)),
      ),
      nextItemIndex:
          (json['next_item_index'] is num
              ? json['next_item_index'].toString()
              : json.valueAsString<String>('next_item_index')),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString<String?>('owner_address')),
      collectionContent: json.valueTo<TokenContent, Map<String, dynamic>>(
        key: 'collection_content',
        parse: (v) => TokenContent.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'address': address,
    'contract_type': contractType.toJson(config: config),
    'next_item_index': nextItemIndex,
    'owner_address': ownerAddress,
    'collection_content': collectionContent.toJson(config: config),
  });
}

/// Individual NFT data. Contains the item index, collection reference, current owner, and item-specific content/metadata.
class NftItemData {
  /// TonLib type identifier for NFT item contract data.
  final NftItemDataType type;

  /// Contract address of this NFT item.
  final String address;

  /// Type of token contract: jetton_master, jetton_wallet, nft_collection, or nft_item.
  final NftItemDataContractType contractType;

  /// Returns `true` if this NFT item has been initialized (deployed); otherwise `false`.
  final bool init;

  /// This item's sequential index within its collection.
  final String index;

  /// Address of the NFT collection this item belongs to. Empty if standalone NFT.
  final String? collectionAddress;

  /// Current owner's address. Changes on each transfer.
  final String? ownerAddress;

  /// NFT item metadata and content (name, description, image URL).
  final NftItemDataContent content;

  const NftItemData({
    required this.type,
    required this.address,
    required this.contractType,
    required this.init,
    required this.index,
    this.collectionAddress,
    this.ownerAddress,
    required this.content,
  });

  factory NftItemData.fromJson(Map<String, dynamic> json) {
    return NftItemData(
      type: json.valueTo<NftItemDataType, Object>(
        key: '@type',
        parse: (e) => NftItemDataType.fromJson(JsonParser.valueAs(e)),
      ),
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      contractType: json.valueTo<NftItemDataContractType, Object>(
        key: 'contract_type',
        parse: (e) => NftItemDataContractType.fromJson(JsonParser.valueAs(e)),
      ),
      init: json.valueAsBool<bool>('init'),
      index:
          (json['index'] is num
              ? json['index'].toString()
              : json.valueAsString<String>('index')),
      collectionAddress:
          (json['collection_address'] is num
              ? json['collection_address'].toString()
              : json.valueAsString<String?>('collection_address')),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString<String?>('owner_address')),
      content: json.valueTo<NftItemDataContent, Object>(
        key: 'content',
        parse: (e) => NftItemDataContent.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'address': address,
    'contract_type': contractType.toJson(config: config),
    'init': init,
    'index': index,
    'collection_address': collectionAddress,
    'owner_address': ownerAddress,
    'content': content.toJson(config: config),
  });
}

class OutMsgQueueSize {
  /// TonLib type identifier for per-shard queue size entries.
  final OutMsgQueueSizeType type;

  /// Full block identifier for the shard.
  final TonBlockIdExt id;

  /// Number of outgoing messages waiting in this shard's queue.
  final int size;

  const OutMsgQueueSize({
    required this.type,
    required this.id,
    required this.size,
  });

  factory OutMsgQueueSize.fromJson(Map<String, dynamic> json) {
    return OutMsgQueueSize(
      type: json.valueTo<OutMsgQueueSizeType, Object>(
        key: '@type',
        parse: (e) => OutMsgQueueSizeType.fromJson(JsonParser.valueAs(e)),
      ),
      id: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      size: json.valueAsInt<int>('size'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'id': id.toJson(config: config),
    'size': size,
  });
}

class OutMsgQueueSizes {
  /// TonLib type identifier for outgoing message queue size responses.
  final OutMsgQueueSizesType type;

  /// Array of per-shard queue sizes. Each entry contains the shard's block identifier and the number of outgoing messages waiting in its queue (integer).
  final List<OutMsgQueueSize> shards;

  /// Limit for the external message queue size.
  final int extMsgQueueSizeLimit;

  const OutMsgQueueSizes({
    required this.type,
    required this.shards,
    required this.extMsgQueueSizeLimit,
  });

  factory OutMsgQueueSizes.fromJson(Map<String, dynamic> json) {
    return OutMsgQueueSizes(
      type: json.valueTo<OutMsgQueueSizesType, Object>(
        key: '@type',
        parse: (e) => OutMsgQueueSizesType.fromJson(JsonParser.valueAs(e)),
      ),
      shards:
          json
              .valueEnsureAsList<Map<String, dynamic>>('shards')
              .map((e) => OutMsgQueueSize.fromJson(e))
              .toList(),
      extMsgQueueSizeLimit: json.valueAsInt<int>('ext_msg_queue_size_limit'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'shards': shards.map((e) => e.toJson(config: config)).toList(),
    'ext_msg_queue_size_limit': extMsgQueueSizeLimit,
  });
}

class PChanConfig {
  /// TonLib type identifier for payment channel configuration.
  final PChanConfigType type;

  /// Alice's Ed25519 public key for signing channel operations.
  final String alicePublicKey;

  /// Alice's on-chain wallet address.
  final AccountAddress aliceAddress;

  /// Bob's Ed25519 public key for signing channel operations.
  final String bobPublicKey;

  /// Bob's on-chain wallet address.
  final AccountAddress bobAddress;

  /// Maximum seconds allowed to complete channel initialization before it expires.
  final int initTimeout;

  /// Maximum seconds allowed to complete cooperative channel closure.
  final int closeTimeout;

  /// Unique numeric identifier for this payment channel.
  final BigInt channelId;

  const PChanConfig({
    required this.type,
    required this.alicePublicKey,
    required this.aliceAddress,
    required this.bobPublicKey,
    required this.bobAddress,
    required this.initTimeout,
    required this.closeTimeout,
    required this.channelId,
  });

  factory PChanConfig.fromJson(Map<String, dynamic> json) {
    return PChanConfig(
      type: json.valueTo<PChanConfigType, Object>(
        key: '@type',
        parse: (e) => PChanConfigType.fromJson(JsonParser.valueAs(e)),
      ),
      alicePublicKey:
          (json['alice_public_key'] is num
              ? json['alice_public_key'].toString()
              : json.valueAsString<String>('alice_public_key')),
      aliceAddress: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'alice_address',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      bobPublicKey:
          (json['bob_public_key'] is num
              ? json['bob_public_key'].toString()
              : json.valueAsString<String>('bob_public_key')),
      bobAddress: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'bob_address',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      initTimeout: json.valueAsInt<int>('init_timeout'),
      closeTimeout: json.valueAsInt<int>('close_timeout'),
      channelId: json.valueAsBigInt<BigInt>('channel_id'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'alice_public_key': alicePublicKey,
    'alice_address': aliceAddress.toJson(config: config),
    'bob_public_key': bobPublicKey,
    'bob_address': bobAddress.toJson(config: config),
    'init_timeout': initTimeout,
    'close_timeout': closeTimeout,
    'channel_id': config.encodeBigint(channelId),
  });
}

class PChanStateClose {
  /// TonLib type identifier for payment channels in the closing phase.
  final PChanStateCloseType type;

  /// Returns `true` if Alice has signed the close proposal; otherwise `false`.
  final bool signedA;

  /// Returns `true` if Bob has signed the close proposal; otherwise `false`.
  final bool signedB;

  /// Minimum guaranteed payout for Alice, in nanotons.
  final BigInt minA;

  /// Minimum guaranteed payout for Bob, in nanotons.
  final BigInt minB;

  /// Unix timestamp when the close proposal expires.
  final BigInt expireAt;

  /// Alice's final balance in nanotons.
  final BigInt a;

  /// Bob's final balance in nanotons.
  final BigInt b;

  const PChanStateClose({
    required this.type,
    required this.signedA,
    required this.signedB,
    required this.minA,
    required this.minB,
    required this.expireAt,
    required this.a,
    required this.b,
  });

  factory PChanStateClose.fromJson(Map<String, dynamic> json) {
    return PChanStateClose(
      type: json.valueTo<PChanStateCloseType, Object>(
        key: '@type',
        parse: (e) => PChanStateCloseType.fromJson(JsonParser.valueAs(e)),
      ),
      signedA: json.valueAsBool<bool>('signed_A'),
      signedB: json.valueAsBool<bool>('signed_B'),
      minA: json.valueAsBigInt<BigInt>('min_A'),
      minB: json.valueAsBigInt<BigInt>('min_B'),
      expireAt: json.valueAsBigInt<BigInt>('expire_at'),
      a: json.valueAsBigInt<BigInt>('A'),
      b: json.valueAsBigInt<BigInt>('B'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'signed_A': signedA,
    'signed_B': signedB,
    'min_A': config.encodeBigint(minA),
    'min_B': config.encodeBigint(minB),
    'expire_at': config.encodeBigint(expireAt),
    'A': config.encodeBigint(a),
    'B': config.encodeBigint(b),
  });
}

class PChanStateInit {
  /// TonLib type identifier for payment channels in the initialization phase.
  final PChanStateInitType type;

  /// Returns `true` if Alice has signed the initialization; otherwise `false`.
  final bool signedA;

  /// Returns `true` if Bob has signed the initialization; otherwise `false`.
  final bool signedB;

  /// Minimum deposit required from Alice, in nanotons.
  final BigInt minA;

  /// Minimum deposit required from Bob, in nanotons.
  final BigInt minB;

  /// Unix timestamp when the initialization offer expires.
  final BigInt expireAt;

  /// Alice's deposited amount in nanotons.
  final BigInt a;

  /// Bob's deposited amount in nanotons.
  final BigInt b;

  const PChanStateInit({
    required this.type,
    required this.signedA,
    required this.signedB,
    required this.minA,
    required this.minB,
    required this.expireAt,
    required this.a,
    required this.b,
  });

  factory PChanStateInit.fromJson(Map<String, dynamic> json) {
    return PChanStateInit(
      type: json.valueTo<PChanStateInitType, Object>(
        key: '@type',
        parse: (e) => PChanStateInitType.fromJson(JsonParser.valueAs(e)),
      ),
      signedA: json.valueAsBool<bool>('signed_A'),
      signedB: json.valueAsBool<bool>('signed_B'),
      minA: json.valueAsBigInt<BigInt>('min_A'),
      minB: json.valueAsBigInt<BigInt>('min_B'),
      expireAt: json.valueAsBigInt<BigInt>('expire_at'),
      a: json.valueAsBigInt<BigInt>('A'),
      b: json.valueAsBigInt<BigInt>('B'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'signed_A': signedA,
    'signed_B': signedB,
    'min_A': config.encodeBigint(minA),
    'min_B': config.encodeBigint(minB),
    'expire_at': config.encodeBigint(expireAt),
    'A': config.encodeBigint(a),
    'B': config.encodeBigint(b),
  });
}

class PChanStatePayout {
  /// TonLib type identifier for payment channels in the payout phase.
  final PChanStatePayoutType type;

  /// Alice's payout amount in nanotons.
  final BigInt a;

  /// Bob's payout amount in nanotons.
  final BigInt b;

  const PChanStatePayout({
    required this.type,
    required this.a,
    required this.b,
  });

  factory PChanStatePayout.fromJson(Map<String, dynamic> json) {
    return PChanStatePayout(
      type: json.valueTo<PChanStatePayoutType, Object>(
        key: '@type',
        parse: (e) => PChanStatePayoutType.fromJson(JsonParser.valueAs(e)),
      ),
      a: json.valueAsBigInt<BigInt>('A'),
      b: json.valueAsBigInt<BigInt>('B'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'A': config.encodeBigint(a),
    'B': config.encodeBigint(b),
  });
}

/// Estimated fees for a transaction. Shows the breakdown between storage fees (for contract state), gas fees (for computation), and forward fees (for message delivery).
class QueryFees {
  /// TonLib type identifier for fee estimation results.
  final QueryFeesType type;

  /// Fees charged on the sending account.
  final Fees sourceFees;
  final List<Fees> destinationFees;

  const QueryFees({
    required this.type,
    required this.sourceFees,
    required this.destinationFees,
  });

  factory QueryFees.fromJson(Map<String, dynamic> json) {
    return QueryFees(
      type: json.valueTo<QueryFeesType, Object>(
        key: '@type',
        parse: (e) => QueryFeesType.fromJson(JsonParser.valueAs(e)),
      ),
      sourceFees: json.valueTo<Fees, Map<String, dynamic>>(
        key: 'source_fees',
        parse: (v) => Fees.fromJson(v),
      ),
      destinationFees:
          json
              .valueEnsureAsList<Map<String, dynamic>>('destination_fees')
              .map((e) => Fees.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'source_fees': sourceFees.toJson(config: config),
    'destination_fees':
        destinationFees.map((e) => e.toJson(config: config)).toList(),
  });
}

class RWalletConfig {
  /// TonLib type identifier for restricted wallet configuration.
  final RWalletConfigType type;

  /// Unix timestamp when the spending limits become active.
  final BigInt startAt;

  /// Array of spending limit rules. Each entry defines a time window in seconds and the maximum spendable amount in nanotons within that window.
  final List<RWalletLimit> limits;

  const RWalletConfig({
    required this.type,
    required this.startAt,
    required this.limits,
  });

  factory RWalletConfig.fromJson(Map<String, dynamic> json) {
    return RWalletConfig(
      type: json.valueTo<RWalletConfigType, Object>(
        key: '@type',
        parse: (e) => RWalletConfigType.fromJson(JsonParser.valueAs(e)),
      ),
      startAt: json.valueAsBigInt<BigInt>('start_at'),
      limits:
          json
              .valueEnsureAsList<Map<String, dynamic>>('limits')
              .map((e) => RWalletLimit.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'start_at': config.encodeBigint(startAt),
    'limits': limits.map((e) => e.toJson(config: config)).toList(),
  });
}

class RWalletLimit {
  /// TonLib type identifier for restricted wallet spending limit rules.
  final RWalletLimitType type;

  /// Duration of this spending limit window in seconds.
  final int seconds;

  /// Maximum spendable amount within this time period, in nanotons.
  final BigInt value;

  const RWalletLimit({
    required this.type,
    required this.seconds,
    required this.value,
  });

  factory RWalletLimit.fromJson(Map<String, dynamic> json) {
    return RWalletLimit(
      type: json.valueTo<RWalletLimitType, Object>(
        key: '@type',
        parse: (e) => RWalletLimitType.fromJson(JsonParser.valueAs(e)),
      ),
      seconds: json.valueAsInt<int>('seconds'),
      value: json.valueAsBigInt<BigInt>('value'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'seconds': seconds,
    'value': config.encodeBigint(value),
  });
}

/// Simple success response with no additional data.
class ResultOk {
  /// TonLib type identifier for successful operations with no return data.
  final ResultOkType type;

  const ResultOk({required this.type});

  factory ResultOk.fromJson(Map<String, dynamic> json) {
    return ResultOk(
      type: json.valueTo<ResultOkType, Object>(
        key: '@type',
        parse: (e) => ResultOkType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) =>
      config.encodeMap(<String, dynamic>{'@type': type.toJson(config: config)});
}

/// Request to execute a smart contract get method. Specify address, method name/ID, and input stack.
///
/// POST /api/v2/runGetMethod (request)
class RunGetMethodRequest {
  final String address;

  /// The get method name (e.g., `seqno`, `get_wallet_data`) or its numeric ID.
  final RunGetMethodRequestMethod method;

  /// Input arguments as a TVM stack. Each entry is a two-element array: `[type, value]` where type is `"num"` (decimal string), `"cell"` (base64 BoC), or `"slice"` (base64 BoC).
  final List<LegacyStackEntry> stack;

  /// Masterchain block sequence number. Run the get method against the contract state at this specific block height. If omitted, uses the current state.
  final int? seqno;

  const RunGetMethodRequest({
    required this.address,
    required this.method,
    required this.stack,
    this.seqno,
  });

  factory RunGetMethodRequest.fromJson(Map<String, dynamic> json) {
    return RunGetMethodRequest(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      method: json.valueTo<RunGetMethodRequestMethod, Object>(
        key: 'method',
        parse: (e) => RunGetMethodRequestMethod.fromJson(JsonParser.valueAs(e)),
      ),
      stack:
          json
              .valueEnsureAsList<dynamic>('stack')
              .map(
                (e) =>
                    (e as List)
                        .map((e) => LegacyStackEntryItem.fromJson(e))
                        .toList(),
              )
              .toList(),
      seqno: json.valueAsInt<int?>('seqno'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'method': method.toJson(config: config),
    'stack':
        stack
            .map((e) => e.map((x) => x.toJson(config: config)).toList())
            .toList(),
    'seqno': seqno,
  });
}

/// Result of executing a smart contract get method. Contains the TVM exit code (0 or 1 means success), gas used, and the output stack with return values.
class RunGetMethodResult {
  /// TonLib type identifier for get method execution results.
  final RunGetMethodStdResultType type;

  /// Gas consumed during execution. Useful for cost estimation.
  final BigInt gasUsed;
  final List<LegacyStackEntry> stack;

  /// TVM exit code. `0` or `1` means success; other values indicate errors. Refer to the TVM exit code reference for all values.
  final int exitCode;

  /// Block at which the get method was executed.
  final TonBlockIdExt blockId;

  /// Most recent transaction at the time of execution.
  final InternalTransactionId lastTransactionId;

  const RunGetMethodResult({
    required this.type,
    required this.gasUsed,
    required this.stack,
    required this.exitCode,
    required this.blockId,
    required this.lastTransactionId,
  });

  factory RunGetMethodResult.fromJson(Map<String, dynamic> json) {
    return RunGetMethodResult(
      type: json.valueTo<RunGetMethodStdResultType, Object>(
        key: '@type',
        parse: (e) => RunGetMethodStdResultType.fromJson(JsonParser.valueAs(e)),
      ),
      gasUsed: json.valueAsBigInt<BigInt>('gas_used'),
      stack:
          json
              .valueEnsureAsList<dynamic>('stack')
              .map(
                (e) =>
                    (e as List)
                        .map((e) => LegacyStackEntryItem.fromJson(e))
                        .toList(),
              )
              .toList(),
      exitCode: json.valueAsInt<int>('exit_code'),
      blockId: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'block_id',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      lastTransactionId: json
          .valueTo<InternalTransactionId, Map<String, dynamic>>(
            key: 'last_transaction_id',
            parse: (v) => InternalTransactionId.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'gas_used': config.encodeBigint(gasUsed),
    'stack':
        stack
            .map((e) => e.map((x) => x.toJson(config: config)).toList())
            .toList(),
    'exit_code': exitCode,
    'block_id': blockId.toJson(config: config),
    'last_transaction_id': lastTransactionId.toJson(config: config),
  });
}

/// POST /api/v2/runGetMethodStd (request)
class RunGetMethodStdRequest {
  final String address;

  /// The get method name (e.g., `seqno`, `get_wallet_data`) or its numeric ID.
  final RunGetMethodRequestMethod method;

  /// Input arguments as a TVM stack. Each entry is a typed object with `@type` discriminator: `tvm.stackEntryNumber` (decimal string), `tvm.stackEntryCell` (base64 BoC), `tvm.stackEntrySlice` (base64 BoC), `tvm.stackEntryTuple`, or `tvm.stackEntryList`.
  final List<RunGetMethodStdResultStackItem> stack;

  /// Masterchain block sequence number. Run the get method against the contract state at this specific block height. If omitted, uses the current state.
  final int? seqno;

  const RunGetMethodStdRequest({
    required this.address,
    required this.method,
    required this.stack,
    this.seqno,
  });

  factory RunGetMethodStdRequest.fromJson(Map<String, dynamic> json) {
    return RunGetMethodStdRequest(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      method: json.valueTo<RunGetMethodRequestMethod, Object>(
        key: 'method',
        parse: (e) => RunGetMethodRequestMethod.fromJson(JsonParser.valueAs(e)),
      ),
      stack:
          json
              .valueEnsureAsList<dynamic>('stack')
              .map((e) => RunGetMethodStdResultStackItem.fromJson(e))
              .toList(),
      seqno: json.valueAsInt<int?>('seqno'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'method': method.toJson(config: config),
    'stack': stack.map((e) => e.toJson(config: config)).toList(),
    'seqno': seqno,
  });
}

/// Result of executing a smart contract get method. Contains the TVM exit code (0 or 1 means success), gas consumed, and the output stack with typed return values.
class RunGetMethodStdResult {
  /// TonLib type identifier for standardized get method execution results.
  final RunGetMethodStdResultType type;

  /// Gas consumed during execution. Useful for cost estimation.
  final BigInt gasUsed;

  /// Output values as a TVM stack. Each entry is a typed object with `@type` discriminator: `tvm.stackEntryNumber` (decimal string), `tvm.stackEntryCell` (base64 BoC), `tvm.stackEntrySlice` (base64 BoC), `tvm.stackEntryTuple`, or `tvm.stackEntryList`.
  final List<RunGetMethodStdResultStackItem> stack;

  /// TVM exit code. `0` or `1` means success; other values indicate errors. Refer to the TVM exit code reference for all values.
  final int exitCode;

  const RunGetMethodStdResult({
    required this.type,
    required this.gasUsed,
    required this.stack,
    required this.exitCode,
  });

  factory RunGetMethodStdResult.fromJson(Map<String, dynamic> json) {
    return RunGetMethodStdResult(
      type: json.valueTo<RunGetMethodStdResultType, Object>(
        key: '@type',
        parse: (e) => RunGetMethodStdResultType.fromJson(JsonParser.valueAs(e)),
      ),
      gasUsed: json.valueAsBigInt<BigInt>('gas_used'),
      stack:
          json
              .valueEnsureAsList<dynamic>('stack')
              .map((e) => RunGetMethodStdResultStackItem.fromJson(e))
              .toList(),
      exitCode: json.valueAsInt<int>('exit_code'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'gas_used': config.encodeBigint(gasUsed),
    'stack': stack.map((e) => e.toJson(config: config)).toList(),
    'exit_code': exitCode,
  });
}

/// Request to broadcast a signed message. The boc field contains the base64-encoded external message.
///
/// POST /api/v2/sendBoc (request)
/// POST /api/v2/sendBocReturnHash (request)
class SendBocRequest {
  /// Serialized external message in BoC format, base64 encoded.
  final String boc;

  const SendBocRequest({required this.boc});

  factory SendBocRequest.fromJson(Map<String, dynamic> json) {
    return SendBocRequest(
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

class SeqnoRequest {
  final AddressWithSeqnoRequestSeqno seqno;

  const SeqnoRequest({required this.seqno});

  factory SeqnoRequest.fromJson(Map<String, dynamic> json) {
    return SeqnoRequest(
      seqno: json.valueTo<AddressWithSeqnoRequestSeqno, Object>(
        key: 'seqno',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'seqno': seqno.toJson(config: config),
  });
}

class ShardBlockLink {
  /// TonLib type identifier for shard-to-masterchain proof links.
  final ShardBlockLinkType type;

  /// Block identifier for this link in the proof chain.
  final TonBlockIdExt id;

  /// Merkle proof data for this shard block link.
  final String proof;

  const ShardBlockLink({
    required this.type,
    required this.id,
    required this.proof,
  });

  factory ShardBlockLink.fromJson(Map<String, dynamic> json) {
    return ShardBlockLink(
      type: json.valueTo<ShardBlockLinkType, Object>(
        key: '@type',
        parse: (e) => ShardBlockLinkType.fromJson(JsonParser.valueAs(e)),
      ),
      id: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'id',
        parse: (v) => TonBlockIdExt.fromJson(v),
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
    '@type': type.toJson(config: config),
    'id': id.toJson(config: config),
    'proof': proof,
  });
}

class ShardBlockProof {
  /// TonLib type identifier for shard block proof chains.
  final ShardBlockProofType type;

  /// The shard block being proven.
  final TonBlockIdExt from;

  /// Masterchain block used as trust anchor for the proof.
  final TonBlockIdExt mcId;

  /// Array of cryptographic links forming a proof chain from the shard block to the masterchain. Each link contains a block identifier and a Merkle proof (base64).
  final List<ShardBlockLink> links;

  /// Array of masterchain block link proofs. Each entry contains source and destination block identifiers with corresponding Merkle proofs (base64) and state proofs (base64).
  final List<BlockLinkBack> mcProof;

  const ShardBlockProof({
    required this.type,
    required this.from,
    required this.mcId,
    required this.links,
    required this.mcProof,
  });

  factory ShardBlockProof.fromJson(Map<String, dynamic> json) {
    return ShardBlockProof(
      type: json.valueTo<ShardBlockProofType, Object>(
        key: '@type',
        parse: (e) => ShardBlockProofType.fromJson(JsonParser.valueAs(e)),
      ),
      from: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'from',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      mcId: json.valueTo<TonBlockIdExt, Map<String, dynamic>>(
        key: 'mc_id',
        parse: (v) => TonBlockIdExt.fromJson(v),
      ),
      links:
          json
              .valueEnsureAsList<Map<String, dynamic>>('links')
              .map((e) => ShardBlockLink.fromJson(e))
              .toList(),
      mcProof:
          json
              .valueEnsureAsList<Map<String, dynamic>>('mc_proof')
              .map((e) => BlockLinkBack.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'from': from.toJson(config: config),
    'mc_id': mcId.toJson(config: config),
    'links': links.map((e) => e.toJson(config: config)).toList(),
    'mc_proof': mcProof.map((e) => e.toJson(config: config)).toList(),
  });
}

/// POST /api/v2/getShardBlockProof (request)
class ShardBlockProofRequest {
  /// Workchain ID: `-1` for masterchain, `0` for basechain. Most user transactions are on workchain `0`.
  final AddressWithSeqnoRequestSeqno workchain;

  /// Shard identifier. A signed 64-bit integer. Masterchain uses -9223372036854775808.
  final BigInt shard;

  /// Shardchain block sequence number. Identifies a specific block within the given workchain and shard. Use together with `workchain` and `shard` to uniquely identify a block.
  final AddressWithSeqnoRequestSeqno seqno;

  /// Starting masterchain block for proof generation.
  final AddressWithSeqnoRequestSeqno? fromSeqno;

  const ShardBlockProofRequest({
    required this.workchain,
    required this.shard,
    required this.seqno,
    this.fromSeqno,
  });

  factory ShardBlockProofRequest.fromJson(Map<String, dynamic> json) {
    return ShardBlockProofRequest(
      workchain: json.valueTo<AddressWithSeqnoRequestSeqno, Object>(
        key: 'workchain',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
      shard: json.valueAsBigInt<BigInt>('shard'),
      seqno: json.valueTo<AddressWithSeqnoRequestSeqno, Object>(
        key: 'seqno',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
      fromSeqno: json.valueTo<AddressWithSeqnoRequestSeqno?, Object>(
        key: 'from_seqno',
        parse:
            (e) => AddressWithSeqnoRequestSeqno.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'workchain': workchain.toJson(config: config),
    'shard': config.encodeBigint(shard),
    'seqno': seqno.toJson(config: config),
    'from_seqno': fromSeqno?.toJson(config: config),
  });
}

/// List of shardchain blocks at a specific masterchain height. Shows how the basechain is currently partitioned.
class Shards {
  /// TonLib type identifier for shard listing responses.
  final ShardsType type;

  /// Array of active shard block identifiers. Each entry contains `workchain` (integer), `shard` ID (string), `seqno` (integer), `root_hash` (base64/hex), and `file_hash` (base64/hex).
  final List<TonBlockIdExt> shards;

  const Shards({required this.type, required this.shards});

  factory Shards.fromJson(Map<String, dynamic> json) {
    return Shards(
      type: json.valueTo<ShardsType, Object>(
        key: '@type',
        parse: (e) => ShardsType.fromJson(JsonParser.valueAs(e)),
      ),
      shards:
          json
              .valueEnsureAsList<Map<String, dynamic>>('shards')
              .map((e) => TonBlockIdExt.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'shards': shards.map((e) => e.toJson(config: config)).toList(),
  });
}

/// Compact transaction reference containing the account address, logical time, and hash. Used in block transaction listings for efficient enumeration.
class ShortTxId {
  /// TonLib type identifier for compact transaction references.
  final ShortTxIdType type;

  /// Bitmask indicating which optional fields are present.
  final int mode;

  /// Account address that executed this transaction.
  final String account;

  /// Logical time of the transaction. Use together with its hash for pagination and lookups.
  final String lt;

  /// SHA-256 hash of this transaction, encoded in base64.
  final String hash;

  const ShortTxId({
    required this.type,
    required this.mode,
    required this.account,
    required this.lt,
    required this.hash,
  });

  factory ShortTxId.fromJson(Map<String, dynamic> json) {
    return ShortTxId(
      type: json.valueTo<ShortTxIdType, Object>(
        key: '@type',
        parse: (e) => ShortTxIdType.fromJson(JsonParser.valueAs(e)),
      ),
      mode: json.valueAsInt<int>('mode'),
      account:
          (json['account'] is num
              ? json['account'].toString()
              : json.valueAsString<String>('account')),
      lt:
          (json['lt'] is num
              ? json['lt'].toString()
              : json.valueAsString<String>('lt')),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String>('hash')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'mode': mode,
    'account': account,
    'lt': lt,
    'hash': hash,
  });
}

class SmcAddr {
  /// TonLib type identifier for standard smart contract addresses.
  final SmcAddrType type;

  /// Workchain ID (`0` for basechain, `-1` for masterchain).
  final int workchainId;

  /// Account identifier as a 64-character hex string.
  final String address;

  const SmcAddr({
    required this.type,
    required this.workchainId,
    required this.address,
  });

  factory SmcAddr.fromJson(Map<String, dynamic> json) {
    return SmcAddr(
      type: json.valueTo<SmcAddrType, Object>(
        key: '@type',
        parse: (e) => SmcAddrType.fromJson(JsonParser.valueAs(e)),
      ),
      workchainId: json.valueAsInt<int>('workchain_id'),
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'workchain_id': workchainId,
    'address': address,
  });
}

class TokenContent {
  /// Storage method for token (jetton) metadata content: `onchain` (stored in contract data) or `offchain` (external URI).
  final TokenContentType type;

  /// Token metadata key-value pairs (name, symbol, decimals, image, description).
  final TokenContentData data;

  const TokenContent({required this.type, required this.data});

  factory TokenContent.fromJson(Map<String, dynamic> json) {
    return TokenContent(
      type: json.valueTo<TokenContentType, Object>(
        key: 'type',
        parse: (e) => TokenContentType.fromJson(JsonParser.valueAs(e)),
      ),
      data: json.valueTo<TokenContentData, Object>(
        key: 'data',
        parse: (e) => TokenContentData.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'type': type.toJson(config: config),
    'data': data.toJson(config: config),
  });
}

class TokenContentDict {
  final Map<String, dynamic> values;
  const TokenContentDict(this.values);

  factory TokenContentDict.fromJson(Map<String, dynamic> json) =>
      TokenContentDict(json.map((k, v) => MapEntry(k, v)));

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(values.map((k, v) => MapEntry(k, v)));
}

/// A complete block identifier with cryptographic hashes. Contains `workchain`, `shard`, `seqno` (position) plus `root_hash` and `file_hash` (verification).
class TonBlockIdExt {
  /// TonLib type identifier for full block identifiers.
  final TonBlockIdExtType type;

  /// Workchain ID: `-1` for masterchain, `0` for basechain.
  final int workchain;

  /// Shard identifier as a signed 64-bit integer string. Masterchain uses `-9223372036854775808`.
  final String shard;

  /// Block sequence number within its workchain and shard. For the masterchain (workchain `-1`), this equals the global block height. For basechain shards (workchain `0`), this is the sequence number local to that specific shard, not a global height.
  final int seqno;

  /// Root hash of the block. Together with `file_hash`, uniquely identifies a block.
  final String rootHash;

  /// Hash of the serialized block file. Together with `root_hash`, uniquely identifies a block.
  final String fileHash;

  const TonBlockIdExt({
    required this.type,
    required this.workchain,
    required this.shard,
    required this.seqno,
    required this.rootHash,
    required this.fileHash,
  });

  factory TonBlockIdExt.fromJson(Map<String, dynamic> json) {
    return TonBlockIdExt(
      type: json.valueTo<TonBlockIdExtType, Object>(
        key: '@type',
        parse: (e) => TonBlockIdExtType.fromJson(JsonParser.valueAs(e)),
      ),
      workchain: json.valueAsInt<int>('workchain'),
      shard:
          (json['shard'] is num
              ? json['shard'].toString()
              : json.valueAsString<String>('shard')),
      seqno: json.valueAsInt<int>('seqno'),
      rootHash:
          (json['root_hash'] is num
              ? json['root_hash'].toString()
              : json.valueAsString<String>('root_hash')),
      fileHash:
          (json['file_hash'] is num
              ? json['file_hash'].toString()
              : json.valueAsString<String>('file_hash')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'workchain': workchain,
    'shard': shard,
    'seqno': seqno,
    'root_hash': rootHash,
    'file_hash': fileHash,
  });
}

/// The `ok` field is always false, `code` contains the HTTP status, and `error` describes what went wrong.
class TonlibErrorResponse {
  /// Always `false` for error responses.
  final bool ok;

  /// Error message explaining what went wrong.
  final String error;

  /// HTTP status code. Common values: 404 (not found), 409 (conflict), 422 (validation error), 429 (rate limit), 500 (server error), 504 (timeout), 542 (liteserver error).
  final int code;
  final String? extra;
  final String? jsonrpc;
  final String? id;

  const TonlibErrorResponse({
    required this.ok,
    required this.error,
    required this.code,
    this.extra,
    this.jsonrpc,
    this.id,
  });

  factory TonlibErrorResponse.fromJson(Map<String, dynamic> json) {
    return TonlibErrorResponse(
      ok: json.valueAsBool<bool>('ok'),
      error:
          (json['error'] is num
              ? json['error'].toString()
              : json.valueAsString<String>('error')),
      code: json.valueAsInt<int>('code'),
      extra:
          (json['@extra'] is num
              ? json['@extra'].toString()
              : json.valueAsString<String?>('@extra')),
      jsonrpc:
          (json['jsonrpc'] is num
              ? json['jsonrpc'].toString()
              : json.valueAsString<String?>('jsonrpc')),
      id:
          (json['id'] is num
              ? json['id'].toString()
              : json.valueAsString<String?>('id')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'ok': ok,
    'error': error,
    'code': code,
    '@extra': extra,
    'jsonrpc': jsonrpc,
    'id': id,
  });
}

/// POST /api/v2/jsonRPC (response)
/// GET /api/v2/detectAddress (response)
/// POST /api/v2/detectAddress (response)
/// GET /api/v2/detectHash (response)
/// POST /api/v2/detectHash (response)
/// GET /api/v2/packAddress (response)
/// POST /api/v2/packAddress (response)
/// GET /api/v2/unpackAddress (response)
/// POST /api/v2/unpackAddress (response)
/// GET /api/v2/getAddressInformation (response)
/// POST /api/v2/getAddressInformation (response)
/// GET /api/v2/getExtendedAddressInformation (response)
/// POST /api/v2/getExtendedAddressInformation (response)
/// GET /api/v2/getShardAccountCell (response)
/// POST /api/v2/getShardAccountCell (response)
/// GET /api/v2/getWalletInformation (response)
/// POST /api/v2/getWalletInformation (response)
/// GET /api/v2/getAddressBalance (response)
/// POST /api/v2/getAddressBalance (response)
/// GET /api/v2/getAddressState (response)
/// POST /api/v2/getAddressState (response)
/// GET /api/v2/getTokenData (response)
/// POST /api/v2/getTokenData (response)
/// GET /api/v2/dnsResolve (response)
/// POST /api/v2/dnsResolve (response)
/// GET /api/v2/getMasterchainInfo (response)
/// POST /api/v2/getMasterchainInfo (response)
/// GET /api/v2/getMasterchainBlockSignatures (response)
/// POST /api/v2/getMasterchainBlockSignatures (response)
/// GET /api/v2/getShardBlockProof (response)
/// POST /api/v2/getShardBlockProof (response)
/// GET /api/v2/getConsensusBlock (response)
/// POST /api/v2/getConsensusBlock (response)
/// GET /api/v2/lookupBlock (response)
/// POST /api/v2/lookupBlock (response)
/// GET /api/v2/getShards (response)
/// POST /api/v2/getShards (response)
/// GET /api/v2/getBlock (response)
/// POST /api/v2/getBlock (response)
/// GET /api/v2/getBlockHeader (response)
/// POST /api/v2/getBlockHeader (response)
/// GET /api/v2/getOutMsgQueueSize (response)
/// POST /api/v2/getOutMsgQueueSize (response)
/// GET /api/v2/getBlockTransactions (response)
/// POST /api/v2/getBlockTransactions (response)
/// GET /api/v2/getBlockTransactionsExt (response)
/// POST /api/v2/getBlockTransactionsExt (response)
/// GET /api/v2/getTransactions (response)
/// POST /api/v2/getTransactions (response)
/// GET /api/v2/getTransactionsStd (response)
/// POST /api/v2/getTransactionsStd (response)
/// GET /api/v2/tryLocateTx (response)
/// POST /api/v2/tryLocateTx (response)
/// GET /api/v2/tryLocateResultTx (response)
/// POST /api/v2/tryLocateResultTx (response)
/// GET /api/v2/tryLocateSourceTx (response)
/// POST /api/v2/tryLocateSourceTx (response)
/// GET /api/v2/getConfigParam (response)
/// POST /api/v2/getConfigParam (response)
/// GET /api/v2/getConfigAll (response)
/// POST /api/v2/getConfigAll (response)
/// GET /api/v2/getLibraries (response)
/// POST /api/v2/getLibraries (response)
/// POST /api/v2/runGetMethod (response)
/// POST /api/v2/runGetMethodStd (response)
/// POST /api/v2/sendBoc (response)
/// POST /api/v2/sendBocReturnHash (response)
/// POST /api/v2/estimateFee (response)
class TonlibResponse {
  /// Returns `true` if the request succeeded; otherwise `false`. See the `error` field for details.
  final bool ok;

  /// The method return value. The structure depends on the method called; see individual method documentation for response schemas. Only present when `ok` is `true`.
  final JsonRpcResponseResult result;
  final String extra;

  /// JSON-RPC protocol version identifier.
  final String? jsonrpc;
  final String? id;

  const TonlibResponse({
    required this.ok,
    required this.result,
    required this.extra,
    this.jsonrpc,
    this.id,
  });

  factory TonlibResponse.fromJson(Map<String, dynamic> json) {
    return TonlibResponse(
      ok: json.valueAsBool<bool>('ok'),
      result: json.valueTo<JsonRpcResponseResult, Object>(
        key: 'result',
        parse: (e) => JsonRpcResponseResult.fromJson(JsonParser.valueAs(e)),
      ),
      extra:
          (json['@extra'] is num
              ? json['@extra'].toString()
              : json.valueAsString<String>('@extra')),
      jsonrpc:
          (json['jsonrpc'] is num
              ? json['jsonrpc'].toString()
              : json.valueAsString<String?>('jsonrpc')),
      id:
          (json['id'] is num
              ? json['id'].toString()
              : json.valueAsString<String?>('id')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'ok': ok,
    'result': result.toJson(config: config),
    '@extra': extra,
    'jsonrpc': jsonrpc,
    'id': id,
  });
}

class Transaction {
  /// TonLib type identifier for extended transaction objects with decoded messages.
  final TransactionType type;

  /// Account address object for this transaction.
  final AccountAddress address;

  /// Account address in raw format.
  final String account;

  /// Unix timestamp when this transaction was executed.
  final int utime;

  /// Full transaction data serialized as BoC, base64 encoded.
  final String data;

  /// The transaction identifier, represented by logical time and transaction hash.
  final InternalTransactionId transactionId;

  /// Total fees paid for this transaction, in nanotons.
  final String fee;

  /// Storage fees in nanotons deducted from the account balance during the storage phase of this transaction. Covers the cost of storing the contract state on-chain since the last transaction.
  final String storageFee;

  /// Fees in nanotons deducted from the account balance during the computation and action phases of this transaction. Covers the cost of TVM execution and processing outgoing messages.
  final String otherFee;

  /// The inbound message that triggered this transaction.
  final Message? inMsg;

  /// Array of outbound messages produced by this transaction. Each message contains sender, recipient, TON amount (nanotons as string), forwarding fee, message body, and optional decoded text comment.
  final List<Message> outMsgs;

  const Transaction({
    required this.type,
    required this.address,
    required this.account,
    required this.utime,
    required this.data,
    required this.transactionId,
    required this.fee,
    required this.storageFee,
    required this.otherFee,
    this.inMsg,
    required this.outMsgs,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      type: json.valueTo<TransactionType, Object>(
        key: '@type',
        parse: (e) => TransactionType.fromJson(JsonParser.valueAs(e)),
      ),
      address: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'address',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      account:
          (json['account'] is num
              ? json['account'].toString()
              : json.valueAsString<String>('account')),
      utime: json.valueAsInt<int>('utime'),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString<String>('data')),
      transactionId: json.valueTo<InternalTransactionId, Map<String, dynamic>>(
        key: 'transaction_id',
        parse: (v) => InternalTransactionId.fromJson(v),
      ),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString<String>('fee')),
      storageFee:
          (json['storage_fee'] is num
              ? json['storage_fee'].toString()
              : json.valueAsString<String>('storage_fee')),
      otherFee:
          (json['other_fee'] is num
              ? json['other_fee'].toString()
              : json.valueAsString<String>('other_fee')),
      inMsg: json.valueTo<Message?, Map<String, dynamic>>(
        key: 'in_msg',
        parse: (v) => Message.fromJson(v),
      ),
      outMsgs:
          json
              .valueEnsureAsList<Map<String, dynamic>>('out_msgs')
              .map((e) => Message.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'address': address.toJson(config: config),
    'account': account,
    'utime': utime,
    'data': data,
    'transaction_id': transactionId.toJson(config: config),
    'fee': fee,
    'storage_fee': storageFee,
    'other_fee': otherFee,
    'in_msg': inMsg?.toJson(config: config),
    'out_msgs': outMsgs.map((e) => e.toJson(config: config)).toList(),
  });
}

class TransactionExt {
  /// Object type identifier.
  final TransactionExtType type;

  /// Account address object for this transaction.
  final AccountAddress address;

  /// Unix timestamp when this transaction was executed.
  final int utime;

  /// Full transaction data serialized as BoC, base64 encoded.
  final String data;

  /// The transaction identifier, represented by logical time and transaction hash.
  final InternalTransactionId transactionId;

  /// Total fees paid for this transaction, in nanotons.
  final String fee;

  /// Storage fees in nanotons deducted from the account balance during the storage phase of this transaction. Covers the cost of storing the contract state on-chain since the last transaction.
  final String storageFee;

  /// Fees in nanotons deducted from the account balance during the computation and action phases of this transaction. Covers the cost of TVM execution and processing outgoing messages.
  final String otherFee;

  /// The inbound message that triggered this transaction.
  final MessageStd? inMsg;

  /// Array of outbound messages produced by this transaction. Each message contains sender and recipient address objects, TON amount (nanotons as string), forwarding fee, and raw message body.
  final List<MessageStd> outMsgs;

  /// The account address that this transaction belongs to.
  final String? account;

  const TransactionExt({
    required this.type,
    required this.address,
    required this.utime,
    required this.data,
    required this.transactionId,
    required this.fee,
    required this.storageFee,
    required this.otherFee,
    this.inMsg,
    required this.outMsgs,
    this.account,
  });

  factory TransactionExt.fromJson(Map<String, dynamic> json) {
    return TransactionExt(
      type: json.valueTo<TransactionExtType, Object>(
        key: '@type',
        parse: (e) => TransactionExtType.fromJson(JsonParser.valueAs(e)),
      ),
      address: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'address',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      utime: json.valueAsInt<int>('utime'),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString<String>('data')),
      transactionId: json.valueTo<InternalTransactionId, Map<String, dynamic>>(
        key: 'transaction_id',
        parse: (v) => InternalTransactionId.fromJson(v),
      ),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString<String>('fee')),
      storageFee:
          (json['storage_fee'] is num
              ? json['storage_fee'].toString()
              : json.valueAsString<String>('storage_fee')),
      otherFee:
          (json['other_fee'] is num
              ? json['other_fee'].toString()
              : json.valueAsString<String>('other_fee')),
      inMsg: json.valueTo<MessageStd?, Map<String, dynamic>>(
        key: 'in_msg',
        parse: (v) => MessageStd.fromJson(v),
      ),
      outMsgs:
          json
              .valueEnsureAsList<Map<String, dynamic>>('out_msgs')
              .map((e) => MessageStd.fromJson(e))
              .toList(),
      account:
          (json['account'] is num
              ? json['account'].toString()
              : json.valueAsString<String?>('account')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'address': address.toJson(config: config),
    'utime': utime,
    'data': data,
    'transaction_id': transactionId.toJson(config: config),
    'fee': fee,
    'storage_fee': storageFee,
    'other_fee': otherFee,
    'in_msg': inMsg?.toJson(config: config),
    'out_msgs': outMsgs.map((e) => e.toJson(config: config)).toList(),
    'account': account,
  });
}

class TransactionStd {
  /// TonLib type identifier for raw transaction objects.
  final TransactionStdType type;

  /// Account address object for this transaction.
  final AccountAddress address;

  /// Unix timestamp when this transaction was executed.
  final int utime;

  /// Full transaction data serialized as BoC, base64 encoded.
  final String data;

  /// The transaction identifier, represented by logical time and transaction hash.
  final InternalTransactionId transactionId;

  /// Total fees paid for this transaction, in nanotons.
  final String fee;

  /// Storage fees in nanotons deducted from the account balance during the storage phase of this transaction. Covers the cost of storing the contract state on-chain since the last transaction.
  final String storageFee;

  /// Fees in nanotons deducted from the account balance during the computation and action phases of this transaction. Covers the cost of TVM execution and processing outgoing messages.
  final String otherFee;

  /// The inbound message that triggered this transaction.
  final MessageStd? inMsg;

  /// Array of outbound messages produced by this transaction. Each message contains sender and recipient address objects, TON amount (nanotons as string), forwarding fee, and raw message body.
  final List<MessageStd> outMsgs;

  const TransactionStd({
    required this.type,
    required this.address,
    required this.utime,
    required this.data,
    required this.transactionId,
    required this.fee,
    required this.storageFee,
    required this.otherFee,
    this.inMsg,
    required this.outMsgs,
  });

  factory TransactionStd.fromJson(Map<String, dynamic> json) {
    return TransactionStd(
      type: json.valueTo<TransactionStdType, Object>(
        key: '@type',
        parse: (e) => TransactionStdType.fromJson(JsonParser.valueAs(e)),
      ),
      address: json.valueTo<AccountAddress, Map<String, dynamic>>(
        key: 'address',
        parse: (v) => AccountAddress.fromJson(v),
      ),
      utime: json.valueAsInt<int>('utime'),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString<String>('data')),
      transactionId: json.valueTo<InternalTransactionId, Map<String, dynamic>>(
        key: 'transaction_id',
        parse: (v) => InternalTransactionId.fromJson(v),
      ),
      fee:
          (json['fee'] is num
              ? json['fee'].toString()
              : json.valueAsString<String>('fee')),
      storageFee:
          (json['storage_fee'] is num
              ? json['storage_fee'].toString()
              : json.valueAsString<String>('storage_fee')),
      otherFee:
          (json['other_fee'] is num
              ? json['other_fee'].toString()
              : json.valueAsString<String>('other_fee')),
      inMsg: json.valueTo<MessageStd?, Map<String, dynamic>>(
        key: 'in_msg',
        parse: (v) => MessageStd.fromJson(v),
      ),
      outMsgs:
          json
              .valueEnsureAsList<Map<String, dynamic>>('out_msgs')
              .map((e) => MessageStd.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'address': address.toJson(config: config),
    'utime': utime,
    'data': data,
    'transaction_id': transactionId.toJson(config: config),
    'fee': fee,
    'storage_fee': storageFee,
    'other_fee': otherFee,
    'in_msg': inMsg?.toJson(config: config),
    'out_msgs': outMsgs.map((e) => e.toJson(config: config)).toList(),
  });
}

/// Request to fetch transaction history for an account with optional pagination and filtering parameters.
///
/// POST /api/v2/getTransactions (request)
/// POST /api/v2/getTransactionsStd (request)
class TransactionsRequest {
  final String address;

  /// Logical time of the transaction. Use together with its hash for pagination and lookups.
  final BigInt? lt;

  /// Hash of the starting transaction for pagination. Use together with `lt` from a previous response's `transaction_id`.
  final String? hash;

  /// Stop returning items at this logical time.
  final BigInt? toLt;

  /// Whether to use archival nodes for old data.
  final BlockDataRequestArchival? archival;

  /// Maximum number of items to return.
  final BigInt? limit;

  const TransactionsRequest({
    required this.address,
    this.lt,
    this.hash,
    this.toLt,
    this.archival,
    this.limit,
  });

  factory TransactionsRequest.fromJson(Map<String, dynamic> json) {
    return TransactionsRequest(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String>('address')),
      lt: json.valueAsBigInt<BigInt?>('lt'),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String?>('hash')),
      toLt: json.valueAsBigInt<BigInt?>('to_lt'),
      archival: json.valueTo<BlockDataRequestArchival?, Object>(
        key: 'archival',
        parse: (e) => BlockDataRequestArchival.fromJson(JsonParser.valueAs(e)),
      ),
      limit: json.valueAsBigInt<BigInt?>('limit'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'lt': config.encodeBigint(lt),
    'hash': hash,
    'to_lt': config.encodeBigint(toLt),
    'archival': archival?.toJson(config: config),
    'limit': config.encodeBigint(limit),
  });
}

class TransactionsStd {
  /// TonLib type identifier for paginated raw transaction lists.
  final TransactionsStdType type;

  /// Array of transaction objects in standardized format. Each transaction contains address, timestamps, inbound/outbound messages, fees in nanotons, and raw BoC (base64).
  final List<TransactionStd> transactions;

  /// Use this as cursor to fetch the next page of older transactions.
  final InternalTransactionId previousTransactionId;

  const TransactionsStd({
    required this.type,
    required this.transactions,
    required this.previousTransactionId,
  });

  factory TransactionsStd.fromJson(Map<String, dynamic> json) {
    return TransactionsStd(
      type: json.valueTo<TransactionsStdType, Object>(
        key: '@type',
        parse: (e) => TransactionsStdType.fromJson(JsonParser.valueAs(e)),
      ),
      transactions:
          json
              .valueEnsureAsList<Map<String, dynamic>>('transactions')
              .map((e) => TransactionStd.fromJson(e))
              .toList(),
      previousTransactionId: json
          .valueTo<InternalTransactionId, Map<String, dynamic>>(
            key: 'previous_transaction_id',
            parse: (v) => InternalTransactionId.fromJson(v),
          ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'transactions': transactions.map((e) => e.toJson(config: config)).toList(),
    'previous_transaction_id': previousTransactionId.toJson(config: config),
  });
}

/// POST /api/v2/tryLocateTx (request)
class TryLocateTxRequest {
  final String source;

  /// Recipient address.
  final String destination;

  /// Logical time when this message was created. Use with source and destination to uniquely identify a message.
  final BigInt createdLt;

  const TryLocateTxRequest({
    required this.source,
    required this.destination,
    required this.createdLt,
  });

  factory TryLocateTxRequest.fromJson(Map<String, dynamic> json) {
    return TryLocateTxRequest(
      source:
          (json['source'] is num
              ? json['source'].toString()
              : json.valueAsString<String>('source')),
      destination:
          (json['destination'] is num
              ? json['destination'].toString()
              : json.valueAsString<String>('destination')),
      createdLt: json.valueAsBigInt<BigInt>('created_lt'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'source': source,
    'destination': destination,
    'created_lt': config.encodeBigint(createdLt),
  });
}

class TvmCell {
  /// TonLib type identifier for TVM cell values.
  final TvmCellType type;

  /// TVM cell data serialized as base64.
  final String bytes;

  const TvmCell({required this.type, required this.bytes});

  factory TvmCell.fromJson(Map<String, dynamic> json) {
    return TvmCell(
      type: json.valueTo<TvmCellType, Object>(
        key: '@type',
        parse: (e) => TvmCellType.fromJson(JsonParser.valueAs(e)),
      ),
      bytes:
          (json['bytes'] is num
              ? json['bytes'].toString()
              : json.valueAsString<String>('bytes')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'bytes': bytes,
  });
}

class TvmList {
  /// TonLib type identifier for TVM list structures.
  final TvmListType type;

  /// Ordered list of TVM stack entries. Each element is a typed object with `@type` discriminator (`tvm.stackEntryNumber`, `tvm.stackEntryCell`, `tvm.stackEntrySlice`, `tvm.stackEntryTuple`, or `tvm.stackEntryList`).
  final List<TvmListElementsItem> elements;

  const TvmList({required this.type, required this.elements});

  factory TvmList.fromJson(Map<String, dynamic> json) {
    return TvmList(
      type: json.valueTo<TvmListType, Object>(
        key: '@type',
        parse: (e) => TvmListType.fromJson(JsonParser.valueAs(e)),
      ),
      elements:
          json
              .valueEnsureAsList<dynamic>('elements')
              .map((e) => TvmListElementsItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'elements': elements.map((e) => e.toJson(config: config)).toList(),
  });
}

class TvmNumberDecimal {
  /// TonLib type identifier for TVM decimal number values.
  final TvmNumberDecimalType type;

  /// Integer value as a decimal string (supports arbitrarily large numbers).
  final String number;

  const TvmNumberDecimal({required this.type, required this.number});

  factory TvmNumberDecimal.fromJson(Map<String, dynamic> json) {
    return TvmNumberDecimal(
      type: json.valueTo<TvmNumberDecimalType, Object>(
        key: '@type',
        parse: (e) => TvmNumberDecimalType.fromJson(JsonParser.valueAs(e)),
      ),
      number:
          (json['number'] is num
              ? json['number'].toString()
              : json.valueAsString<String>('number')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'number': number,
  });
}

class TvmSlice {
  /// TonLib type identifier for TVM slice values.
  final TvmSliceType type;

  /// TVM slice data serialized as base64.
  final String bytes;

  const TvmSlice({required this.type, required this.bytes});

  factory TvmSlice.fromJson(Map<String, dynamic> json) {
    return TvmSlice(
      type: json.valueTo<TvmSliceType, Object>(
        key: '@type',
        parse: (e) => TvmSliceType.fromJson(JsonParser.valueAs(e)),
      ),
      bytes:
          (json['bytes'] is num
              ? json['bytes'].toString()
              : json.valueAsString<String>('bytes')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'bytes': bytes,
  });
}

class TvmStackEntryCell {
  /// TonLib type identifier for cell-typed stack entries.
  final RunGetMethodStdResultStackItemTypeCellType type;

  /// The TVM cell value.
  final TvmCell cell;

  const TvmStackEntryCell({required this.type, required this.cell});

  factory TvmStackEntryCell.fromJson(Map<String, dynamic> json) {
    return TvmStackEntryCell(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeCellType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeCellType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      cell: json.valueTo<TvmCell, Map<String, dynamic>>(
        key: 'cell',
        parse: (v) => TvmCell.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'cell': cell.toJson(config: config),
  });
}

class TvmStackEntryList {
  /// TonLib type identifier for list-typed stack entries.
  final TvmTupleElementsItemTypeListType type;

  /// The TVM list value.
  final TvmList list;

  const TvmStackEntryList({required this.type, required this.list});

  factory TvmStackEntryList.fromJson(Map<String, dynamic> json) {
    return TvmStackEntryList(
      type: json.valueTo<TvmTupleElementsItemTypeListType, Object>(
        key: '@type',
        parse:
            (e) => TvmTupleElementsItemTypeListType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      list: json.valueTo<TvmList, Map<String, dynamic>>(
        key: 'list',
        parse: (v) => TvmList.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'list': list.toJson(config: config),
  });
}

class TvmStackEntryNumber {
  /// TonLib type identifier for number-typed stack entries.
  final RunGetMethodStdResultStackItemTypeNumberType type;

  /// The TVM number value (arbitrary-precision decimal).
  final TvmNumberDecimal number;

  const TvmStackEntryNumber({required this.type, required this.number});

  factory TvmStackEntryNumber.fromJson(Map<String, dynamic> json) {
    return TvmStackEntryNumber(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeNumberType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeNumberType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      number: json.valueTo<TvmNumberDecimal, Map<String, dynamic>>(
        key: 'number',
        parse: (v) => TvmNumberDecimal.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'number': number.toJson(config: config),
  });
}

class TvmStackEntrySlice {
  /// TonLib type identifier for slice-typed stack entries.
  final RunGetMethodStdResultStackItemTypeSliceType type;

  /// The TVM slice value.
  final TvmSlice slice;

  const TvmStackEntrySlice({required this.type, required this.slice});

  factory TvmStackEntrySlice.fromJson(Map<String, dynamic> json) {
    return TvmStackEntrySlice(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeSliceType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeSliceType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      slice: json.valueTo<TvmSlice, Map<String, dynamic>>(
        key: 'slice',
        parse: (v) => TvmSlice.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'slice': slice.toJson(config: config),
  });
}

class TvmStackEntryTuple {
  /// TonLib type identifier for tuple-typed stack entries.
  final RunGetMethodStdResultStackItemTypeTupleType type;

  /// The TVM tuple value.
  final TvmTuple tuple;

  const TvmStackEntryTuple({required this.type, required this.tuple});

  factory TvmStackEntryTuple.fromJson(Map<String, dynamic> json) {
    return TvmStackEntryTuple(
      type: json.valueTo<RunGetMethodStdResultStackItemTypeTupleType, Object>(
        key: '@type',
        parse:
            (e) => RunGetMethodStdResultStackItemTypeTupleType.fromJson(
              JsonParser.valueAs(e),
            ),
      ),
      tuple: json.valueTo<TvmTuple, Map<String, dynamic>>(
        key: 'tuple',
        parse: (v) => TvmTuple.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'tuple': tuple.toJson(config: config),
  });
}

class TvmStackEntryUnsupported {
  /// TonLib type identifier for stack entries with unsupported types.
  final TvmListElementsItemTypeType type;

  const TvmStackEntryUnsupported({required this.type});

  factory TvmStackEntryUnsupported.fromJson(Map<String, dynamic> json) {
    return TvmStackEntryUnsupported(
      type: json.valueTo<TvmListElementsItemTypeType, Object>(
        key: '@type',
        parse:
            (e) => TvmListElementsItemTypeType.fromJson(JsonParser.valueAs(e)),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) =>
      config.encodeMap(<String, dynamic>{'@type': type.toJson(config: config)});
}

class TvmTuple {
  /// TonLib type identifier for TVM tuple structures.
  final TvmTupleType type;

  /// Ordered tuple of TVM stack entries. Each element is a typed object with `@type` discriminator (`tvm.stackEntryNumber`, `tvm.stackEntryCell`, `tvm.stackEntrySlice`, `tvm.stackEntryTuple`, or `tvm.stackEntryList`).
  final List<TvmTupleElementsItem> elements;

  const TvmTuple({required this.type, required this.elements});

  factory TvmTuple.fromJson(Map<String, dynamic> json) {
    return TvmTuple(
      type: json.valueTo<TvmTupleType, Object>(
        key: '@type',
        parse: (e) => TvmTupleType.fromJson(JsonParser.valueAs(e)),
      ),
      elements:
          json
              .valueEnsureAsList<dynamic>('elements')
              .map((e) => TvmTupleElementsItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'elements': elements.map((e) => e.toJson(config: config)).toList(),
  });
}

/// Information about a wallet account. Check `wallet` before using wallet-specific fields such as `wallet_type`, `seqno`, and `wallet_id`; available fields depend on the wallet type.
class WalletInformation {
  /// TonLib type identifier for wallet info responses.
  final WalletInformationType type;

  /// Returns `true` if this address is a recognized wallet contract type; otherwise `false`.
  final bool wallet;

  /// Account balance in nanotons as a decimal string.
  final String balance;

  /// Account lifecycle state: `uninitialized`, `active`, or `frozen`.
  final AccountStateEnum accountState;

  /// Reference to the most recent transaction. Use as starting point for getTransactions.
  final InternalTransactionId lastTransactionId;

  /// Recognized wallet contract type, such as `wallet v4 r2`, `wallet v5 r1`, or `tg-wallet`.
  final WalletInformationWalletType? walletType;

  /// Wallet contract sequence number. Used for replay protection: each outgoing transaction must include the current `seqno` and increments it by 1. Fetch the current value before sending a transaction.
  final BigInt? seqno;

  /// Subwallet identifier. Allows creating multiple wallets from one key.
  final int? walletId;

  /// Whether signature authentication is enabled for this wallet (v5 wallets only).
  final bool? isSignatureAllowed;

  const WalletInformation({
    required this.type,
    required this.wallet,
    required this.balance,
    required this.accountState,
    required this.lastTransactionId,
    this.walletType,
    this.seqno,
    this.walletId,
    this.isSignatureAllowed,
  });

  factory WalletInformation.fromJson(Map<String, dynamic> json) {
    return WalletInformation(
      type: json.valueTo<WalletInformationType, Object>(
        key: '@type',
        parse: (e) => WalletInformationType.fromJson(JsonParser.valueAs(e)),
      ),
      wallet: json.valueAsBool<bool>('wallet'),
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String>('balance')),
      accountState: json.valueTo<AccountStateEnum, Object>(
        key: 'account_state',
        parse: (e) => AccountStateEnum.fromJson(JsonParser.valueAs(e)),
      ),
      lastTransactionId: json
          .valueTo<InternalTransactionId, Map<String, dynamic>>(
            key: 'last_transaction_id',
            parse: (v) => InternalTransactionId.fromJson(v),
          ),
      walletType: json.valueTo<WalletInformationWalletType?, Object>(
        key: 'wallet_type',
        parse:
            (e) => WalletInformationWalletType.fromJson(JsonParser.valueAs(e)),
      ),
      seqno: json.valueAsBigInt<BigInt?>('seqno'),
      walletId: json.valueAsInt<int?>('wallet_id'),
      isSignatureAllowed: json.valueAsBool<bool?>('is_signature_allowed'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    '@type': type.toJson(config: config),
    'wallet': wallet,
    'balance': balance,
    'account_state': accountState.toJson(config: config),
    'last_transaction_id': lastTransactionId.toJson(config: config),
    'wallet_type': walletType?.toJson(config: config),
    'seqno': config.encodeBigint(seqno),
    'wallet_id': walletId,
    'is_signature_allowed': isSignatureAllowed,
  });
}

/// Cell binary data.
class LegacyTvmCellData {
  /// Cell data in base64.
  final String b64;

  /// Data length in bits.
  final int len;

  const LegacyTvmCellData({required this.b64, required this.len});

  factory LegacyTvmCellData.fromJson(Map<String, dynamic> json) {
    return LegacyTvmCellData(
      b64:
          (json['b64'] is num
              ? json['b64'].toString()
              : json.valueAsString<String>('b64')),
      len: json.valueAsInt<int>('len'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'b64': b64, 'len': len});
}
