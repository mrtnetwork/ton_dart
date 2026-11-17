// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'tonapi_models.dart';

/// POST /v2/accounts/_bulk
class TonApiGetAccounts
    extends TonApiPostRequest<Accounts, Map<String, dynamic>> {
  final String? currency;
  final List<String> accountIds;

  TonApiGetAccounts({this.currency, required this.accountIds});

  @override
  String get method => '/v2/accounts/_bulk';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic> get queryParameters => {'currency': currency};

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'account_ids': accountIds});

  @override
  Accounts onResponse(Map<String, dynamic> result) {
    return Accounts.fromJson(result);
  }
}

/// GET /v2/accounts/search
class TonApiSearchAccounts
    extends TonApiRequest<FoundAccounts, Map<String, dynamic>> {
  final String name;

  TonApiSearchAccounts({required this.name});

  @override
  String get method => '/v2/accounts/search';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'name': name};

  @override
  FoundAccounts onResponse(Map<String, dynamic> result) {
    return FoundAccounts.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}
class TonApiGetAccount extends TonApiRequest<Account, Map<String, dynamic>> {
  final String accountId;

  TonApiGetAccount({required this.accountId});

  @override
  String get method => '/v2/accounts/{account_id}';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Account onResponse(Map<String, dynamic> result) {
    return Account.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/defi/assets
class TonApiGetAccountDefiAssets
    extends TonApiRequest<DefiAssets, Map<String, dynamic>> {
  final String accountId;

  TonApiGetAccountDefiAssets({required this.accountId});

  @override
  String get method => '/v2/accounts/{account_id}/defi/assets';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  DefiAssets onResponse(Map<String, dynamic> result) {
    return DefiAssets.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/diff
class TonApiGetAccountDiff
    extends TonApiRequest<ResponseGetAccountDiff, Map<String, dynamic>> {
  final String accountId;
  final BigInt startDate;
  final BigInt endDate;

  TonApiGetAccountDiff({
    required this.accountId,
    required this.startDate,
    required this.endDate,
  });

  @override
  String get method => '/v2/accounts/{account_id}/diff';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {
    'start_date': startDate.toString(),
    'end_date': endDate.toString(),
  };

  @override
  ResponseGetAccountDiff onResponse(Map<String, dynamic> result) {
    return ResponseGetAccountDiff.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/dns/backresolve
class TonApiAccountDnsBackResolve
    extends TonApiRequest<DomainNames, Map<String, dynamic>> {
  final String accountId;

  TonApiAccountDnsBackResolve({required this.accountId});

  @override
  String get method => '/v2/accounts/{account_id}/dns/backresolve';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  DomainNames onResponse(Map<String, dynamic> result) {
    return DomainNames.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/dns/expiring
class TonApiGetAccountDnsExpiring
    extends TonApiRequest<DnsExpiring, Map<String, dynamic>> {
  final String accountId;
  final int? period;

  TonApiGetAccountDnsExpiring({required this.accountId, this.period});

  @override
  String get method => '/v2/accounts/{account_id}/dns/expiring';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {'period': period?.toString()};

  @override
  DnsExpiring onResponse(Map<String, dynamic> result) {
    return DnsExpiring.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/events
class TonApiGetAccountEvents
    extends TonApiRequest<AccountEvents, Map<String, dynamic>> {
  final String accountId;
  final bool? initiator;
  final bool? subjectOnly;
  final BigInt? afterLt;
  final BigInt? beforeLt;
  final int limit;
  final BigInt? startDate;
  final BigInt? endDate;
  final SortOrder? sortOrder;

  TonApiGetAccountEvents({
    required this.accountId,
    this.initiator,
    this.subjectOnly,
    this.afterLt,
    this.beforeLt,
    required this.limit,
    this.startDate,
    this.endDate,
    this.sortOrder,
  });

  @override
  String get method => '/v2/accounts/{account_id}/events';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'initiator': initiator?.toString(),
    'subject_only': subjectOnly?.toString(),
    'after_lt': afterLt?.toString(),
    'before_lt': beforeLt?.toString(),
    'limit': limit.toString(),
    'start_date': startDate?.toString(),
    'end_date': endDate?.toString(),
    'sort_order': sortOrder?.toJson(),
  };

  @override
  AccountEvents onResponse(Map<String, dynamic> result) {
    return AccountEvents.fromJson(result);
  }
}

/// POST /v2/accounts/{account_id}/events/emulate
class TonApiEmulateMessageToAccountEvent
    extends TonApiPostRequest<AccountEvent, Map<String, dynamic>> {
  final String accountId;
  final bool? ignoreSignatureCheck;
  final String boc;

  TonApiEmulateMessageToAccountEvent({
    required this.accountId,
    this.ignoreSignatureCheck,
    required this.boc,
  });

  @override
  String get method => '/v2/accounts/{account_id}/events/emulate';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic> get queryParameters => {
    'ignore_signature_check': ignoreSignatureCheck?.toString(),
  };

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'boc': boc});

  @override
  AccountEvent onResponse(Map<String, dynamic> result) {
    return AccountEvent.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/events/{event_id}
class TonApiGetAccountEvent
    extends TonApiRequest<AccountEvent, Map<String, dynamic>> {
  final String accountId;
  final String eventId;
  final bool? subjectOnly;

  TonApiGetAccountEvent({
    required this.accountId,
    required this.eventId,
    this.subjectOnly,
  });

  @override
  String get method => '/v2/accounts/{account_id}/events/{event_id}';

  @override
  List<String> get pathParameters => [accountId, eventId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'subject_only': subjectOnly?.toString(),
  };

  @override
  AccountEvent onResponse(Map<String, dynamic> result) {
    return AccountEvent.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/extra-currency/{id}/history
class TonApiGetAccountExtraCurrencyHistoryByID
    extends TonApiRequest<AccountEvents, Map<String, dynamic>> {
  final String accountId;
  final int id;
  final BigInt? beforeLt;
  final int limit;
  final BigInt? startDate;
  final BigInt? endDate;

  TonApiGetAccountExtraCurrencyHistoryByID({
    required this.accountId,
    required this.id,
    this.beforeLt,
    required this.limit,
    this.startDate,
    this.endDate,
  });

  @override
  String get method => '/v2/accounts/{account_id}/extra-currency/{id}/history';

  @override
  List<String> get pathParameters => [accountId, id.toString()];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'before_lt': beforeLt?.toString(),
    'limit': limit.toString(),
    'start_date': startDate?.toString(),
    'end_date': endDate?.toString(),
  };

  @override
  AccountEvents onResponse(Map<String, dynamic> result) {
    return AccountEvents.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/jettons
class TonApiGetAccountJettonsBalances
    extends TonApiRequest<JettonsBalances, Map<String, dynamic>> {
  final String accountId;
  final List<String>? currencies;
  final List<String>? supportedExtensions;
  final int? limit;
  final int? offset;

  TonApiGetAccountJettonsBalances({
    required this.accountId,
    this.currencies,
    this.supportedExtensions,
    this.limit,
    this.offset,
  });

  @override
  String get method => '/v2/accounts/{account_id}/jettons';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'currencies': currencies?.join(','),
    'supported_extensions': supportedExtensions?.join(','),
    'limit': limit?.toString(),
    'offset': offset?.toString(),
  };

  @override
  JettonsBalances onResponse(Map<String, dynamic> result) {
    return JettonsBalances.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/jettons/history
class TonApiGetAccountJettonsHistory
    extends TonApiRequest<JettonOperations, Map<String, dynamic>> {
  final String accountId;
  final BigInt? beforeLt;
  final int limit;

  TonApiGetAccountJettonsHistory({
    required this.accountId,
    this.beforeLt,
    required this.limit,
  });

  @override
  String get method => '/v2/accounts/{account_id}/jettons/history';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'before_lt': beforeLt?.toString(),
    'limit': limit.toString(),
  };

  @override
  JettonOperations onResponse(Map<String, dynamic> result) {
    return JettonOperations.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/jettons/{jetton_id}
class TonApiGetAccountJettonBalance
    extends TonApiRequest<JettonBalance, Map<String, dynamic>> {
  final String accountId;
  final String jettonId;
  final List<String>? currencies;
  final List<String>? supportedExtensions;

  TonApiGetAccountJettonBalance({
    required this.accountId,
    required this.jettonId,
    this.currencies,
    this.supportedExtensions,
  });

  @override
  String get method => '/v2/accounts/{account_id}/jettons/{jetton_id}';

  @override
  List<String> get pathParameters => [accountId, jettonId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'currencies': currencies?.join(','),
    'supported_extensions': supportedExtensions?.join(','),
  };

  @override
  JettonBalance onResponse(Map<String, dynamic> result) {
    return JettonBalance.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/jettons/{jetton_id}/history
class TonApiGetAccountJettonHistoryByID
    extends TonApiRequest<AccountEvents, Map<String, dynamic>> {
  final String accountId;
  final String jettonId;
  final BigInt? beforeLt;
  final int limit;
  final BigInt? startDate;
  final BigInt? endDate;

  TonApiGetAccountJettonHistoryByID({
    required this.accountId,
    required this.jettonId,
    this.beforeLt,
    required this.limit,
    this.startDate,
    this.endDate,
  });

  @override
  String get method => '/v2/accounts/{account_id}/jettons/{jetton_id}/history';

  @override
  List<String> get pathParameters => [accountId, jettonId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'before_lt': beforeLt?.toString(),
    'limit': limit.toString(),
    'start_date': startDate?.toString(),
    'end_date': endDate?.toString(),
  };

  @override
  AccountEvents onResponse(Map<String, dynamic> result) {
    return AccountEvents.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/multisigs
class TonApiGetAccountMultisigs
    extends TonApiRequest<Multisigs, Map<String, dynamic>> {
  final String accountId;

  TonApiGetAccountMultisigs({required this.accountId});

  @override
  String get method => '/v2/accounts/{account_id}/multisigs';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Multisigs onResponse(Map<String, dynamic> result) {
    return Multisigs.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/nfts
class TonApiGetAccountNftItems
    extends TonApiRequest<NftItems, Map<String, dynamic>> {
  final String accountId;
  final String? collection;
  final int? limit;
  final int? offset;
  final bool? indirectOwnership;

  TonApiGetAccountNftItems({
    required this.accountId,
    this.collection,
    this.limit,
    this.offset,
    this.indirectOwnership,
  });

  @override
  String get method => '/v2/accounts/{account_id}/nfts';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'collection': collection,
    'limit': limit?.toString(),
    'offset': offset?.toString(),
    'indirect_ownership': indirectOwnership?.toString(),
  };

  @override
  NftItems onResponse(Map<String, dynamic> result) {
    return NftItems.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/nfts/history
class TonApiGetAccountNftHistory
    extends TonApiRequest<NftOperations, Map<String, dynamic>> {
  final String accountId;
  final BigInt? beforeLt;
  final int limit;

  TonApiGetAccountNftHistory({
    required this.accountId,
    this.beforeLt,
    required this.limit,
  });

  @override
  String get method => '/v2/accounts/{account_id}/nfts/history';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'before_lt': beforeLt?.toString(),
    'limit': limit.toString(),
  };

  @override
  NftOperations onResponse(Map<String, dynamic> result) {
    return NftOperations.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/publickey
class TonApiGetAccountPublicKey
    extends TonApiRequest<ResponseGetAccountPublicKey, Map<String, dynamic>> {
  final String accountId;

  TonApiGetAccountPublicKey({required this.accountId});

  @override
  String get method => '/v2/accounts/{account_id}/publickey';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ResponseGetAccountPublicKey onResponse(Map<String, dynamic> result) {
    return ResponseGetAccountPublicKey.fromJson(result);
  }
}

/// POST /v2/accounts/{account_id}/reindex
class TonApiReindexAccount extends TonApiRequest<dynamic, dynamic> {
  final String accountId;

  TonApiReindexAccount({required this.accountId});

  @override
  String get method => '/v2/accounts/{account_id}/reindex';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /v2/accounts/{account_id}/subscriptions
class TonApiGetAccountSubscriptions
    extends TonApiRequest<Subscriptions, Map<String, dynamic>> {
  final String accountId;

  TonApiGetAccountSubscriptions({required this.accountId});

  @override
  String get method => '/v2/accounts/{account_id}/subscriptions';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Subscriptions onResponse(Map<String, dynamic> result) {
    return Subscriptions.fromJson(result);
  }
}

/// GET /v2/accounts/{account_id}/traces
class TonApiGetAccountTraces
    extends TonApiRequest<TraceIDs, Map<String, dynamic>> {
  final String accountId;
  final BigInt? beforeLt;
  final int? limit;

  TonApiGetAccountTraces({required this.accountId, this.beforeLt, this.limit});

  @override
  String get method => '/v2/accounts/{account_id}/traces';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'before_lt': beforeLt?.toString(),
    'limit': limit?.toString(),
  };

  @override
  TraceIDs onResponse(Map<String, dynamic> result) {
    return TraceIDs.fromJson(result);
  }
}

/// GET /v2/address/{account_id}/parse
class TonApiAddressParse
    extends TonApiRequest<ResponseAddressParse, Map<String, dynamic>> {
  final String accountId;

  TonApiAddressParse({required this.accountId});

  @override
  String get method => '/v2/address/{account_id}/parse';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ResponseAddressParse onResponse(Map<String, dynamic> result) {
    return ResponseAddressParse.fromJson(result);
  }
}

/// POST /v2/blockchain/accounts/_bulk
class TonApiGetBlockchainRawAccounts
    extends TonApiPostRequest<BlockchainRawAccounts, Map<String, dynamic>> {
  final List<String> accountIds;

  TonApiGetBlockchainRawAccounts({required this.accountIds});

  @override
  String get method => '/v2/blockchain/accounts/_bulk';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'account_ids': accountIds});

  @override
  BlockchainRawAccounts onResponse(Map<String, dynamic> result) {
    return BlockchainRawAccounts.fromJson(result);
  }
}

/// GET /v2/blockchain/accounts/{account_id}
class TonApiGetBlockchainRawAccount
    extends TonApiRequest<BlockchainRawAccount, Map<String, dynamic>> {
  final String accountId;

  TonApiGetBlockchainRawAccount({required this.accountId});

  @override
  String get method => '/v2/blockchain/accounts/{account_id}';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  BlockchainRawAccount onResponse(Map<String, dynamic> result) {
    return BlockchainRawAccount.fromJson(result);
  }
}

/// GET /v2/blockchain/accounts/{account_id}/inspect
class TonApiBlockchainAccountInspect
    extends TonApiRequest<BlockchainAccountInspect, Map<String, dynamic>> {
  final String accountId;

  TonApiBlockchainAccountInspect({required this.accountId});

  @override
  String get method => '/v2/blockchain/accounts/{account_id}/inspect';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  BlockchainAccountInspect onResponse(Map<String, dynamic> result) {
    return BlockchainAccountInspect.fromJson(result);
  }
}

/// GET /v2/blockchain/accounts/{account_id}/methods/{method_name}
class TonApiExecGetMethodForBlockchainAccount
    extends TonApiRequest<MethodExecutionResult, Map<String, dynamic>> {
  final String accountId;
  final String methodName;
  final List<String>? args;

  TonApiExecGetMethodForBlockchainAccount({
    required this.accountId,
    required this.methodName,
    this.args,
  });

  @override
  String get method =>
      '/v2/blockchain/accounts/{account_id}/methods/{method_name}';

  @override
  List<String> get pathParameters => [accountId, methodName];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {'args': args};

  @override
  MethodExecutionResult onResponse(Map<String, dynamic> result) {
    return MethodExecutionResult.fromJson(result);
  }
}

/// POST /v2/blockchain/accounts/{account_id}/methods/{method_name}
class TonApiExecGetMethodWithBodyForBlockchainAccount
    extends TonApiPostRequest<MethodExecutionResult, Map<String, dynamic>> {
  final String accountId;
  final String methodName;
  final List<ExecGetMethodArg> args;

  TonApiExecGetMethodWithBodyForBlockchainAccount({
    required this.accountId,
    required this.methodName,
    required this.args,
  });

  @override
  String get method =>
      '/v2/blockchain/accounts/{account_id}/methods/{method_name}';

  @override
  List<String> get pathParameters => [accountId, methodName];

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'args': args.map((e) => e.toJson(config: config)).toList(),
      });

  @override
  MethodExecutionResult onResponse(Map<String, dynamic> result) {
    return MethodExecutionResult.fromJson(result);
  }
}

/// GET /v2/blockchain/accounts/{account_id}/transactions
class TonApiGetBlockchainAccountTransactions
    extends TonApiRequest<Transactions, Map<String, dynamic>> {
  final String accountId;
  final BigInt? afterLt;
  final BigInt? beforeLt;
  final int? limit;
  final SortOrder? sortOrder;

  TonApiGetBlockchainAccountTransactions({
    required this.accountId,
    this.afterLt,
    this.beforeLt,
    this.limit,
    this.sortOrder,
  });

  @override
  String get method => '/v2/blockchain/accounts/{account_id}/transactions';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'after_lt': afterLt?.toString(),
    'before_lt': beforeLt?.toString(),
    'limit': limit?.toString(),
    'sort_order': sortOrder?.toJson(),
  };

  @override
  Transactions onResponse(Map<String, dynamic> result) {
    return Transactions.fromJson(result);
  }
}

/// GET /v2/blockchain/blocks/{block_id}
class TonApiGetBlockchainBlock
    extends TonApiRequest<BlockchainBlock, Map<String, dynamic>> {
  final String blockId;

  TonApiGetBlockchainBlock({required this.blockId});

  @override
  String get method => '/v2/blockchain/blocks/{block_id}';

  @override
  List<String> get pathParameters => [blockId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  BlockchainBlock onResponse(Map<String, dynamic> result) {
    return BlockchainBlock.fromJson(result);
  }
}

/// GET /v2/blockchain/blocks/{block_id}/boc
class TonApiDownloadBlockchainBlockBoc extends TonApiRequest<String, String> {
  final String blockId;

  TonApiDownloadBlockchainBlockBoc({required this.blockId});

  @override
  String get method => '/v2/blockchain/blocks/{block_id}/boc';

  @override
  List<String> get pathParameters => [blockId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// GET /v2/blockchain/blocks/{block_id}/transactions
class TonApiGetBlockchainBlockTransactions
    extends TonApiRequest<Transactions, Map<String, dynamic>> {
  final String blockId;

  TonApiGetBlockchainBlockTransactions({required this.blockId});

  @override
  String get method => '/v2/blockchain/blocks/{block_id}/transactions';

  @override
  List<String> get pathParameters => [blockId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Transactions onResponse(Map<String, dynamic> result) {
    return Transactions.fromJson(result);
  }
}

/// GET /v2/blockchain/config
class TonApiGetBlockchainConfig
    extends TonApiRequest<BlockchainConfig, Map<String, dynamic>> {
  TonApiGetBlockchainConfig();

  @override
  String get method => '/v2/blockchain/config';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  BlockchainConfig onResponse(Map<String, dynamic> result) {
    return BlockchainConfig.fromJson(result);
  }
}

/// GET /v2/blockchain/config/raw
class TonApiGetRawBlockchainConfig
    extends TonApiRequest<RawBlockchainConfig, Map<String, dynamic>> {
  TonApiGetRawBlockchainConfig();

  @override
  String get method => '/v2/blockchain/config/raw';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  RawBlockchainConfig onResponse(Map<String, dynamic> result) {
    return RawBlockchainConfig.fromJson(result);
  }
}

/// GET /v2/blockchain/libraries/{hash}
class TonApiGetLibraryByHash
    extends TonApiRequest<BlockchainLibrary, Map<String, dynamic>> {
  final String hash;

  TonApiGetLibraryByHash({required this.hash});

  @override
  String get method => '/v2/blockchain/libraries/{hash}';

  @override
  List<String> get pathParameters => [hash];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  BlockchainLibrary onResponse(Map<String, dynamic> result) {
    return BlockchainLibrary.fromJson(result);
  }
}

/// GET /v2/blockchain/masterchain-head
class TonApiGetBlockchainMasterchainHead
    extends TonApiRequest<BlockchainBlock, Map<String, dynamic>> {
  TonApiGetBlockchainMasterchainHead();

  @override
  String get method => '/v2/blockchain/masterchain-head';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  BlockchainBlock onResponse(Map<String, dynamic> result) {
    return BlockchainBlock.fromJson(result);
  }
}

/// GET /v2/blockchain/masterchain/{masterchain_seqno}/blocks
class TonApiGetBlockchainMasterchainBlocks
    extends TonApiRequest<BlockchainBlocks, Map<String, dynamic>> {
  final int masterchainSeqno;

  TonApiGetBlockchainMasterchainBlocks({required this.masterchainSeqno});

  @override
  String get method => '/v2/blockchain/masterchain/{masterchain_seqno}/blocks';

  @override
  List<String> get pathParameters => [masterchainSeqno.toString()];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  BlockchainBlocks onResponse(Map<String, dynamic> result) {
    return BlockchainBlocks.fromJson(result);
  }
}

/// GET /v2/blockchain/masterchain/{masterchain_seqno}/config
class TonApiGetBlockchainConfigFromBlock
    extends TonApiRequest<BlockchainConfig, Map<String, dynamic>> {
  final int masterchainSeqno;

  TonApiGetBlockchainConfigFromBlock({required this.masterchainSeqno});

  @override
  String get method => '/v2/blockchain/masterchain/{masterchain_seqno}/config';

  @override
  List<String> get pathParameters => [masterchainSeqno.toString()];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  BlockchainConfig onResponse(Map<String, dynamic> result) {
    return BlockchainConfig.fromJson(result);
  }
}

/// GET /v2/blockchain/masterchain/{masterchain_seqno}/config/raw
class TonApiGetRawBlockchainConfigFromBlock
    extends TonApiRequest<RawBlockchainConfig, Map<String, dynamic>> {
  final int masterchainSeqno;

  TonApiGetRawBlockchainConfigFromBlock({required this.masterchainSeqno});

  @override
  String get method =>
      '/v2/blockchain/masterchain/{masterchain_seqno}/config/raw';

  @override
  List<String> get pathParameters => [masterchainSeqno.toString()];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  RawBlockchainConfig onResponse(Map<String, dynamic> result) {
    return RawBlockchainConfig.fromJson(result);
  }
}

/// GET /v2/blockchain/masterchain/{masterchain_seqno}/shards
class TonApiGetBlockchainMasterchainShards
    extends TonApiRequest<BlockchainBlockShards, Map<String, dynamic>> {
  final int masterchainSeqno;

  TonApiGetBlockchainMasterchainShards({required this.masterchainSeqno});

  @override
  String get method => '/v2/blockchain/masterchain/{masterchain_seqno}/shards';

  @override
  List<String> get pathParameters => [masterchainSeqno.toString()];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  BlockchainBlockShards onResponse(Map<String, dynamic> result) {
    return BlockchainBlockShards.fromJson(result);
  }
}

/// GET /v2/blockchain/masterchain/{masterchain_seqno}/transactions
class TonApiGetBlockchainMasterchainTransactions
    extends TonApiRequest<Transactions, Map<String, dynamic>> {
  final int masterchainSeqno;
  final int? offset;
  final int? limit;

  TonApiGetBlockchainMasterchainTransactions({
    required this.masterchainSeqno,
    this.offset,
    this.limit,
  });

  @override
  String get method =>
      '/v2/blockchain/masterchain/{masterchain_seqno}/transactions';

  @override
  List<String> get pathParameters => [masterchainSeqno.toString()];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'offset': offset?.toString(),
    'limit': limit?.toString(),
  };

  @override
  Transactions onResponse(Map<String, dynamic> result) {
    return Transactions.fromJson(result);
  }
}

/// POST /v2/blockchain/message
class TonApiSendBlockchainMessage extends TonApiPostRequest<dynamic, String> {
  final List<String>? batch;
  final String? boc;
  final Map<String, String>? meta;

  TonApiSendBlockchainMessage({this.batch, this.boc, this.meta});

  @override
  String get method => '/v2/blockchain/message';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'batch': batch,
        'boc': boc,
        'meta': meta,
      });

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /v2/blockchain/messages/{msg_id}/transaction
class TonApiGetBlockchainTransactionByMessageHash
    extends TonApiRequest<Transaction, Map<String, dynamic>> {
  final String msgId;

  TonApiGetBlockchainTransactionByMessageHash({required this.msgId});

  @override
  String get method => '/v2/blockchain/messages/{msg_id}/transaction';

  @override
  List<String> get pathParameters => [msgId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Transaction onResponse(Map<String, dynamic> result) {
    return Transaction.fromJson(result);
  }
}

/// GET /v2/blockchain/reduced/blocks
class TonApiGetReducedBlockchainBlocks
    extends TonApiRequest<ReducedBlocks, Map<String, dynamic>> {
  final BigInt from;
  final BigInt to;

  TonApiGetReducedBlockchainBlocks({required this.from, required this.to});

  @override
  String get method => '/v2/blockchain/reduced/blocks';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {
    'from': from.toString(),
    'to': to.toString(),
  };

  @override
  ReducedBlocks onResponse(Map<String, dynamic> result) {
    return ReducedBlocks.fromJson(result);
  }
}

/// GET /v2/blockchain/transactions/{transaction_id}
class TonApiGetBlockchainTransaction
    extends TonApiRequest<Transaction, Map<String, dynamic>> {
  final String transactionId;

  TonApiGetBlockchainTransaction({required this.transactionId});

  @override
  String get method => '/v2/blockchain/transactions/{transaction_id}';

  @override
  List<String> get pathParameters => [transactionId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Transaction onResponse(Map<String, dynamic> result) {
    return Transaction.fromJson(result);
  }
}

/// GET /v2/blockchain/validators
class TonApiGetBlockchainValidators
    extends TonApiRequest<Validators, Map<String, dynamic>> {
  TonApiGetBlockchainValidators();

  @override
  String get method => '/v2/blockchain/validators';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Validators onResponse(Map<String, dynamic> result) {
    return Validators.fromJson(result);
  }
}

/// GET /v2/dns/auctions
class TonApiGetAllAuctions
    extends TonApiRequest<Auctions, Map<String, dynamic>> {
  final String? tld;

  TonApiGetAllAuctions({this.tld});

  @override
  String get method => '/v2/dns/auctions';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {'tld': tld};

  @override
  Auctions onResponse(Map<String, dynamic> result) {
    return Auctions.fromJson(result);
  }
}

/// GET /v2/dns/{domain_name}
class TonApiGetDnsInfo extends TonApiRequest<DomainInfo, Map<String, dynamic>> {
  final String domainName;

  TonApiGetDnsInfo({required this.domainName});

  @override
  String get method => '/v2/dns/{domain_name}';

  @override
  List<String> get pathParameters => [domainName];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  DomainInfo onResponse(Map<String, dynamic> result) {
    return DomainInfo.fromJson(result);
  }
}

/// GET /v2/dns/{domain_name}/bids
class TonApiGetDomainBids
    extends TonApiRequest<DomainBids, Map<String, dynamic>> {
  final String domainName;

  TonApiGetDomainBids({required this.domainName});

  @override
  String get method => '/v2/dns/{domain_name}/bids';

  @override
  List<String> get pathParameters => [domainName];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  DomainBids onResponse(Map<String, dynamic> result) {
    return DomainBids.fromJson(result);
  }
}

/// GET /v2/dns/{domain_name}/resolve
class TonApiDnsResolve extends TonApiRequest<DnsRecord, Map<String, dynamic>> {
  final String domainName;
  final bool? filter;

  TonApiDnsResolve({required this.domainName, this.filter});

  @override
  String get method => '/v2/dns/{domain_name}/resolve';

  @override
  List<String> get pathParameters => [domainName];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {'filter': filter?.toString()};

  @override
  DnsRecord onResponse(Map<String, dynamic> result) {
    return DnsRecord.fromJson(result);
  }
}

/// POST /v2/events/emulate
class TonApiEmulateMessageToEvent
    extends TonApiPostRequest<Event, Map<String, dynamic>> {
  final bool? ignoreSignatureCheck;
  final String boc;

  TonApiEmulateMessageToEvent({this.ignoreSignatureCheck, required this.boc});

  @override
  String get method => '/v2/events/emulate';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic> get queryParameters => {
    'ignore_signature_check': ignoreSignatureCheck?.toString(),
  };

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'boc': boc});

  @override
  Event onResponse(Map<String, dynamic> result) {
    return Event.fromJson(result);
  }
}

/// GET /v2/events/{event_id}
class TonApiGetEvent extends TonApiRequest<Event, Map<String, dynamic>> {
  final String eventId;

  TonApiGetEvent({required this.eventId});

  @override
  String get method => '/v2/events/{event_id}';

  @override
  List<String> get pathParameters => [eventId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Event onResponse(Map<String, dynamic> result) {
    return Event.fromJson(result);
  }
}

/// GET /v2/events/{event_id}/jettons
class TonApiGetJettonsEvents
    extends TonApiRequest<Event, Map<String, dynamic>> {
  final String eventId;

  TonApiGetJettonsEvents({required this.eventId});

  @override
  String get method => '/v2/events/{event_id}/jettons';

  @override
  List<String> get pathParameters => [eventId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Event onResponse(Map<String, dynamic> result) {
    return Event.fromJson(result);
  }
}

/// GET /v2/extra-currency/{id}
class TonApiGetExtraCurrencyInfo
    extends TonApiRequest<EcPreview, Map<String, dynamic>> {
  final int id;

  TonApiGetExtraCurrencyInfo({required this.id});

  @override
  String get method => '/v2/extra-currency/{id}';

  @override
  List<String> get pathParameters => [id.toString()];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  EcPreview onResponse(Map<String, dynamic> result) {
    return EcPreview.fromJson(result);
  }
}

/// GET /v2/gasless/config
class TonApiGaslessConfig
    extends TonApiRequest<GaslessConfig, Map<String, dynamic>> {
  TonApiGaslessConfig();

  @override
  String get method => '/v2/gasless/config';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  GaslessConfig onResponse(Map<String, dynamic> result) {
    return GaslessConfig.fromJson(result);
  }
}

/// POST /v2/gasless/estimate/{master_id}
class TonApiGaslessEstimate
    extends TonApiPostRequest<SignRawParams, Map<String, dynamic>> {
  final String masterId;
  final List<EmulateMessageToAccountEventBody> messages;
  final bool? returnEmulation;
  final bool? throwErrorIfNotEnoughJettons;
  final String walletAddress;
  final String walletPublicKey;

  TonApiGaslessEstimate({
    required this.masterId,
    required this.messages,
    this.returnEmulation,
    this.throwErrorIfNotEnoughJettons,
    required this.walletAddress,
    required this.walletPublicKey,
  });

  @override
  String get method => '/v2/gasless/estimate/{master_id}';

  @override
  List<String> get pathParameters => [masterId];

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'messages': messages.map((e) => e.toJson(config: config)).toList(),
        'return_emulation': returnEmulation,
        'throw_error_if_not_enough_jettons': throwErrorIfNotEnoughJettons,
        'wallet_address': walletAddress,
        'wallet_public_key': walletPublicKey,
      });

  @override
  SignRawParams onResponse(Map<String, dynamic> result) {
    return SignRawParams.fromJson(result);
  }
}

/// POST /v2/gasless/send
class TonApiGaslessSend
    extends TonApiPostRequest<GaslessTx, Map<String, dynamic>> {
  final String boc;
  final String? walletPublicKey;

  TonApiGaslessSend({required this.boc, this.walletPublicKey});

  @override
  String get method => '/v2/gasless/send';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'boc': boc,
        'wallet_public_key': walletPublicKey,
      });

  @override
  GaslessTx onResponse(Map<String, dynamic> result) {
    return GaslessTx.fromJson(result);
  }
}

/// GET /v2/jettons
class TonApiGetJettons extends TonApiRequest<Jettons, Map<String, dynamic>> {
  final int? limit;
  final int? offset;
  final String? lastAccountId;

  TonApiGetJettons({this.limit, this.offset, this.lastAccountId});

  @override
  String get method => '/v2/jettons';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'limit': limit?.toString(),
    'offset': offset?.toString(),
    'last_account_id': lastAccountId,
  };

  @override
  Jettons onResponse(Map<String, dynamic> result) {
    return Jettons.fromJson(result);
  }
}

/// POST /v2/jettons/_bulk
class TonApiGetJettonInfosByAddresses
    extends TonApiPostRequest<Jettons, Map<String, dynamic>> {
  final List<String> accountIds;

  TonApiGetJettonInfosByAddresses({required this.accountIds});

  @override
  String get method => '/v2/jettons/_bulk';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'account_ids': accountIds});

  @override
  Jettons onResponse(Map<String, dynamic> result) {
    return Jettons.fromJson(result);
  }
}

/// GET /v2/jettons/{account_id}
class TonApiGetJettonInfo
    extends TonApiRequest<JettonInfo, Map<String, dynamic>> {
  final String accountId;

  TonApiGetJettonInfo({required this.accountId});

  @override
  String get method => '/v2/jettons/{account_id}';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  JettonInfo onResponse(Map<String, dynamic> result) {
    return JettonInfo.fromJson(result);
  }
}

/// GET /v2/jettons/{account_id}/holders
class TonApiGetJettonHolders
    extends TonApiRequest<JettonHolders, Map<String, dynamic>> {
  final String accountId;
  final int? limit;
  final int? offset;
  final SortBy? sortBy;
  final String? lastAccountId;

  TonApiGetJettonHolders({
    required this.accountId,
    this.limit,
    this.offset,
    this.sortBy,
    this.lastAccountId,
  });

  @override
  String get method => '/v2/jettons/{account_id}/holders';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'limit': limit?.toString(),
    'offset': offset?.toString(),
    'sort_by': sortBy?.toJson(),
    'last_account_id': lastAccountId,
  };

  @override
  JettonHolders onResponse(Map<String, dynamic> result) {
    return JettonHolders.fromJson(result);
  }
}

/// GET /v2/jettons/{jetton_id}/accounts/{account_id}/history
class TonApiGetJettonAccountHistoryByID
    extends TonApiRequest<JettonOperations, Map<String, dynamic>> {
  final String accountId;
  final String jettonId;
  final BigInt? beforeLt;
  final int limit;
  final BigInt? startDate;
  final BigInt? endDate;

  TonApiGetJettonAccountHistoryByID({
    required this.accountId,
    required this.jettonId,
    this.beforeLt,
    required this.limit,
    this.startDate,
    this.endDate,
  });

  @override
  String get method => '/v2/jettons/{jetton_id}/accounts/{account_id}/history';

  @override
  List<String> get pathParameters => [accountId, jettonId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'before_lt': beforeLt?.toString(),
    'limit': limit.toString(),
    'start_date': startDate?.toString(),
    'end_date': endDate?.toString(),
  };

  @override
  JettonOperations onResponse(Map<String, dynamic> result) {
    return JettonOperations.fromJson(result);
  }
}

/// GET /v2/jettons/{jetton_id}/transfer/{account_id}/payload
class TonApiGetJettonTransferPayload
    extends TonApiRequest<JettonTransferPayload, Map<String, dynamic>> {
  final String accountId;
  final String jettonId;

  TonApiGetJettonTransferPayload({
    required this.accountId,
    required this.jettonId,
  });

  @override
  String get method => '/v2/jettons/{jetton_id}/transfer/{account_id}/payload';

  @override
  List<String> get pathParameters => [accountId, jettonId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  JettonTransferPayload onResponse(Map<String, dynamic> result) {
    return JettonTransferPayload.fromJson(result);
  }
}

/// GET /v2/liteserver/get_account_state/{account_id}
class TonApiGetRawAccountState
    extends TonApiRequest<ResponseGetRawAccountState, Map<String, dynamic>> {
  final String accountId;
  final String? targetBlock;

  TonApiGetRawAccountState({required this.accountId, this.targetBlock});

  @override
  String get method => '/v2/liteserver/get_account_state/{account_id}';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {'target_block': targetBlock};

  @override
  ResponseGetRawAccountState onResponse(Map<String, dynamic> result) {
    return ResponseGetRawAccountState.fromJson(result);
  }
}

/// GET /v2/liteserver/get_all_shards_info/{block_id}
class TonApiGetAllRawShardsInfo
    extends TonApiRequest<ResponseGetAllRawShardsInfo, Map<String, dynamic>> {
  final String blockId;

  TonApiGetAllRawShardsInfo({required this.blockId});

  @override
  String get method => '/v2/liteserver/get_all_shards_info/{block_id}';

  @override
  List<String> get pathParameters => [blockId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ResponseGetAllRawShardsInfo onResponse(Map<String, dynamic> result) {
    return ResponseGetAllRawShardsInfo.fromJson(result);
  }
}

/// GET /v2/liteserver/get_block/{block_id}
class TonApiGetRawBlockchainBlock
    extends TonApiRequest<ResponseGetRawBlockchainBlock, Map<String, dynamic>> {
  final String blockId;

  TonApiGetRawBlockchainBlock({required this.blockId});

  @override
  String get method => '/v2/liteserver/get_block/{block_id}';

  @override
  List<String> get pathParameters => [blockId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ResponseGetRawBlockchainBlock onResponse(Map<String, dynamic> result) {
    return ResponseGetRawBlockchainBlock.fromJson(result);
  }
}

/// GET /v2/liteserver/get_block_header/{block_id}
class TonApiGetRawBlockchainBlockHeader
    extends
        TonApiRequest<
          ResponseGetRawBlockchainBlockHeader,
          Map<String, dynamic>
        > {
  final String blockId;
  final int mode;

  TonApiGetRawBlockchainBlockHeader({
    required this.blockId,
    required this.mode,
  });

  @override
  String get method => '/v2/liteserver/get_block_header/{block_id}';

  @override
  List<String> get pathParameters => [blockId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'mode': mode.toString()};

  @override
  ResponseGetRawBlockchainBlockHeader onResponse(Map<String, dynamic> result) {
    return ResponseGetRawBlockchainBlockHeader.fromJson(result);
  }
}

/// GET /v2/liteserver/get_block_proof
class TonApiGetRawBlockProof
    extends TonApiRequest<ResponseGetRawBlockProof, Map<String, dynamic>> {
  final String knownBlock;
  final String? targetBlock;
  final int mode;

  TonApiGetRawBlockProof({
    required this.knownBlock,
    this.targetBlock,
    required this.mode,
  });

  @override
  String get method => '/v2/liteserver/get_block_proof';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'known_block': knownBlock,
    'target_block': targetBlock,
    'mode': mode.toString(),
  };

  @override
  ResponseGetRawBlockProof onResponse(Map<String, dynamic> result) {
    return ResponseGetRawBlockProof.fromJson(result);
  }
}

/// GET /v2/liteserver/get_config_all/{block_id}
class TonApiGetRawConfig
    extends TonApiRequest<ResponseGetRawConfig, Map<String, dynamic>> {
  final String blockId;
  final int mode;

  TonApiGetRawConfig({required this.blockId, required this.mode});

  @override
  String get method => '/v2/liteserver/get_config_all/{block_id}';

  @override
  List<String> get pathParameters => [blockId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'mode': mode.toString()};

  @override
  ResponseGetRawConfig onResponse(Map<String, dynamic> result) {
    return ResponseGetRawConfig.fromJson(result);
  }
}

/// GET /v2/liteserver/get_masterchain_info
class TonApiGetRawMasterchainInfo
    extends TonApiRequest<ResponseGetRawMasterchainInfo, Map<String, dynamic>> {
  TonApiGetRawMasterchainInfo();

  @override
  String get method => '/v2/liteserver/get_masterchain_info';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ResponseGetRawMasterchainInfo onResponse(Map<String, dynamic> result) {
    return ResponseGetRawMasterchainInfo.fromJson(result);
  }
}

/// GET /v2/liteserver/get_masterchain_info_ext
class TonApiGetRawMasterchainInfoExt
    extends
        TonApiRequest<ResponseGetRawMasterchainInfoExt, Map<String, dynamic>> {
  final int mode;

  TonApiGetRawMasterchainInfoExt({required this.mode});

  @override
  String get method => '/v2/liteserver/get_masterchain_info_ext';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'mode': mode.toString()};

  @override
  ResponseGetRawMasterchainInfoExt onResponse(Map<String, dynamic> result) {
    return ResponseGetRawMasterchainInfoExt.fromJson(result);
  }
}

/// GET /v2/liteserver/get_out_msg_queue_sizes
class TonApiGetOutMsgQueueSizes
    extends TonApiRequest<ResponseGetOutMsgQueueSizes, Map<String, dynamic>> {
  TonApiGetOutMsgQueueSizes();

  @override
  String get method => '/v2/liteserver/get_out_msg_queue_sizes';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ResponseGetOutMsgQueueSizes onResponse(Map<String, dynamic> result) {
    return ResponseGetOutMsgQueueSizes.fromJson(result);
  }
}

/// GET /v2/liteserver/get_shard_block_proof/{block_id}
class TonApiGetRawShardBlockProof
    extends TonApiRequest<ResponseGetRawShardBlockProof, Map<String, dynamic>> {
  final String blockId;

  TonApiGetRawShardBlockProof({required this.blockId});

  @override
  String get method => '/v2/liteserver/get_shard_block_proof/{block_id}';

  @override
  List<String> get pathParameters => [blockId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ResponseGetRawShardBlockProof onResponse(Map<String, dynamic> result) {
    return ResponseGetRawShardBlockProof.fromJson(result);
  }
}

/// GET /v2/liteserver/get_shard_info/{block_id}
class TonApiGetRawShardInfo
    extends TonApiRequest<ResponseGetRawShardInfo, Map<String, dynamic>> {
  final String blockId;
  final int workchain;
  final BigInt shard;
  final bool exact;

  TonApiGetRawShardInfo({
    required this.blockId,
    required this.workchain,
    required this.shard,
    required this.exact,
  });

  @override
  String get method => '/v2/liteserver/get_shard_info/{block_id}';

  @override
  List<String> get pathParameters => [blockId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {
    'workchain': workchain.toString(),
    'shard': shard.toString(),
    'exact': exact.toString(),
  };

  @override
  ResponseGetRawShardInfo onResponse(Map<String, dynamic> result) {
    return ResponseGetRawShardInfo.fromJson(result);
  }
}

/// GET /v2/liteserver/get_state/{block_id}
class TonApiGetRawBlockchainBlockState
    extends
        TonApiRequest<
          ResponseGetRawBlockchainBlockState,
          Map<String, dynamic>
        > {
  final String blockId;

  TonApiGetRawBlockchainBlockState({required this.blockId});

  @override
  String get method => '/v2/liteserver/get_state/{block_id}';

  @override
  List<String> get pathParameters => [blockId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ResponseGetRawBlockchainBlockState onResponse(Map<String, dynamic> result) {
    return ResponseGetRawBlockchainBlockState.fromJson(result);
  }
}

/// GET /v2/liteserver/get_time
class TonApiGetRawTime
    extends TonApiRequest<ResponseGetRawTime, Map<String, dynamic>> {
  TonApiGetRawTime();

  @override
  String get method => '/v2/liteserver/get_time';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ResponseGetRawTime onResponse(Map<String, dynamic> result) {
    return ResponseGetRawTime.fromJson(result);
  }
}

/// GET /v2/liteserver/get_transactions/{account_id}
class TonApiGetRawTransactions
    extends TonApiRequest<ResponseGetRawTransactions, Map<String, dynamic>> {
  final String accountId;
  final int count;
  final BigInt lt;
  final String hash;

  TonApiGetRawTransactions({
    required this.accountId,
    required this.count,
    required this.lt,
    required this.hash,
  });

  @override
  String get method => '/v2/liteserver/get_transactions/{account_id}';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {
    'count': count.toString(),
    'lt': lt.toString(),
    'hash': hash,
  };

  @override
  ResponseGetRawTransactions onResponse(Map<String, dynamic> result) {
    return ResponseGetRawTransactions.fromJson(result);
  }
}

/// GET /v2/liteserver/list_block_transactions/{block_id}
class TonApiGetRawListBlockTransactions
    extends
        TonApiRequest<
          ResponseGetRawListBlockTransactions,
          Map<String, dynamic>
        > {
  final String blockId;
  final int mode;
  final int count;
  final String? accountId;
  final BigInt? lt;

  TonApiGetRawListBlockTransactions({
    required this.blockId,
    required this.mode,
    required this.count,
    this.accountId,
    this.lt,
  });

  @override
  String get method => '/v2/liteserver/list_block_transactions/{block_id}';

  @override
  List<String> get pathParameters => [blockId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'mode': mode.toString(),
    'count': count.toString(),
    'account_id': accountId,
    'lt': lt?.toString(),
  };

  @override
  ResponseGetRawListBlockTransactions onResponse(Map<String, dynamic> result) {
    return ResponseGetRawListBlockTransactions.fromJson(result);
  }
}

/// POST /v2/liteserver/send_message
class TonApiSendRawMessage
    extends TonApiPostRequest<ResponseSendRawMessage, Map<String, dynamic>> {
  final String body_;

  TonApiSendRawMessage({required this.body_});

  @override
  String get method => '/v2/liteserver/send_message';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'body': body_});

  @override
  ResponseSendRawMessage onResponse(Map<String, dynamic> result) {
    return ResponseSendRawMessage.fromJson(result);
  }
}

/// POST /v2/message/decode
class TonApiDecodeMessage
    extends TonApiPostRequest<DecodedMessage, Map<String, dynamic>> {
  final String boc;

  TonApiDecodeMessage({required this.boc});

  @override
  String get method => '/v2/message/decode';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'boc': boc});

  @override
  DecodedMessage onResponse(Map<String, dynamic> result) {
    return DecodedMessage.fromJson(result);
  }
}

/// POST /v2/migration/prepare
class TonApiPrepareMigration
    extends TonApiPostRequest<MigrationPrepareResponse, Map<String, dynamic>> {
  final String? currency;
  final String from;
  final String? gasJettonMaster;
  final MigrationPrepareRequestGasPayer? gasPayer;
  final String? publicKey;
  final String to;

  TonApiPrepareMigration({
    this.currency,
    required this.from,
    this.gasJettonMaster,
    this.gasPayer,
    this.publicKey,
    required this.to,
  });

  @override
  String get method => '/v2/migration/prepare';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'currency': currency,
        'from': from,
        'gas_jetton_master': gasJettonMaster,
        'gas_payer': gasPayer?.toJson(config: config),
        'public_key': publicKey,
        'to': to,
      });

  @override
  MigrationPrepareResponse onResponse(Map<String, dynamic> result) {
    return MigrationPrepareResponse.fromJson(result);
  }
}

/// POST /v2/migration/wallets
class TonApiGetMigrationWallets
    extends TonApiPostRequest<MigrationWallets, Map<String, dynamic>> {
  final List<String>? currencies;
  final List<String> accountIds;

  TonApiGetMigrationWallets({this.currencies, required this.accountIds});

  @override
  String get method => '/v2/migration/wallets';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic> get queryParameters => {
    'currencies': currencies?.join(','),
  };

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'account_ids': accountIds});

  @override
  MigrationWallets onResponse(Map<String, dynamic> result) {
    return MigrationWallets.fromJson(result);
  }
}

/// GET /v2/multisig/order/{account_id}
class TonApiGetMultisigOrder
    extends TonApiRequest<MultisigOrder, Map<String, dynamic>> {
  final String accountId;

  TonApiGetMultisigOrder({required this.accountId});

  @override
  String get method => '/v2/multisig/order/{account_id}';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  MultisigOrder onResponse(Map<String, dynamic> result) {
    return MultisigOrder.fromJson(result);
  }
}

/// GET /v2/multisig/{account_id}
class TonApiGetMultisigAccount
    extends TonApiRequest<Multisig, Map<String, dynamic>> {
  final String accountId;

  TonApiGetMultisigAccount({required this.accountId});

  @override
  String get method => '/v2/multisig/{account_id}';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Multisig onResponse(Map<String, dynamic> result) {
    return Multisig.fromJson(result);
  }
}

/// POST /v2/nfts/_bulk
class TonApiGetNftItemsByAddresses
    extends TonApiPostRequest<NftItems, Map<String, dynamic>> {
  final List<String> accountIds;

  TonApiGetNftItemsByAddresses({required this.accountIds});

  @override
  String get method => '/v2/nfts/_bulk';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'account_ids': accountIds});

  @override
  NftItems onResponse(Map<String, dynamic> result) {
    return NftItems.fromJson(result);
  }
}

/// GET /v2/nfts/collections
class TonApiGetNftCollections
    extends TonApiRequest<NftCollections, Map<String, dynamic>> {
  final int? limit;
  final int? offset;

  TonApiGetNftCollections({this.limit, this.offset});

  @override
  String get method => '/v2/nfts/collections';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'limit': limit?.toString(),
    'offset': offset?.toString(),
  };

  @override
  NftCollections onResponse(Map<String, dynamic> result) {
    return NftCollections.fromJson(result);
  }
}

/// POST /v2/nfts/collections/_bulk
class TonApiGetNftCollectionItemsByAddresses
    extends TonApiPostRequest<NftCollections, Map<String, dynamic>> {
  final List<String> accountIds;

  TonApiGetNftCollectionItemsByAddresses({required this.accountIds});

  @override
  String get method => '/v2/nfts/collections/_bulk';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'account_ids': accountIds});

  @override
  NftCollections onResponse(Map<String, dynamic> result) {
    return NftCollections.fromJson(result);
  }
}

/// GET /v2/nfts/collections/{account_id}
class TonApiGetNftCollection
    extends TonApiRequest<NftCollection, Map<String, dynamic>> {
  final String accountId;

  TonApiGetNftCollection({required this.accountId});

  @override
  String get method => '/v2/nfts/collections/{account_id}';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  NftCollection onResponse(Map<String, dynamic> result) {
    return NftCollection.fromJson(result);
  }
}

/// GET /v2/nfts/collections/{account_id}/items
class TonApiGetItemsFromCollection
    extends TonApiRequest<NftItems, Map<String, dynamic>> {
  final String accountId;
  final int? limit;
  final int? offset;

  TonApiGetItemsFromCollection({
    required this.accountId,
    this.limit,
    this.offset,
  });

  @override
  String get method => '/v2/nfts/collections/{account_id}/items';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'limit': limit?.toString(),
    'offset': offset?.toString(),
  };

  @override
  NftItems onResponse(Map<String, dynamic> result) {
    return NftItems.fromJson(result);
  }
}

/// GET /v2/nfts/{account_id}
class TonApiGetNftItemByAddress
    extends TonApiRequest<NftItem, Map<String, dynamic>> {
  final String accountId;

  TonApiGetNftItemByAddress({required this.accountId});

  @override
  String get method => '/v2/nfts/{account_id}';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  NftItem onResponse(Map<String, dynamic> result) {
    return NftItem.fromJson(result);
  }
}

/// GET /v2/nfts/{account_id}/history
class TonApiGetNftHistoryByID
    extends TonApiRequest<AccountEvents, Map<String, dynamic>> {
  final String accountId;
  final BigInt? beforeLt;
  final int limit;
  final BigInt? startDate;
  final BigInt? endDate;

  TonApiGetNftHistoryByID({
    required this.accountId,
    this.beforeLt,
    required this.limit,
    this.startDate,
    this.endDate,
  });

  @override
  String get method => '/v2/nfts/{account_id}/history';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'before_lt': beforeLt?.toString(),
    'limit': limit.toString(),
    'start_date': startDate?.toString(),
    'end_date': endDate?.toString(),
  };

  @override
  AccountEvents onResponse(Map<String, dynamic> result) {
    return AccountEvents.fromJson(result);
  }
}

/// GET /v2/openapi.json
class TonApiGetOpenapiJson extends TonApiRequest<dynamic, dynamic> {
  TonApiGetOpenapiJson();

  @override
  String get method => '/v2/openapi.json';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  dynamic onResponse(dynamic result) {
    return result;
  }
}

/// GET /v2/openapi.yml
class TonApiGetOpenapiYml extends TonApiRequest<String, String> {
  TonApiGetOpenapiYml();

  @override
  String get method => '/v2/openapi.yml';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  String onResponse(String result) {
    return result;
  }
}

/// POST /v2/pubkeys/wallets/_bulk
class TonApiGetWalletsByPublicKeyBulk
    extends TonApiPostRequest<WalletsByPublicKeys, Map<String, dynamic>> {
  final List<String> publicKeys;

  TonApiGetWalletsByPublicKeyBulk({required this.publicKeys});

  @override
  String get method => '/v2/pubkeys/wallets/_bulk';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'public_keys': publicKeys});

