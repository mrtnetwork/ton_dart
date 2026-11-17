// GENERATED CODE - DO NOT MODIFY BY HAND
// Source: OpenAPI 2.0
// TON Index (Go) 1.2.6
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

enum ModelsFinalityState {
  finalityStatePending(0),
  finalityStateConfirmed(1),
  finalityStateFinalized(2);

  final int value;
  const ModelsFinalityState(this.value);

  static ModelsFinalityState fromJson(dynamic json) {
    if (json is int) {
      return values.firstWhere(
        (e) => e.value == json,
        orElse:
            () =>
                throw BuError(
                  DefaultErrorType.notFound,
                  "No matching ModelsFinalityState found for the given value. null",
                ),
      );
    }
    // The live API also emits the string form ("pending"/"confirmed"/
    // "finalized") while the spec declares integers.
    final name = json?.toString().toLowerCase();
    const byName = {
      'pending': ModelsFinalityState.finalityStatePending,
      'confirmed': ModelsFinalityState.finalityStateConfirmed,
      'finalized': ModelsFinalityState.finalityStateFinalized,
    };
    final match = name == null ? null : byName[name];
    if (match != null) return match;
    final asInt = int.tryParse(name ?? '');
    if (asInt != null) {
      return values.firstWhere(
        (e) => e.value == asInt,
        orElse:
            () =>
                throw BuError(
                  DefaultErrorType.notFound,
                  "No matching ModelsFinalityState found for the given value. null",
                ),
      );
    }
    throw BuError(
      DefaultErrorType.notFound,
      "No matching ModelsFinalityState found for the given value. null",
    );
  }

  int toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// "reward", "deposit", "withdrawal", "pending_deposit_activation", "withdrawal_request"
enum NominatorPoolEventType {
  reward("reward"),
  deposit("deposit"),
  withdrawal("withdrawal"),
  pendingDepositActivation("pending_deposit_activation"),
  withdrawalRequest("withdrawal_request");

  final String value;
  const NominatorPoolEventType(this.value);

  static NominatorPoolEventType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching NominatorPoolEventType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// "reward", "penalty", "deposit", "withdrawal"
enum NominatorPoolValidatorEventType {
  reward("reward"),
  penalty("penalty"),
  deposit("deposit"),
  withdrawal("withdrawal");

  final String value;
  const NominatorPoolValidatorEventType(this.value);

  static NominatorPoolValidatorEventType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching NominatorPoolValidatorEventType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

/// "stake_accepted", "stake_rejected", "stake_recovered"
enum ValidatorEventType {
  stakeAccepted("stake_accepted"),
  stakeRejected("stake_rejected"),
  stakeRecovered("stake_recovered");

  final String value;
  const ValidatorEventType(this.value);

  static ValidatorEventType fromJson(dynamic json) {
    final value = json is String ? json : json?.toString();
    return values.firstWhere(
      (e) => e.value == value,
      orElse:
          () =>
              throw BuError(
                DefaultErrorType.notFound,
                "No matching ValidatorEventType found for the given value. null",
              ),
    );
  }

  String toJson({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      value;
}

class AccountBalance {
  final String? account;
  final String? balance;

  const AccountBalance({this.account, this.balance});

  factory AccountBalance.fromJson(Map<String, dynamic> json) {
    return AccountBalance(
      account:
          (json['account'] is num
              ? json['account'].toString()
              : json.valueAsString<String?>('account')),
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String?>('balance')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'account': account,
    'balance': balance,
  });
}

class AccountState {
  final String? accountStatus;
  final String? balance;
  final String? codeBoc;
  final String? codeHash;
  final String? dataBoc;
  final String? dataHash;
  final Map<String, String>? extraCurrencies;
  final String? frozenHash;
  final String? hash;

  const AccountState({
    this.accountStatus,
    this.balance,
    this.codeBoc,
    this.codeHash,
    this.dataBoc,
    this.dataHash,
    this.extraCurrencies,
    this.frozenHash,
    this.hash,
  });

  factory AccountState.fromJson(Map<String, dynamic> json) {
    return AccountState(
      accountStatus:
          (json['account_status'] is num
              ? json['account_status'].toString()
              : json.valueAsString<String?>('account_status')),
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String?>('balance')),
      codeBoc:
          (json['code_boc'] is num
              ? json['code_boc'].toString()
              : json.valueAsString<String?>('code_boc')),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String?>('code_hash')),
      dataBoc:
          (json['data_boc'] is num
              ? json['data_boc'].toString()
              : json.valueAsString<String?>('data_boc')),
      dataHash:
          (json['data_hash'] is num
              ? json['data_hash'].toString()
              : json.valueAsString<String?>('data_hash')),
      extraCurrencies:
          json.hasValue('extra_currencies')
              ? json
                  .valueEnsureAsMap<String, dynamic>('extra_currencies')
                  .map(
                    (k, v) => MapEntry(
                      k,
                      (v is num
                          ? v.toString()
                          : JsonParser.valueAsString<String>(v)),
                    ),
                  )
              : null,
      frozenHash:
          (json['frozen_hash'] is num
              ? json['frozen_hash'].toString()
              : json.valueAsString<String?>('frozen_hash')),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String?>('hash')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'account_status': accountStatus,
    'balance': balance,
    'code_boc': codeBoc,
    'code_hash': codeHash,
    'data_boc': dataBoc,
    'data_hash': dataHash,
    'extra_currencies': extraCurrencies,
    'frozen_hash': frozenHash,
    'hash': hash,
  });
}

class AccountStateFull {
  final String? accountStateHash;
  final String? address;
  final String? balance;
  final String? codeBoc;
  final String? codeHash;
  final List<int>? contractMethods;
  final String? dataBoc;
  final String? dataHash;
  final Map<String, String>? extraCurrencies;
  final String? frozenHash;
  final List<String>? interfaces;
  final String? lastTransactionHash;
  final String? lastTransactionLt;
  final String? status;
  final bool? suspended;

  const AccountStateFull({
    this.accountStateHash,
    this.address,
    this.balance,
    this.codeBoc,
    this.codeHash,
    this.contractMethods,
    this.dataBoc,
    this.dataHash,
    this.extraCurrencies,
    this.frozenHash,
    this.interfaces,
    this.lastTransactionHash,
    this.lastTransactionLt,
    this.status,
    this.suspended,
  });

  factory AccountStateFull.fromJson(Map<String, dynamic> json) {
    return AccountStateFull(
      accountStateHash:
          (json['account_state_hash'] is num
              ? json['account_state_hash'].toString()
              : json.valueAsString<String?>('account_state_hash')),
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String?>('balance')),
      codeBoc:
          (json['code_boc'] is num
              ? json['code_boc'].toString()
              : json.valueAsString<String?>('code_boc')),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String?>('code_hash')),
      contractMethods: json.valueAsList<List<int>?>('contract_methods'),
      dataBoc:
          (json['data_boc'] is num
              ? json['data_boc'].toString()
              : json.valueAsString<String?>('data_boc')),
      dataHash:
          (json['data_hash'] is num
              ? json['data_hash'].toString()
              : json.valueAsString<String?>('data_hash')),
      extraCurrencies:
          json.hasValue('extra_currencies')
              ? json
                  .valueEnsureAsMap<String, dynamic>('extra_currencies')
                  .map(
                    (k, v) => MapEntry(
                      k,
                      (v is num
                          ? v.toString()
                          : JsonParser.valueAsString<String>(v)),
                    ),
                  )
              : null,
      frozenHash:
          (json['frozen_hash'] is num
              ? json['frozen_hash'].toString()
              : json.valueAsString<String?>('frozen_hash')),
      interfaces: json.valueAsList<List<String>?>('interfaces'),
      lastTransactionHash:
          (json['last_transaction_hash'] is num
              ? json['last_transaction_hash'].toString()
              : json.valueAsString<String?>('last_transaction_hash')),
      lastTransactionLt:
          (json['last_transaction_lt'] is num
              ? json['last_transaction_lt'].toString()
              : json.valueAsString<String?>('last_transaction_lt')),
      status:
          (json['status'] is num
              ? json['status'].toString()
              : json.valueAsString<String?>('status')),
      suspended: json.valueAsBool<bool?>('suspended'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'account_state_hash': accountStateHash,
    'address': address,
    'balance': balance,
    'code_boc': codeBoc,
    'code_hash': codeHash,
    'contract_methods': contractMethods,
    'data_boc': dataBoc,
    'data_hash': dataHash,
    'extra_currencies': extraCurrencies,
    'frozen_hash': frozenHash,
    'interfaces': interfaces,
    'last_transaction_hash': lastTransactionHash,
    'last_transaction_lt': lastTransactionLt,
    'status': status,
    'suspended': suspended,
  });
}

class AccountStatesResponse {
  final List<AccountStateFull>? accounts;
  final AddressBook? addressBook;
  final Metadata? metadata;

  const AccountStatesResponse({this.accounts, this.addressBook, this.metadata});

  factory AccountStatesResponse.fromJson(Map<String, dynamic> json) {
    return AccountStatesResponse(
      accounts:
          json.hasValue('accounts')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('accounts')
                  .map((e) => AccountStateFull.fromJson(e))
                  .toList()
              : null,
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'accounts': accounts?.map((e) => e.toJson(config: config)).toList(),
    'address_book': addressBook?.toJson(config: config),
    'metadata': metadata?.toJson(config: config),
  });
}

class Action {
  final List<String>? accounts;
  final String? actionId;
  final dynamic details;
  final String? endLt;
  final int? endUtime;
  final ModelsFinalityState? finality;

  /// action_id of the gasless_request action this action is an immediate result of
  final String? parentGaslessAction;
  final String? startLt;
  final int? startUtime;
  final bool? success;
  final String? traceEndLt;
  final int? traceEndUtime;
  final String? traceExternalHash;
  final String? traceExternalHashNorm;
  final String? traceId;
  final int? traceMcSeqnoEnd;
  final List<String>? transactions;
  final List<Transaction>? transactionsFull;
  final String? type;

  const Action({
    this.accounts,
    this.actionId,
    this.details,
    this.endLt,
    this.endUtime,
    this.finality,
    this.parentGaslessAction,
    this.startLt,
    this.startUtime,
    this.success,
    this.traceEndLt,
    this.traceEndUtime,
    this.traceExternalHash,
    this.traceExternalHashNorm,
    this.traceId,
    this.traceMcSeqnoEnd,
    this.transactions,
    this.transactionsFull,
    this.type,
  });

  factory Action.fromJson(Map<String, dynamic> json) {
    return Action(
      accounts: json.valueAsList<List<String>?>('accounts'),
      actionId:
          (json['action_id'] is num
              ? json['action_id'].toString()
              : json.valueAsString<String?>('action_id')),
      details: json['details'],
      endLt:
          (json['end_lt'] is num
              ? json['end_lt'].toString()
              : json.valueAsString<String?>('end_lt')),
      endUtime: json.valueAsInt<int?>('end_utime'),
      finality:
          json['finality'] == null
              ? null
              : json.valueTo<ModelsFinalityState?, Object>(
                key: 'finality',
                parse:
                    (e) => ModelsFinalityState.fromJson(JsonParser.valueAs(e)),
              ),
      parentGaslessAction:
          (json['parent_gasless_action'] is num
              ? json['parent_gasless_action'].toString()
              : json.valueAsString<String?>('parent_gasless_action')),
      startLt:
          (json['start_lt'] is num
              ? json['start_lt'].toString()
              : json.valueAsString<String?>('start_lt')),
      startUtime: json.valueAsInt<int?>('start_utime'),
      success: json.valueAsBool<bool?>('success'),
      traceEndLt:
          (json['trace_end_lt'] is num
              ? json['trace_end_lt'].toString()
              : json.valueAsString<String?>('trace_end_lt')),
      traceEndUtime: json.valueAsInt<int?>('trace_end_utime'),
      traceExternalHash:
          (json['trace_external_hash'] is num
              ? json['trace_external_hash'].toString()
              : json.valueAsString<String?>('trace_external_hash')),
      traceExternalHashNorm:
          (json['trace_external_hash_norm'] is num
              ? json['trace_external_hash_norm'].toString()
              : json.valueAsString<String?>('trace_external_hash_norm')),
      traceId:
          (json['trace_id'] is num
              ? json['trace_id'].toString()
              : json.valueAsString<String?>('trace_id')),
      traceMcSeqnoEnd: json.valueAsInt<int?>('trace_mc_seqno_end'),
      transactions: json.valueAsList<List<String>?>('transactions'),
      transactionsFull:
          json.hasValue('transactions_full')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('transactions_full')
                  .map((e) => Transaction.fromJson(e))
                  .toList()
              : null,
      type:
          (json['type'] is num
              ? json['type'].toString()
              : json.valueAsString<String?>('type')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'accounts': accounts,
    'action_id': actionId,
    'details': details,
    'end_lt': endLt,
    'end_utime': endUtime,
    'finality': finality?.toJson(config: config),
    'parent_gasless_action': parentGaslessAction,
    'start_lt': startLt,
    'start_utime': startUtime,
    'success': success,
    'trace_end_lt': traceEndLt,
    'trace_end_utime': traceEndUtime,
    'trace_external_hash': traceExternalHash,
    'trace_external_hash_norm': traceExternalHashNorm,
    'trace_id': traceId,
    'trace_mc_seqno_end': traceMcSeqnoEnd,
    'transactions': transactions,
    'transactions_full':
        transactionsFull?.map((e) => e.toJson(config: config)).toList(),
    'type': type,
  });
}

class ActionPhase {
  final String? actionListHash;
  final int? msgsCreated;
  final bool? noFunds;
  final int? resultArg;
  final int? resultCode;
  final int? skippedActions;
  final int? specActions;
  final String? statusChange;
  final bool? success;
  final int? totActions;
  final MsgSize? totMsgSize;
  final String? totalActionFees;
  final String? totalFwdFees;
  final bool? valid;

  const ActionPhase({
    this.actionListHash,
    this.msgsCreated,
    this.noFunds,
    this.resultArg,
    this.resultCode,
    this.skippedActions,
    this.specActions,
    this.statusChange,
    this.success,
    this.totActions,
    this.totMsgSize,
    this.totalActionFees,
    this.totalFwdFees,
    this.valid,
  });

  factory ActionPhase.fromJson(Map<String, dynamic> json) {
    return ActionPhase(
      actionListHash:
          (json['action_list_hash'] is num
              ? json['action_list_hash'].toString()
              : json.valueAsString<String?>('action_list_hash')),
      msgsCreated: json.valueAsInt<int?>('msgs_created'),
      noFunds: json.valueAsBool<bool?>('no_funds'),
      resultArg: json.valueAsInt<int?>('result_arg'),
      resultCode: json.valueAsInt<int?>('result_code'),
      skippedActions: json.valueAsInt<int?>('skipped_actions'),
      specActions: json.valueAsInt<int?>('spec_actions'),
      statusChange:
          (json['status_change'] is num
              ? json['status_change'].toString()
              : json.valueAsString<String?>('status_change')),
      success: json.valueAsBool<bool?>('success'),
      totActions: json.valueAsInt<int?>('tot_actions'),
      totMsgSize: json.valueTo<MsgSize?, Map<String, dynamic>>(
        key: 'tot_msg_size',
        parse: (v) => MsgSize.fromJson(v),
      ),
      totalActionFees:
          (json['total_action_fees'] is num
              ? json['total_action_fees'].toString()
              : json.valueAsString<String?>('total_action_fees')),
      totalFwdFees:
          (json['total_fwd_fees'] is num
              ? json['total_fwd_fees'].toString()
              : json.valueAsString<String?>('total_fwd_fees')),
      valid: json.valueAsBool<bool?>('valid'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'action_list_hash': actionListHash,
    'msgs_created': msgsCreated,
    'no_funds': noFunds,
    'result_arg': resultArg,
    'result_code': resultCode,
    'skipped_actions': skippedActions,
    'spec_actions': specActions,
    'status_change': statusChange,
    'success': success,
    'tot_actions': totActions,
    'tot_msg_size': totMsgSize?.toJson(config: config),
    'total_action_fees': totalActionFees,
    'total_fwd_fees': totalFwdFees,
    'valid': valid,
  });
}

class ActionsResponse {
  final List<Action>? actions;
  final AddressBook? addressBook;
  final Metadata? metadata;
  final String? nextCursor;

  const ActionsResponse({
    this.actions,
    this.addressBook,
    this.metadata,
    this.nextCursor,
  });

  factory ActionsResponse.fromJson(Map<String, dynamic> json) {
    return ActionsResponse(
      actions:
          json.hasValue('actions')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('actions')
                  .map((e) => Action.fromJson(e))
                  .toList()
              : null,
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
      nextCursor:
          (json['next_cursor'] is num
              ? json['next_cursor'].toString()
              : json.valueAsString<String?>('next_cursor')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'actions': actions?.map((e) => e.toJson(config: config)).toList(),
    'address_book': addressBook?.toJson(config: config),
    'metadata': metadata?.toJson(config: config),
    'next_cursor': nextCursor,
  });
}

class ActiveNominatorInfo {
  final String? address;
  final String? balance;
  final String? pendingBalance;

  const ActiveNominatorInfo({this.address, this.balance, this.pendingBalance});

  factory ActiveNominatorInfo.fromJson(Map<String, dynamic> json) {
    return ActiveNominatorInfo(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String?>('balance')),
      pendingBalance:
          (json['pending_balance'] is num
              ? json['pending_balance'].toString()
              : json.valueAsString<String?>('pending_balance')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'balance': balance,
    'pending_balance': pendingBalance,
  });
}

class AddressBook {
  final Map<String, AddressBookRow> values;
  const AddressBook(this.values);

  factory AddressBook.fromJson(Map<String, dynamic> json) => AddressBook(
    json.map(
      (k, v) => MapEntry(k, AddressBookRow.fromJson(v as Map<String, dynamic>)),
    ),
  );

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(
    values.map((k, v) => MapEntry(k, v.toJson(config: config))),
  );
}

class AddressBookRow {
  final String? domain;
  final List<String>? interfaces;
  final String? userFriendly;

  const AddressBookRow({this.domain, this.interfaces, this.userFriendly});

  factory AddressBookRow.fromJson(Map<String, dynamic> json) {
    return AddressBookRow(
      domain:
          (json['domain'] is num
              ? json['domain'].toString()
              : json.valueAsString<String?>('domain')),
      interfaces: json.valueAsList<List<String>?>('interfaces'),
      userFriendly:
          (json['user_friendly'] is num
              ? json['user_friendly'].toString()
              : json.valueAsString<String?>('user_friendly')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'domain': domain,
    'interfaces': interfaces,
    'user_friendly': userFriendly,
  });
}

class AddressMetadata {
  final bool? isIndexed;
  final List<TokenInfo>? tokenInfo;

