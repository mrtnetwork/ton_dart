// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'toncenter_models.dart';

/// POST /api/v2/jsonRPC
class TonCenterJsonRPCPost
    extends TonApiPostRequest<JsonRpcResponseResult, dynamic> {
  final String jsonrpc;
  final String id;
  final String method_;
  final Map<String, dynamic> params_;

  TonCenterJsonRPCPost({
    required this.jsonrpc,
    required this.id,
    required this.method_,
    required this.params_,
  });

  @override
  String get method => '/api/v2/jsonRPC';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'jsonrpc': jsonrpc,
        'id': id,
        'method': method_,
        'params': params_,
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  JsonRpcResponseResult onResponse(dynamic result) {
    return JsonRpcResponseResult.fromJson(result);
  }
}

/// POST /api/v2/detectAddress
class TonCenterDetectAddressPost
    extends TonApiPostRequest<DetectAddress, Map<String, dynamic>> {
  final String address;

  TonCenterDetectAddressPost({required this.address});

  @override
  String get method => '/api/v2/detectAddress';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'address': address});

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  DetectAddress onResponse(Map<String, dynamic> result) {
    return DetectAddress.fromJson(result);
  }
}

/// POST /api/v2/detectHash
class TonCenterDetectHashPost
    extends TonApiPostRequest<DetectHash, Map<String, dynamic>> {
  final String hash;

  TonCenterDetectHashPost({required this.hash});

  @override
  String get method => '/api/v2/detectHash';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'hash': hash});

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  DetectHash onResponse(Map<String, dynamic> result) {
    return DetectHash.fromJson(result);
  }
}

/// POST /api/v2/packAddress
class TonCenterPackAddressPost extends TonApiPostRequest<String, String> {
  final String address;

  TonCenterPackAddressPost({required this.address});

  @override
  String get method => '/api/v2/packAddress';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'address': address});

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  String onResponse(String result) {
    return result;
  }
}

/// POST /api/v2/unpackAddress
class TonCenterUnpackAddressPost extends TonApiPostRequest<String, String> {
  final String address;

  TonCenterUnpackAddressPost({required this.address});

  @override
  String get method => '/api/v2/unpackAddress';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'address': address});

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  String onResponse(String result) {
    return result;
  }
}

/// POST /api/v2/getAddressInformation
class TonCenterGetAddressInformationPost
    extends TonApiPostRequest<AddressInformation, Map<String, dynamic>> {
  final String address;
  final AddressWithSeqnoRequestSeqno? seqno;

  TonCenterGetAddressInformationPost({required this.address, this.seqno});

  @override
  String get method => '/api/v2/getAddressInformation';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'seqno': seqno?.toJson(config: config),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  AddressInformation onResponse(Map<String, dynamic> result) {
    return AddressInformation.fromJson(result);
  }
}

/// POST /api/v2/getExtendedAddressInformation
class TonCenterGetExtendedAddressInformationPost
    extends
        TonApiPostRequest<ExtendedAddressInformation, Map<String, dynamic>> {
  final String address;
  final AddressWithSeqnoRequestSeqno? seqno;

  TonCenterGetExtendedAddressInformationPost({
    required this.address,
    this.seqno,
  });

  @override
  String get method => '/api/v2/getExtendedAddressInformation';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'seqno': seqno?.toJson(config: config),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  ExtendedAddressInformation onResponse(Map<String, dynamic> result) {
    return ExtendedAddressInformation.fromJson(result);
  }
}

/// POST /api/v2/getShardAccountCell
class TonCenterGetShardAccountCellPost
    extends TonApiPostRequest<TvmCell, Map<String, dynamic>> {
  final String address;
  final AddressWithSeqnoRequestSeqno? seqno;

  TonCenterGetShardAccountCellPost({required this.address, this.seqno});

  @override
  String get method => '/api/v2/getShardAccountCell';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'seqno': seqno?.toJson(config: config),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  TvmCell onResponse(Map<String, dynamic> result) {
    return TvmCell.fromJson(result);
  }
}

