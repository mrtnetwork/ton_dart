// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'toncenter_v3_models.dart';

/// GET /api/v3/accountStates
class TonCenterV3GetAccountStates
    extends
        TonCenterV3RequestParam<AccountStatesResponse, Map<String, dynamic>> {
  final String address;
  final String? includeBoc;

  TonCenterV3GetAccountStates({required this.address, this.includeBoc});

  @override
  String get method => '/api/v3/accountStates';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'address': address,
    'include_boc': includeBoc,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  AccountStatesResponse onResponse(Map<String, dynamic> result) {
    return AccountStatesResponse.fromJson(result);
  }
}

/// GET /api/v3/actions
class TonCenterV3GetActions
    extends TonCenterV3RequestParam<ActionsResponse, Map<String, dynamic>> {
  final String? account;
  final String? txHash;
  final String? msgHash;
  final String? actionId;
  final String? traceId;
  final String? mcSeqno;
  final String? startUtime;
  final String? endUtime;
  final String? startLt;
  final String? endLt;
  final String? actionType;
  final String? excludeActionType;
  final String? supportedActionTypes;
  final String? includeAccounts;
  final String? includeTransactions;
  final String? limit;
  final String? offset;
  final String? cursor;
  final String? sort;

  TonCenterV3GetActions({
    this.account,
    this.txHash,
    this.msgHash,
    this.actionId,
    this.traceId,
    this.mcSeqno,
    this.startUtime,
    this.endUtime,
    this.startLt,
    this.endLt,
    this.actionType,
    this.excludeActionType,
    this.supportedActionTypes,
    this.includeAccounts,
    this.includeTransactions,
    this.limit,
    this.offset,
    this.cursor,
    this.sort,
  });

  @override
  String get method => '/api/v3/actions';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'account': account,
    'tx_hash': txHash,
    'msg_hash': msgHash,
    'action_id': actionId,
    'trace_id': traceId,
    'mc_seqno': mcSeqno,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'start_lt': startLt,
    'end_lt': endLt,
    'action_type': actionType,
    'exclude_action_type': excludeActionType,
    'supported_action_types': supportedActionTypes,
    'include_accounts': includeAccounts,
    'include_transactions': includeTransactions,
    'limit': limit,
    'offset': offset,
    'cursor': cursor,
    'sort': sort,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  ActionsResponse onResponse(Map<String, dynamic> result) {
    return ActionsResponse.fromJson(result);
  }
}

/// GET /api/v3/addressBook
class TonCenterV3GetAddressBook
    extends TonCenterV3RequestParam<GenericAddressBook, Map<String, dynamic>> {
  final String address;

  TonCenterV3GetAddressBook({required this.address});

  @override
  String get method => '/api/v3/addressBook';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'address': address};

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  GenericAddressBook onResponse(Map<String, dynamic> result) {
    return GenericAddressBook.fromJson(result);
  }
}

/// GET /api/v3/addressInformation
class TonCenterV3GetV2AddressInformation
    extends
        TonCenterV3RequestParam<V2AddressInformation, Map<String, dynamic>> {
  final String address;
  final String? useV2;

  TonCenterV3GetV2AddressInformation({required this.address, this.useV2});

  @override
  String get method => '/api/v3/addressInformation';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'address': address,
    'use_v2': useV2,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  V2AddressInformation onResponse(Map<String, dynamic> result) {
    return V2AddressInformation.fromJson(result);
  }
}

/// GET /api/v3/adjacentTransactions
class TonCenterV3GetAdjacentTransactions
    extends
        TonCenterV3RequestParam<TransactionsResponse, Map<String, dynamic>> {
  final String? hash;
  final String? direction;

  TonCenterV3GetAdjacentTransactions({this.hash, this.direction});

  @override
  String get method => '/api/v3/adjacentTransactions';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'hash': hash,
    'direction': direction,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  TransactionsResponse onResponse(Map<String, dynamic> result) {
    return TransactionsResponse.fromJson(result);
  }
}

/// GET /api/v3/blocks
class TonCenterV3GetBlocks
    extends TonCenterV3RequestParam<BlocksResponse, Map<String, dynamic>> {
  final String? workchain;
  final String? shard;
  final String? seqno;
  final String? rootHash;
  final String? fileHash;
  final String? mcSeqno;
  final String? startUtime;
  final String? endUtime;
  final String? startLt;
  final String? endLt;
  final String? limit;
  final String? offset;
  final String? sort;

  TonCenterV3GetBlocks({
    this.workchain,
    this.shard,
    this.seqno,
    this.rootHash,
    this.fileHash,
    this.mcSeqno,
    this.startUtime,
    this.endUtime,
    this.startLt,
    this.endLt,
    this.limit,
    this.offset,
    this.sort,
  });

  @override
  String get method => '/api/v3/blocks';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'workchain': workchain,
    'shard': shard,
    'seqno': seqno,
    'root_hash': rootHash,
    'file_hash': fileHash,
    'mc_seqno': mcSeqno,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'start_lt': startLt,
    'end_lt': endLt,
    'limit': limit,
    'offset': offset,
    'sort': sort,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  BlocksResponse onResponse(Map<String, dynamic> result) {
    return BlocksResponse.fromJson(result);
  }
}