  const AddressMetadata({this.isIndexed, this.tokenInfo});

  factory AddressMetadata.fromJson(Map<String, dynamic> json) {
    return AddressMetadata(
      isIndexed: json.valueAsBool<bool?>('is_indexed'),
      tokenInfo:
          json.hasValue('token_info')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('token_info')
                  .map((e) => TokenInfo.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'is_indexed': isIndexed,
    'token_info': tokenInfo?.map((e) => e.toJson(config: config)).toList(),
  });
}

class Block {
  final bool? afterMerge;
  final bool? afterSplit;
  final bool? beforeSplit;
  final String? createdBy;
  final String? endLt;
  final String? fileHash;
  final int? flags;
  final int? genCatchainSeqno;
  final String? genUtime;
  final int? globalId;
  final bool? keyBlock;
  final int? masterRefSeqno;
  final BlockId? masterchainBlockRef;
  final int? minRefMcSeqno;
  final List<BlockId>? prevBlocks;
  final int? prevKeyBlockSeqno;
  final String? randSeed;
  final String? rootHash;
  final int? seqno;
  final String? shard;
  final String? startLt;
  final int? txCount;
  final int? validatorListHashShort;
  final int? version;
  final int? vertSeqno;
  final bool? vertSeqnoIncr;
  final bool? wantMerge;
  final bool? wantSplit;
  final int? workchain;

  const Block({
    this.afterMerge,
    this.afterSplit,
    this.beforeSplit,
    this.createdBy,
    this.endLt,
    this.fileHash,
    this.flags,
    this.genCatchainSeqno,
    this.genUtime,
    this.globalId,
    this.keyBlock,
    this.masterRefSeqno,
    this.masterchainBlockRef,
    this.minRefMcSeqno,
    this.prevBlocks,
    this.prevKeyBlockSeqno,
    this.randSeed,
    this.rootHash,
    this.seqno,
    this.shard,
    this.startLt,
    this.txCount,
    this.validatorListHashShort,
    this.version,
    this.vertSeqno,
    this.vertSeqnoIncr,
    this.wantMerge,
    this.wantSplit,
    this.workchain,
  });

  factory Block.fromJson(Map<String, dynamic> json) {
    return Block(
      afterMerge: json.valueAsBool<bool?>('after_merge'),
      afterSplit: json.valueAsBool<bool?>('after_split'),
      beforeSplit: json.valueAsBool<bool?>('before_split'),
      createdBy:
          (json['created_by'] is num
              ? json['created_by'].toString()
              : json.valueAsString<String?>('created_by')),
      endLt:
          (json['end_lt'] is num
              ? json['end_lt'].toString()
              : json.valueAsString<String?>('end_lt')),
      fileHash:
          (json['file_hash'] is num
              ? json['file_hash'].toString()
              : json.valueAsString<String?>('file_hash')),
      flags: json.valueAsInt<int?>('flags'),
      genCatchainSeqno: json.valueAsInt<int?>('gen_catchain_seqno'),
      genUtime:
          (json['gen_utime'] is num
              ? json['gen_utime'].toString()
              : json.valueAsString<String?>('gen_utime')),
      globalId: json.valueAsInt<int?>('global_id'),
      keyBlock: json.valueAsBool<bool?>('key_block'),
      masterRefSeqno: json.valueAsInt<int?>('master_ref_seqno'),
      masterchainBlockRef: json.valueTo<BlockId?, Map<String, dynamic>>(
        key: 'masterchain_block_ref',
        parse: (v) => BlockId.fromJson(v),
      ),
      minRefMcSeqno: json.valueAsInt<int?>('min_ref_mc_seqno'),
      prevBlocks:
          json.hasValue('prev_blocks')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('prev_blocks')
                  .map((e) => BlockId.fromJson(e))
                  .toList()
              : null,
      prevKeyBlockSeqno: json.valueAsInt<int?>('prev_key_block_seqno'),
      randSeed:
          (json['rand_seed'] is num
              ? json['rand_seed'].toString()
              : json.valueAsString<String?>('rand_seed')),
      rootHash:
          (json['root_hash'] is num
              ? json['root_hash'].toString()
              : json.valueAsString<String?>('root_hash')),
      seqno: json.valueAsInt<int?>('seqno'),
      shard:
          (json['shard'] is num
              ? json['shard'].toString()
              : json.valueAsString<String?>('shard')),
      startLt:
          (json['start_lt'] is num
              ? json['start_lt'].toString()
              : json.valueAsString<String?>('start_lt')),
      txCount: json.valueAsInt<int?>('tx_count'),
      validatorListHashShort: json.valueAsInt<int?>(
        'validator_list_hash_short',
      ),
      version: json.valueAsInt<int?>('version'),
      vertSeqno: json.valueAsInt<int?>('vert_seqno'),
      vertSeqnoIncr: json.valueAsBool<bool?>('vert_seqno_incr'),
      wantMerge: json.valueAsBool<bool?>('want_merge'),
      wantSplit: json.valueAsBool<bool?>('want_split'),
      workchain: json.valueAsInt<int?>('workchain'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'after_merge': afterMerge,
    'after_split': afterSplit,
    'before_split': beforeSplit,
    'created_by': createdBy,
    'end_lt': endLt,
    'file_hash': fileHash,
    'flags': flags,
    'gen_catchain_seqno': genCatchainSeqno,
    'gen_utime': genUtime,
    'global_id': globalId,
    'key_block': keyBlock,
    'master_ref_seqno': masterRefSeqno,
    'masterchain_block_ref': masterchainBlockRef?.toJson(config: config),
    'min_ref_mc_seqno': minRefMcSeqno,
    'prev_blocks': prevBlocks?.map((e) => e.toJson(config: config)).toList(),
    'prev_key_block_seqno': prevKeyBlockSeqno,
    'rand_seed': randSeed,
    'root_hash': rootHash,
    'seqno': seqno,
    'shard': shard,
    'start_lt': startLt,
    'tx_count': txCount,
    'validator_list_hash_short': validatorListHashShort,
    'version': version,
    'vert_seqno': vertSeqno,
    'vert_seqno_incr': vertSeqnoIncr,
    'want_merge': wantMerge,
    'want_split': wantSplit,
    'workchain': workchain,
  });
}

class BlockId {
  final int? seqno;
  final String? shard;
  final int? workchain;

  const BlockId({this.seqno, this.shard, this.workchain});

  factory BlockId.fromJson(Map<String, dynamic> json) {
    return BlockId(
      seqno: json.valueAsInt<int?>('seqno'),
      shard:
          (json['shard'] is num
              ? json['shard'].toString()
              : json.valueAsString<String?>('shard')),
      workchain: json.valueAsInt<int?>('workchain'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'seqno': seqno,
    'shard': shard,
    'workchain': workchain,
  });
}

class BlocksResponse {
  final List<Block>? blocks;

  const BlocksResponse({this.blocks});

  factory BlocksResponse.fromJson(Map<String, dynamic> json) {
    return BlocksResponse(
      blocks:
          json.hasValue('blocks')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('blocks')
                  .map((e) => Block.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'blocks': blocks?.map((e) => e.toJson(config: config)).toList(),
  });
}

class BouncePhase {
  final String? fwdFees;
  final String? msgFees;
  final MsgSize? msgSize;
  final String? reqFwdFees;
  final String? type;

  const BouncePhase({
    this.fwdFees,
    this.msgFees,
    this.msgSize,
    this.reqFwdFees,
    this.type,
  });

  factory BouncePhase.fromJson(Map<String, dynamic> json) {
    return BouncePhase(
      fwdFees:
          (json['fwd_fees'] is num
              ? json['fwd_fees'].toString()
              : json.valueAsString<String?>('fwd_fees')),
      msgFees:
          (json['msg_fees'] is num
              ? json['msg_fees'].toString()
              : json.valueAsString<String?>('msg_fees')),
      msgSize: json.valueTo<MsgSize?, Map<String, dynamic>>(
        key: 'msg_size',
        parse: (v) => MsgSize.fromJson(v),
      ),
      reqFwdFees:
          (json['req_fwd_fees'] is num
              ? json['req_fwd_fees'].toString()
              : json.valueAsString<String?>('req_fwd_fees')),
      type:
          (json['type'] is num
              ? json['type'].toString()
              : json.valueAsString<String?>('type')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'fwd_fees': fwdFees,
    'msg_fees': msgFees,
    'msg_size': msgSize?.toJson(config: config),
    'req_fwd_fees': reqFwdFees,
    'type': type,
  });
}

class ComputePhase {
  final bool? accountActivated;
  final int? exitArg;
  final int? exitCode;
  final String? gasCredit;
  final String? gasFees;
  final String? gasLimit;
  final String? gasUsed;
  final int? mode;
  final bool? msgStateUsed;
  final String? reason;
  final bool? skipped;
  final bool? success;
  final String? vmFinalStateHash;
  final String? vmInitStateHash;
  final int? vmSteps;

  const ComputePhase({
    this.accountActivated,
    this.exitArg,
    this.exitCode,
    this.gasCredit,
    this.gasFees,
    this.gasLimit,
    this.gasUsed,
    this.mode,
    this.msgStateUsed,
    this.reason,
    this.skipped,
    this.success,
    this.vmFinalStateHash,
    this.vmInitStateHash,
    this.vmSteps,
  });

  factory ComputePhase.fromJson(Map<String, dynamic> json) {
    return ComputePhase(
      accountActivated: json.valueAsBool<bool?>('account_activated'),
      exitArg: json.valueAsInt<int?>('exit_arg'),
      exitCode: json.valueAsInt<int?>('exit_code'),
      gasCredit:
          (json['gas_credit'] is num
              ? json['gas_credit'].toString()
              : json.valueAsString<String?>('gas_credit')),
      gasFees:
          (json['gas_fees'] is num
              ? json['gas_fees'].toString()
              : json.valueAsString<String?>('gas_fees')),
      gasLimit:
          (json['gas_limit'] is num
              ? json['gas_limit'].toString()
              : json.valueAsString<String?>('gas_limit')),
      gasUsed:
          (json['gas_used'] is num
              ? json['gas_used'].toString()
              : json.valueAsString<String?>('gas_used')),
      mode: json.valueAsInt<int?>('mode'),
      msgStateUsed: json.valueAsBool<bool?>('msg_state_used'),
      reason:
          (json['reason'] is num
              ? json['reason'].toString()
              : json.valueAsString<String?>('reason')),
      skipped: json.valueAsBool<bool?>('skipped'),
      success: json.valueAsBool<bool?>('success'),
      vmFinalStateHash:
          (json['vm_final_state_hash'] is num
              ? json['vm_final_state_hash'].toString()
              : json.valueAsString<String?>('vm_final_state_hash')),
      vmInitStateHash:
          (json['vm_init_state_hash'] is num
              ? json['vm_init_state_hash'].toString()
              : json.valueAsString<String?>('vm_init_state_hash')),
      vmSteps: json.valueAsInt<int?>('vm_steps'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'account_activated': accountActivated,
    'exit_arg': exitArg,
    'exit_code': exitCode,
    'gas_credit': gasCredit,
    'gas_fees': gasFees,
    'gas_limit': gasLimit,
    'gas_used': gasUsed,
    'mode': mode,
    'msg_state_used': msgStateUsed,
    'reason': reason,
    'skipped': skipped,
    'success': success,
    'vm_final_state_hash': vmFinalStateHash,
    'vm_init_state_hash': vmInitStateHash,
    'vm_steps': vmSteps,
  });
}

class CreditPhase {
  final String? credit;
  final Map<String, String>? creditExtraCurrencies;
  final String? dueFeesCollected;

  const CreditPhase({
    this.credit,
    this.creditExtraCurrencies,
    this.dueFeesCollected,
  });

  factory CreditPhase.fromJson(Map<String, dynamic> json) {
    return CreditPhase(
      credit:
          (json['credit'] is num
              ? json['credit'].toString()
              : json.valueAsString<String?>('credit')),
      creditExtraCurrencies:
          json.hasValue('credit_extra_currencies')
              ? json
                  .valueEnsureAsMap<String, dynamic>('credit_extra_currencies')
                  .map(
                    (k, v) => MapEntry(
                      k,
                      (v is num
                          ? v.toString()
                          : JsonParser.valueAsString<String>(v)),
                    ),
                  )
              : null,
      dueFeesCollected:
          (json['due_fees_collected'] is num
              ? json['due_fees_collected'].toString()
              : json.valueAsString<String?>('due_fees_collected')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'credit': credit,
    'credit_extra_currencies': creditExtraCurrencies,
    'due_fees_collected': dueFeesCollected,
  });
}

class DNSAuction {
  final String? auctionEndTime;
  final String? domain;
  final bool? finished;
  final String? lastFillUpTime;
  final String? maxBidAddress;
  final String? maxBidAmount;
  final NFTItem? nftItem;
  final String? nftItemAddress;

  const DNSAuction({
    this.auctionEndTime,
    this.domain,
    this.finished,
    this.lastFillUpTime,
    this.maxBidAddress,
    this.maxBidAmount,
    this.nftItem,
    this.nftItemAddress,
  });

  factory DNSAuction.fromJson(Map<String, dynamic> json) {
    return DNSAuction(
      auctionEndTime:
          (json['auction_end_time'] is num
              ? json['auction_end_time'].toString()
              : json.valueAsString<String?>('auction_end_time')),
      domain:
          (json['domain'] is num
              ? json['domain'].toString()
              : json.valueAsString<String?>('domain')),
      finished: json.valueAsBool<bool?>('finished'),
      lastFillUpTime:
          (json['last_fill_up_time'] is num
              ? json['last_fill_up_time'].toString()
              : json.valueAsString<String?>('last_fill_up_time')),
      maxBidAddress:
          (json['max_bid_address'] is num
              ? json['max_bid_address'].toString()
              : json.valueAsString<String?>('max_bid_address')),
      maxBidAmount:
          (json['max_bid_amount'] is num
              ? json['max_bid_amount'].toString()
              : json.valueAsString<String?>('max_bid_amount')),
      nftItem: json.valueTo<NFTItem?, Map<String, dynamic>>(
        key: 'nft_item',
        parse: (v) => NFTItem.fromJson(v),
      ),
      nftItemAddress:
          (json['nft_item_address'] is num
              ? json['nft_item_address'].toString()
              : json.valueAsString<String?>('nft_item_address')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'auction_end_time': auctionEndTime,
    'domain': domain,
    'finished': finished,
    'last_fill_up_time': lastFillUpTime,
    'max_bid_address': maxBidAddress,
    'max_bid_amount': maxBidAmount,
    'nft_item': nftItem?.toJson(config: config),
    'nft_item_address': nftItemAddress,
  });
}

class DNSAuctionsResponse {
  final AddressBook? addressBook;
  final List<DNSAuction>? auctions;
  final Metadata? metadata;
  final String? nextCursor;

  const DNSAuctionsResponse({
    this.addressBook,
    this.auctions,
    this.metadata,
    this.nextCursor,
  });

  factory DNSAuctionsResponse.fromJson(Map<String, dynamic> json) {
    return DNSAuctionsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      auctions:
          json.hasValue('auctions')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('auctions')
                  .map((e) => DNSAuction.fromJson(e))
                  .toList()
              : null,
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
      nextCursor:
          (json['next_cursor'] is num
              ? json['next_cursor'].toString()
              : json.valueAsString<String?>('next_cursor')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'auctions': auctions?.map((e) => e.toJson(config: config)).toList(),
    'metadata': metadata?.toJson(config: config),
    'next_cursor': nextCursor,
  });
}

class DNSRecord {
  final String? dnsNextResolver;
  final String? dnsSiteAdnl;
  final String? dnsStorageBagId;
  final String? dnsWallet;
  final String? domain;
  final String? nftItemAddress;
  final String? nftItemOwner;

  const DNSRecord({
    this.dnsNextResolver,
    this.dnsSiteAdnl,
    this.dnsStorageBagId,
    this.dnsWallet,
    this.domain,
    this.nftItemAddress,
    this.nftItemOwner,
  });

  factory DNSRecord.fromJson(Map<String, dynamic> json) {
    return DNSRecord(
      dnsNextResolver:
          (json['dns_next_resolver'] is num
              ? json['dns_next_resolver'].toString()
              : json.valueAsString<String?>('dns_next_resolver')),
      dnsSiteAdnl:
          (json['dns_site_adnl'] is num
              ? json['dns_site_adnl'].toString()
              : json.valueAsString<String?>('dns_site_adnl')),
      dnsStorageBagId:
          (json['dns_storage_bag_id'] is num
              ? json['dns_storage_bag_id'].toString()
              : json.valueAsString<String?>('dns_storage_bag_id')),
      dnsWallet:
          (json['dns_wallet'] is num
              ? json['dns_wallet'].toString()
              : json.valueAsString<String?>('dns_wallet')),
      domain:
          (json['domain'] is num
              ? json['domain'].toString()
              : json.valueAsString<String?>('domain')),
      nftItemAddress:
          (json['nft_item_address'] is num
              ? json['nft_item_address'].toString()
              : json.valueAsString<String?>('nft_item_address')),
      nftItemOwner:
          (json['nft_item_owner'] is num
              ? json['nft_item_owner'].toString()
              : json.valueAsString<String?>('nft_item_owner')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'dns_next_resolver': dnsNextResolver,
    'dns_site_adnl': dnsSiteAdnl,
    'dns_storage_bag_id': dnsStorageBagId,
    'dns_wallet': dnsWallet,
    'domain': domain,
    'nft_item_address': nftItemAddress,
    'nft_item_owner': nftItemOwner,
  });
}

class DNSRecordsResponse {
  final AddressBook? addressBook;
  final List<DNSRecord>? records;

  const DNSRecordsResponse({this.addressBook, this.records});

  factory DNSRecordsResponse.fromJson(Map<String, dynamic> json) {
    return DNSRecordsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      records:
          json.hasValue('records')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('records')
                  .map((e) => DNSRecord.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'records': records?.map((e) => e.toJson(config: config)).toList(),
  });
}

class DecodeRequest {
  final List<String>? bodies;
  final List<String>? opcodes;

  const DecodeRequest({this.bodies, this.opcodes});