/// POST /api/v2/getWalletInformation
class TonCenterGetWalletInformationPost
    extends TonApiPostRequest<WalletInformation, Map<String, dynamic>> {
  final String address;
  final AddressWithSeqnoRequestSeqno? seqno;

  TonCenterGetWalletInformationPost({required this.address, this.seqno});

  @override
  String get method => '/api/v2/getWalletInformation';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'seqno': seqno?.toJson(config: config),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  WalletInformation onResponse(Map<String, dynamic> result) {
    return WalletInformation.fromJson(result);
  }
}

/// POST /api/v2/getAddressBalance
class TonCenterGetAddressBalancePost extends TonApiPostRequest<BigInt, String> {
  final String address;
  final AddressWithSeqnoRequestSeqno? seqno;

  TonCenterGetAddressBalancePost({required this.address, this.seqno});

  @override
  String get method => '/api/v2/getAddressBalance';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'seqno': seqno?.toJson(config: config),
      });
  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  BigInt onResponse(String result) {
    return JsonParser.valueAsBigInt(result);
  }
}

/// POST /api/v2/getAddressState
class TonCenterGetAddressStatePost extends TonApiPostRequest<String, String> {
  final String address;
  final AddressWithSeqnoRequestSeqno? seqno;

  TonCenterGetAddressStatePost({required this.address, this.seqno});

  @override
  String get method => '/api/v2/getAddressState';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'seqno': seqno?.toJson(config: config),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  String onResponse(String result) {
    return result;
  }
}

/// POST /api/v2/getTokenData
class TonCenterGetTokenDataPost
    extends TonApiPostRequest<TokenData, Map<String, dynamic>> {
  final String address;
  final AddressWithSeqnoRequestSeqno? seqno;

  TonCenterGetTokenDataPost({required this.address, this.seqno});

  @override
  String get method => '/api/v2/getTokenData';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'seqno': seqno?.toJson(config: config),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  TokenData onResponse(Map<String, dynamic> result) {
    return TokenData.fromJson(result);
  }
}

/// POST /api/v2/dnsResolve
class TonCenterDnsResolvePost
    extends TonApiPostRequest<DnsResolved, Map<String, dynamic>> {
  final String domain;
  final String? resolverAddress;
  final int? seqno;

  TonCenterDnsResolvePost({
    required this.domain,
    this.resolverAddress,
    this.seqno,
  });

  @override
  String get method => '/api/v2/dnsResolve';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'domain': domain,
        'resolver_address': resolverAddress,
        'seqno': seqno,
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  DnsResolved onResponse(Map<String, dynamic> result) {
    return DnsResolved.fromJson(result);
  }
}

/// POST /api/v2/getMasterchainInfo
class TonCenterGetMasterchainInfoPost
    extends TonApiPostRequest<MasterchainInfo, Map<String, dynamic>> {
  final MasterchainInfoRequest requestBody;

  TonCenterGetMasterchainInfoPost({required this.requestBody});

  @override
  String get method => '/api/v2/getMasterchainInfo';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      requestBody.toJson(config: config);

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  MasterchainInfo onResponse(Map<String, dynamic> result) {
    return MasterchainInfo.fromJson(result);
  }
}

/// POST /api/v2/getMasterchainBlockSignatures
class TonCenterGetMasterchainBlockSignaturesPost
    extends TonApiPostRequest<TonlibObject, Map<String, dynamic>> {
  final AddressWithSeqnoRequestSeqno seqno;

  TonCenterGetMasterchainBlockSignaturesPost({required this.seqno});

  @override
  String get method => '/api/v2/getMasterchainBlockSignatures';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'seqno': seqno.toJson(config: config),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  TonlibObject onResponse(Map<String, dynamic> result) {
    return TonlibObject.fromJson(result);
  }
}