/// GET /api/v3/decode
class TonCenterV3GetDecode
    extends TonCenterV3RequestParam<DecodeResponse, Map<String, dynamic>> {
  final String? opcodes;
  final String? bodies;

  TonCenterV3GetDecode({this.opcodes, this.bodies});

  @override
  String get method => '/api/v3/decode';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'opcodes': opcodes,
    'bodies': bodies,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  DecodeResponse onResponse(Map<String, dynamic> result) {
    return DecodeResponse.fromJson(result);
  }
}

/// POST /api/v3/decode
class TonCenterV3PostDecode
    extends TonCenterV3PostRequestParam<DecodeResponse, Map<String, dynamic>> {
  final List<String>? bodies;
  final List<String>? opcodes;

  TonCenterV3PostDecode({this.bodies, this.opcodes});

  @override
  String get method => '/api/v3/decode';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'bodies': bodies, 'opcodes': opcodes});

  @override
  DecodeResponse onResponse(Map<String, dynamic> result) {
    return DecodeResponse.fromJson(result);
  }
}

/// GET /api/v3/dns/activeAuctions
class TonCenterV3GetDnsActiveAuctions
    extends TonCenterV3RequestParam<DNSAuctionsResponse, Map<String, dynamic>> {
  final String bidder;
  final String? state;
  final String? includeNftItems;
  final String? after;
  final String? limit;
  final String? offset;

  TonCenterV3GetDnsActiveAuctions({
    required this.bidder,
    this.state,
    this.includeNftItems,
    this.after,
    this.limit,
    this.offset,
  });

  @override
  String get method => '/api/v3/dns/activeAuctions';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'bidder': bidder,
    'state': state,
    'include_nft_items': includeNftItems,
    'after': after,
    'limit': limit,
    'offset': offset,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  DNSAuctionsResponse onResponse(Map<String, dynamic> result) {
    return DNSAuctionsResponse.fromJson(result);
  }
}

/// GET /api/v3/dns/records
class TonCenterV3GetDnsRecords
    extends TonCenterV3RequestParam<DNSRecordsResponse, Map<String, dynamic>> {
  final String? wallet;
  final String? domain;
  final String? limit;
  final String? offset;

  TonCenterV3GetDnsRecords({this.wallet, this.domain, this.limit, this.offset});

  @override
  String get method => '/api/v3/dns/records';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'wallet': wallet,
    'domain': domain,
    'limit': limit,
    'offset': offset,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  DNSRecordsResponse onResponse(Map<String, dynamic> result) {
    return DNSRecordsResponse.fromJson(result);
  }
}

/// POST /api/v3/estimateFee
class TonCenterV3PostV2EstimateFee
    extends
        TonCenterV3PostRequestParam<V2EstimateFeeResult, Map<String, dynamic>> {
  final String? address;
  final String? body_;
  final bool? ignoreChksig;
  final String? initCode;
  final String? initData;

  TonCenterV3PostV2EstimateFee({
    this.address,
    this.body_,
    this.ignoreChksig,
    this.initCode,
    this.initData,
  });

  @override
  String get method => '/api/v3/estimateFee';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'body': body_,
        'ignore_chksig': ignoreChksig,
        'init_code': initCode,
        'init_data': initData,
      });

  @override
  V2EstimateFeeResult onResponse(Map<String, dynamic> result) {
    return V2EstimateFeeResult.fromJson(result);
  }
}

/// GET /api/v3/jetton/burns
class TonCenterV3GetJettonBurns
    extends TonCenterV3RequestParam<JettonBurnsResponse, Map<String, dynamic>> {
  final String? address;
  final String? jettonWallet;
  final String? jettonMaster;
  final String? startUtime;
  final String? endUtime;
  final String? startLt;
  final String? endLt;
  final String? limit;
  final String? offset;
  final String? sort;

  TonCenterV3GetJettonBurns({
    this.address,
    this.jettonWallet,
    this.jettonMaster,
    this.startUtime,
    this.endUtime,
    this.startLt,
    this.endLt,
    this.limit,
    this.offset,
    this.sort,
  });

  @override
  String get method => '/api/v3/jetton/burns';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'address': address,
    'jetton_wallet': jettonWallet,
    'jetton_master': jettonMaster,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'start_lt': startLt,
    'end_lt': endLt,
    'limit': limit,
    'offset': offset,
    'sort': sort,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  JettonBurnsResponse onResponse(Map<String, dynamic> result) {
    return JettonBurnsResponse.fromJson(result);
  }
}

/// GET /api/v3/jetton/masters
class TonCenterV3GetJettonMasters
    extends
        TonCenterV3RequestParam<JettonMastersResponse, Map<String, dynamic>> {
  final String? address;
  final String? adminAddress;
  final String? limit;
  final String? offset;

  TonCenterV3GetJettonMasters({
    this.address,
    this.adminAddress,
    this.limit,
    this.offset,
  });

  @override
  String get method => '/api/v3/jetton/masters';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'address': address,
    'admin_address': adminAddress,
    'limit': limit,
    'offset': offset,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  JettonMastersResponse onResponse(Map<String, dynamic> result) {
    return JettonMastersResponse.fromJson(result);
  }
}