  @override
  WalletsByPublicKeys onResponse(Map<String, dynamic> result) {
    return WalletsByPublicKeys.fromJson(result);
  }
}

/// GET /v2/pubkeys/{public_key}/wallets
class TonApiGetWalletsByPublicKey
    extends TonApiRequest<Wallets, Map<String, dynamic>> {
  final String publicKey;

  TonApiGetWalletsByPublicKey({required this.publicKey});

  @override
  String get method => '/v2/pubkeys/{public_key}/wallets';

  @override
  List<String> get pathParameters => [publicKey];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Wallets onResponse(Map<String, dynamic> result) {
    return Wallets.fromJson(result);
  }
}

/// GET /v2/purchases/{account_id}/history
class TonApiGetPurchaseHistory
    extends TonApiRequest<AccountPurchases, Map<String, dynamic>> {
  final String accountId;
  final BigInt? beforeLt;
  final int? limit;

  TonApiGetPurchaseHistory({
    required this.accountId,
    this.beforeLt,
    this.limit,
  });

  @override
  String get method => '/v2/purchases/{account_id}/history';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'before_lt': beforeLt?.toString(),
    'limit': limit?.toString(),
  };

  @override
  AccountPurchases onResponse(Map<String, dynamic> result) {
    return AccountPurchases.fromJson(result);
  }
}