/// POST /api/v2/getShardBlockProof
class TonCenterGetShardBlockProofPost
    extends TonApiPostRequest<ShardBlockProof, Map<String, dynamic>> {
  final AddressWithSeqnoRequestSeqno workchain;
  final BigInt shard;
  final AddressWithSeqnoRequestSeqno seqno;
  final AddressWithSeqnoRequestSeqno? fromSeqno;

  TonCenterGetShardBlockProofPost({
    required this.workchain,
    required this.shard,
    required this.seqno,
    this.fromSeqno,
  });

  @override
  String get method => '/api/v2/getShardBlockProof';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'workchain': workchain.toJson(config: config),
        'shard': config.encodeBigint(shard),
        'seqno': seqno.toJson(config: config),
        'from_seqno': fromSeqno?.toJson(config: config),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  ShardBlockProof onResponse(Map<String, dynamic> result) {
    return ShardBlockProof.fromJson(result);
  }
}

/// POST /api/v2/getConsensusBlock
class TonCenterGetConsensusBlockPost
    extends TonApiPostRequest<ConsensusBlock, Map<String, dynamic>> {
  final ConsensusBlockRequest requestBody;

  TonCenterGetConsensusBlockPost({required this.requestBody});

  @override
  String get method => '/api/v2/getConsensusBlock';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      requestBody.toJson(config: config);

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  ConsensusBlock onResponse(Map<String, dynamic> result) {
    return ConsensusBlock.fromJson(result);
  }
}

/// POST /api/v2/lookupBlock
class TonCenterLookupBlockPost
    extends TonApiPostRequest<TonBlockIdExt, Map<String, dynamic>> {
  final AddressWithSeqnoRequestSeqno workchain;
  final BigInt shard;
  final AddressWithSeqnoRequestSeqno? seqno;
  final BigInt? lt;
  final AddressWithSeqnoRequestSeqno? unixtime;

  TonCenterLookupBlockPost({
    required this.workchain,
    required this.shard,
    this.seqno,
    this.lt,
    this.unixtime,
  });

  @override
  String get method => '/api/v2/lookupBlock';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'workchain': workchain.toJson(config: config),
        'shard': config.encodeBigint(shard),
        'seqno': seqno?.toJson(config: config),
        'lt': config.encodeBigint(lt),
        'unixtime': unixtime?.toJson(config: config),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  TonBlockIdExt onResponse(Map<String, dynamic> result) {
    return TonBlockIdExt.fromJson(result);
  }
}

/// POST /api/v2/getShards
class TonCenterGetShardsPost
    extends TonApiPostRequest<Shards, Map<String, dynamic>> {
  final AddressWithSeqnoRequestSeqno seqno;

  TonCenterGetShardsPost({required this.seqno});

  @override
  String get method => '/api/v2/getShards';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'seqno': seqno.toJson(config: config),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  Shards onResponse(Map<String, dynamic> result) {
    return Shards.fromJson(result);
  }
}

/// POST /api/v2/getBlock
class TonCenterGetBlockPost
    extends TonApiPostRequest<BlockData, Map<String, dynamic>> {
  final AddressWithSeqnoRequestSeqno workchain;
  final BigInt shard;
  final AddressWithSeqnoRequestSeqno seqno;
  final String? rootHash;
  final String? fileHash;
  final BlockDataRequestArchival? archival;

  TonCenterGetBlockPost({
    required this.workchain,
    required this.shard,
    required this.seqno,
    this.rootHash,
    this.fileHash,
    this.archival,
  });

  @override
  String get method => '/api/v2/getBlock';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'workchain': workchain.toJson(config: config),
        'shard': config.encodeBigint(shard),
        'seqno': seqno.toJson(config: config),
        'root_hash': rootHash,
        'file_hash': fileHash,
        'archival': archival?.toJson(config: config),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  BlockData onResponse(Map<String, dynamic> result) {
    return BlockData.fromJson(result);
  }
}

/// POST /api/v2/getBlockHeader
class TonCenterGetBlockHeaderPost
    extends TonApiPostRequest<BlockHeader, Map<String, dynamic>> {
  final AddressWithSeqnoRequestSeqno workchain;
  final BigInt shard;
  final AddressWithSeqnoRequestSeqno seqno;
  final String? rootHash;
  final String? fileHash;

  TonCenterGetBlockHeaderPost({
    required this.workchain,
    required this.shard,
    required this.seqno,
    this.rootHash,
    this.fileHash,
  });

  @override
  String get method => '/api/v2/getBlockHeader';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'workchain': workchain.toJson(config: config),
        'shard': config.encodeBigint(shard),
        'seqno': seqno.toJson(config: config),
        'root_hash': rootHash,
        'file_hash': fileHash,
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  BlockHeader onResponse(Map<String, dynamic> result) {
    return BlockHeader.fromJson(result);
  }
}