  factory DecodeRequest.fromJson(Map<String, dynamic> json) {
    return DecodeRequest(
      bodies: json.valueAsList<List<String>?>('bodies'),
      opcodes: json.valueAsList<List<String>?>('opcodes'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) =>
      config.encodeMap(<String, dynamic>{'bodies': bodies, 'opcodes': opcodes});
}

class DecodeResponse {
  final List<Map<String, dynamic>>? bodies;
  final List<String>? opcodes;

  const DecodeResponse({this.bodies, this.opcodes});

  factory DecodeResponse.fromJson(Map<String, dynamic> json) {
    return DecodeResponse(
      bodies:
          json.hasValue('bodies')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('bodies')
                  .map((e) => Map<String, dynamic>.from(e as Map))
                  .toList()
              : null,
      opcodes: json.valueAsList<List<String>?>('opcodes'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) =>
      config.encodeMap(<String, dynamic>{'bodies': bodies, 'opcodes': opcodes});
}

class GenericAddressBook {
  final Map<String, AddressBookRow> values;
  const GenericAddressBook(this.values);

  factory GenericAddressBook.fromJson(Map<String, dynamic> json) =>
      GenericAddressBook(
        json.map(
          (k, v) =>
              MapEntry(k, AddressBookRow.fromJson(v as Map<String, dynamic>)),
        ),
      );

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(
    values.map((k, v) => MapEntry(k, v.toJson(config: config))),
  );
}

class JettonBurn {
  final String? amount;
  final String? customPayload;
  final Map<String, dynamic>? decodedCustomPayload;
  final String? jettonMaster;
  final String? jettonWallet;
  final String? owner;
  final String? queryId;
  final String? responseDestination;
  final String? traceId;
  final bool? transactionAborted;
  final String? transactionHash;
  final String? transactionLt;
  final int? transactionNow;

  const JettonBurn({
    this.amount,
    this.customPayload,
    this.decodedCustomPayload,
    this.jettonMaster,
    this.jettonWallet,
    this.owner,
    this.queryId,
    this.responseDestination,
    this.traceId,
    this.transactionAborted,
    this.transactionHash,
    this.transactionLt,
    this.transactionNow,
  });

  factory JettonBurn.fromJson(Map<String, dynamic> json) {
    return JettonBurn(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String?>('amount')),
      customPayload:
          (json['custom_payload'] is num
              ? json['custom_payload'].toString()
              : json.valueAsString<String?>('custom_payload')),
      decodedCustomPayload: json.valueAsMap<Map<String, dynamic>?>(
        'decoded_custom_payload',
      ),
      jettonMaster:
          (json['jetton_master'] is num
              ? json['jetton_master'].toString()
              : json.valueAsString<String?>('jetton_master')),
      jettonWallet:
          (json['jetton_wallet'] is num
              ? json['jetton_wallet'].toString()
              : json.valueAsString<String?>('jetton_wallet')),
      owner:
          (json['owner'] is num
              ? json['owner'].toString()
              : json.valueAsString<String?>('owner')),
      queryId:
          (json['query_id'] is num
              ? json['query_id'].toString()
              : json.valueAsString<String?>('query_id')),
      responseDestination:
          (json['response_destination'] is num
              ? json['response_destination'].toString()
              : json.valueAsString<String?>('response_destination')),
      traceId:
          (json['trace_id'] is num
              ? json['trace_id'].toString()
              : json.valueAsString<String?>('trace_id')),
      transactionAborted: json.valueAsBool<bool?>('transaction_aborted'),
      transactionHash:
          (json['transaction_hash'] is num
              ? json['transaction_hash'].toString()
              : json.valueAsString<String?>('transaction_hash')),
      transactionLt:
          (json['transaction_lt'] is num
              ? json['transaction_lt'].toString()
              : json.valueAsString<String?>('transaction_lt')),
      transactionNow: json.valueAsInt<int?>('transaction_now'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'custom_payload': customPayload,
    'decoded_custom_payload': decodedCustomPayload,
    'jetton_master': jettonMaster,
    'jetton_wallet': jettonWallet,
    'owner': owner,
    'query_id': queryId,
    'response_destination': responseDestination,
    'trace_id': traceId,
    'transaction_aborted': transactionAborted,
    'transaction_hash': transactionHash,
    'transaction_lt': transactionLt,
    'transaction_now': transactionNow,
  });
}

class JettonBurnsResponse {
  final AddressBook? addressBook;
  final List<JettonBurn>? jettonBurns;
  final Metadata? metadata;

  const JettonBurnsResponse({
    this.addressBook,
    this.jettonBurns,
    this.metadata,
  });

  factory JettonBurnsResponse.fromJson(Map<String, dynamic> json) {
    return JettonBurnsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      jettonBurns:
          json.hasValue('jetton_burns')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('jetton_burns')
                  .map((e) => JettonBurn.fromJson(e))
                  .toList()
              : null,
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'jetton_burns': jettonBurns?.map((e) => e.toJson(config: config)).toList(),
    'metadata': metadata?.toJson(config: config),
  });
}

class JettonMaster {
  final String? address;
  final String? adminAddress;
  final String? codeHash;
  final String? dataHash;
  final Map<String, dynamic>? jettonContent;
  final String? jettonWalletCodeHash;
  final String? lastTransactionLt;
  final bool? mintable;
  final String? totalSupply;

  const JettonMaster({
    this.address,
    this.adminAddress,
    this.codeHash,
    this.dataHash,
    this.jettonContent,
    this.jettonWalletCodeHash,
    this.lastTransactionLt,
    this.mintable,
    this.totalSupply,
  });

  factory JettonMaster.fromJson(Map<String, dynamic> json) {
    return JettonMaster(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      adminAddress:
          (json['admin_address'] is num
              ? json['admin_address'].toString()
              : json.valueAsString<String?>('admin_address')),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String?>('code_hash')),
      dataHash:
          (json['data_hash'] is num
              ? json['data_hash'].toString()
              : json.valueAsString<String?>('data_hash')),
      jettonContent: json.valueAsMap<Map<String, dynamic>?>('jetton_content'),
      jettonWalletCodeHash:
          (json['jetton_wallet_code_hash'] is num
              ? json['jetton_wallet_code_hash'].toString()
              : json.valueAsString<String?>('jetton_wallet_code_hash')),
      lastTransactionLt:
          (json['last_transaction_lt'] is num
              ? json['last_transaction_lt'].toString()
              : json.valueAsString<String?>('last_transaction_lt')),
      mintable: json.valueAsBool<bool?>('mintable'),
      totalSupply:
          (json['total_supply'] is num
              ? json['total_supply'].toString()
              : json.valueAsString<String?>('total_supply')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'admin_address': adminAddress,
    'code_hash': codeHash,
    'data_hash': dataHash,
    'jetton_content': jettonContent,
    'jetton_wallet_code_hash': jettonWalletCodeHash,
    'last_transaction_lt': lastTransactionLt,
    'mintable': mintable,
    'total_supply': totalSupply,
  });
}

class JettonMastersResponse {
  final AddressBook? addressBook;
  final List<JettonMaster>? jettonMasters;
  final Metadata? metadata;

  const JettonMastersResponse({
    this.addressBook,
    this.jettonMasters,
    this.metadata,
  });

  factory JettonMastersResponse.fromJson(Map<String, dynamic> json) {
    return JettonMastersResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      jettonMasters:
          json.hasValue('jetton_masters')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('jetton_masters')
                  .map((e) => JettonMaster.fromJson(e))
                  .toList()
              : null,
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'jetton_masters':
        jettonMasters?.map((e) => e.toJson(config: config)).toList(),
    'metadata': metadata?.toJson(config: config),
  });
}

class JettonTransfer {
  final String? amount;
  final String? customPayload;
  final Map<String, dynamic>? decodedCustomPayload;
  final Map<String, dynamic>? decodedForwardPayload;
  final String? destination;
  final String? forwardPayload;
  final String? forwardTonAmount;
  final String? jettonMaster;
  final String? queryId;
  final String? responseDestination;
  final String? source;
  final String? sourceWallet;
  final String? traceId;
  final bool? transactionAborted;
  final String? transactionHash;
  final String? transactionLt;
  final int? transactionNow;

  const JettonTransfer({
    this.amount,
    this.customPayload,
    this.decodedCustomPayload,
    this.decodedForwardPayload,
    this.destination,
    this.forwardPayload,
    this.forwardTonAmount,
    this.jettonMaster,
    this.queryId,
    this.responseDestination,
    this.source,
    this.sourceWallet,
    this.traceId,
    this.transactionAborted,
    this.transactionHash,
    this.transactionLt,
    this.transactionNow,
  });

  factory JettonTransfer.fromJson(Map<String, dynamic> json) {
    return JettonTransfer(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String?>('amount')),
      customPayload:
          (json['custom_payload'] is num
              ? json['custom_payload'].toString()
              : json.valueAsString<String?>('custom_payload')),
      decodedCustomPayload: json.valueAsMap<Map<String, dynamic>?>(
        'decoded_custom_payload',
      ),
      decodedForwardPayload: json.valueAsMap<Map<String, dynamic>?>(
        'decoded_forward_payload',
      ),
      destination:
          (json['destination'] is num
              ? json['destination'].toString()
              : json.valueAsString<String?>('destination')),
      forwardPayload:
          (json['forward_payload'] is num
              ? json['forward_payload'].toString()
              : json.valueAsString<String?>('forward_payload')),
      forwardTonAmount:
          (json['forward_ton_amount'] is num
              ? json['forward_ton_amount'].toString()
              : json.valueAsString<String?>('forward_ton_amount')),
      jettonMaster:
          (json['jetton_master'] is num
              ? json['jetton_master'].toString()
              : json.valueAsString<String?>('jetton_master')),
      queryId:
          (json['query_id'] is num
              ? json['query_id'].toString()
              : json.valueAsString<String?>('query_id')),
      responseDestination:
          (json['response_destination'] is num
              ? json['response_destination'].toString()
              : json.valueAsString<String?>('response_destination')),
      source:
          (json['source'] is num
              ? json['source'].toString()
              : json.valueAsString<String?>('source')),
      sourceWallet:
          (json['source_wallet'] is num
              ? json['source_wallet'].toString()
              : json.valueAsString<String?>('source_wallet')),
      traceId:
          (json['trace_id'] is num
              ? json['trace_id'].toString()
              : json.valueAsString<String?>('trace_id')),
      transactionAborted: json.valueAsBool<bool?>('transaction_aborted'),
      transactionHash:
          (json['transaction_hash'] is num
              ? json['transaction_hash'].toString()
              : json.valueAsString<String?>('transaction_hash')),
      transactionLt:
          (json['transaction_lt'] is num
              ? json['transaction_lt'].toString()
              : json.valueAsString<String?>('transaction_lt')),
      transactionNow: json.valueAsInt<int?>('transaction_now'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'custom_payload': customPayload,
    'decoded_custom_payload': decodedCustomPayload,
    'decoded_forward_payload': decodedForwardPayload,
    'destination': destination,
    'forward_payload': forwardPayload,
    'forward_ton_amount': forwardTonAmount,
    'jetton_master': jettonMaster,
    'query_id': queryId,
    'response_destination': responseDestination,
    'source': source,
    'source_wallet': sourceWallet,
    'trace_id': traceId,
    'transaction_aborted': transactionAborted,
    'transaction_hash': transactionHash,
    'transaction_lt': transactionLt,
    'transaction_now': transactionNow,
  });
}

class JettonTransfersResponse {
  final AddressBook? addressBook;
  final List<JettonTransfer>? jettonTransfers;
  final Metadata? metadata;

  const JettonTransfersResponse({
    this.addressBook,
    this.jettonTransfers,
    this.metadata,
  });

  factory JettonTransfersResponse.fromJson(Map<String, dynamic> json) {
    return JettonTransfersResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      jettonTransfers:
          json.hasValue('jetton_transfers')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('jetton_transfers')
                  .map((e) => JettonTransfer.fromJson(e))
                  .toList()
              : null,
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'jetton_transfers':
        jettonTransfers?.map((e) => e.toJson(config: config)).toList(),
    'metadata': metadata?.toJson(config: config),
  });
}

class JettonWallet {
  final String? address;
  final String? balance;
  final String? codeHash;
  final String? dataHash;
  final String? jetton;
  final String? lastTransactionLt;
  final JettonWalletMintlessInfo? mintlessInfo;
  final String? owner;

  const JettonWallet({
    this.address,
    this.balance,
    this.codeHash,
    this.dataHash,
    this.jetton,
    this.lastTransactionLt,
    this.mintlessInfo,
    this.owner,
  });

  factory JettonWallet.fromJson(Map<String, dynamic> json) {
    return JettonWallet(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String?>('balance')),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String?>('code_hash')),
      dataHash:
          (json['data_hash'] is num
              ? json['data_hash'].toString()
              : json.valueAsString<String?>('data_hash')),
      jetton:
          (json['jetton'] is num
              ? json['jetton'].toString()
              : json.valueAsString<String?>('jetton')),
      lastTransactionLt:
          (json['last_transaction_lt'] is num
              ? json['last_transaction_lt'].toString()
              : json.valueAsString<String?>('last_transaction_lt')),
      mintlessInfo: json
          .valueTo<JettonWalletMintlessInfo?, Map<String, dynamic>>(
            key: 'mintless_info',
            parse: (v) => JettonWalletMintlessInfo.fromJson(v),
          ),
      owner:
          (json['owner'] is num
              ? json['owner'].toString()
              : json.valueAsString<String?>('owner')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'balance': balance,
    'code_hash': codeHash,
    'data_hash': dataHash,
    'jetton': jetton,
    'last_transaction_lt': lastTransactionLt,
    'mintless_info': mintlessInfo?.toJson(config: config),
    'owner': owner,
  });
}

class JettonWalletMintlessInfo {
  final String? amount;
  final List<String>? customPayloadApiUri;
  final int? expireAt;
  final int? startFrom;

  const JettonWalletMintlessInfo({
    this.amount,
    this.customPayloadApiUri,
    this.expireAt,
    this.startFrom,
  });

  factory JettonWalletMintlessInfo.fromJson(Map<String, dynamic> json) {
    return JettonWalletMintlessInfo(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String?>('amount')),
      customPayloadApiUri: json.valueAsList<List<String>?>(
        'custom_payload_api_uri',
      ),
      expireAt: json.valueAsInt<int?>('expire_at'),
      startFrom: json.valueAsInt<int?>('start_from'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'custom_payload_api_uri': customPayloadApiUri,
    'expire_at': expireAt,
    'start_from': startFrom,
  });
}

class JettonWalletsResponse {
  final AddressBook? addressBook;
  final List<JettonWallet>? jettonWallets;
  final Metadata? metadata;

  const JettonWalletsResponse({
    this.addressBook,
    this.jettonWallets,
    this.metadata,
  });

  factory JettonWalletsResponse.fromJson(Map<String, dynamic> json) {
    return JettonWalletsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      jettonWallets:
          json.hasValue('jetton_wallets')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('jetton_wallets')
                  .map((e) => JettonWallet.fromJson(e))
                  .toList()
              : null,
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'jetton_wallets':
        jettonWallets?.map((e) => e.toJson(config: config)).toList(),
    'metadata': metadata?.toJson(config: config),
  });
}

class MasterchainInfo {
  final Block? first;
  final Block? last;

  const MasterchainInfo({this.first, this.last});

  factory MasterchainInfo.fromJson(Map<String, dynamic> json) {
    return MasterchainInfo(
      first: json.valueTo<Block?, Map<String, dynamic>>(
        key: 'first',
        parse: (v) => Block.fromJson(v),
      ),
      last: json.valueTo<Block?, Map<String, dynamic>>(
        key: 'last',
        parse: (v) => Block.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'first': first?.toJson(config: config),
    'last': last?.toJson(config: config),
  });
}

class Message {
  final bool? bounce;
  final bool? bounced;
  final String? createdAt;
  final String? createdLt;
  final String? decodedOpcode;
  final String? destination;
  final String? extraFlags;
  final String? fwdFee;
  final String? hash;
  final String? hashNorm;
  final bool? ihrDisabled;
  final String? ihrFee;
  final String? importFee;
  final String? inMsgTxHash;
  final MessageContent? initState;
  final MessageContent? messageContent;
  final int? opcode;
  final String? outMsgTxHash;
  final String? source;
  final String? value;
  final Map<String, String>? valueExtraCurrencies;

  const Message({
    this.bounce,
    this.bounced,
    this.createdAt,
    this.createdLt,
    this.decodedOpcode,
    this.destination,
    this.extraFlags,
    this.fwdFee,
    this.hash,
    this.hashNorm,
    this.ihrDisabled,
    this.ihrFee,
    this.importFee,
    this.inMsgTxHash,
    this.initState,
    this.messageContent,
    this.opcode,
    this.outMsgTxHash,
    this.source,
    this.value,
    this.valueExtraCurrencies,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      bounce: json.valueAsBool<bool?>('bounce'),
      bounced: json.valueAsBool<bool?>('bounced'),
      createdAt:
          (json['created_at'] is num
              ? json['created_at'].toString()
              : json.valueAsString<String?>('created_at')),
      createdLt:
          (json['created_lt'] is num
              ? json['created_lt'].toString()
              : json.valueAsString<String?>('created_lt')),
      decodedOpcode:
          (json['decoded_opcode'] is num
              ? json['decoded_opcode'].toString()
              : json.valueAsString<String?>('decoded_opcode')),
      destination:
          (json['destination'] is num
              ? json['destination'].toString()
              : json.valueAsString<String?>('destination')),
      extraFlags:
          (json['extra_flags'] is num
              ? json['extra_flags'].toString()
              : json.valueAsString<String?>('extra_flags')),
      fwdFee:
          (json['fwd_fee'] is num
              ? json['fwd_fee'].toString()
              : json.valueAsString<String?>('fwd_fee')),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String?>('hash')),
      hashNorm:
          (json['hash_norm'] is num
              ? json['hash_norm'].toString()
              : json.valueAsString<String?>('hash_norm')),
      ihrDisabled: json.valueAsBool<bool?>('ihr_disabled'),
      ihrFee:
          (json['ihr_fee'] is num
              ? json['ihr_fee'].toString()
              : json.valueAsString<String?>('ihr_fee')),
      importFee:
          (json['import_fee'] is num
              ? json['import_fee'].toString()
              : json.valueAsString<String?>('import_fee')),
      inMsgTxHash:
          (json['in_msg_tx_hash'] is num
              ? json['in_msg_tx_hash'].toString()
              : json.valueAsString<String?>('in_msg_tx_hash')),
      initState: json.valueTo<MessageContent?, Map<String, dynamic>>(
        key: 'init_state',
        parse: (v) => MessageContent.fromJson(v),
      ),
      messageContent: json.valueTo<MessageContent?, Map<String, dynamic>>(
        key: 'message_content',
        parse: (v) => MessageContent.fromJson(v),
      ),
      opcode: json.valueAsInt<int?>('opcode'),
      outMsgTxHash:
          (json['out_msg_tx_hash'] is num
              ? json['out_msg_tx_hash'].toString()
              : json.valueAsString<String?>('out_msg_tx_hash')),
      source:
          (json['source'] is num
              ? json['source'].toString()
              : json.valueAsString<String?>('source')),
      value:
          (json['value'] is num
              ? json['value'].toString()
              : json.valueAsString<String?>('value')),
      valueExtraCurrencies:
          json.hasValue('value_extra_currencies')
              ? json
                  .valueEnsureAsMap<String, dynamic>('value_extra_currencies')
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
    'bounce': bounce,
    'bounced': bounced,
    'created_at': createdAt,
    'created_lt': createdLt,
    'decoded_opcode': decodedOpcode,
    'destination': destination,
    'extra_flags': extraFlags,
    'fwd_fee': fwdFee,
    'hash': hash,
    'hash_norm': hashNorm,
    'ihr_disabled': ihrDisabled,
    'ihr_fee': ihrFee,
    'import_fee': importFee,
    'in_msg_tx_hash': inMsgTxHash,
    'init_state': initState?.toJson(config: config),
    'message_content': messageContent?.toJson(config: config),
    'opcode': opcode,
    'out_msg_tx_hash': outMsgTxHash,
    'source': source,
    'value': value,
    'value_extra_currencies': valueExtraCurrencies,
  });
}

class MessageContent {
  final String? body;
  final Map<String, dynamic>? decoded;
  final String? hash;