/// GET /v2/rates
class TonApiGetRates
    extends TonApiRequest<ResponseGetRates, Map<String, dynamic>> {
  final List<String> tokens;
  final List<String> currencies;

  TonApiGetRates({required this.tokens, required this.currencies});

  @override
  String get method => '/v2/rates';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {
    'tokens': tokens.join(','),
    'currencies': currencies.join(','),
  };

  @override
  ResponseGetRates onResponse(Map<String, dynamic> result) {
    return ResponseGetRates.fromJson(result);
  }
}

/// GET /v2/rates/chart
class TonApiGetChartRates
    extends TonApiRequest<ResponseGetChartRates, Map<String, dynamic>> {
  final String token;
  final String? currency;
  final BigInt? startDate;
  final BigInt? endDate;
  final int? pointsCount;

  TonApiGetChartRates({
    required this.token,
    this.currency,
    this.startDate,
    this.endDate,
    this.pointsCount,
  });

  @override
  String get method => '/v2/rates/chart';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'token': token,
    'currency': currency,
    'start_date': startDate?.toString(),
    'end_date': endDate?.toString(),
    'points_count': pointsCount?.toString(),
  };

  @override
  ResponseGetChartRates onResponse(Map<String, dynamic> result) {
    return ResponseGetChartRates.fromJson(result);
  }
}