/// POST /api/v2/getOutMsgQueueSize
class TonCenterGetOutMsgQueueSizePost
    extends TonApiPostRequest<OutMsgQueueSizes, Map<String, dynamic>> {
  final OutMsgQueueSizeRequest requestBody;

  TonCenterGetOutMsgQueueSizePost({required this.requestBody});

  @override
  String get method => '/api/v2/getOutMsgQueueSize';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      requestBody.toJson(config: config);

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  OutMsgQueueSizes onResponse(Map<String, dynamic> result) {
    return OutMsgQueueSizes.fromJson(result);
  }
}

/// POST /api/v2/getBlockTransactions
class TonCenterGetBlockTransactionsPost
    extends TonApiPostRequest<BlockTransactions, Map<String, dynamic>> {
  final AddressWithSeqnoRequestSeqno workchain;
  final BigInt shard;
  final AddressWithSeqnoRequestSeqno seqno;
  final String? rootHash;
  final String? fileHash;
  final BigInt? afterLt;
  final String? afterHash;
  final BigInt? count;

  TonCenterGetBlockTransactionsPost({
    required this.workchain,
    required this.shard,
    required this.seqno,
    this.rootHash,
    this.fileHash,
    this.afterLt,
    this.afterHash,
    this.count,
  });

  @override
  String get method => '/api/v2/getBlockTransactions';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'workchain': workchain.toJson(config: config),
        'shard': config.encodeBigint(shard),
        'seqno': seqno.toJson(config: config),
        'root_hash': rootHash,
        'file_hash': fileHash,
        'after_lt': config.encodeBigint(afterLt),
        'after_hash': afterHash,
        'count': config.encodeBigint(count),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  BlockTransactions onResponse(Map<String, dynamic> result) {
    return BlockTransactions.fromJson(result);
  }
}

/// POST /api/v2/getBlockTransactionsExt
class TonCenterGetBlockTransactionsExtPost
    extends TonApiPostRequest<BlockTransactionsExt, Map<String, dynamic>> {
  final AddressWithSeqnoRequestSeqno workchain;
  final BigInt shard;
  final AddressWithSeqnoRequestSeqno seqno;
  final String? rootHash;
  final String? fileHash;
  final BigInt? afterLt;
  final String? afterHash;
  final BigInt? count;

  TonCenterGetBlockTransactionsExtPost({
    required this.workchain,
    required this.shard,
    required this.seqno,
    this.rootHash,
    this.fileHash,
    this.afterLt,
    this.afterHash,
    this.count,
  });

  @override
  String get method => '/api/v2/getBlockTransactionsExt';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'workchain': workchain.toJson(config: config),
        'shard': config.encodeBigint(shard),
        'seqno': seqno.toJson(config: config),
        'root_hash': rootHash,
        'file_hash': fileHash,
        'after_lt': config.encodeBigint(afterLt),
        'after_hash': afterHash,
        'count': config.encodeBigint(count),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  BlockTransactionsExt onResponse(Map<String, dynamic> result) {
    return BlockTransactionsExt.fromJson(result);
  }
}