/// GET /api/v3/jetton/transfers
class TonCenterV3GetJettonTransfers
    extends
        TonCenterV3RequestParam<JettonTransfersResponse, Map<String, dynamic>> {
  final String? ownerAddress;
  final String? jettonWallet;
  final String? jettonMaster;
  final String? direction;
  final String? startUtime;
  final String? endUtime;
  final String? startLt;
  final String? endLt;
  final String? limit;
  final String? offset;
  final String? sort;

  TonCenterV3GetJettonTransfers({
    this.ownerAddress,
    this.jettonWallet,
    this.jettonMaster,
    this.direction,
    this.startUtime,
    this.endUtime,
    this.startLt,
    this.endLt,
    this.limit,
    this.offset,
    this.sort,
  });

  @override
  String get method => '/api/v3/jetton/transfers';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'owner_address': ownerAddress,
    'jetton_wallet': jettonWallet,
    'jetton_master': jettonMaster,
    'direction': direction,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'start_lt': startLt,
    'end_lt': endLt,
    'limit': limit,
    'offset': offset,
    'sort': sort,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  JettonTransfersResponse onResponse(Map<String, dynamic> result) {
    return JettonTransfersResponse.fromJson(result);
  }
}

/// GET /api/v3/jetton/wallets
class TonCenterV3GetJettonWallets
    extends
        TonCenterV3RequestParam<JettonWalletsResponse, Map<String, dynamic>> {
  final String? address;
  final String? ownerAddress;
  final String? jettonAddress;
  final String? excludeZeroBalance;
  final String? limit;
  final String? offset;
  final String? sort;

  TonCenterV3GetJettonWallets({
    this.address,
    this.ownerAddress,
    this.jettonAddress,
    this.excludeZeroBalance,
    this.limit,
    this.offset,
    this.sort,
  });

  @override
  String get method => '/api/v3/jetton/wallets';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'address': address,
    'owner_address': ownerAddress,
    'jetton_address': jettonAddress,
    'exclude_zero_balance': excludeZeroBalance,
    'limit': limit,
    'offset': offset,
    'sort': sort,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  JettonWalletsResponse onResponse(Map<String, dynamic> result) {
    return JettonWalletsResponse.fromJson(result);
  }
}

/// GET /api/v3/masterchainBlockShardState
class TonCenterV3GetMasterchainBlockShardState
    extends
        TonCenterV3RequestParam<TransactionsResponse, Map<String, dynamic>> {
  final String seqno;

  TonCenterV3GetMasterchainBlockShardState({required this.seqno});

  @override
  String get method => '/api/v3/masterchainBlockShardState';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'seqno': seqno};

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  TransactionsResponse onResponse(Map<String, dynamic> result) {
    return TransactionsResponse.fromJson(result);
  }
}

/// GET /api/v3/masterchainBlockShards
class TonCenterV3GetMasterchainBlockShards
    extends
        TonCenterV3RequestParam<TransactionsResponse, Map<String, dynamic>> {
  final String seqno;
  final String? limit;
  final String? offset;

  TonCenterV3GetMasterchainBlockShards({
    required this.seqno,
    this.limit,
    this.offset,
  });

  @override
  String get method => '/api/v3/masterchainBlockShards';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'seqno': seqno,
    'limit': limit,
    'offset': offset,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  TransactionsResponse onResponse(Map<String, dynamic> result) {
    return TransactionsResponse.fromJson(result);
  }
}

/// GET /api/v3/masterchainInfo
class TonCenterV3GetMasterchainInfo
    extends TonCenterV3RequestParam<MasterchainInfo, Map<String, dynamic>> {
  TonCenterV3GetMasterchainInfo();

  @override
  String get method => '/api/v3/masterchainInfo';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  MasterchainInfo onResponse(Map<String, dynamic> result) {
    return MasterchainInfo.fromJson(result);
  }
}

/// POST /api/v3/message
class TonCenterV3PostV2Message
    extends
        TonCenterV3PostRequestParam<V2SendMessageResult, Map<String, dynamic>> {
  final String? boc;

  TonCenterV3PostV2Message({this.boc});

  @override
  String get method => '/api/v3/message';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'boc': boc});

  @override
  V2SendMessageResult onResponse(Map<String, dynamic> result) {
    return V2SendMessageResult.fromJson(result);
  }
}