/// GET /v2/rates/markets
class TonApiGetMarketsRates
    extends TonApiRequest<ResponseGetMarketsRates, Map<String, dynamic>> {
  TonApiGetMarketsRates();

  @override
  String get method => '/v2/rates/markets';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ResponseGetMarketsRates onResponse(Map<String, dynamic> result) {
    return ResponseGetMarketsRates.fromJson(result);
  }
}

/// GET /v2/rewards/apy
class TonApiGetRewardsApy extends TonApiRequest<double, double> {
  TonApiGetRewardsApy();

  @override
  String get method => '/v2/rewards/apy';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  double onResponse(double result) {
    return result;
  }
}

/// GET /v2/rewards/round-rewards
class TonApiGetRoundRewards
    extends TonApiRequest<RoundRewardsResponse, Map<String, dynamic>> {
  final BigInt? electionId;
  final int? block;
  final int? unixtime;
  final bool? shallow;

  TonApiGetRoundRewards({
    this.electionId,
    this.block,
    this.unixtime,
    this.shallow,
  });

  @override
  String get method => '/v2/rewards/round-rewards';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'election_id': electionId?.toString(),
    'block': block?.toString(),
    'unixtime': unixtime?.toString(),
    'shallow': shallow?.toString(),
  };

  @override
  RoundRewardsResponse onResponse(Map<String, dynamic> result) {
    return RoundRewardsResponse.fromJson(result);
  }
}