  const MessageContent({this.body, this.decoded, this.hash});

  factory MessageContent.fromJson(Map<String, dynamic> json) {
    return MessageContent(
      body:
          (json['body'] is num
              ? json['body'].toString()
              : json.valueAsString<String?>('body')),
      decoded: json.valueAsMap<Map<String, dynamic>?>('decoded'),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String?>('hash')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'body': body,
    'decoded': decoded,
    'hash': hash,
  });
}

class MessagesResponse {
  final AddressBook? addressBook;
  final List<Message>? messages;
  final Metadata? metadata;

  const MessagesResponse({this.addressBook, this.messages, this.metadata});

  factory MessagesResponse.fromJson(Map<String, dynamic> json) {
    return MessagesResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      messages:
          json.hasValue('messages')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('messages')
                  .map((e) => Message.fromJson(e))
                  .toList()
              : null,
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'messages': messages?.map((e) => e.toJson(config: config)).toList(),
    'metadata': metadata?.toJson(config: config),
  });
}

class Metadata {
  final Map<String, AddressMetadata> values;
  const Metadata(this.values);

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
    json.map(
      (k, v) =>
          MapEntry(k, AddressMetadata.fromJson(v as Map<String, dynamic>)),
    ),
  );

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(
    values.map((k, v) => MapEntry(k, v.toJson(config: config))),
  );
}

class MsgSize {
  final String? bits;
  final String? cells;

  const MsgSize({this.bits, this.cells});

  factory MsgSize.fromJson(Map<String, dynamic> json) {
    return MsgSize(
      bits:
          (json['bits'] is num
              ? json['bits'].toString()
              : json.valueAsString<String?>('bits')),
      cells:
          (json['cells'] is num
              ? json['cells'].toString()
              : json.valueAsString<String?>('cells')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'bits': bits, 'cells': cells});
}

class Multisig {
  final String? address;
  final String? codeHash;
  final String? dataHash;
  final String? lastTransactionLt;
  final String? nextOrderSeqno;
  final List<MultisigOrder>? orders;
  final List<String>? proposers;
  final List<String>? signers;
  final int? threshold;

  const Multisig({
    this.address,
    this.codeHash,
    this.dataHash,
    this.lastTransactionLt,
    this.nextOrderSeqno,
    this.orders,
    this.proposers,
    this.signers,
    this.threshold,
  });

  factory Multisig.fromJson(Map<String, dynamic> json) {
    return Multisig(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String?>('code_hash')),
      dataHash:
          (json['data_hash'] is num
              ? json['data_hash'].toString()
              : json.valueAsString<String?>('data_hash')),
      lastTransactionLt:
          (json['last_transaction_lt'] is num
              ? json['last_transaction_lt'].toString()
              : json.valueAsString<String?>('last_transaction_lt')),
      nextOrderSeqno:
          (json['next_order_seqno'] is num
              ? json['next_order_seqno'].toString()
              : json.valueAsString<String?>('next_order_seqno')),
      orders:
          json.hasValue('orders')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('orders')
                  .map((e) => MultisigOrder.fromJson(e))
                  .toList()
              : null,
      proposers: json.valueAsList<List<String>?>('proposers'),
      signers: json.valueAsList<List<String>?>('signers'),
      threshold: json.valueAsInt<int?>('threshold'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'code_hash': codeHash,
    'data_hash': dataHash,
    'last_transaction_lt': lastTransactionLt,
    'next_order_seqno': nextOrderSeqno,
    'orders': orders?.map((e) => e.toJson(config: config)).toList(),
    'proposers': proposers,
    'signers': signers,
    'threshold': threshold,
  });
}

class MultisigOrder {
  final List<ModelsOrderAction>? actions;
  final String? address;
  final String? approvalsMask;
  final int? approvalsNum;
  final String? codeHash;
  final String? dataHash;
  final int? expirationDate;
  final String? lastTransactionLt;
  final String? multisigAddress;
  final String? orderBoc;
  final String? orderSeqno;
  final bool? sentForExecution;
  final List<String>? signers;
  final int? threshold;

  const MultisigOrder({
    this.actions,
    this.address,
    this.approvalsMask,
    this.approvalsNum,
    this.codeHash,
    this.dataHash,
    this.expirationDate,
    this.lastTransactionLt,
    this.multisigAddress,
    this.orderBoc,
    this.orderSeqno,
    this.sentForExecution,
    this.signers,
    this.threshold,
  });

  factory MultisigOrder.fromJson(Map<String, dynamic> json) {
    return MultisigOrder(
      actions:
          json.hasValue('actions')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('actions')
                  .map((e) => ModelsOrderAction.fromJson(e))
                  .toList()
              : null,
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      approvalsMask:
          (json['approvals_mask'] is num
              ? json['approvals_mask'].toString()
              : json.valueAsString<String?>('approvals_mask')),
      approvalsNum: json.valueAsInt<int?>('approvals_num'),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String?>('code_hash')),
      dataHash:
          (json['data_hash'] is num
              ? json['data_hash'].toString()
              : json.valueAsString<String?>('data_hash')),
      expirationDate: json.valueAsInt<int?>('expiration_date'),
      lastTransactionLt:
          (json['last_transaction_lt'] is num
              ? json['last_transaction_lt'].toString()
              : json.valueAsString<String?>('last_transaction_lt')),
      multisigAddress:
          (json['multisig_address'] is num
              ? json['multisig_address'].toString()
              : json.valueAsString<String?>('multisig_address')),
      orderBoc:
          (json['order_boc'] is num
              ? json['order_boc'].toString()
              : json.valueAsString<String?>('order_boc')),
      orderSeqno:
          (json['order_seqno'] is num
              ? json['order_seqno'].toString()
              : json.valueAsString<String?>('order_seqno')),
      sentForExecution: json.valueAsBool<bool?>('sent_for_execution'),
      signers: json.valueAsList<List<String>?>('signers'),
      threshold: json.valueAsInt<int?>('threshold'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'actions': actions?.map((e) => e.toJson(config: config)).toList(),
    'address': address,
    'approvals_mask': approvalsMask,
    'approvals_num': approvalsNum,
    'code_hash': codeHash,
    'data_hash': dataHash,
    'expiration_date': expirationDate,
    'last_transaction_lt': lastTransactionLt,
    'multisig_address': multisigAddress,
    'order_boc': orderBoc,
    'order_seqno': orderSeqno,
    'sent_for_execution': sentForExecution,
    'signers': signers,
    'threshold': threshold,
  });
}

class MultisigOrderResponse {
  final AddressBook? addressBook;
  final List<MultisigOrder>? orders;

  const MultisigOrderResponse({this.addressBook, this.orders});

  factory MultisigOrderResponse.fromJson(Map<String, dynamic> json) {
    return MultisigOrderResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      orders:
          json.hasValue('orders')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('orders')
                  .map((e) => MultisigOrder.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'orders': orders?.map((e) => e.toJson(config: config)).toList(),
  });
}

class MultisigResponse {
  final AddressBook? addressBook;
  final List<Multisig>? multisigs;

  const MultisigResponse({this.addressBook, this.multisigs});

  factory MultisigResponse.fromJson(Map<String, dynamic> json) {
    return MultisigResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      multisigs:
          json.hasValue('multisigs')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('multisigs')
                  .map((e) => Multisig.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'multisigs': multisigs?.map((e) => e.toJson(config: config)).toList(),
  });
}

class NFTCollection {
  final String? address;
  final String? codeHash;
  final Map<String, dynamic>? collectionContent;
  final String? dataHash;
  final String? lastTransactionLt;
  final String? nextItemIndex;
  final String? ownerAddress;

  const NFTCollection({
    this.address,
    this.codeHash,
    this.collectionContent,
    this.dataHash,
    this.lastTransactionLt,
    this.nextItemIndex,
    this.ownerAddress,
  });

  factory NFTCollection.fromJson(Map<String, dynamic> json) {
    return NFTCollection(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String?>('code_hash')),
      collectionContent: json.valueAsMap<Map<String, dynamic>?>(
        'collection_content',
      ),
      dataHash:
          (json['data_hash'] is num
              ? json['data_hash'].toString()
              : json.valueAsString<String?>('data_hash')),
      lastTransactionLt:
          (json['last_transaction_lt'] is num
              ? json['last_transaction_lt'].toString()
              : json.valueAsString<String?>('last_transaction_lt')),
      nextItemIndex:
          (json['next_item_index'] is num
              ? json['next_item_index'].toString()
              : json.valueAsString<String?>('next_item_index')),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString<String?>('owner_address')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'code_hash': codeHash,
    'collection_content': collectionContent,
    'data_hash': dataHash,
    'last_transaction_lt': lastTransactionLt,
    'next_item_index': nextItemIndex,
    'owner_address': ownerAddress,
  });
}

class NFTCollectionsResponse {
  final AddressBook? addressBook;
  final Metadata? metadata;
  final List<NFTCollection>? nftCollections;

  const NFTCollectionsResponse({
    this.addressBook,
    this.metadata,
    this.nftCollections,
  });

  factory NFTCollectionsResponse.fromJson(Map<String, dynamic> json) {
    return NFTCollectionsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
      nftCollections:
          json.hasValue('nft_collections')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('nft_collections')
                  .map((e) => NFTCollection.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'metadata': metadata?.toJson(config: config),
    'nft_collections':
        nftCollections?.map((e) => e.toJson(config: config)).toList(),
  });
}

class NFTItem {
  final String? address;
  final String? auctionContractAddress;
  final String? codeHash;
  final NFTCollection? collection;
  final String? collectionAddress;
  final Map<String, dynamic>? content;
  final String? dataHash;
  final String? index;
  final bool? init;
  final String? lastTransactionLt;
  final bool? onSale;
  final String? ownerAddress;
  final String? realOwner;
  final String? saleContractAddress;

  const NFTItem({
    this.address,
    this.auctionContractAddress,
    this.codeHash,
    this.collection,
    this.collectionAddress,
    this.content,
    this.dataHash,
    this.index,
    this.init,
    this.lastTransactionLt,
    this.onSale,
    this.ownerAddress,
    this.realOwner,
    this.saleContractAddress,
  });

  factory NFTItem.fromJson(Map<String, dynamic> json) {
    return NFTItem(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      auctionContractAddress:
          (json['auction_contract_address'] is num
              ? json['auction_contract_address'].toString()
              : json.valueAsString<String?>('auction_contract_address')),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String?>('code_hash')),
      collection: json.valueTo<NFTCollection?, Map<String, dynamic>>(
        key: 'collection',
        parse: (v) => NFTCollection.fromJson(v),
      ),
      collectionAddress:
          (json['collection_address'] is num
              ? json['collection_address'].toString()
              : json.valueAsString<String?>('collection_address')),
      content: json.valueAsMap<Map<String, dynamic>?>('content'),
      dataHash:
          (json['data_hash'] is num
              ? json['data_hash'].toString()
              : json.valueAsString<String?>('data_hash')),
      index:
          (json['index'] is num
              ? json['index'].toString()
              : json.valueAsString<String?>('index')),
      init: json.valueAsBool<bool?>('init'),
      lastTransactionLt:
          (json['last_transaction_lt'] is num
              ? json['last_transaction_lt'].toString()
              : json.valueAsString<String?>('last_transaction_lt')),
      onSale: json.valueAsBool<bool?>('on_sale'),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString<String?>('owner_address')),
      realOwner:
          (json['real_owner'] is num
              ? json['real_owner'].toString()
              : json.valueAsString<String?>('real_owner')),
      saleContractAddress:
          (json['sale_contract_address'] is num
              ? json['sale_contract_address'].toString()
              : json.valueAsString<String?>('sale_contract_address')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'auction_contract_address': auctionContractAddress,
    'code_hash': codeHash,
    'collection': collection?.toJson(config: config),
    'collection_address': collectionAddress,
    'content': content,
    'data_hash': dataHash,
    'index': index,
    'init': init,
    'last_transaction_lt': lastTransactionLt,
    'on_sale': onSale,
    'owner_address': ownerAddress,
    'real_owner': realOwner,
    'sale_contract_address': saleContractAddress,
  });
}

class NFTItemsResponse {
  final AddressBook? addressBook;
  final Metadata? metadata;
  final List<NFTItem>? nftItems;

  const NFTItemsResponse({this.addressBook, this.metadata, this.nftItems});

  factory NFTItemsResponse.fromJson(Map<String, dynamic> json) {
    return NFTItemsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
      nftItems:
          json.hasValue('nft_items')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('nft_items')
                  .map((e) => NFTItem.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'metadata': metadata?.toJson(config: config),
    'nft_items': nftItems?.map((e) => e.toJson(config: config)).toList(),
  });
}

class NFTSale {
  final String? address;
  final String? codeHash;
  final int? createdAt;
  final String? dataHash;
  final dynamic details;
  final String? lastTransactionLt;
  final String? marketplaceAddress;
  final String? nftAddress;
  final NFTItem? nftItem;
  final String? nftOwnerAddress;
  final String? type;

  const NFTSale({
    this.address,
    this.codeHash,
    this.createdAt,
    this.dataHash,
    this.details,
    this.lastTransactionLt,
    this.marketplaceAddress,
    this.nftAddress,
    this.nftItem,
    this.nftOwnerAddress,
    this.type,
  });

  factory NFTSale.fromJson(Map<String, dynamic> json) {
    return NFTSale(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String?>('code_hash')),
      createdAt: json.valueAsInt<int?>('created_at'),
      dataHash:
          (json['data_hash'] is num
              ? json['data_hash'].toString()
              : json.valueAsString<String?>('data_hash')),
      details: json['details'],
      lastTransactionLt:
          (json['last_transaction_lt'] is num
              ? json['last_transaction_lt'].toString()
              : json.valueAsString<String?>('last_transaction_lt')),
      marketplaceAddress:
          (json['marketplace_address'] is num
              ? json['marketplace_address'].toString()
              : json.valueAsString<String?>('marketplace_address')),
      nftAddress:
          (json['nft_address'] is num
              ? json['nft_address'].toString()
              : json.valueAsString<String?>('nft_address')),
      nftItem: json.valueTo<NFTItem?, Map<String, dynamic>>(
        key: 'nft_item',
        parse: (v) => NFTItem.fromJson(v),
      ),
      nftOwnerAddress:
          (json['nft_owner_address'] is num
              ? json['nft_owner_address'].toString()
              : json.valueAsString<String?>('nft_owner_address')),
      type:
          (json['type'] is num
              ? json['type'].toString()
              : json.valueAsString<String?>('type')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'code_hash': codeHash,
    'created_at': createdAt,
    'data_hash': dataHash,
    'details': details,
    'last_transaction_lt': lastTransactionLt,
    'marketplace_address': marketplaceAddress,
    'nft_address': nftAddress,
    'nft_item': nftItem?.toJson(config: config),
    'nft_owner_address': nftOwnerAddress,
    'type': type,
  });
}

class NFTSalesResponse {
  final AddressBook? addressBook;
  final Metadata? metadata;
  final List<NFTSale>? nftSales;

  const NFTSalesResponse({this.addressBook, this.metadata, this.nftSales});

  factory NFTSalesResponse.fromJson(Map<String, dynamic> json) {
    return NFTSalesResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
      nftSales:
          json.hasValue('nft_sales')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('nft_sales')
                  .map((e) => NFTSale.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'metadata': metadata?.toJson(config: config),
    'nft_sales': nftSales?.map((e) => e.toJson(config: config)).toList(),
  });
}

class NFTTransfer {
  final String? customPayload;
  final Map<String, dynamic>? decodedCustomPayload;
  final Map<String, dynamic>? decodedForwardPayload;
  final String? forwardAmount;
  final String? forwardPayload;
  final String? newOwner;
  final String? nftAddress;
  final String? nftCollection;
  final String? oldOwner;
  final String? queryId;
  final String? responseDestination;
  final String? traceId;
  final bool? transactionAborted;
  final String? transactionHash;
  final String? transactionLt;
  final int? transactionNow;

  const NFTTransfer({
    this.customPayload,
    this.decodedCustomPayload,
    this.decodedForwardPayload,
    this.forwardAmount,
    this.forwardPayload,
    this.newOwner,
    this.nftAddress,
    this.nftCollection,
    this.oldOwner,
    this.queryId,
    this.responseDestination,
    this.traceId,
    this.transactionAborted,
    this.transactionHash,
    this.transactionLt,
    this.transactionNow,
  });