/// POST /api/v2/getTransactions
class TonCenterGetTransactionsPost
    extends TonApiPostRequest<List<Transaction>, List<dynamic>> {
  final String address;
  final BigInt? lt;
  final String? hash;
  final BigInt? toLt;
  final BlockDataRequestArchival? archival;
  final BigInt? limit;

  TonCenterGetTransactionsPost({
    required this.address,
    this.lt,
    this.hash,
    this.toLt,
    this.archival,
    this.limit,
  });

  @override
  String get method => '/api/v2/getTransactions';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'lt': config.encodeBigint(lt),
        'hash': hash,
        'to_lt': config.encodeBigint(toLt),
        'archival': archival?.toJson(config: config),
        'limit': config.encodeBigint(limit),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  List<Transaction> onResponse(List<dynamic> result) {
    return result
        .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

/// POST /api/v2/getTransactionsStd
class TonCenterGetTransactionsStdPost
    extends TonApiPostRequest<TransactionsStd, Map<String, dynamic>> {
  final String address;
  final BigInt? lt;
  final String? hash;
  final BigInt? toLt;
  final BlockDataRequestArchival? archival;
  final BigInt? limit;

  TonCenterGetTransactionsStdPost({
    required this.address,
    this.lt,
    this.hash,
    this.toLt,
    this.archival,
    this.limit,
  });

  @override
  String get method => '/api/v2/getTransactionsStd';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'lt': config.encodeBigint(lt),
        'hash': hash,
        'to_lt': config.encodeBigint(toLt),
        'archival': archival?.toJson(config: config),
        'limit': config.encodeBigint(limit),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  TransactionsStd onResponse(Map<String, dynamic> result) {
    return TransactionsStd.fromJson(result);
  }
}

/// POST /api/v2/tryLocateTx
class TonCenterTryLocateTxPost
    extends TonApiPostRequest<Transaction, Map<String, dynamic>> {
  final String source;
  final String destination;
  final BigInt createdLt;

  TonCenterTryLocateTxPost({
    required this.source,
    required this.destination,
    required this.createdLt,
  });

  @override
  String get method => '/api/v2/tryLocateTx';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'source': source,
        'destination': destination,
        'created_lt': config.encodeBigint(createdLt),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  Transaction onResponse(Map<String, dynamic> result) {
    return Transaction.fromJson(result);
  }
}

/// POST /api/v2/tryLocateResultTx
class TonCenterTryLocateResultTxPost
    extends TonApiPostRequest<Transaction, Map<String, dynamic>> {
  final String source;
  final String destination;
  final BigInt createdLt;

  TonCenterTryLocateResultTxPost({
    required this.source,
    required this.destination,
    required this.createdLt,
  });

  @override
  String get method => '/api/v2/tryLocateResultTx';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'source': source,
        'destination': destination,
        'created_lt': config.encodeBigint(createdLt),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  Transaction onResponse(Map<String, dynamic> result) {
    return Transaction.fromJson(result);
  }
}

/// POST /api/v2/tryLocateSourceTx
class TonCenterTryLocateSourceTxPost
    extends TonApiPostRequest<Transaction, Map<String, dynamic>> {
  final String source;
  final String destination;
  final BigInt createdLt;

  TonCenterTryLocateSourceTxPost({
    required this.source,
    required this.destination,
    required this.createdLt,
  });

  @override
  String get method => '/api/v2/tryLocateSourceTx';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'source': source,
        'destination': destination,
        'created_lt': config.encodeBigint(createdLt),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  Transaction onResponse(Map<String, dynamic> result) {
    return Transaction.fromJson(result);
  }
}

/// POST /api/v2/getConfigParam
class TonCenterGetConfigParamPost
    extends TonApiPostRequest<ConfigInfo, Map<String, dynamic>> {
  final AddressWithSeqnoRequestSeqno? configId;
  final AddressWithSeqnoRequestSeqno? param;
  final AddressWithSeqnoRequestSeqno? seqno;

  TonCenterGetConfigParamPost({this.configId, this.param, this.seqno});

  @override
  String get method => '/api/v2/getConfigParam';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'config_id': configId?.toJson(config: config),
        'param': param?.toJson(config: config),
        'seqno': seqno?.toJson(config: config),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  ConfigInfo onResponse(Map<String, dynamic> result) {
    return ConfigInfo.fromJson(result);
  }
}

/// POST /api/v2/getConfigAll
class TonCenterGetConfigAllPost
    extends TonApiPostRequest<TvmCell, Map<String, dynamic>> {
  final AddressWithSeqnoRequestSeqno? seqno;

  TonCenterGetConfigAllPost({this.seqno});

  @override
  String get method => '/api/v2/getConfigAll';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'seqno': seqno?.toJson(config: config),
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  TvmCell onResponse(Map<String, dynamic> result) {
    return TvmCell.fromJson(result);
  }
}

/// POST /api/v2/getLibraries
class TonCenterGetLibrariesPost
    extends TonApiPostRequest<LibraryResult, Map<String, dynamic>> {
  final List<String>? libraries;

  TonCenterGetLibrariesPost({this.libraries});

  @override
  String get method => '/api/v2/getLibraries';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'libraries': libraries});

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  LibraryResult onResponse(Map<String, dynamic> result) {
    return LibraryResult.fromJson(result);
  }
}