/// GET /api/v3/messages
class TonCenterV3GetMessages
    extends TonCenterV3RequestParam<MessagesResponse, Map<String, dynamic>> {
  final String? msgHash;
  final String? bodyHash;
  final String? source;
  final String? destination;
  final String? opcode;
  final String? startUtime;
  final String? endUtime;
  final String? startLt;
  final String? endLt;
  final String? direction;
  final String? excludeExternals;
  final String? onlyExternals;
  final String? limit;
  final String? offset;
  final String? sort;

  TonCenterV3GetMessages({
    this.msgHash,
    this.bodyHash,
    this.source,
    this.destination,
    this.opcode,
    this.startUtime,
    this.endUtime,
    this.startLt,
    this.endLt,
    this.direction,
    this.excludeExternals,
    this.onlyExternals,
    this.limit,
    this.offset,
    this.sort,
  });

  @override
  String get method => '/api/v3/messages';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'msg_hash': msgHash,
    'body_hash': bodyHash,
    'source': source,
    'destination': destination,
    'opcode': opcode,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'start_lt': startLt,
    'end_lt': endLt,
    'direction': direction,
    'exclude_externals': excludeExternals,
    'only_externals': onlyExternals,
    'limit': limit,
    'offset': offset,
    'sort': sort,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  MessagesResponse onResponse(Map<String, dynamic> result) {
    return MessagesResponse.fromJson(result);
  }
}

/// GET /api/v3/metadata
class TonCenterV3GetMetadata
    extends TonCenterV3RequestParam<Metadata, Map<String, dynamic>> {
  final String address;

  TonCenterV3GetMetadata({required this.address});

  @override
  String get method => '/api/v3/metadata';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'address': address};

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  Metadata onResponse(Map<String, dynamic> result) {
    return Metadata.fromJson(result);
  }
}

/// GET /api/v3/multisig/orders
class TonCenterV3GetMultisigOrders
    extends
        TonCenterV3RequestParam<MultisigOrderResponse, Map<String, dynamic>> {
  final String? address;
  final String? multisigAddress;
  final String? parseActions;
  final String? limit;
  final String? offset;
  final String? sort;

  TonCenterV3GetMultisigOrders({
    this.address,
    this.multisigAddress,
    this.parseActions,
    this.limit,
    this.offset,
    this.sort,
  });

  @override
  String get method => '/api/v3/multisig/orders';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'address': address,
    'multisig_address': multisigAddress,
    'parse_actions': parseActions,
    'limit': limit,
    'offset': offset,
    'sort': sort,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  MultisigOrderResponse onResponse(Map<String, dynamic> result) {
    return MultisigOrderResponse.fromJson(result);
  }
}

/// GET /api/v3/multisig/wallets
class TonCenterV3GetMultisigWallets
    extends TonCenterV3RequestParam<MultisigResponse, Map<String, dynamic>> {
  final String? address;
  final String? walletAddress;
  final String? limit;
  final String? offset;
  final String? sort;
  final String? includeOrders;

  TonCenterV3GetMultisigWallets({
    this.address,
    this.walletAddress,
    this.limit,
    this.offset,
    this.sort,
    this.includeOrders,
  });

  @override
  String get method => '/api/v3/multisig/wallets';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'address': address,
    'wallet_address': walletAddress,
    'limit': limit,
    'offset': offset,
    'sort': sort,
    'include_orders': includeOrders,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  MultisigResponse onResponse(Map<String, dynamic> result) {
    return MultisigResponse.fromJson(result);
  }
}

/// GET /api/v3/nft/collections
class TonCenterV3GetNftCollections
    extends
        TonCenterV3RequestParam<NFTCollectionsResponse, Map<String, dynamic>> {
  final String? collectionAddress;
  final String? ownerAddress;
  final String? limit;
  final String? offset;

  TonCenterV3GetNftCollections({
    this.collectionAddress,
    this.ownerAddress,
    this.limit,
    this.offset,
  });

  @override
  String get method => '/api/v3/nft/collections';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'collection_address': collectionAddress,
    'owner_address': ownerAddress,
    'limit': limit,
    'offset': offset,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  NFTCollectionsResponse onResponse(Map<String, dynamic> result) {
    return NFTCollectionsResponse.fromJson(result);
  }
}

/// GET /api/v3/nft/items
class TonCenterV3GetNftItems
    extends TonCenterV3RequestParam<NFTItemsResponse, Map<String, dynamic>> {
  final String? address;
  final String? ownerAddress;
  final String? collectionAddress;
  final String? index;
  final String? includeOnSale;
  final String? sortByLastTransactionLt;
  final String? limit;
  final String? offset;

  TonCenterV3GetNftItems({
    this.address,
    this.ownerAddress,
    this.collectionAddress,
    this.index,
    this.includeOnSale,
    this.sortByLastTransactionLt,
    this.limit,
    this.offset,
  });

  @override
  String get method => '/api/v3/nft/items';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'address': address,
    'owner_address': ownerAddress,
    'collection_address': collectionAddress,
    'index': index,
    'include_on_sale': includeOnSale,
    'sort_by_last_transaction_lt': sortByLastTransactionLt,
    'limit': limit,
    'offset': offset,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  NFTItemsResponse onResponse(Map<String, dynamic> result) {
    return NFTItemsResponse.fromJson(result);
  }
}

/// GET /api/v3/nft/sales
class TonCenterV3GetNftSales
    extends TonCenterV3RequestParam<NFTSalesResponse, Map<String, dynamic>> {
  final String address;

  TonCenterV3GetNftSales({required this.address});

  @override
  String get method => '/api/v3/nft/sales';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'address': address};

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  NFTSalesResponse onResponse(Map<String, dynamic> result) {
    return NFTSalesResponse.fromJson(result);
  }
}