/// GET /v2/rewards/stats
class TonApiGetRewardsStats
    extends TonApiRequest<RewardsStats, Map<String, dynamic>> {
  TonApiGetRewardsStats();

  @override
  String get method => '/v2/rewards/stats';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  RewardsStats onResponse(Map<String, dynamic> result) {
    return RewardsStats.fromJson(result);
  }
}

/// GET /v2/rewards/validation-rounds
class TonApiGetValidationRounds
    extends TonApiRequest<ValidationRoundsResponse, Map<String, dynamic>> {
  final BigInt? electionId;
  final int? block;
  final int? unixtime;

  TonApiGetValidationRounds({this.electionId, this.block, this.unixtime});

  @override
  String get method => '/v2/rewards/validation-rounds';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'election_id': electionId?.toString(),
    'block': block?.toString(),
    'unixtime': unixtime?.toString(),
  };

  @override
  ValidationRoundsResponse onResponse(Map<String, dynamic> result) {
    return ValidationRoundsResponse.fromJson(result);
  }
}

/// GET /v2/rewards/validators
class TonApiGetValidators
    extends TonApiRequest<ValidatorsResponse, Map<String, dynamic>> {
  final int? seqno;
  final int? unixtime;
  final bool? shallow;

  TonApiGetValidators({this.seqno, this.unixtime, this.shallow});

  @override
  String get method => '/v2/rewards/validators';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'seqno': seqno?.toString(),
    'unixtime': unixtime?.toString(),
    'shallow': shallow?.toString(),
  };

  @override
  ValidatorsResponse onResponse(Map<String, dynamic> result) {
    return ValidatorsResponse.fromJson(result);
  }
}