/// POST /api/v2/runGetMethod
class TonCenterRunGetMethodPost
    extends TonApiPostRequest<RunGetMethodResult, Map<String, dynamic>> {
  final String address;
  final RunGetMethodRequestMethod method_;
  final List<LegacyStackEntry> stack;
  final int? seqno;

  TonCenterRunGetMethodPost({
    required this.address,
    required this.method_,
    required this.stack,
    this.seqno,
  });

  @override
  String get method => '/api/v2/runGetMethod';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'method': method_.toJson(config: config),
        'stack':
            stack
                .map((e) => e.map((x) => x.toJson(config: config)).toList())
                .toList(),
        'seqno': seqno,
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  RunGetMethodResult onResponse(Map<String, dynamic> result) {
    return RunGetMethodResult.fromJson(result);
  }
}

/// POST /api/v2/runGetMethodStd
class TonCenterRunGetMethodStdPost
    extends TonApiPostRequest<RunGetMethodStdResult, Map<String, dynamic>> {
  final String address;
  final RunGetMethodRequestMethod method_;
  final List<RunGetMethodStdResultStackItem> stack;
  final int? seqno;

  TonCenterRunGetMethodStdPost({
    required this.address,
    required this.method_,
    required this.stack,
    this.seqno,
  });

  @override
  String get method => '/api/v2/runGetMethodStd';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'method': method_.toJson(config: config),
        'stack': stack.map((e) => e.toJson(config: config)).toList(),
        'seqno': seqno,
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  RunGetMethodStdResult onResponse(Map<String, dynamic> result) {
    return RunGetMethodStdResult.fromJson(result);
  }
}

/// POST /api/v2/sendBoc
class TonCenterSendBocPost
    extends TonApiPostRequest<SendBocResult, Map<String, dynamic>> {
  final String boc;

  TonCenterSendBocPost({required this.boc});

  @override
  String get method => '/api/v2/sendBoc';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'boc': boc});

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  SendBocResult onResponse(Map<String, dynamic> result) {
    return SendBocResult.fromJson(result);
  }
}

/// POST /api/v2/sendBocReturnHash
class TonCenterSendBocReturnHashPost
    extends TonApiPostRequest<SendBocResult, Map<String, dynamic>> {
  final String boc;

  TonCenterSendBocReturnHashPost({required this.boc});

  @override
  String get method => '/api/v2/sendBocReturnHash';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{'boc': boc});

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  SendBocResult onResponse(Map<String, dynamic> result) {
    return SendBocResult.fromJson(result);
  }
}

/// POST /api/v2/estimateFee
class TonCenterEstimateFeePost
    extends TonApiPostRequest<QueryFees, Map<String, dynamic>> {
  final String address;
  final String body_;
  final String? initCode;
  final String? initData;
  final bool? ignoreChksig;

  TonCenterEstimateFeePost({
    required this.address,
    required this.body_,
    this.initCode,
    this.initData,
    this.ignoreChksig,
  });

  @override
  String get method => '/api/v2/estimateFee';

  @override
  RequestMethod get requestMethod => RequestMethod.post;

  @override
  dynamic body({JsonifyConfig config = DefaultJsonifyConfig.defaultConfig}) =>
      config.encodeMap(<String, dynamic>{
        'address': address,
        'body': body_,
        'init_code': initCode,
        'init_data': initData,
        'ignore_chksig': ignoreChksig,
      });

  @override
  TonRequestDetails buildRequest(int v) {
    return super
        .buildRequest(v)
        .copyWith(api: TonApiType.tonCenter, isJsonRpc: true);
  }

  @override
  QueryFees onResponse(Map<String, dynamic> result) {
    return QueryFees.fromJson(result);
  }
}