/// GET /api/v3/nft/transfers
class TonCenterV3GetNftTransfers
    extends
        TonCenterV3RequestParam<NFTTransfersResponse, Map<String, dynamic>> {
  final String? ownerAddress;
  final String? itemAddress;
  final String? collectionAddress;
  final String? direction;
  final String? startUtime;
  final String? endUtime;
  final String? startLt;
  final String? endLt;
  final String? limit;
  final String? offset;
  final String? sort;

  TonCenterV3GetNftTransfers({
    this.ownerAddress,
    this.itemAddress,
    this.collectionAddress,
    this.direction,
    this.startUtime,
    this.endUtime,
    this.startLt,
    this.endLt,
    this.limit,
    this.offset,
    this.sort,
  });

  @override
  String get method => '/api/v3/nft/transfers';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'owner_address': ownerAddress,
    'item_address': itemAddress,
    'collection_address': collectionAddress,
    'direction': direction,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'start_lt': startLt,
    'end_lt': endLt,
    'limit': limit,
    'offset': offset,
    'sort': sort,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  NFTTransfersResponse onResponse(Map<String, dynamic> result) {
    return NFTTransfersResponse.fromJson(result);
  }
}

/// GET /api/v3/pendingActions
class TonCenterV3GetPendingActions
    extends TonCenterV3RequestParam<ActionsResponse, Map<String, dynamic>> {
  final String? account;
  final String? extMsgHash;
  final String? supportedActionTypes;
  final String? includeTransactions;

  TonCenterV3GetPendingActions({
    this.account,
    this.extMsgHash,
    this.supportedActionTypes,
    this.includeTransactions,
  });

  @override
  String get method => '/api/v3/pendingActions';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'account': account,
    'ext_msg_hash': extMsgHash,
    'supported_action_types': supportedActionTypes,
    'include_transactions': includeTransactions,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  ActionsResponse onResponse(Map<String, dynamic> result) {
    return ActionsResponse.fromJson(result);
  }
}

/// GET /api/v3/pendingTraces
class TonCenterV3GetPendingTraces
    extends TonCenterV3RequestParam<TracesResponse, Map<String, dynamic>> {
  final String? account;
  final String? extMsgHash;

  TonCenterV3GetPendingTraces({this.account, this.extMsgHash});

  @override
  String get method => '/api/v3/pendingTraces';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'account': account,
    'ext_msg_hash': extMsgHash,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  TracesResponse onResponse(Map<String, dynamic> result) {
    return TracesResponse.fromJson(result);
  }
}

/// GET /api/v3/pendingTransactions
class TonCenterV3GetPendingTransactions
    extends
        TonCenterV3RequestParam<TransactionsResponse, Map<String, dynamic>> {
  final String? account;
  final String? traceId;

  TonCenterV3GetPendingTransactions({this.account, this.traceId});

  @override
  String get method => '/api/v3/pendingTransactions';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'account': account,
    'trace_id': traceId,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  TransactionsResponse onResponse(Map<String, dynamic> result) {
    return TransactionsResponse.fromJson(result);
  }
}

/// POST /api/v3/runGetMethod
class TonCenterV3PostV2Rungetmethod
    extends
        TonCenterV3PostRequestParam<
          Map<String, dynamic>,
          Map<String, dynamic>
        > {
  final String? address;
  final String? method_;
  final List<V2StackEntity>? stack;

  TonCenterV3PostV2Rungetmethod({this.address, this.method_, this.stack});

  @override
  String get method => '/api/v3/runGetMethod';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'method': method_,
        'stack': stack?.map((e) => e.toJson(config: config)).toList(),
      });

  /// NOTE: the spec references V2RunGetMethodRequest for this
  /// response; the real payload is the execution result, so it
  /// is returned as a raw map until the spec is fixed.
  @override
  Map<String, dynamic> onResponse(Map<String, dynamic> result) {
    return result;
  }
}

/// GET /api/v3/staking/nominatorPools/nominator
class TonCenterV3GetNominatorPoolNominator
    extends
        TonCenterV3RequestParam<NominatorPoolsResponse, Map<String, dynamic>> {
  final String nominator;

  TonCenterV3GetNominatorPoolNominator({required this.nominator});

  @override
  String get method => '/api/v3/staking/nominatorPools/nominator';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'nominator': nominator};

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  NominatorPoolsResponse onResponse(Map<String, dynamic> result) {
    return NominatorPoolsResponse.fromJson(result);
  }
}

/// GET /api/v3/staking/nominatorPools/nominatorEvents
class TonCenterV3GetNominatorPoolNominatorEvents
    extends
        TonCenterV3RequestParam<
          NominatorPoolEventsResponse,
          Map<String, dynamic>
        > {
  final String pool;
  final String? nominator;
  final String? startUtime;
  final String? endUtime;
  final String? limit;

  TonCenterV3GetNominatorPoolNominatorEvents({
    required this.pool,
    this.nominator,
    this.startUtime,
    this.endUtime,
    this.limit,
  });

  @override
  String get method => '/api/v3/staking/nominatorPools/nominatorEvents';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'pool': pool,
    'nominator': nominator,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'limit': limit,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  NominatorPoolEventsResponse onResponse(Map<String, dynamic> result) {
    return NominatorPoolEventsResponse.fromJson(result);
  }
}