  factory NFTTransfer.fromJson(Map<String, dynamic> json) {
    return NFTTransfer(
      customPayload:
          (json['custom_payload'] is num
              ? json['custom_payload'].toString()
              : json.valueAsString<String?>('custom_payload')),
      decodedCustomPayload: json.valueAsMap<Map<String, dynamic>?>(
        'decoded_custom_payload',
      ),
      decodedForwardPayload: json.valueAsMap<Map<String, dynamic>?>(
        'decoded_forward_payload',
      ),
      forwardAmount:
          (json['forward_amount'] is num
              ? json['forward_amount'].toString()
              : json.valueAsString<String?>('forward_amount')),
      forwardPayload:
          (json['forward_payload'] is num
              ? json['forward_payload'].toString()
              : json.valueAsString<String?>('forward_payload')),
      newOwner:
          (json['new_owner'] is num
              ? json['new_owner'].toString()
              : json.valueAsString<String?>('new_owner')),
      nftAddress:
          (json['nft_address'] is num
              ? json['nft_address'].toString()
              : json.valueAsString<String?>('nft_address')),
      nftCollection:
          (json['nft_collection'] is num
              ? json['nft_collection'].toString()
              : json.valueAsString<String?>('nft_collection')),
      oldOwner:
          (json['old_owner'] is num
              ? json['old_owner'].toString()
              : json.valueAsString<String?>('old_owner')),
      queryId:
          (json['query_id'] is num
              ? json['query_id'].toString()
              : json.valueAsString<String?>('query_id')),
      responseDestination:
          (json['response_destination'] is num
              ? json['response_destination'].toString()
              : json.valueAsString<String?>('response_destination')),
      traceId:
          (json['trace_id'] is num
              ? json['trace_id'].toString()
              : json.valueAsString<String?>('trace_id')),
      transactionAborted: json.valueAsBool<bool?>('transaction_aborted'),
      transactionHash:
          (json['transaction_hash'] is num
              ? json['transaction_hash'].toString()
              : json.valueAsString<String?>('transaction_hash')),
      transactionLt:
          (json['transaction_lt'] is num
              ? json['transaction_lt'].toString()
              : json.valueAsString<String?>('transaction_lt')),
      transactionNow: json.valueAsInt<int?>('transaction_now'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'custom_payload': customPayload,
    'decoded_custom_payload': decodedCustomPayload,
    'decoded_forward_payload': decodedForwardPayload,
    'forward_amount': forwardAmount,
    'forward_payload': forwardPayload,
    'new_owner': newOwner,
    'nft_address': nftAddress,
    'nft_collection': nftCollection,
    'old_owner': oldOwner,
    'query_id': queryId,
    'response_destination': responseDestination,
    'trace_id': traceId,
    'transaction_aborted': transactionAborted,
    'transaction_hash': transactionHash,
    'transaction_lt': transactionLt,
    'transaction_now': transactionNow,
  });
}

class NFTTransfersResponse {
  final AddressBook? addressBook;
  final Metadata? metadata;
  final List<NFTTransfer>? nftTransfers;

  const NFTTransfersResponse({
    this.addressBook,
    this.metadata,
    this.nftTransfers,
  });

  factory NFTTransfersResponse.fromJson(Map<String, dynamic> json) {
    return NFTTransfersResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
      nftTransfers:
          json.hasValue('nft_transfers')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('nft_transfers')
                  .map((e) => NFTTransfer.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'metadata': metadata?.toJson(config: config),
    'nft_transfers':
        nftTransfers?.map((e) => e.toJson(config: config)).toList(),
  });
}

class NominatorPoolEvent {
  final String? amount;
  final String? balanceAfter;
  final String? balanceBefore;
  final String? balanceDelta;
  final String? nominatorAddress;
  final String? pendingBalanceAfter;
  final String? pendingBalanceBefore;
  final String? pendingBalanceDelta;
  final String? poolAddress;
  final String? txHash;
  final String? txLt;

  /// "reward", "deposit", "withdrawal", "pending_deposit_activation", "withdrawal_request"
  final NominatorPoolEventType? type;
  final int? utime;
  final bool? withdrawRequestAfter;
  final bool? withdrawRequestBefore;

  const NominatorPoolEvent({
    this.amount,
    this.balanceAfter,
    this.balanceBefore,
    this.balanceDelta,
    this.nominatorAddress,
    this.pendingBalanceAfter,
    this.pendingBalanceBefore,
    this.pendingBalanceDelta,
    this.poolAddress,
    this.txHash,
    this.txLt,
    this.type,
    this.utime,
    this.withdrawRequestAfter,
    this.withdrawRequestBefore,
  });

  factory NominatorPoolEvent.fromJson(Map<String, dynamic> json) {
    return NominatorPoolEvent(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String?>('amount')),
      balanceAfter:
          (json['balance_after'] is num
              ? json['balance_after'].toString()
              : json.valueAsString<String?>('balance_after')),
      balanceBefore:
          (json['balance_before'] is num
              ? json['balance_before'].toString()
              : json.valueAsString<String?>('balance_before')),
      balanceDelta:
          (json['balance_delta'] is num
              ? json['balance_delta'].toString()
              : json.valueAsString<String?>('balance_delta')),
      nominatorAddress:
          (json['nominator_address'] is num
              ? json['nominator_address'].toString()
              : json.valueAsString<String?>('nominator_address')),
      pendingBalanceAfter:
          (json['pending_balance_after'] is num
              ? json['pending_balance_after'].toString()
              : json.valueAsString<String?>('pending_balance_after')),
      pendingBalanceBefore:
          (json['pending_balance_before'] is num
              ? json['pending_balance_before'].toString()
              : json.valueAsString<String?>('pending_balance_before')),
      pendingBalanceDelta:
          (json['pending_balance_delta'] is num
              ? json['pending_balance_delta'].toString()
              : json.valueAsString<String?>('pending_balance_delta')),
      poolAddress:
          (json['pool_address'] is num
              ? json['pool_address'].toString()
              : json.valueAsString<String?>('pool_address')),
      txHash:
          (json['tx_hash'] is num
              ? json['tx_hash'].toString()
              : json.valueAsString<String?>('tx_hash')),
      txLt:
          (json['tx_lt'] is num
              ? json['tx_lt'].toString()
              : json.valueAsString<String?>('tx_lt')),
      type: json.valueTo<NominatorPoolEventType?, Object>(
        key: 'type',
        parse: (e) => NominatorPoolEventType.fromJson(JsonParser.valueAs(e)),
      ),
      utime: json.valueAsInt<int?>('utime'),
      withdrawRequestAfter: json.valueAsBool<bool?>('withdraw_request_after'),
      withdrawRequestBefore: json.valueAsBool<bool?>('withdraw_request_before'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'balance_after': balanceAfter,
    'balance_before': balanceBefore,
    'balance_delta': balanceDelta,
    'nominator_address': nominatorAddress,
    'pending_balance_after': pendingBalanceAfter,
    'pending_balance_before': pendingBalanceBefore,
    'pending_balance_delta': pendingBalanceDelta,
    'pool_address': poolAddress,
    'tx_hash': txHash,
    'tx_lt': txLt,
    'type': type?.toJson(config: config),
    'utime': utime,
    'withdraw_request_after': withdrawRequestAfter,
    'withdraw_request_before': withdrawRequestBefore,
  });
}

class NominatorPoolEventsResponse {
  final AddressBook? addressBook;
  final int? endUtime;
  final List<NominatorPoolEvent>? events;
  final int? startUtime;

  const NominatorPoolEventsResponse({
    this.addressBook,
    this.endUtime,
    this.events,
    this.startUtime,
  });

  factory NominatorPoolEventsResponse.fromJson(Map<String, dynamic> json) {
    return NominatorPoolEventsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      endUtime: json.valueAsInt<int?>('end_utime'),
      events:
          json.hasValue('events')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('events')
                  .map((e) => NominatorPoolEvent.fromJson(e))
                  .toList()
              : null,
      startUtime: json.valueAsInt<int?>('start_utime'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'end_utime': endUtime,
    'events': events?.map((e) => e.toJson(config: config)).toList(),
    'start_utime': startUtime,
  });
}

class NominatorPoolInfo {
  final List<ActiveNominatorInfo>? activeNominators;
  final AddressBook? addressBook;
  final int? maxNominatorsCount;
  final String? minNominatorStake;
  final String? minValidatorStake;
  final int? nominatorsCount;
  final String? stakeAmountSent;
  final int? state;
  final String? validatorAddress;
  final String? validatorAmount;
  final int? validatorRewardShare;

  const NominatorPoolInfo({
    this.activeNominators,
    this.addressBook,
    this.maxNominatorsCount,
    this.minNominatorStake,
    this.minValidatorStake,
    this.nominatorsCount,
    this.stakeAmountSent,
    this.state,
    this.validatorAddress,
    this.validatorAmount,
    this.validatorRewardShare,
  });

  factory NominatorPoolInfo.fromJson(Map<String, dynamic> json) {
    return NominatorPoolInfo(
      activeNominators:
          json.hasValue('active_nominators')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('active_nominators')
                  .map((e) => ActiveNominatorInfo.fromJson(e))
                  .toList()
              : null,
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      maxNominatorsCount: json.valueAsInt<int?>('max_nominators_count'),
      minNominatorStake:
          (json['min_nominator_stake'] is num
              ? json['min_nominator_stake'].toString()
              : json.valueAsString<String?>('min_nominator_stake')),
      minValidatorStake:
          (json['min_validator_stake'] is num
              ? json['min_validator_stake'].toString()
              : json.valueAsString<String?>('min_validator_stake')),
      nominatorsCount: json.valueAsInt<int?>('nominators_count'),
      stakeAmountSent:
          (json['stake_amount_sent'] is num
              ? json['stake_amount_sent'].toString()
              : json.valueAsString<String?>('stake_amount_sent')),
      state: json.valueAsInt<int?>('state'),
      validatorAddress:
          (json['validator_address'] is num
              ? json['validator_address'].toString()
              : json.valueAsString<String?>('validator_address')),
      validatorAmount:
          (json['validator_amount'] is num
              ? json['validator_amount'].toString()
              : json.valueAsString<String?>('validator_amount')),
      validatorRewardShare: json.valueAsInt<int?>('validator_reward_share'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'active_nominators':
        activeNominators?.map((e) => e.toJson(config: config)).toList(),
    'address_book': addressBook?.toJson(config: config),
    'max_nominators_count': maxNominatorsCount,
    'min_nominator_stake': minNominatorStake,
    'min_validator_stake': minValidatorStake,
    'nominators_count': nominatorsCount,
    'stake_amount_sent': stakeAmountSent,
    'state': state,
    'validator_address': validatorAddress,
    'validator_amount': validatorAmount,
    'validator_reward_share': validatorRewardShare,
  });
}

class NominatorPoolPosition {
  final String? balance;
  final String? pendingBalance;
  final String? poolAddress;

  const NominatorPoolPosition({
    this.balance,
    this.pendingBalance,
    this.poolAddress,
  });

  factory NominatorPoolPosition.fromJson(Map<String, dynamic> json) {
    return NominatorPoolPosition(
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String?>('balance')),
      pendingBalance:
          (json['pending_balance'] is num
              ? json['pending_balance'].toString()
              : json.valueAsString<String?>('pending_balance')),
      poolAddress:
          (json['pool_address'] is num
              ? json['pool_address'].toString()
              : json.valueAsString<String?>('pool_address')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'balance': balance,
    'pending_balance': pendingBalance,
    'pool_address': poolAddress,
  });
}

class NominatorPoolValidatorEvent {
  final String? amount;
  final String? balanceAfter;
  final String? balanceBefore;
  final String? balanceDelta;
  final int? cycleStart;
  final String? poolAddress;
  final String? queryId;
  final String? txHash;
  final String? txLt;

  /// "reward", "penalty", "deposit", "withdrawal"
  final NominatorPoolValidatorEventType? type;
  final int? utime;
  final String? validatorAddress;
  final int? validatorRewardShare;

  const NominatorPoolValidatorEvent({
    this.amount,
    this.balanceAfter,
    this.balanceBefore,
    this.balanceDelta,
    this.cycleStart,
    this.poolAddress,
    this.queryId,
    this.txHash,
    this.txLt,
    this.type,
    this.utime,
    this.validatorAddress,
    this.validatorRewardShare,
  });

  factory NominatorPoolValidatorEvent.fromJson(Map<String, dynamic> json) {
    return NominatorPoolValidatorEvent(
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String?>('amount')),
      balanceAfter:
          (json['balance_after'] is num
              ? json['balance_after'].toString()
              : json.valueAsString<String?>('balance_after')),
      balanceBefore:
          (json['balance_before'] is num
              ? json['balance_before'].toString()
              : json.valueAsString<String?>('balance_before')),
      balanceDelta:
          (json['balance_delta'] is num
              ? json['balance_delta'].toString()
              : json.valueAsString<String?>('balance_delta')),
      cycleStart: json.valueAsInt<int?>('cycle_start'),
      poolAddress:
          (json['pool_address'] is num
              ? json['pool_address'].toString()
              : json.valueAsString<String?>('pool_address')),
      queryId:
          (json['query_id'] is num
              ? json['query_id'].toString()
              : json.valueAsString<String?>('query_id')),
      txHash:
          (json['tx_hash'] is num
              ? json['tx_hash'].toString()
              : json.valueAsString<String?>('tx_hash')),
      txLt:
          (json['tx_lt'] is num
              ? json['tx_lt'].toString()
              : json.valueAsString<String?>('tx_lt')),
      type: json.valueTo<NominatorPoolValidatorEventType?, Object>(
        key: 'type',
        parse:
            (e) =>
                NominatorPoolValidatorEventType.fromJson(JsonParser.valueAs(e)),
      ),
      utime: json.valueAsInt<int?>('utime'),
      validatorAddress:
          (json['validator_address'] is num
              ? json['validator_address'].toString()
              : json.valueAsString<String?>('validator_address')),
      validatorRewardShare: json.valueAsInt<int?>('validator_reward_share'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'amount': amount,
    'balance_after': balanceAfter,
    'balance_before': balanceBefore,
    'balance_delta': balanceDelta,
    'cycle_start': cycleStart,
    'pool_address': poolAddress,
    'query_id': queryId,
    'tx_hash': txHash,
    'tx_lt': txLt,
    'type': type?.toJson(config: config),
    'utime': utime,
    'validator_address': validatorAddress,
    'validator_reward_share': validatorRewardShare,
  });
}

class NominatorPoolValidatorEventsResponse {
  final AddressBook? addressBook;
  final int? endUtime;
  final List<NominatorPoolValidatorEvent>? events;
  final int? startUtime;

  const NominatorPoolValidatorEventsResponse({
    this.addressBook,
    this.endUtime,
    this.events,
    this.startUtime,
  });

  factory NominatorPoolValidatorEventsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return NominatorPoolValidatorEventsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      endUtime: json.valueAsInt<int?>('end_utime'),
      events:
          json.hasValue('events')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('events')
                  .map((e) => NominatorPoolValidatorEvent.fromJson(e))
                  .toList()
              : null,
      startUtime: json.valueAsInt<int?>('start_utime'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'end_utime': endUtime,
    'events': events?.map((e) => e.toJson(config: config)).toList(),
    'start_utime': startUtime,
  });
}

class NominatorPoolValidatorReward {
  final String? balanceBefore;
  final int? cycleStart;
  final String? queryId;
  final String? reward;
  final String? txHash;
  final String? txLt;
  final int? utime;

  const NominatorPoolValidatorReward({
    this.balanceBefore,
    this.cycleStart,
    this.queryId,
    this.reward,
    this.txHash,
    this.txLt,
    this.utime,
  });

  factory NominatorPoolValidatorReward.fromJson(Map<String, dynamic> json) {
    return NominatorPoolValidatorReward(
      balanceBefore:
          (json['balance_before'] is num
              ? json['balance_before'].toString()
              : json.valueAsString<String?>('balance_before')),
      cycleStart: json.valueAsInt<int?>('cycle_start'),
      queryId:
          (json['query_id'] is num
              ? json['query_id'].toString()
              : json.valueAsString<String?>('query_id')),
      reward:
          (json['reward'] is num
              ? json['reward'].toString()
              : json.valueAsString<String?>('reward')),
      txHash:
          (json['tx_hash'] is num
              ? json['tx_hash'].toString()
              : json.valueAsString<String?>('tx_hash')),
      txLt:
          (json['tx_lt'] is num
              ? json['tx_lt'].toString()
              : json.valueAsString<String?>('tx_lt')),
      utime: json.valueAsInt<int?>('utime'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'balance_before': balanceBefore,
    'cycle_start': cycleStart,
    'query_id': queryId,
    'reward': reward,
    'tx_hash': txHash,
    'tx_lt': txLt,
    'utime': utime,
  });
}

class NominatorPoolValidatorRewardsResponse {
  final AddressBook? addressBook;
  final int? endUtime;
  final List<NominatorPoolValidatorReward>? rewards;
  final int? startUtime;
  final String? totalOnPage;

  const NominatorPoolValidatorRewardsResponse({
    this.addressBook,
    this.endUtime,
    this.rewards,
    this.startUtime,
    this.totalOnPage,
  });

  factory NominatorPoolValidatorRewardsResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return NominatorPoolValidatorRewardsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      endUtime: json.valueAsInt<int?>('end_utime'),
      rewards:
          json.hasValue('rewards')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('rewards')
                  .map((e) => NominatorPoolValidatorReward.fromJson(e))
                  .toList()
              : null,
      startUtime: json.valueAsInt<int?>('start_utime'),
      totalOnPage:
          (json['total_on_page'] is num
              ? json['total_on_page'].toString()
              : json.valueAsString<String?>('total_on_page')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'end_utime': endUtime,
    'rewards': rewards?.map((e) => e.toJson(config: config)).toList(),
    'start_utime': startUtime,
    'total_on_page': totalOnPage,
  });
}

class NominatorPoolsResponse {
  final AddressBook? addressBook;
  final List<NominatorPoolPosition>? nominatorPools;

  const NominatorPoolsResponse({this.addressBook, this.nominatorPools});

  factory NominatorPoolsResponse.fromJson(Map<String, dynamic> json) {
    return NominatorPoolsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      nominatorPools:
          json.hasValue('nominator_pools')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('nominator_pools')
                  .map((e) => NominatorPoolPosition.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'nominator_pools':
        nominatorPools?.map((e) => e.toJson(config: config)).toList(),
  });
}

class NominatorReward {
  final String? reward;
  final String? stakeBefore;
  final String? txHash;
  final String? txLt;
  final int? utime;

  const NominatorReward({
    this.reward,
    this.stakeBefore,
    this.txHash,
    this.txLt,
    this.utime,
  });

  factory NominatorReward.fromJson(Map<String, dynamic> json) {
    return NominatorReward(
      reward:
          (json['reward'] is num
              ? json['reward'].toString()
              : json.valueAsString<String?>('reward')),
      stakeBefore:
          (json['stake_before'] is num
              ? json['stake_before'].toString()
              : json.valueAsString<String?>('stake_before')),
      txHash:
          (json['tx_hash'] is num
              ? json['tx_hash'].toString()
              : json.valueAsString<String?>('tx_hash')),
      txLt:
          (json['tx_lt'] is num
              ? json['tx_lt'].toString()
              : json.valueAsString<String?>('tx_lt')),
      utime: json.valueAsInt<int?>('utime'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'reward': reward,
    'stake_before': stakeBefore,
    'tx_hash': txHash,
    'tx_lt': txLt,
    'utime': utime,
  });
}

class NominatorRewardsResponse {
  final AddressBook? addressBook;
  final int? endUtime;
  final List<NominatorReward>? rewards;
  final int? startUtime;
  final String? totalOnPage;