/// GET /v2/staking/nominator/{account_id}/pools
class TonApiGetAccountNominatorsPools
    extends TonApiRequest<AccountStaking, Map<String, dynamic>> {
  final String accountId;

  TonApiGetAccountNominatorsPools({required this.accountId});

  @override
  String get method => '/v2/staking/nominator/{account_id}/pools';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  AccountStaking onResponse(Map<String, dynamic> result) {
    return AccountStaking.fromJson(result);
  }
}

/// GET /v2/staking/pool/{account_id}
class TonApiGetStakingPoolInfo
    extends TonApiRequest<ResponseGetStakingPoolInfo, Map<String, dynamic>> {
  final String accountId;

  TonApiGetStakingPoolInfo({required this.accountId});

  @override
  String get method => '/v2/staking/pool/{account_id}';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ResponseGetStakingPoolInfo onResponse(Map<String, dynamic> result) {
    return ResponseGetStakingPoolInfo.fromJson(result);
  }
}

/// GET /v2/staking/pool/{account_id}/history
class TonApiGetStakingPoolHistory
    extends TonApiRequest<ResponseGetStakingPoolHistory, Map<String, dynamic>> {
  final String accountId;
  final BigInt? beforeLt;
  final int? limit;

  TonApiGetStakingPoolHistory({
    required this.accountId,
    this.beforeLt,
    this.limit,
  });

  @override
  String get method => '/v2/staking/pool/{account_id}/history';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'before_lt': beforeLt?.toString(),
    'limit': limit?.toString(),
  };

  @override
  ResponseGetStakingPoolHistory onResponse(Map<String, dynamic> result) {
    return ResponseGetStakingPoolHistory.fromJson(result);
  }
}