/// GET /api/v3/staking/nominatorPools/nominatorRewards
class TonCenterV3GetNominatorPoolNominatorRewards
    extends
        TonCenterV3RequestParam<
          NominatorRewardsResponse,
          Map<String, dynamic>
        > {
  final String nominator;
  final String pool;
  final String? startUtime;
  final String? endUtime;
  final String? limit;

  TonCenterV3GetNominatorPoolNominatorRewards({
    required this.nominator,
    required this.pool,
    this.startUtime,
    this.endUtime,
    this.limit,
  });

  @override
  String get method => '/api/v3/staking/nominatorPools/nominatorRewards';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'nominator': nominator,
    'pool': pool,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'limit': limit,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  NominatorRewardsResponse onResponse(Map<String, dynamic> result) {
    return NominatorRewardsResponse.fromJson(result);
  }
}

/// GET /api/v3/staking/nominatorPools/pool
class TonCenterV3GetNominatorPool
    extends TonCenterV3RequestParam<NominatorPoolInfo, Map<String, dynamic>> {
  final String pool;

  TonCenterV3GetNominatorPool({required this.pool});

  @override
  String get method => '/api/v3/staking/nominatorPools/pool';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'pool': pool};

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  NominatorPoolInfo onResponse(Map<String, dynamic> result) {
    return NominatorPoolInfo.fromJson(result);
  }
}

/// GET /api/v3/staking/nominatorPools/validatorEvents
class TonCenterV3GetNominatorPoolValidatorEvents
    extends
        TonCenterV3RequestParam<
          NominatorPoolValidatorEventsResponse,
          Map<String, dynamic>
        > {
  final String? validator;
  final String? pool;
  final String? type;
  final String? startUtime;
  final String? endUtime;
  final String? limit;

  TonCenterV3GetNominatorPoolValidatorEvents({
    this.validator,
    this.pool,
    this.type,
    this.startUtime,
    this.endUtime,
    this.limit,
  });

  @override
  String get method => '/api/v3/staking/nominatorPools/validatorEvents';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'validator': validator,
    'pool': pool,
    'type': type,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'limit': limit,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  NominatorPoolValidatorEventsResponse onResponse(Map<String, dynamic> result) {
    return NominatorPoolValidatorEventsResponse.fromJson(result);
  }
}

/// GET /api/v3/staking/nominatorPools/validatorRewards
class TonCenterV3GetNominatorPoolValidatorRewards
    extends
        TonCenterV3RequestParam<
          NominatorPoolValidatorRewardsResponse,
          Map<String, dynamic>
        > {
  final String validator;
  final String pool;
  final String? startUtime;
  final String? endUtime;
  final String? limit;

  TonCenterV3GetNominatorPoolValidatorRewards({
    required this.validator,
    required this.pool,
    this.startUtime,
    this.endUtime,
    this.limit,
  });

  @override
  String get method => '/api/v3/staking/nominatorPools/validatorRewards';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'validator': validator,
    'pool': pool,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'limit': limit,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  NominatorPoolValidatorRewardsResponse onResponse(
    Map<String, dynamic> result,
  ) {
    return NominatorPoolValidatorRewardsResponse.fromJson(result);
  }
}

/// GET /api/v3/topAccountsByBalance
class TonCenterV3GetTopAccountsByBalance
    extends TonCenterV3RequestParam<List<AccountBalance>, List<dynamic>> {
  final String? limit;
  final String? offset;

  TonCenterV3GetTopAccountsByBalance({this.limit, this.offset});

  @override
  String get method => '/api/v3/topAccountsByBalance';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'limit': limit,
    'offset': offset,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  List<AccountBalance> onResponse(List<dynamic> result) {
    return result.map((e) => AccountBalance.fromJson(e)).toList();
  }
}

/// GET /api/v3/traces
class TonCenterV3GetTraces
    extends TonCenterV3RequestParam<TracesResponse, Map<String, dynamic>> {
  final String? account;
  final String? traceId;
  final String? txHash;
  final String? msgHash;
  final String? mcSeqno;
  final String? startUtime;
  final String? endUtime;
  final String? startLt;
  final String? endLt;
  final String? includeActions;
  final String? supportedActionTypes;
  final String? limit;
  final String? offset;
  final String? sort;

  TonCenterV3GetTraces({
    this.account,
    this.traceId,
    this.txHash,
    this.msgHash,
    this.mcSeqno,
    this.startUtime,
    this.endUtime,
    this.startLt,
    this.endLt,
    this.includeActions,
    this.supportedActionTypes,
    this.limit,
    this.offset,
    this.sort,
  });

  @override
  String get method => '/api/v3/traces';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'account': account,
    'trace_id': traceId,
    'tx_hash': txHash,
    'msg_hash': msgHash,
    'mc_seqno': mcSeqno,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'start_lt': startLt,
    'end_lt': endLt,
    'include_actions': includeActions,
    'supported_action_types': supportedActionTypes,
    'limit': limit,
    'offset': offset,
    'sort': sort,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  TracesResponse onResponse(Map<String, dynamic> result) {
    return TracesResponse.fromJson(result);
  }
}