  const NominatorRewardsResponse({
    this.addressBook,
    this.endUtime,
    this.rewards,
    this.startUtime,
    this.totalOnPage,
  });

  factory NominatorRewardsResponse.fromJson(Map<String, dynamic> json) {
    return NominatorRewardsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      endUtime: json.valueAsInt<int?>('end_utime'),
      rewards:
          json.hasValue('rewards')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('rewards')
                  .map((e) => NominatorReward.fromJson(e))
                  .toList()
              : null,
      startUtime: json.valueAsInt<int?>('start_utime'),
      totalOnPage:
          (json['total_on_page'] is num
              ? json['total_on_page'].toString()
              : json.valueAsString<String?>('total_on_page')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'end_utime': endUtime,
    'rewards': rewards?.map((e) => e.toJson(config: config)).toList(),
    'start_utime': startUtime,
    'total_on_page': totalOnPage,
  });
}

class RequestError {
  final int? code;
  final String? error;

  const RequestError({this.code, this.error});

  factory RequestError.fromJson(Map<String, dynamic> json) {
    return RequestError(
      code: json.valueAsInt<int?>('code'),
      error:
          (json['error'] is num
              ? json['error'].toString()
              : json.valueAsString<String?>('error')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'code': code, 'error': error});
}

class SplitInfo {
  final int? accSplitDepth;
  final int? curShardPfxLen;
  final String? siblingAddr;
  final String? thisAddr;

  const SplitInfo({
    this.accSplitDepth,
    this.curShardPfxLen,
    this.siblingAddr,
    this.thisAddr,
  });

  factory SplitInfo.fromJson(Map<String, dynamic> json) {
    return SplitInfo(
      accSplitDepth: json.valueAsInt<int?>('acc_split_depth'),
      curShardPfxLen: json.valueAsInt<int?>('cur_shard_pfx_len'),
      siblingAddr:
          (json['sibling_addr'] is num
              ? json['sibling_addr'].toString()
              : json.valueAsString<String?>('sibling_addr')),
      thisAddr:
          (json['this_addr'] is num
              ? json['this_addr'].toString()
              : json.valueAsString<String?>('this_addr')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'acc_split_depth': accSplitDepth,
    'cur_shard_pfx_len': curShardPfxLen,
    'sibling_addr': siblingAddr,
    'this_addr': thisAddr,
  });
}

class StoragePhase {
  final String? statusChange;
  final String? storageFeesCollected;
  final String? storageFeesDue;

  const StoragePhase({
    this.statusChange,
    this.storageFeesCollected,
    this.storageFeesDue,
  });

  factory StoragePhase.fromJson(Map<String, dynamic> json) {
    return StoragePhase(
      statusChange:
          (json['status_change'] is num
              ? json['status_change'].toString()
              : json.valueAsString<String?>('status_change')),
      storageFeesCollected:
          (json['storage_fees_collected'] is num
              ? json['storage_fees_collected'].toString()
              : json.valueAsString<String?>('storage_fees_collected')),
      storageFeesDue:
          (json['storage_fees_due'] is num
              ? json['storage_fees_due'].toString()
              : json.valueAsString<String?>('storage_fees_due')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'status_change': statusChange,
    'storage_fees_collected': storageFeesCollected,
    'storage_fees_due': storageFeesDue,
  });
}

class TokenInfo {
  final String? description;
  final Map<String, dynamic>? extra;
  final String? image;
  final bool? isNsfw;
  final bool? isScam;
  final String? name;
  final String? nftIndex;
  final String? symbol;
  final String? type;
  final bool? valid;

  const TokenInfo({
    this.description,
    this.extra,
    this.image,
    this.isNsfw,
    this.isScam,
    this.name,
    this.nftIndex,
    this.symbol,
    this.type,
    this.valid,
  });

  factory TokenInfo.fromJson(Map<String, dynamic> json) {
    return TokenInfo(
      description:
          (json['description'] is num
              ? json['description'].toString()
              : json.valueAsString<String?>('description')),
      extra: json.valueAsMap<Map<String, dynamic>?>('extra'),
      image:
          (json['image'] is num
              ? json['image'].toString()
              : json.valueAsString<String?>('image')),
      isNsfw: json.valueAsBool<bool?>('is_nsfw'),
      isScam: json.valueAsBool<bool?>('is_scam'),
      name:
          (json['name'] is num
              ? json['name'].toString()
              : json.valueAsString<String?>('name')),
      nftIndex:
          (json['nft_index'] is num
              ? json['nft_index'].toString()
              : json.valueAsString<String?>('nft_index')),
      symbol:
          (json['symbol'] is num
              ? json['symbol'].toString()
              : json.valueAsString<String?>('symbol')),
      type:
          (json['type'] is num
              ? json['type'].toString()
              : json.valueAsString<String?>('type')),
      valid: json.valueAsBool<bool?>('valid'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'description': description,
    'extra': extra,
    'image': image,
    'is_nsfw': isNsfw,
    'is_scam': isScam,
    'name': name,
    'nft_index': nftIndex,
    'symbol': symbol,
    'type': type,
    'valid': valid,
  });
}

class Trace {
  final List<Action>? actions;
  final String? endLt;
  final int? endUtime;
  final String? externalHash;
  final bool? isIncomplete;
  final String? mcSeqnoEnd;
  final String? mcSeqnoStart;
  final String? startLt;
  final int? startUtime;
  final TraceNode? trace;
  final String? traceId;
  final TraceMeta? traceInfo;
  final Map<String, Transaction>? transactions;
  final List<String>? transactionsOrder;
  final String? warning;

  const Trace({
    this.actions,
    this.endLt,
    this.endUtime,
    this.externalHash,
    this.isIncomplete,
    this.mcSeqnoEnd,
    this.mcSeqnoStart,
    this.startLt,
    this.startUtime,
    this.trace,
    this.traceId,
    this.traceInfo,
    this.transactions,
    this.transactionsOrder,
    this.warning,
  });

  factory Trace.fromJson(Map<String, dynamic> json) {
    return Trace(
      actions:
          json.hasValue('actions')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('actions')
                  .map((e) => Action.fromJson(e))
                  .toList()
              : null,
      endLt:
          (json['end_lt'] is num
              ? json['end_lt'].toString()
              : json.valueAsString<String?>('end_lt')),
      endUtime: json.valueAsInt<int?>('end_utime'),
      externalHash:
          (json['external_hash'] is num
              ? json['external_hash'].toString()
              : json.valueAsString<String?>('external_hash')),
      isIncomplete: json.valueAsBool<bool?>('is_incomplete'),
      mcSeqnoEnd:
          (json['mc_seqno_end'] is num
              ? json['mc_seqno_end'].toString()
              : json.valueAsString<String?>('mc_seqno_end')),
      mcSeqnoStart:
          (json['mc_seqno_start'] is num
              ? json['mc_seqno_start'].toString()
              : json.valueAsString<String?>('mc_seqno_start')),
      startLt:
          (json['start_lt'] is num
              ? json['start_lt'].toString()
              : json.valueAsString<String?>('start_lt')),
      startUtime: json.valueAsInt<int?>('start_utime'),
      trace: json.valueTo<TraceNode?, Map<String, dynamic>>(
        key: 'trace',
        parse: (v) => TraceNode.fromJson(v),
      ),
      traceId:
          (json['trace_id'] is num
              ? json['trace_id'].toString()
              : json.valueAsString<String?>('trace_id')),
      traceInfo: json.valueTo<TraceMeta?, Map<String, dynamic>>(
        key: 'trace_info',
        parse: (v) => TraceMeta.fromJson(v),
      ),
      transactions:
          json.hasValue('transactions')
              ? json
                  .valueEnsureAsMap<String, dynamic>('transactions')
                  .map(
                    (k, v) => MapEntry(
                      k,
                      Transaction.fromJson(v as Map<String, dynamic>),
                    ),
                  )
              : null,
      transactionsOrder: json.valueAsList<List<String>?>('transactions_order'),
      warning:
          (json['warning'] is num
              ? json['warning'].toString()
              : json.valueAsString<String?>('warning')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'actions': actions?.map((e) => e.toJson(config: config)).toList(),
    'end_lt': endLt,
    'end_utime': endUtime,
    'external_hash': externalHash,
    'is_incomplete': isIncomplete,
    'mc_seqno_end': mcSeqnoEnd,
    'mc_seqno_start': mcSeqnoStart,
    'start_lt': startLt,
    'start_utime': startUtime,
    'trace': trace?.toJson(config: config),
    'trace_id': traceId,
    'trace_info': traceInfo?.toJson(config: config),
    'transactions': transactions?.map(
      (k, v) => MapEntry(k, v.toJson(config: config)),
    ),
    'transactions_order': transactionsOrder,
    'warning': warning,
  });
}

class TraceMeta {
  final String? classificationState;
  final int? messages;
  final int? pendingMessages;
  final String? traceState;
  final int? transactions;

  const TraceMeta({
    this.classificationState,
    this.messages,
    this.pendingMessages,
    this.traceState,
    this.transactions,
  });

  factory TraceMeta.fromJson(Map<String, dynamic> json) {
    return TraceMeta(
      classificationState:
          (json['classification_state'] is num
              ? json['classification_state'].toString()
              : json.valueAsString<String?>('classification_state')),
      messages: json.valueAsInt<int?>('messages'),
      pendingMessages: json.valueAsInt<int?>('pending_messages'),
      traceState:
          (json['trace_state'] is num
              ? json['trace_state'].toString()
              : json.valueAsString<String?>('trace_state')),
      transactions: json.valueAsInt<int?>('transactions'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'classification_state': classificationState,
    'messages': messages,
    'pending_messages': pendingMessages,
    'trace_state': traceState,
    'transactions': transactions,
  });
}

class TraceNode {
  final List<TraceNode>? children;
  final Message? inMsg;
  final String? inMsgHash;
  final Transaction? transaction;
  final String? txHash;

  const TraceNode({
    this.children,
    this.inMsg,
    this.inMsgHash,
    this.transaction,
    this.txHash,
  });

  factory TraceNode.fromJson(Map<String, dynamic> json) {
    return TraceNode(
      children:
          json.hasValue('children')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('children')
                  .map((e) => TraceNode.fromJson(e))
                  .toList()
              : null,
      inMsg: json.valueTo<Message?, Map<String, dynamic>>(
        key: 'in_msg',
        parse: (v) => Message.fromJson(v),
      ),
      inMsgHash:
          (json['in_msg_hash'] is num
              ? json['in_msg_hash'].toString()
              : json.valueAsString<String?>('in_msg_hash')),
      transaction: json.valueTo<Transaction?, Map<String, dynamic>>(
        key: 'transaction',
        parse: (v) => Transaction.fromJson(v),
      ),
      txHash:
          (json['tx_hash'] is num
              ? json['tx_hash'].toString()
              : json.valueAsString<String?>('tx_hash')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'children': children?.map((e) => e.toJson(config: config)).toList(),
    'in_msg': inMsg?.toJson(config: config),
    'in_msg_hash': inMsgHash,
    'transaction': transaction?.toJson(config: config),
    'tx_hash': txHash,
  });
}

class TracesResponse {
  final AddressBook? addressBook;
  final Metadata? metadata;
  final List<Trace>? traces;

  const TracesResponse({this.addressBook, this.metadata, this.traces});

  factory TracesResponse.fromJson(Map<String, dynamic> json) {
    return TracesResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
      traces:
          json.hasValue('traces')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('traces')
                  .map((e) => Trace.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'metadata': metadata?.toJson(config: config),
    'traces': traces?.map((e) => e.toJson(config: config)).toList(),
  });
}

class Transaction {
  final String? account;
  final AccountState? accountStateAfter;
  final AccountState? accountStateBefore;
  final BlockId? blockRef;
  final TransactionDescr? description;
  final bool? emulated;
  final String? endStatus;
  final ModelsFinalityState? finality;
  final String? hash;
  final Message? inMsg;
  final String? lt;
  final int? mcBlockSeqno;
  final int? now;
  final String? origStatus;
  final List<Message>? outMsgs;
  final String? prevTransHash;
  final String? prevTransLt;
  final String? totalFees;
  final Map<String, String>? totalFeesExtraCurrencies;
  final String? traceExternalHash;
  final String? traceId;

  const Transaction({
    this.account,
    this.accountStateAfter,
    this.accountStateBefore,
    this.blockRef,
    this.description,
    this.emulated,
    this.endStatus,
    this.finality,
    this.hash,
    this.inMsg,
    this.lt,
    this.mcBlockSeqno,
    this.now,
    this.origStatus,
    this.outMsgs,
    this.prevTransHash,
    this.prevTransLt,
    this.totalFees,
    this.totalFeesExtraCurrencies,
    this.traceExternalHash,
    this.traceId,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      account:
          (json['account'] is num
              ? json['account'].toString()
              : json.valueAsString<String?>('account')),
      accountStateAfter: json.valueTo<AccountState?, Map<String, dynamic>>(
        key: 'account_state_after',
        parse: (v) => AccountState.fromJson(v),
      ),
      accountStateBefore: json.valueTo<AccountState?, Map<String, dynamic>>(
        key: 'account_state_before',
        parse: (v) => AccountState.fromJson(v),
      ),
      blockRef: json.valueTo<BlockId?, Map<String, dynamic>>(
        key: 'block_ref',
        parse: (v) => BlockId.fromJson(v),
      ),
      description: json.valueTo<TransactionDescr?, Map<String, dynamic>>(
        key: 'description',
        parse: (v) => TransactionDescr.fromJson(v),
      ),
      emulated: json.valueAsBool<bool?>('emulated'),
      endStatus:
          (json['end_status'] is num
              ? json['end_status'].toString()
              : json.valueAsString<String?>('end_status')),
      finality:
          json['finality'] == null
              ? null
              : json.valueTo<ModelsFinalityState?, Object>(
                key: 'finality',
                parse:
                    (e) => ModelsFinalityState.fromJson(JsonParser.valueAs(e)),
              ),
      hash:
          (json['hash'] is num
              ? json['hash'].toString()
              : json.valueAsString<String?>('hash')),
      inMsg: json.valueTo<Message?, Map<String, dynamic>>(
        key: 'in_msg',
        parse: (v) => Message.fromJson(v),
      ),
      lt:
          (json['lt'] is num
              ? json['lt'].toString()
              : json.valueAsString<String?>('lt')),
      mcBlockSeqno: json.valueAsInt<int?>('mc_block_seqno'),
      now: json.valueAsInt<int?>('now'),
      origStatus:
          (json['orig_status'] is num
              ? json['orig_status'].toString()
              : json.valueAsString<String?>('orig_status')),
      outMsgs:
          json.hasValue('out_msgs')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('out_msgs')
                  .map((e) => Message.fromJson(e))
                  .toList()
              : null,
      prevTransHash:
          (json['prev_trans_hash'] is num
              ? json['prev_trans_hash'].toString()
              : json.valueAsString<String?>('prev_trans_hash')),
      prevTransLt:
          (json['prev_trans_lt'] is num
              ? json['prev_trans_lt'].toString()
              : json.valueAsString<String?>('prev_trans_lt')),
      totalFees:
          (json['total_fees'] is num
              ? json['total_fees'].toString()
              : json.valueAsString<String?>('total_fees')),
      totalFeesExtraCurrencies:
          json.hasValue('total_fees_extra_currencies')
              ? json
                  .valueEnsureAsMap<String, dynamic>(
                    'total_fees_extra_currencies',
                  )
                  .map(
                    (k, v) => MapEntry(
                      k,
                      (v is num
                          ? v.toString()
                          : JsonParser.valueAsString<String>(v)),
                    ),
                  )
              : null,
      traceExternalHash:
          (json['trace_external_hash'] is num
              ? json['trace_external_hash'].toString()
              : json.valueAsString<String?>('trace_external_hash')),
      traceId:
          (json['trace_id'] is num
              ? json['trace_id'].toString()
              : json.valueAsString<String?>('trace_id')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'account': account,
    'account_state_after': accountStateAfter?.toJson(config: config),
    'account_state_before': accountStateBefore?.toJson(config: config),
    'block_ref': blockRef?.toJson(config: config),
    'description': description?.toJson(config: config),
    'emulated': emulated,
    'end_status': endStatus,
    'finality': finality?.toJson(config: config),
    'hash': hash,
    'in_msg': inMsg?.toJson(config: config),
    'lt': lt,
    'mc_block_seqno': mcBlockSeqno,
    'now': now,
    'orig_status': origStatus,
    'out_msgs': outMsgs?.map((e) => e.toJson(config: config)).toList(),
    'prev_trans_hash': prevTransHash,
    'prev_trans_lt': prevTransLt,
    'total_fees': totalFees,
    'total_fees_extra_currencies': totalFeesExtraCurrencies,
    'trace_external_hash': traceExternalHash,
    'trace_id': traceId,
  });
}

class TransactionDescr {
  final bool? aborted;
  final ActionPhase? action;
  final BouncePhase? bounce;
  final ComputePhase? computePh;
  final bool? creditFirst;
  final CreditPhase? creditPh;
  final bool? destroyed;
  final bool? installed;
  final bool? isTock;
  final SplitInfo? splitInfo;
  final StoragePhase? storagePh;
  final String? type;

  const TransactionDescr({
    this.aborted,
    this.action,
    this.bounce,
    this.computePh,
    this.creditFirst,
    this.creditPh,
    this.destroyed,
    this.installed,
    this.isTock,
    this.splitInfo,
    this.storagePh,
    this.type,
  });