/// GET /v2/staking/pools
class TonApiGetStakingPools
    extends TonApiRequest<ResponseGetStakingPools, Map<String, dynamic>> {
  final String? availableFor;
  final bool? includeUnverified;

  TonApiGetStakingPools({this.availableFor, this.includeUnverified});

  @override
  String get method => '/v2/staking/pools';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, dynamic> get queryParameters => {
    'available_for': availableFor,
    'include_unverified': includeUnverified?.toString(),
  };

  @override
  ResponseGetStakingPools onResponse(Map<String, dynamic> result) {
    return ResponseGetStakingPools.fromJson(result);
  }
}

/// GET /v2/status
class TonApiStatus extends TonApiRequest<ServiceStatus, Map<String, dynamic>> {
  TonApiStatus();

  @override
  String get method => '/v2/status';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ServiceStatus onResponse(Map<String, dynamic> result) {
    return ServiceStatus.fromJson(result);
  }
}

/// GET /v2/storage/providers
class TonApiGetStorageProviders
    extends TonApiRequest<ResponseGetStorageProviders, Map<String, dynamic>> {
  TonApiGetStorageProviders();

  @override
  String get method => '/v2/storage/providers';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ResponseGetStorageProviders onResponse(Map<String, dynamic> result) {
    return ResponseGetStorageProviders.fromJson(result);
  }
}