/// GET /api/v3/transactions
class TonCenterV3GetTransactions
    extends
        TonCenterV3RequestParam<TransactionsResponse, Map<String, dynamic>> {
  final String? workchain;
  final String? shard;
  final String? seqno;
  final String? mcSeqno;
  final String? account;
  final String? excludeAccount;
  final String? hash;
  final String? lt;
  final String? startUtime;
  final String? endUtime;
  final String? startLt;
  final String? endLt;
  final String? limit;
  final String? offset;
  final String? sort;

  TonCenterV3GetTransactions({
    this.workchain,
    this.shard,
    this.seqno,
    this.mcSeqno,
    this.account,
    this.excludeAccount,
    this.hash,
    this.lt,
    this.startUtime,
    this.endUtime,
    this.startLt,
    this.endLt,
    this.limit,
    this.offset,
    this.sort,
  });

  @override
  String get method => '/api/v3/transactions';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'workchain': workchain,
    'shard': shard,
    'seqno': seqno,
    'mc_seqno': mcSeqno,
    'account': account,
    'exclude_account': excludeAccount,
    'hash': hash,
    'lt': lt,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'start_lt': startLt,
    'end_lt': endLt,
    'limit': limit,
    'offset': offset,
    'sort': sort,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  TransactionsResponse onResponse(Map<String, dynamic> result) {
    return TransactionsResponse.fromJson(result);
  }
}

/// GET /api/v3/transactionsByMasterchainBlock
class TonCenterV3GetTransactionsByMasterchainBlock
    extends
        TonCenterV3RequestParam<TransactionsResponse, Map<String, dynamic>> {
  final String seqno;
  final String? limit;
  final String? offset;
  final String? sort;

  TonCenterV3GetTransactionsByMasterchainBlock({
    required this.seqno,
    this.limit,
    this.offset,
    this.sort,
  });

  @override
  String get method => '/api/v3/transactionsByMasterchainBlock';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'seqno': seqno,
    'limit': limit,
    'offset': offset,
    'sort': sort,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  TransactionsResponse onResponse(Map<String, dynamic> result) {
    return TransactionsResponse.fromJson(result);
  }
}

/// GET /api/v3/transactionsByMessage
class TonCenterV3GetTransactionsByMessage
    extends
        TonCenterV3RequestParam<TransactionsResponse, Map<String, dynamic>> {
  final String? msgHash;
  final String? bodyHash;
  final String? opcode;
  final String? direction;
  final String? limit;
  final String? offset;

  TonCenterV3GetTransactionsByMessage({
    this.msgHash,
    this.bodyHash,
    this.opcode,
    this.direction,
    this.limit,
    this.offset,
  });

  @override
  String get method => '/api/v3/transactionsByMessage';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'msg_hash': msgHash,
    'body_hash': bodyHash,
    'opcode': opcode,
    'direction': direction,
    'limit': limit,
    'offset': offset,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  TransactionsResponse onResponse(Map<String, dynamic> result) {
    return TransactionsResponse.fromJson(result);
  }
}

/// GET /api/v3/validators/complaints
class TonCenterV3GetValidatorComplaints
    extends
        TonCenterV3RequestParam<
          ValidatorComplaintsResponse,
          Map<String, dynamic>
        > {
  final String? cycleStart;
  final String? electionId;
  final String? stakeHolderAddress;
  final String? adnlAddress;
  final String? validatorPubkey;
  final String? startUtime;
  final String? endUtime;
  final String? limit;

  TonCenterV3GetValidatorComplaints({
    this.cycleStart,
    this.electionId,
    this.stakeHolderAddress,
    this.adnlAddress,
    this.validatorPubkey,
    this.startUtime,
    this.endUtime,
    this.limit,
  });

  @override
  String get method => '/api/v3/validators/complaints';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'cycle_start': cycleStart,
    'election_id': electionId,
    'stake_holder_address': stakeHolderAddress,
    'adnl_address': adnlAddress,
    'validator_pubkey': validatorPubkey,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'limit': limit,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  ValidatorComplaintsResponse onResponse(Map<String, dynamic> result) {
    return ValidatorComplaintsResponse.fromJson(result);
  }
}