  factory TransactionDescr.fromJson(Map<String, dynamic> json) {
    return TransactionDescr(
      aborted: json.valueAsBool<bool?>('aborted'),
      action: json.valueTo<ActionPhase?, Map<String, dynamic>>(
        key: 'action',
        parse: (v) => ActionPhase.fromJson(v),
      ),
      bounce: json.valueTo<BouncePhase?, Map<String, dynamic>>(
        key: 'bounce',
        parse: (v) => BouncePhase.fromJson(v),
      ),
      computePh: json.valueTo<ComputePhase?, Map<String, dynamic>>(
        key: 'compute_ph',
        parse: (v) => ComputePhase.fromJson(v),
      ),
      creditFirst: json.valueAsBool<bool?>('credit_first'),
      creditPh: json.valueTo<CreditPhase?, Map<String, dynamic>>(
        key: 'credit_ph',
        parse: (v) => CreditPhase.fromJson(v),
      ),
      destroyed: json.valueAsBool<bool?>('destroyed'),
      installed: json.valueAsBool<bool?>('installed'),
      isTock: json.valueAsBool<bool?>('is_tock'),
      splitInfo: json.valueTo<SplitInfo?, Map<String, dynamic>>(
        key: 'split_info',
        parse: (v) => SplitInfo.fromJson(v),
      ),
      storagePh: json.valueTo<StoragePhase?, Map<String, dynamic>>(
        key: 'storage_ph',
        parse: (v) => StoragePhase.fromJson(v),
      ),
      type:
          (json['type'] is num
              ? json['type'].toString()
              : json.valueAsString<String?>('type')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'aborted': aborted,
    'action': action?.toJson(config: config),
    'bounce': bounce?.toJson(config: config),
    'compute_ph': computePh?.toJson(config: config),
    'credit_first': creditFirst,
    'credit_ph': creditPh?.toJson(config: config),
    'destroyed': destroyed,
    'installed': installed,
    'is_tock': isTock,
    'split_info': splitInfo?.toJson(config: config),
    'storage_ph': storagePh?.toJson(config: config),
    'type': type,
  });
}

class TransactionsResponse {
  final AddressBook? addressBook;
  final List<Transaction>? transactions;

  const TransactionsResponse({this.addressBook, this.transactions});

  factory TransactionsResponse.fromJson(Map<String, dynamic> json) {
    return TransactionsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      transactions:
          json.hasValue('transactions')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('transactions')
                  .map((e) => Transaction.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'transactions': transactions?.map((e) => e.toJson(config: config)).toList(),
  });
}

class V2AddressInformation {
  final String? balance;
  final String? code;
  final String? data;
  final String? frozenHash;
  final String? lastTransactionHash;
  final String? lastTransactionLt;
  final String? status;
  final bool? suspended;

  const V2AddressInformation({
    this.balance,
    this.code,
    this.data,
    this.frozenHash,
    this.lastTransactionHash,
    this.lastTransactionLt,
    this.status,
    this.suspended,
  });

  factory V2AddressInformation.fromJson(Map<String, dynamic> json) {
    return V2AddressInformation(
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String?>('balance')),
      code:
          (json['code'] is num
              ? json['code'].toString()
              : json.valueAsString<String?>('code')),
      data:
          (json['data'] is num
              ? json['data'].toString()
              : json.valueAsString<String?>('data')),
      frozenHash:
          (json['frozen_hash'] is num
              ? json['frozen_hash'].toString()
              : json.valueAsString<String?>('frozen_hash')),
      lastTransactionHash:
          (json['last_transaction_hash'] is num
              ? json['last_transaction_hash'].toString()
              : json.valueAsString<String?>('last_transaction_hash')),
      lastTransactionLt:
          (json['last_transaction_lt'] is num
              ? json['last_transaction_lt'].toString()
              : json.valueAsString<String?>('last_transaction_lt')),
      status:
          (json['status'] is num
              ? json['status'].toString()
              : json.valueAsString<String?>('status')),
      suspended: json.valueAsBool<bool?>('suspended'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'balance': balance,
    'code': code,
    'data': data,
    'frozen_hash': frozenHash,
    'last_transaction_hash': lastTransactionHash,
    'last_transaction_lt': lastTransactionLt,
    'status': status,
    'suspended': suspended,
  });
}

class V2EstimateFeeRequest {
  final String? address;
  final String? body;
  final bool? ignoreChksig;
  final String? initCode;
  final String? initData;

  const V2EstimateFeeRequest({
    this.address,
    this.body,
    this.ignoreChksig,
    this.initCode,
    this.initData,
  });

  factory V2EstimateFeeRequest.fromJson(Map<String, dynamic> json) {
    return V2EstimateFeeRequest(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      body:
          (json['body'] is num
              ? json['body'].toString()
              : json.valueAsString<String?>('body')),
      ignoreChksig: json.valueAsBool<bool?>('ignore_chksig'),
      initCode:
          (json['init_code'] is num
              ? json['init_code'].toString()
              : json.valueAsString<String?>('init_code')),
      initData:
          (json['init_data'] is num
              ? json['init_data'].toString()
              : json.valueAsString<String?>('init_data')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'body': body,
    'ignore_chksig': ignoreChksig,
    'init_code': initCode,
    'init_data': initData,
  });
}

class V2EstimateFeeResult {
  final List<V2EstimatedFee>? destinationFees;
  final V2EstimatedFee? sourceFees;

  const V2EstimateFeeResult({this.destinationFees, this.sourceFees});

  factory V2EstimateFeeResult.fromJson(Map<String, dynamic> json) {
    return V2EstimateFeeResult(
      destinationFees:
          json.hasValue('destination_fees')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('destination_fees')
                  .map((e) => V2EstimatedFee.fromJson(e))
                  .toList()
              : null,
      sourceFees: json.valueTo<V2EstimatedFee?, Map<String, dynamic>>(
        key: 'source_fees',
        parse: (v) => V2EstimatedFee.fromJson(v),
      ),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'destination_fees':
        destinationFees?.map((e) => e.toJson(config: config)).toList(),
    'source_fees': sourceFees?.toJson(config: config),
  });
}

class V2EstimatedFee {
  final int? fwdFee;
  final int? gasFee;
  final int? inFwdFee;
  final int? storageFee;

  const V2EstimatedFee({
    this.fwdFee,
    this.gasFee,
    this.inFwdFee,
    this.storageFee,
  });

  factory V2EstimatedFee.fromJson(Map<String, dynamic> json) {
    return V2EstimatedFee(
      fwdFee: json.valueAsInt<int?>('fwd_fee'),
      gasFee: json.valueAsInt<int?>('gas_fee'),
      inFwdFee: json.valueAsInt<int?>('in_fwd_fee'),
      storageFee: json.valueAsInt<int?>('storage_fee'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'fwd_fee': fwdFee,
    'gas_fee': gasFee,
    'in_fwd_fee': inFwdFee,
    'storage_fee': storageFee,
  });
}

class V2RunGetMethodRequest {
  final String? address;
  final String? method;
  final List<V2StackEntity>? stack;

  const V2RunGetMethodRequest({this.address, this.method, this.stack});

  factory V2RunGetMethodRequest.fromJson(Map<String, dynamic> json) {
    return V2RunGetMethodRequest(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      method:
          (json['method'] is num
              ? json['method'].toString()
              : json.valueAsString<String?>('method')),
      stack:
          json.hasValue('stack')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('stack')
                  .map((e) => V2StackEntity.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'method': method,
    'stack': stack?.map((e) => e.toJson(config: config)).toList(),
  });
}

class V2SendMessageRequest {
  final String? boc;

  const V2SendMessageRequest({this.boc});

  factory V2SendMessageRequest.fromJson(Map<String, dynamic> json) {
    return V2SendMessageRequest(
      boc:
          (json['boc'] is num
              ? json['boc'].toString()
              : json.valueAsString<String?>('boc')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'boc': boc});
}

class V2SendMessageResult {
  final String? messageHash;
  final String? messageHashNorm;

  const V2SendMessageResult({this.messageHash, this.messageHashNorm});

  factory V2SendMessageResult.fromJson(Map<String, dynamic> json) {
    return V2SendMessageResult(
      messageHash:
          (json['message_hash'] is num
              ? json['message_hash'].toString()
              : json.valueAsString<String?>('message_hash')),
      messageHashNorm:
          (json['message_hash_norm'] is num
              ? json['message_hash_norm'].toString()
              : json.valueAsString<String?>('message_hash_norm')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'message_hash': messageHash,
    'message_hash_norm': messageHashNorm,
  });
}

class V2StackEntity {
  final String? type;
  final dynamic value;

  const V2StackEntity({this.type, this.value});

  factory V2StackEntity.fromJson(Map<String, dynamic> json) {
    return V2StackEntity(
      type:
          (json['type'] is num
              ? json['type'].toString()
              : json.valueAsString<String?>('type')),
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'type': type, 'value': value});
}

class V2WalletInformation {
  final String? balance;
  final String? lastTransactionHash;
  final String? lastTransactionLt;
  final int? seqno;
  final String? status;
  final bool? suspended;
  final int? walletId;
  final String? walletType;

  const V2WalletInformation({
    this.balance,
    this.lastTransactionHash,
    this.lastTransactionLt,
    this.seqno,
    this.status,
    this.suspended,
    this.walletId,
    this.walletType,
  });

  factory V2WalletInformation.fromJson(Map<String, dynamic> json) {
    return V2WalletInformation(
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String?>('balance')),
      lastTransactionHash:
          (json['last_transaction_hash'] is num
              ? json['last_transaction_hash'].toString()
              : json.valueAsString<String?>('last_transaction_hash')),
      lastTransactionLt:
          (json['last_transaction_lt'] is num
              ? json['last_transaction_lt'].toString()
              : json.valueAsString<String?>('last_transaction_lt')),
      seqno: json.valueAsInt<int?>('seqno'),
      status:
          (json['status'] is num
              ? json['status'].toString()
              : json.valueAsString<String?>('status')),
      suspended: json.valueAsBool<bool?>('suspended'),
      walletId: json.valueAsInt<int?>('wallet_id'),
      walletType:
          (json['wallet_type'] is num
              ? json['wallet_type'].toString()
              : json.valueAsString<String?>('wallet_type')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'balance': balance,
    'last_transaction_hash': lastTransactionHash,
    'last_transaction_lt': lastTransactionLt,
    'seqno': seqno,
    'status': status,
    'suspended': suspended,
    'wallet_id': walletId,
    'wallet_type': walletType,
  });
}

class ValidatorComplaint {
  final String? adnlAddr;
  final num? approvedPercent;
  final String? complaintHash;
  final int? createdAt;
  final int? cycleStart;
  final String? descriptionBoc;
  final int? electionId;
  final bool? isPassed;
  final String? paid;
  final String? rewardAddress;
  final int? severity;
  final String? stakeHolderAddress;
  final String? suggestedFine;
  final int? suggestedFinePart;
  final String? validatorPubkey;
  final List<ValidatorComplaintVote>? votedValidators;
  final String? vsetId;
  final String? weightRemaining;

  const ValidatorComplaint({
    this.adnlAddr,
    this.approvedPercent,
    this.complaintHash,
    this.createdAt,
    this.cycleStart,
    this.descriptionBoc,
    this.electionId,
    this.isPassed,
    this.paid,
    this.rewardAddress,
    this.severity,
    this.stakeHolderAddress,
    this.suggestedFine,
    this.suggestedFinePart,
    this.validatorPubkey,
    this.votedValidators,
    this.vsetId,
    this.weightRemaining,
  });

  factory ValidatorComplaint.fromJson(Map<String, dynamic> json) {
    return ValidatorComplaint(
      adnlAddr:
          (json['adnl_addr'] is num
              ? json['adnl_addr'].toString()
              : json.valueAsString<String?>('adnl_addr')),
      approvedPercent: json.valueAsNum<num?>('approved_percent'),
      complaintHash:
          (json['complaint_hash'] is num
              ? json['complaint_hash'].toString()
              : json.valueAsString<String?>('complaint_hash')),
      createdAt: json.valueAsInt<int?>('created_at'),
      cycleStart: json.valueAsInt<int?>('cycle_start'),
      descriptionBoc:
          (json['description_boc'] is num
              ? json['description_boc'].toString()
              : json.valueAsString<String?>('description_boc')),
      electionId: json.valueAsInt<int?>('election_id'),
      isPassed: json.valueAsBool<bool?>('is_passed'),
      paid:
          (json['paid'] is num
              ? json['paid'].toString()
              : json.valueAsString<String?>('paid')),
      rewardAddress:
          (json['reward_address'] is num
              ? json['reward_address'].toString()
              : json.valueAsString<String?>('reward_address')),
      severity: json.valueAsInt<int?>('severity'),
      stakeHolderAddress:
          (json['stake_holder_address'] is num
              ? json['stake_holder_address'].toString()
              : json.valueAsString<String?>('stake_holder_address')),
      suggestedFine:
          (json['suggested_fine'] is num
              ? json['suggested_fine'].toString()
              : json.valueAsString<String?>('suggested_fine')),
      suggestedFinePart: json.valueAsInt<int?>('suggested_fine_part'),
      validatorPubkey:
          (json['validator_pubkey'] is num
              ? json['validator_pubkey'].toString()
              : json.valueAsString<String?>('validator_pubkey')),
      votedValidators:
          json.hasValue('voted_validators')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('voted_validators')
                  .map((e) => ValidatorComplaintVote.fromJson(e))
                  .toList()
              : null,
      vsetId:
          (json['vset_id'] is num
              ? json['vset_id'].toString()
              : json.valueAsString<String?>('vset_id')),
      weightRemaining:
          (json['weight_remaining'] is num
              ? json['weight_remaining'].toString()
              : json.valueAsString<String?>('weight_remaining')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'adnl_addr': adnlAddr,
    'approved_percent': approvedPercent,
    'complaint_hash': complaintHash,
    'created_at': createdAt,
    'cycle_start': cycleStart,
    'description_boc': descriptionBoc,
    'election_id': electionId,
    'is_passed': isPassed,
    'paid': paid,
    'reward_address': rewardAddress,
    'severity': severity,
    'stake_holder_address': stakeHolderAddress,
    'suggested_fine': suggestedFine,
    'suggested_fine_part': suggestedFinePart,
    'validator_pubkey': validatorPubkey,
    'voted_validators':
        votedValidators?.map((e) => e.toJson(config: config)).toList(),
    'vset_id': vsetId,
    'weight_remaining': weightRemaining,
  });
}

class ValidatorComplaintVote {
  final String? adnlAddr;
  final int? validatorIndex;
  final String? validatorPubkey;
  final String? weight;

  const ValidatorComplaintVote({
    this.adnlAddr,
    this.validatorIndex,
    this.validatorPubkey,
    this.weight,
  });

  factory ValidatorComplaintVote.fromJson(Map<String, dynamic> json) {
    return ValidatorComplaintVote(
      adnlAddr:
          (json['adnl_addr'] is num
              ? json['adnl_addr'].toString()
              : json.valueAsString<String?>('adnl_addr')),
      validatorIndex: json.valueAsInt<int?>('validator_index'),
      validatorPubkey:
          (json['validator_pubkey'] is num
              ? json['validator_pubkey'].toString()
              : json.valueAsString<String?>('validator_pubkey')),
      weight:
          (json['weight'] is num
              ? json['weight'].toString()
              : json.valueAsString<String?>('weight')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'adnl_addr': adnlAddr,
    'validator_index': validatorIndex,
    'validator_pubkey': validatorPubkey,
    'weight': weight,
  });
}

class ValidatorComplaintsResponse {
  final AddressBook? addressBook;
  final List<ValidatorComplaint>? complaints;

  const ValidatorComplaintsResponse({this.addressBook, this.complaints});

  factory ValidatorComplaintsResponse.fromJson(Map<String, dynamic> json) {
    return ValidatorComplaintsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      complaints:
          json.hasValue('complaints')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('complaints')
                  .map((e) => ValidatorComplaint.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'complaints': complaints?.map((e) => e.toJson(config: config)).toList(),
  });
}

class ValidatorCycle {
  final int? cycleEnd;
  final int? cycleStart;
  final int? electionId;
  final int? electionsEndBefore;
  final int? electionsStartBefore;
  final int? main;
  final int? maxMainValidators;
  final String? maxStake;
  final int? maxStakeFactor;
  final String? maxStakeLimit;
  final int? maxValidators;
  final String? minStake;
  final String? minStakeLimit;
  final String? minTotalStake;
  final int? minValidators;
  final int? stakeHeldFor;
  final int? total;
  final String? totalStake;
  final String? totalWeight;
  final List<ValidatorCycleValidator>? validators;
  final int? validatorsElectedFor;

  const ValidatorCycle({
    this.cycleEnd,
    this.cycleStart,
    this.electionId,
    this.electionsEndBefore,
    this.electionsStartBefore,
    this.main,
    this.maxMainValidators,
    this.maxStake,
    this.maxStakeFactor,
    this.maxStakeLimit,
    this.maxValidators,
    this.minStake,
    this.minStakeLimit,
    this.minTotalStake,
    this.minValidators,
    this.stakeHeldFor,
    this.total,
    this.totalStake,
    this.totalWeight,
    this.validators,
    this.validatorsElectedFor,
  });

  factory ValidatorCycle.fromJson(Map<String, dynamic> json) {
    return ValidatorCycle(
      cycleEnd: json.valueAsInt<int?>('cycle_end'),
      cycleStart: json.valueAsInt<int?>('cycle_start'),
      electionId: json.valueAsInt<int?>('election_id'),
      electionsEndBefore: json.valueAsInt<int?>('elections_end_before'),
      electionsStartBefore: json.valueAsInt<int?>('elections_start_before'),
      main: json.valueAsInt<int?>('main'),
      maxMainValidators: json.valueAsInt<int?>('max_main_validators'),
      maxStake:
          (json['max_stake'] is num
              ? json['max_stake'].toString()
              : json.valueAsString<String?>('max_stake')),
      maxStakeFactor: json.valueAsInt<int?>('max_stake_factor'),
      maxStakeLimit:
          (json['max_stake_limit'] is num
              ? json['max_stake_limit'].toString()
              : json.valueAsString<String?>('max_stake_limit')),
      maxValidators: json.valueAsInt<int?>('max_validators'),
      minStake:
          (json['min_stake'] is num
              ? json['min_stake'].toString()
              : json.valueAsString<String?>('min_stake')),
      minStakeLimit:
          (json['min_stake_limit'] is num
              ? json['min_stake_limit'].toString()
              : json.valueAsString<String?>('min_stake_limit')),
      minTotalStake:
          (json['min_total_stake'] is num
              ? json['min_total_stake'].toString()
              : json.valueAsString<String?>('min_total_stake')),
      minValidators: json.valueAsInt<int?>('min_validators'),
      stakeHeldFor: json.valueAsInt<int?>('stake_held_for'),
      total: json.valueAsInt<int?>('total'),
      totalStake:
          (json['total_stake'] is num
              ? json['total_stake'].toString()
              : json.valueAsString<String?>('total_stake')),
      totalWeight:
          (json['total_weight'] is num
              ? json['total_weight'].toString()
              : json.valueAsString<String?>('total_weight')),
      validators:
          json.hasValue('validators')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('validators')
                  .map((e) => ValidatorCycleValidator.fromJson(e))
                  .toList()
              : null,
      validatorsElectedFor: json.valueAsInt<int?>('validators_elected_for'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'cycle_end': cycleEnd,
    'cycle_start': cycleStart,
    'election_id': electionId,
    'elections_end_before': electionsEndBefore,
    'elections_start_before': electionsStartBefore,
    'main': main,
    'max_main_validators': maxMainValidators,
    'max_stake': maxStake,
    'max_stake_factor': maxStakeFactor,
    'max_stake_limit': maxStakeLimit,
    'max_validators': maxValidators,
    'min_stake': minStake,
    'min_stake_limit': minStakeLimit,
    'min_total_stake': minTotalStake,
    'min_validators': minValidators,
    'stake_held_for': stakeHeldFor,
    'total': total,
    'total_stake': totalStake,
    'total_weight': totalWeight,
    'validators': validators?.map((e) => e.toJson(config: config)).toList(),
    'validators_elected_for': validatorsElectedFor,
  });
}

class ValidatorCycleValidator {
  final String? adnlAddr;
  final List<ValidatorComplaint>? complaints;