/// GET /v2/tonconnect/payload
class TonApiGetTonConnectPayload
    extends TonApiRequest<ResponseGetTonConnectPayload, Map<String, dynamic>> {
  TonApiGetTonConnectPayload();

  @override
  String get method => '/v2/tonconnect/payload';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  ResponseGetTonConnectPayload onResponse(Map<String, dynamic> result) {
    return ResponseGetTonConnectPayload.fromJson(result);
  }
}

/// POST /v2/tonconnect/stateinit
class TonApiGetAccountInfoByStateInit
    extends TonApiPostRequest<AccountInfoByStateInit, Map<String, dynamic>> {
  final String stateInit;

  TonApiGetAccountInfoByStateInit({required this.stateInit});

  @override
  String get method => '/v2/tonconnect/stateinit';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'state_init': stateInit});

  @override
  AccountInfoByStateInit onResponse(Map<String, dynamic> result) {
    return AccountInfoByStateInit.fromJson(result);
  }
}

/// POST /v2/traces/emulate
class TonApiEmulateMessageToTrace
    extends TonApiPostRequest<Trace, Map<String, dynamic>> {
  final bool? ignoreSignatureCheck;
  final String boc;

  TonApiEmulateMessageToTrace({this.ignoreSignatureCheck, required this.boc});

  @override
  String get method => '/v2/traces/emulate';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic> get queryParameters => {
    'ignore_signature_check': ignoreSignatureCheck?.toString(),
  };

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'boc': boc});

  @override
  Trace onResponse(Map<String, dynamic> result) {
    return Trace.fromJson(result);
  }
}

/// GET /v2/traces/{trace_id}
class TonApiGetTrace extends TonApiRequest<Trace, Map<String, dynamic>> {
  final String traceId;

  TonApiGetTrace({required this.traceId});

  @override
  String get method => '/v2/traces/{trace_id}';

  @override
  List<String> get pathParameters => [traceId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Trace onResponse(Map<String, dynamic> result) {
    return Trace.fromJson(result);
  }
}

/// POST /v2/wallet/auth/proof
class TonApiTonConnectProof
    extends TonApiPostRequest<ResponseTonConnectProof, Map<String, dynamic>> {
  final String address;
  final TonConnectProofBodyProof proof;

  TonApiTonConnectProof({required this.address, required this.proof});

  @override
  String get method => '/v2/wallet/auth/proof';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'proof': proof.toJson(config: config),
      });

  @override
  ResponseTonConnectProof onResponse(Map<String, dynamic> result) {
    return ResponseTonConnectProof.fromJson(result);
  }
}

/// POST /v2/wallet/emulate
class TonApiEmulateMessageToWallet
    extends TonApiPostRequest<MessageConsequences, Map<String, dynamic>> {
  final String? currency;
  final String? addressOverride;
  final String boc;
  final List<EmulateMessageToWalletBodyParamsItem>? params_;

  TonApiEmulateMessageToWallet({
    this.currency,
    this.addressOverride,
    required this.boc,
    this.params_,
  });

  @override
  String get method => '/v2/wallet/emulate';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  Map<String, dynamic> get queryParameters => {'currency': currency};

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address_override': addressOverride,
        'boc': boc,
        'params': params_?.map((e) => e.toJson(config: config)).toList(),
      });

  @override
  MessageConsequences onResponse(Map<String, dynamic> result) {
    return MessageConsequences.fromJson(result);
  }
}

/// GET /v2/wallet/{account_id}
class TonApiGetWalletInfo extends TonApiRequest<Wallet, Map<String, dynamic>> {
  final String accountId;

  TonApiGetWalletInfo({required this.accountId});

  @override
  String get method => '/v2/wallet/{account_id}';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Wallet onResponse(Map<String, dynamic> result) {
    return Wallet.fromJson(result);
  }
}

/// GET /v2/wallet/{account_id}/seqno
class TonApiGetAccountSeqno extends TonApiRequest<Seqno, Map<String, dynamic>> {
  final String accountId;

  TonApiGetAccountSeqno({required this.accountId});

  @override
  String get method => '/v2/wallet/{account_id}/seqno';

  @override
  List<String> get pathParameters => [accountId];

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Seqno onResponse(Map<String, dynamic> result) {
    return Seqno.fromJson(result);
  }
}