/// GET /api/v3/validators/cycles
class TonCenterV3GetValidatorCycles
    extends
        TonCenterV3RequestParam<ValidatorCyclesResponse, Map<String, dynamic>> {
  final String? cycleStart;
  final String? electionId;
  final String? stakeHolderAddress;
  final String? adnlAddress;
  final String? validatorPubkey;
  final String? returnValidators;
  final String? startUtime;
  final String? endUtime;
  final String? limit;

  TonCenterV3GetValidatorCycles({
    this.cycleStart,
    this.electionId,
    this.stakeHolderAddress,
    this.adnlAddress,
    this.validatorPubkey,
    this.returnValidators,
    this.startUtime,
    this.endUtime,
    this.limit,
  });

  @override
  String get method => '/api/v3/validators/cycles';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'cycle_start': cycleStart,
    'election_id': electionId,
    'stake_holder_address': stakeHolderAddress,
    'adnl_address': adnlAddress,
    'validator_pubkey': validatorPubkey,
    'return_validators': returnValidators,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'limit': limit,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  ValidatorCyclesResponse onResponse(Map<String, dynamic> result) {
    return ValidatorCyclesResponse.fromJson(result);
  }
}

/// GET /api/v3/validators/elections
class TonCenterV3GetValidatorElections
    extends
        TonCenterV3RequestParam<
          ValidatorElectionsResponse,
          Map<String, dynamic>
        > {
  final String? electionId;
  final String? stakeHolderAddress;
  final String? adnlAddress;
  final String? validatorPubkey;
  final String? returnParticipants;
  final String? finished;
  final String? startUtime;
  final String? endUtime;
  final String? limit;

  TonCenterV3GetValidatorElections({
    this.electionId,
    this.stakeHolderAddress,
    this.adnlAddress,
    this.validatorPubkey,
    this.returnParticipants,
    this.finished,
    this.startUtime,
    this.endUtime,
    this.limit,
  });

  @override
  String get method => '/api/v3/validators/elections';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'election_id': electionId,
    'stake_holder_address': stakeHolderAddress,
    'adnl_address': adnlAddress,
    'validator_pubkey': validatorPubkey,
    'return_participants': returnParticipants,
    'finished': finished,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'limit': limit,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  ValidatorElectionsResponse onResponse(Map<String, dynamic> result) {
    return ValidatorElectionsResponse.fromJson(result);
  }
}

/// GET /api/v3/validators/events
class TonCenterV3GetValidatorEvents
    extends
        TonCenterV3RequestParam<ValidatorEventsResponse, Map<String, dynamic>> {
  final String? stakeHolderAddress;
  final String? adnlAddress;
  final String? validatorPubkey;
  final String? type;
  final String? startUtime;
  final String? endUtime;
  final String? limit;

  TonCenterV3GetValidatorEvents({
    this.stakeHolderAddress,
    this.adnlAddress,
    this.validatorPubkey,
    this.type,
    this.startUtime,
    this.endUtime,
    this.limit,
  });

  @override
  String get method => '/api/v3/validators/events';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'stake_holder_address': stakeHolderAddress,
    'adnl_address': adnlAddress,
    'validator_pubkey': validatorPubkey,
    'type': type,
    'start_utime': startUtime,
    'end_utime': endUtime,
    'limit': limit,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  ValidatorEventsResponse onResponse(Map<String, dynamic> result) {
    return ValidatorEventsResponse.fromJson(result);
  }
}

/// GET /api/v3/vesting
class TonCenterV3GetVestingContracts
    extends
        TonCenterV3RequestParam<
          VestingContractsResponse,
          Map<String, dynamic>
        > {
  final String? contractAddress;
  final String? walletAddress;
  final String? checkWhitelist;
  final String? limit;
  final String? offset;

  TonCenterV3GetVestingContracts({
    this.contractAddress,
    this.walletAddress,
    this.checkWhitelist,
    this.limit,
    this.offset,
  });

  @override
  String get method => '/api/v3/vesting';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'contract_address': contractAddress,
    'wallet_address': walletAddress,
    'check_whitelist': checkWhitelist,
    'limit': limit,
    'offset': offset,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  VestingContractsResponse onResponse(Map<String, dynamic> result) {
    return VestingContractsResponse.fromJson(result);
  }
}

/// GET /api/v3/walletInformation
class TonCenterV3GetWalletInformation
    extends TonCenterV3RequestParam<V2WalletInformation, Map<String, dynamic>> {
  final String address;
  final String? useV2;

  TonCenterV3GetWalletInformation({required this.address, this.useV2});

  @override
  String get method => '/api/v3/walletInformation';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String?> get queryParameters => {
    'address': address,
    'use_v2': useV2,
  };

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  V2WalletInformation onResponse(Map<String, dynamic> result) {
    return V2WalletInformation.fromJson(result);
  }
}

/// GET /api/v3/walletStates
class TonCenterV3GetWalletStates
    extends
        TonCenterV3RequestParam<WalletStatesResponse, Map<String, dynamic>> {
  final String address;

  TonCenterV3GetWalletStates({required this.address});

  @override
  String get method => '/api/v3/walletStates';

  @override
  RequestMethod get requestMethod => RequestMethod.get;

  @override
  Map<String, String> get queryParameters => {'address': address};

  @override
  TonRequestDetails buildRequest(int v) {
    return super.buildRequest(v).copyWith(api: TonApiType.tonCenter);
  }

  @override
  WalletStatesResponse onResponse(Map<String, dynamic> result) {
    return WalletStatesResponse.fromJson(result);
  }
}