  /// MaxFactor is the participant's raw declared max stake factor (65536 = 1.0), not the effective one.
  final int? maxFactor;
  final String? stake;
  final String? stakeHolderAddress;
  final int? validatorIndex;
  final String? validatorPubkey;
  final String? weight;

  const ValidatorCycleValidator({
    this.adnlAddr,
    this.complaints,
    this.maxFactor,
    this.stake,
    this.stakeHolderAddress,
    this.validatorIndex,
    this.validatorPubkey,
    this.weight,
  });

  factory ValidatorCycleValidator.fromJson(Map<String, dynamic> json) {
    return ValidatorCycleValidator(
      adnlAddr:
          (json['adnl_addr'] is num
              ? json['adnl_addr'].toString()
              : json.valueAsString<String?>('adnl_addr')),
      complaints:
          json.hasValue('complaints')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('complaints')
                  .map((e) => ValidatorComplaint.fromJson(e))
                  .toList()
              : null,
      maxFactor: json.valueAsInt<int?>('max_factor'),
      stake:
          (json['stake'] is num
              ? json['stake'].toString()
              : json.valueAsString<String?>('stake')),
      stakeHolderAddress:
          (json['stake_holder_address'] is num
              ? json['stake_holder_address'].toString()
              : json.valueAsString<String?>('stake_holder_address')),
      validatorIndex: json.valueAsInt<int?>('validator_index'),
      validatorPubkey:
          (json['validator_pubkey'] is num
              ? json['validator_pubkey'].toString()
              : json.valueAsString<String?>('validator_pubkey')),
      weight:
          (json['weight'] is num
              ? json['weight'].toString()
              : json.valueAsString<String?>('weight')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'adnl_addr': adnlAddr,
    'complaints': complaints?.map((e) => e.toJson(config: config)).toList(),
    'max_factor': maxFactor,
    'stake': stake,
    'stake_holder_address': stakeHolderAddress,
    'validator_index': validatorIndex,
    'validator_pubkey': validatorPubkey,
    'weight': weight,
  });
}

class ValidatorCyclesResponse {
  final AddressBook? addressBook;
  final List<ValidatorCycle>? cycles;

  const ValidatorCyclesResponse({this.addressBook, this.cycles});

  factory ValidatorCyclesResponse.fromJson(Map<String, dynamic> json) {
    return ValidatorCyclesResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      cycles:
          json.hasValue('cycles')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('cycles')
                  .map((e) => ValidatorCycle.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'cycles': cycles?.map((e) => e.toJson(config: config)).toList(),
  });
}

class ValidatorElection {
  final int? electClose;
  final int? electionId;
  final bool? failed;
  final bool? finished;
  final String? minStake;
  final List<ValidatorElectionParticipant>? participants;
  final int? totalParticipants;
  final String? totalStake;

  const ValidatorElection({
    this.electClose,
    this.electionId,
    this.failed,
    this.finished,
    this.minStake,
    this.participants,
    this.totalParticipants,
    this.totalStake,
  });

  factory ValidatorElection.fromJson(Map<String, dynamic> json) {
    return ValidatorElection(
      electClose: json.valueAsInt<int?>('elect_close'),
      electionId: json.valueAsInt<int?>('election_id'),
      failed: json.valueAsBool<bool?>('failed'),
      finished: json.valueAsBool<bool?>('finished'),
      minStake:
          (json['min_stake'] is num
              ? json['min_stake'].toString()
              : json.valueAsString<String?>('min_stake')),
      participants:
          json.hasValue('participants')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('participants')
                  .map((e) => ValidatorElectionParticipant.fromJson(e))
                  .toList()
              : null,
      totalParticipants: json.valueAsInt<int?>('total_participants'),
      totalStake:
          (json['total_stake'] is num
              ? json['total_stake'].toString()
              : json.valueAsString<String?>('total_stake')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'elect_close': electClose,
    'election_id': electionId,
    'failed': failed,
    'finished': finished,
    'min_stake': minStake,
    'participants': participants?.map((e) => e.toJson(config: config)).toList(),
    'total_participants': totalParticipants,
    'total_stake': totalStake,
  });
}

class ValidatorElectionParticipant {
  final String? adnlAddr;
  final int? maxFactor;
  final String? stake;
  final String? stakeHolderAddress;
  final int? validatorIndex;
  final String? validatorPubkey;

  const ValidatorElectionParticipant({
    this.adnlAddr,
    this.maxFactor,
    this.stake,
    this.stakeHolderAddress,
    this.validatorIndex,
    this.validatorPubkey,
  });

  factory ValidatorElectionParticipant.fromJson(Map<String, dynamic> json) {
    return ValidatorElectionParticipant(
      adnlAddr:
          (json['adnl_addr'] is num
              ? json['adnl_addr'].toString()
              : json.valueAsString<String?>('adnl_addr')),
      maxFactor: json.valueAsInt<int?>('max_factor'),
      stake:
          (json['stake'] is num
              ? json['stake'].toString()
              : json.valueAsString<String?>('stake')),
      stakeHolderAddress:
          (json['stake_holder_address'] is num
              ? json['stake_holder_address'].toString()
              : json.valueAsString<String?>('stake_holder_address')),
      validatorIndex: json.valueAsInt<int?>('validator_index'),
      validatorPubkey:
          (json['validator_pubkey'] is num
              ? json['validator_pubkey'].toString()
              : json.valueAsString<String?>('validator_pubkey')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'adnl_addr': adnlAddr,
    'max_factor': maxFactor,
    'stake': stake,
    'stake_holder_address': stakeHolderAddress,
    'validator_index': validatorIndex,
    'validator_pubkey': validatorPubkey,
  });
}

class ValidatorElectionsResponse {
  final AddressBook? addressBook;
  final List<ValidatorElection>? elections;

  const ValidatorElectionsResponse({this.addressBook, this.elections});

  factory ValidatorElectionsResponse.fromJson(Map<String, dynamic> json) {
    return ValidatorElectionsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      elections:
          json.hasValue('elections')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('elections')
                  .map((e) => ValidatorElection.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'elections': elections?.map((e) => e.toJson(config: config)).toList(),
  });
}

class ValidatorEvent {
  final String? adnlAddr;
  final String? amount;
  final int? electionId;
  final String? queryId;
  final int? reason;
  final String? stakeHolderAddress;
  final String? txHash;
  final String? txLt;

  /// "stake_accepted", "stake_rejected", "stake_recovered"
  final ValidatorEventType? type;
  final int? utime;
  final String? validatorPubkey;

  const ValidatorEvent({
    this.adnlAddr,
    this.amount,
    this.electionId,
    this.queryId,
    this.reason,
    this.stakeHolderAddress,
    this.txHash,
    this.txLt,
    this.type,
    this.utime,
    this.validatorPubkey,
  });

  factory ValidatorEvent.fromJson(Map<String, dynamic> json) {
    return ValidatorEvent(
      adnlAddr:
          (json['adnl_addr'] is num
              ? json['adnl_addr'].toString()
              : json.valueAsString<String?>('adnl_addr')),
      amount:
          (json['amount'] is num
              ? json['amount'].toString()
              : json.valueAsString<String?>('amount')),
      electionId: json.valueAsInt<int?>('election_id'),
      queryId:
          (json['query_id'] is num
              ? json['query_id'].toString()
              : json.valueAsString<String?>('query_id')),
      reason: json.valueAsInt<int?>('reason'),
      stakeHolderAddress:
          (json['stake_holder_address'] is num
              ? json['stake_holder_address'].toString()
              : json.valueAsString<String?>('stake_holder_address')),
      txHash:
          (json['tx_hash'] is num
              ? json['tx_hash'].toString()
              : json.valueAsString<String?>('tx_hash')),
      txLt:
          (json['tx_lt'] is num
              ? json['tx_lt'].toString()
              : json.valueAsString<String?>('tx_lt')),
      type: json.valueTo<ValidatorEventType?, Object>(
        key: 'type',
        parse: (e) => ValidatorEventType.fromJson(JsonParser.valueAs(e)),
      ),
      utime: json.valueAsInt<int?>('utime'),
      validatorPubkey:
          (json['validator_pubkey'] is num
              ? json['validator_pubkey'].toString()
              : json.valueAsString<String?>('validator_pubkey')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'adnl_addr': adnlAddr,
    'amount': amount,
    'election_id': electionId,
    'query_id': queryId,
    'reason': reason,
    'stake_holder_address': stakeHolderAddress,
    'tx_hash': txHash,
    'tx_lt': txLt,
    'type': type?.toJson(config: config),
    'utime': utime,
    'validator_pubkey': validatorPubkey,
  });
}

class ValidatorEventsResponse {
  final AddressBook? addressBook;
  final int? endUtime;
  final List<ValidatorEvent>? events;
  final int? startUtime;

  const ValidatorEventsResponse({
    this.addressBook,
    this.endUtime,
    this.events,
    this.startUtime,
  });

  factory ValidatorEventsResponse.fromJson(Map<String, dynamic> json) {
    return ValidatorEventsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      endUtime: json.valueAsInt<int?>('end_utime'),
      events:
          json.hasValue('events')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('events')
                  .map((e) => ValidatorEvent.fromJson(e))
                  .toList()
              : null,
      startUtime: json.valueAsInt<int?>('start_utime'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'end_utime': endUtime,
    'events': events?.map((e) => e.toJson(config: config)).toList(),
    'start_utime': startUtime,
  });
}

class VestingContractsResponse {
  final AddressBook? addressBook;
  final List<ModelsVestingInfo>? vestingContracts;

  const VestingContractsResponse({this.addressBook, this.vestingContracts});

  factory VestingContractsResponse.fromJson(Map<String, dynamic> json) {
    return VestingContractsResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      vestingContracts:
          json.hasValue('vesting_contracts')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('vesting_contracts')
                  .map((e) => ModelsVestingInfo.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'vesting_contracts':
        vestingContracts?.map((e) => e.toJson(config: config)).toList(),
  });
}

class WalletState {
  final String? address;
  final String? balance;
  final String? codeHash;
  final Map<String, String>? extraCurrencies;
  final bool? isSignatureAllowed;
  final bool? isWallet;
  final String? lastTransactionHash;
  final String? lastTransactionLt;
  final int? seqno;
  final String? status;
  final bool? suspended;
  final int? walletId;
  final String? walletType;

  const WalletState({
    this.address,
    this.balance,
    this.codeHash,
    this.extraCurrencies,
    this.isSignatureAllowed,
    this.isWallet,
    this.lastTransactionHash,
    this.lastTransactionLt,
    this.seqno,
    this.status,
    this.suspended,
    this.walletId,
    this.walletType,
  });

  factory WalletState.fromJson(Map<String, dynamic> json) {
    return WalletState(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      balance:
          (json['balance'] is num
              ? json['balance'].toString()
              : json.valueAsString<String?>('balance')),
      codeHash:
          (json['code_hash'] is num
              ? json['code_hash'].toString()
              : json.valueAsString<String?>('code_hash')),
      extraCurrencies:
          json.hasValue('extra_currencies')
              ? json
                  .valueEnsureAsMap<String, dynamic>('extra_currencies')
                  .map(
                    (k, v) => MapEntry(
                      k,
                      (v is num
                          ? v.toString()
                          : JsonParser.valueAsString<String>(v)),
                    ),
                  )
              : null,
      isSignatureAllowed: json.valueAsBool<bool?>('is_signature_allowed'),
      isWallet: json.valueAsBool<bool?>('is_wallet'),
      lastTransactionHash:
          (json['last_transaction_hash'] is num
              ? json['last_transaction_hash'].toString()
              : json.valueAsString<String?>('last_transaction_hash')),
      lastTransactionLt:
          (json['last_transaction_lt'] is num
              ? json['last_transaction_lt'].toString()
              : json.valueAsString<String?>('last_transaction_lt')),
      seqno: json.valueAsInt<int?>('seqno'),
      status:
          (json['status'] is num
              ? json['status'].toString()
              : json.valueAsString<String?>('status')),
      suspended: json.valueAsBool<bool?>('suspended'),
      walletId: json.valueAsInt<int?>('wallet_id'),
      walletType:
          (json['wallet_type'] is num
              ? json['wallet_type'].toString()
              : json.valueAsString<String?>('wallet_type')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'balance': balance,
    'code_hash': codeHash,
    'extra_currencies': extraCurrencies,
    'is_signature_allowed': isSignatureAllowed,
    'is_wallet': isWallet,
    'last_transaction_hash': lastTransactionHash,
    'last_transaction_lt': lastTransactionLt,
    'seqno': seqno,
    'status': status,
    'suspended': suspended,
    'wallet_id': walletId,
    'wallet_type': walletType,
  });
}

class WalletStatesResponse {
  final AddressBook? addressBook;
  final Metadata? metadata;
  final List<WalletState>? wallets;

  const WalletStatesResponse({this.addressBook, this.metadata, this.wallets});

  factory WalletStatesResponse.fromJson(Map<String, dynamic> json) {
    return WalletStatesResponse(
      addressBook: json.valueTo<AddressBook?, Map<String, dynamic>>(
        key: 'address_book',
        parse: (v) => AddressBook.fromJson(v),
      ),
      metadata: json.valueTo<Metadata?, Map<String, dynamic>>(
        key: 'metadata',
        parse: (v) => Metadata.fromJson(v),
      ),
      wallets:
          json.hasValue('wallets')
              ? json
                  .valueEnsureAsList<Map<String, dynamic>>('wallets')
                  .map((e) => WalletState.fromJson(e))
                  .toList()
              : null,
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address_book': addressBook?.toJson(config: config),
    'metadata': metadata?.toJson(config: config),
    'wallets': wallets?.map((e) => e.toJson(config: config)).toList(),
  });
}

class ModelsIndexError {
  final String? error;

  const ModelsIndexError({this.error});

  factory ModelsIndexError.fromJson(Map<String, dynamic> json) {
    return ModelsIndexError(
      error:
          (json['error'] is num
              ? json['error'].toString()
              : json.valueAsString<String?>('error')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{'error': error});
}

class ModelsOrderAction {
  final List<int>? bodyRaw;
  final String? destination;
  final String? error;
  final bool? parsed;
  final dynamic parsedBody;
  final String? parsedBodyType;
  final int? sendMode;
  final String? value;

  const ModelsOrderAction({
    this.bodyRaw,
    this.destination,
    this.error,
    this.parsed,
    this.parsedBody,
    this.parsedBodyType,
    this.sendMode,
    this.value,
  });

  factory ModelsOrderAction.fromJson(Map<String, dynamic> json) {
    return ModelsOrderAction(
      bodyRaw: json.valueAsList<List<int>?>('body_raw'),
      destination:
          (json['destination'] is num
              ? json['destination'].toString()
              : json.valueAsString<String?>('destination')),
      error:
          (json['error'] is num
              ? json['error'].toString()
              : json.valueAsString<String?>('error')),
      parsed: json.valueAsBool<bool?>('parsed'),
      parsedBody: json['parsed_body'],
      parsedBodyType:
          (json['parsed_body_type'] is num
              ? json['parsed_body_type'].toString()
              : json.valueAsString<String?>('parsed_body_type')),
      sendMode: json.valueAsInt<int?>('send_mode'),
      value:
          (json['value'] is num
              ? json['value'].toString()
              : json.valueAsString<String?>('value')),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'body_raw': bodyRaw,
    'destination': destination,
    'error': error,
    'parsed': parsed,
    'parsed_body': parsedBody,
    'parsed_body_type': parsedBodyType,
    'send_mode': sendMode,
    'value': value,
  });
}

class ModelsVestingInfo {
  final String? address;
  final int? cliffDuration;
  final String? ownerAddress;
  final String? senderAddress;
  final int? startTime;
  final String? totalAmount;
  final int? totalDuration;
  final int? unlockPeriod;
  final List<String>? whitelist;

  const ModelsVestingInfo({
    this.address,
    this.cliffDuration,
    this.ownerAddress,
    this.senderAddress,
    this.startTime,
    this.totalAmount,
    this.totalDuration,
    this.unlockPeriod,
    this.whitelist,
  });

  factory ModelsVestingInfo.fromJson(Map<String, dynamic> json) {
    return ModelsVestingInfo(
      address:
          (json['address'] is num
              ? json['address'].toString()
              : json.valueAsString<String?>('address')),
      cliffDuration: json.valueAsInt<int?>('cliff_duration'),
      ownerAddress:
          (json['owner_address'] is num
              ? json['owner_address'].toString()
              : json.valueAsString<String?>('owner_address')),
      senderAddress:
          (json['sender_address'] is num
              ? json['sender_address'].toString()
              : json.valueAsString<String?>('sender_address')),
      startTime: json.valueAsInt<int?>('start_time'),
      totalAmount:
          (json['total_amount'] is num
              ? json['total_amount'].toString()
              : json.valueAsString<String?>('total_amount')),
      totalDuration: json.valueAsInt<int?>('total_duration'),
      unlockPeriod: json.valueAsInt<int?>('unlock_period'),
      whitelist: json.valueAsList<List<String>?>('whitelist'),
    );
  }

  Map<String, dynamic> toJson({
    JsonifyConfig config = DefaultJsonifyConfig.defaultConfig,
  }) => config.encodeMap(<String, dynamic>{
    'address': address,
    'cliff_duration': cliffDuration,
    'owner_address': ownerAddress,
    'sender_address': senderAddress,
    'start_time': startTime,
    'total_amount': totalAmount,
    'total_duration': totalDuration,
    'unlock_period': unlockPeriod,
    'whitelist': whitelist,
  });
}
