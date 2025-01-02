import 'package:ton_dart/src/provider/core/core.dart';

class TonApiMethods {
  final String name;
  final RequestMethod type;
  final String url;
  const TonApiMethods._(
      {required this.name, required this.type, required this.url});

  static const TonApiMethods accountdnsbackresolve = TonApiMethods._(
      name: 'AccountDnsBackResolve',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}/dns/backresolve');
  static const TonApiMethods addressparse = TonApiMethods._(
      name: 'AddressParse',
      type: RequestMethod.get,
      url: '/v2/address/{account_id}/parse');
  static const TonApiMethods blockchainaccountinspect = TonApiMethods._(
      name: 'BlockchainAccountInspectResponse',
      type: RequestMethod.get,
      url: '/v2/blockchain/accounts/{account_id}/inspect');
  static const TonApiMethods decodemessage = TonApiMethods._(
      name: 'DecodeMessage',
      type: RequestMethod.post,
      url: '/v2/message/decode');
  static const TonApiMethods dnsresolve = TonApiMethods._(
      name: 'DnsResolve',
      type: RequestMethod.get,
      url: '/v2/dns/{domain_name}/resolve');
  static const TonApiMethods emulatemessagetoaccountevent = TonApiMethods._(
      name: 'EmulateMessageToAccountEvent',
      type: RequestMethod.post,
      url: '/v2/accounts/{account_id}/events/emulate');
  static const TonApiMethods emulatemessagetoevent = TonApiMethods._(
      name: 'EmulateMessageToEvent',
      type: RequestMethod.post,
      url: '/v2/events/emulate');
  static const TonApiMethods emulatemessagetotrace = TonApiMethods._(
      name: 'EmulateMessageToTrace',
      type: RequestMethod.post,
      url: '/v2/traces/emulate');
  static const TonApiMethods emulatemessagetowallet = TonApiMethods._(
      name: 'EmulateMessageToWallet',
      type: RequestMethod.post,
      url: '/v2/wallet/emulate');
  static const TonApiMethods execgetmethodforblockchainaccount =
      TonApiMethods._(
          name: 'ExecGetMethodForBlockchainAccount',
          type: RequestMethod.get,
          url: '/v2/blockchain/accounts/{account_id}/methods/{method_name}');
  static const TonApiMethods getaccount = TonApiMethods._(
      name: 'GetAccount',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}');
  static const TonApiMethods getaccountdiff = TonApiMethods._(
      name: 'GetAccountDiff',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}/diff');
  static const TonApiMethods getaccountdnsexpiring = TonApiMethods._(
      name: 'GetAccountDnsExpiring',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}/dns/expiring');
  static const TonApiMethods getaccountevent = TonApiMethods._(
      name: 'GetAccountEvent',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}/events/{event_id}');
  static const TonApiMethods getaccountevents = TonApiMethods._(
      name: 'GetAccountEvents',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}/events');
  static const TonApiMethods getaccountinfobystateinit = TonApiMethods._(
      name: 'GetAccountInfoByStateInit',
      type: RequestMethod.post,
      url: '/v2/tonconnect/stateinit');
  static const TonApiMethods getaccountinscriptions = TonApiMethods._(
      name: 'GetAccountInscriptions',
      type: RequestMethod.get,
      url: '/v2/experimental/accounts/{account_id}/inscriptions');
  static const TonApiMethods getaccountinscriptionshistory = TonApiMethods._(
      name: 'GetAccountInscriptionsHistory',
      type: RequestMethod.get,
      url: '/v2/experimental/accounts/{account_id}/inscriptions/history');
  static const TonApiMethods getaccountinscriptionshistorybyticker =
      TonApiMethods._(
          name: 'GetAccountInscriptionsHistoryByTicker',
          type: RequestMethod.get,
          url:
              '/v2/experimental/accounts/{account_id}/inscriptions/{ticker}/history');
  static const TonApiMethods getaccountjettonhistorybyid = TonApiMethods._(
      name: 'GetAccountJettonHistoryByID',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}/jettons/{jetton_id}/history');
  static const TonApiMethods getaccountjettonsbalances = TonApiMethods._(
      name: 'GetAccountJettonsBalances',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}/jettons');
  static const TonApiMethods getaccountjettonshistory = TonApiMethods._(
      name: 'GetAccountJettonsHistory',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}/jettons/history');
  static const TonApiMethods getaccountnfthistory = TonApiMethods._(
      name: 'GetAccountNftHistory',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}/nfts/history');
  static const TonApiMethods getaccountnftitems = TonApiMethods._(
      name: 'GetAccountNftItems',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}/nfts');
  static const TonApiMethods getaccountnominatorspools = TonApiMethods._(
      name: 'GetAccountNominatorsPools',
      type: RequestMethod.get,
      url: '/v2/staking/nominator/{account_id}/pools');
  static const TonApiMethods getaccountpublickey = TonApiMethods._(
      name: 'GetAccountPublicKey',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}/publickey');
  static const TonApiMethods getaccountseqno = TonApiMethods._(
      name: 'GetAccountSeqno',
      type: RequestMethod.get,
      url: '/v2/wallet/{account_id}/seqno');
  static const TonApiMethods getaccountsubscriptions = TonApiMethods._(
      name: 'GetAccountSubscriptions',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}/subscriptions');
  static const TonApiMethods getaccounttraces = TonApiMethods._(
      name: 'GetAccountTraces',
      type: RequestMethod.get,
      url: '/v2/accounts/{account_id}/traces');
  static const TonApiMethods getaccounts = TonApiMethods._(
      name: 'GetAccounts', type: RequestMethod.post, url: '/v2/accounts/_bulk');
  static const TonApiMethods getallauctions = TonApiMethods._(
      name: 'GetAllAuctions', type: RequestMethod.get, url: '/v2/dns/auctions');
  static const TonApiMethods getallrawshardsinfo = TonApiMethods._(
      name: 'GetAllRawShardsInfo',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_all_shards_info/{block_id}');
  static const TonApiMethods getblockchainaccounttransactions = TonApiMethods._(
      name: 'GetBlockchainAccountTransactions',
      type: RequestMethod.get,
      url: '/v2/blockchain/accounts/{account_id}/transactions');
  static const TonApiMethods getblockchainblock = TonApiMethods._(
      name: 'GetBlockchainBlock',
      type: RequestMethod.get,
      url: '/v2/blockchain/blocks/{block_id}');
  static const TonApiMethods getblockchainblocktransactions = TonApiMethods._(
      name: 'GetBlockchainBlockTransactions',
      type: RequestMethod.get,
      url: '/v2/blockchain/blocks/{block_id}/transactions');
  static const TonApiMethods getblockchainconfig = TonApiMethods._(
      name: 'GetBlockchainConfig',
      type: RequestMethod.get,
      url: '/v2/blockchain/config');
  static const TonApiMethods getblockchainconfigfromblock = TonApiMethods._(
      name: 'GetBlockchainConfigFromBlock',
      type: RequestMethod.get,
      url: '/v2/blockchain/masterchain/{masterchain_seqno}/config');
  static const TonApiMethods getblockchainmasterchainblocks = TonApiMethods._(
      name: 'GetBlockchainMasterchainBlocks',
      type: RequestMethod.get,
      url: '/v2/blockchain/masterchain/{masterchain_seqno}/blocks');
  static const TonApiMethods getblockchainmasterchainhead = TonApiMethods._(
      name: 'GetBlockchainMasterchainHead',
      type: RequestMethod.get,
      url: '/v2/blockchain/masterchain-head');
  static const TonApiMethods getblockchainmasterchainshards = TonApiMethods._(
      name: 'GetBlockchainMasterchainShards',
      type: RequestMethod.get,
      url: '/v2/blockchain/masterchain/{masterchain_seqno}/shards');
  static const TonApiMethods getblockchainmasterchaintransactions =
      TonApiMethods._(
          name: 'GetBlockchainMasterchainTransactions',
          type: RequestMethod.get,
          url: '/v2/blockchain/masterchain/{masterchain_seqno}/transactions');
  static const TonApiMethods getblockchainrawaccount = TonApiMethods._(
      name: 'GetBlockchainRawAccount',
      type: RequestMethod.get,
      url: '/v2/blockchain/accounts/{account_id}');
  static const TonApiMethods getblockchaintransaction = TonApiMethods._(
      name: 'GetBlockchainTransaction',
      type: RequestMethod.get,
      url: '/v2/blockchain/transactions/{transaction_id}');
  static const TonApiMethods getblockchaintransactionbymessagehash =
      TonApiMethods._(
          name: 'GetBlockchainTransactionByMessageHash',
          type: RequestMethod.get,
          url: '/v2/blockchain/messages/{msg_id}/transaction');
  static const TonApiMethods getblockchainvalidators = TonApiMethods._(
      name: 'GetBlockchainValidators',
      type: RequestMethod.get,
      url: '/v2/blockchain/validators');
  static const TonApiMethods getchartrates = TonApiMethods._(
      name: 'GetChartRates', type: RequestMethod.get, url: '/v2/rates/chart');
  static const TonApiMethods getdnsinfo = TonApiMethods._(
      name: 'GetDnsInfo',
      type: RequestMethod.get,
      url: '/v2/dns/{domain_name}');
  static const TonApiMethods getdomainbids = TonApiMethods._(
      name: 'GetDomainBids',
      type: RequestMethod.get,
      url: '/v2/dns/{domain_name}/bids');
  static const TonApiMethods getevent = TonApiMethods._(
      name: 'GetEvent', type: RequestMethod.get, url: '/v2/events/{event_id}');
  static const TonApiMethods getinscriptionoptemplate = TonApiMethods._(
      name: 'GetInscriptionOpTemplate',
      type: RequestMethod.get,
      url: '/v2/experimental/inscriptions/op-template');
  static const TonApiMethods getitemsfromcollection = TonApiMethods._(
      name: 'GetItemsFromCollection',
      type: RequestMethod.get,
      url: '/v2/nfts/collections/{account_id}/items');
  static const TonApiMethods getjettonholders = TonApiMethods._(
      name: 'GetJettonHolders',
      type: RequestMethod.get,
      url: '/v2/jettons/{account_id}/holders');
  static const TonApiMethods getjettoninfo = TonApiMethods._(
      name: 'GetJettonInfo',
      type: RequestMethod.get,
      url: '/v2/jettons/{account_id}');
  static const TonApiMethods getjettons = TonApiMethods._(
      name: 'GetJettons', type: RequestMethod.get, url: '/v2/jettons');
  static const TonApiMethods getjettonsevents = TonApiMethods._(
      name: 'GetJettonsEvents',
      type: RequestMethod.get,
      url: '/v2/events/{event_id}/jettons');
  static const TonApiMethods getmarketsrates = TonApiMethods._(
      name: 'GetMarketsRates',
      type: RequestMethod.get,
      url: '/v2/rates/markets');
  static const TonApiMethods getnftcollection = TonApiMethods._(
      name: 'GetNftCollection',
      type: RequestMethod.get,
      url: '/v2/nfts/collections/{account_id}');
  static const TonApiMethods getnftcollections = TonApiMethods._(
      name: 'GetNftCollections',
      type: RequestMethod.get,
      url: '/v2/nfts/collections');
  static const TonApiMethods getnfthistorybyid = TonApiMethods._(
      name: 'GetNftHistoryByID',
      type: RequestMethod.get,
      url: '/v2/nfts/{account_id}/history');
  static const TonApiMethods getnftitembyaddress = TonApiMethods._(
      name: 'GetNftItemByAddress',
      type: RequestMethod.get,
      url: '/v2/nfts/{account_id}');
  static const TonApiMethods getnftitemsbyaddresses = TonApiMethods._(
      name: 'GetNftItemsByAddresses',
      type: RequestMethod.post,
      url: '/v2/nfts/_bulk');
  static const TonApiMethods getoutmsgqueuesizes = TonApiMethods._(
      name: 'GetOutMsgQueueSizes',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_out_msg_queue_sizes');
  static const TonApiMethods getrates = TonApiMethods._(
      name: 'GetRates', type: RequestMethod.get, url: '/v2/rates');
  static const TonApiMethods getrawaccountstate = TonApiMethods._(
      name: 'GetRawAccountState',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_account_state/{account_id}');
  static const TonApiMethods getrawblockproof = TonApiMethods._(
      name: 'GetRawBlockProof',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_block_proof');
  static const TonApiMethods getrawblockchainblock = TonApiMethods._(
      name: 'GetRawBlockchainBlock',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_block/{block_id}');
  static const TonApiMethods getrawblockchainblockheader = TonApiMethods._(
      name: 'GetRawBlockchainBlockHeader',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_block_header/{block_id}');
  static const TonApiMethods getrawblockchainblockstate = TonApiMethods._(
      name: 'GetRawBlockchainBlockState',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_state/{block_id}');
  static const TonApiMethods getrawblockchainconfig = TonApiMethods._(
      name: 'GetRawBlockchainConfig',
      type: RequestMethod.get,
      url: '/v2/blockchain/config/raw');
  static const TonApiMethods getrawblockchainconfigfromblock = TonApiMethods._(
      name: 'GetRawBlockchainConfigFromBlock',
      type: RequestMethod.get,
      url: '/v2/blockchain/masterchain/{masterchain_seqno}/config/raw');
  static const TonApiMethods getrawconfig = TonApiMethods._(
      name: 'GetRawConfig',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_config_all/{block_id}');
  static const TonApiMethods getrawlistblocktransactions = TonApiMethods._(
      name: 'GetRawListBlockTransactions',
      type: RequestMethod.get,
      url: '/v2/liteserver/list_block_transactions/{block_id}');
  static const TonApiMethods getrawmasterchaininfo = TonApiMethods._(
      name: 'GetRawMasterchainInfo',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_masterchain_info');
  static const TonApiMethods getrawmasterchaininfoext = TonApiMethods._(
      name: 'GetRawMasterchainInfoExt',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_masterchain_info_ext');
  static const TonApiMethods getrawshardblockproof = TonApiMethods._(
      name: 'GetRawShardBlockProof',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_shard_block_proof/{block_id}');
  static const TonApiMethods getrawshardinfo = TonApiMethods._(
      name: 'GetRawShardInfo',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_shard_info/{block_id}');
  static const TonApiMethods getrawtime = TonApiMethods._(
      name: 'GetRawTime',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_time');
  static const TonApiMethods getrawtransactions = TonApiMethods._(
      name: 'GetRawTransactions',
      type: RequestMethod.get,
      url: '/v2/liteserver/get_transactions/{account_id}');
  static const TonApiMethods getstakingpoolhistory = TonApiMethods._(
      name: 'GetStakingPoolHistory',
      type: RequestMethod.get,
      url: '/v2/staking/pool/{account_id}/history');
  static const TonApiMethods getstakingpoolinfo = TonApiMethods._(
      name: 'GetStakingPoolInfo',
      type: RequestMethod.get,
      url: '/v2/staking/pool/{account_id}');
  static const TonApiMethods getstakingpools = TonApiMethods._(
      name: 'GetStakingPools',
      type: RequestMethod.get,
      url: '/v2/staking/pools');
  static const TonApiMethods getstorageproviders = TonApiMethods._(
      name: 'GetStorageProviders',
      type: RequestMethod.get,
      url: '/v2/storage/providers');
  static const TonApiMethods gettonconnectpayload = TonApiMethods._(
      name: 'GetTonConnectPayload',
      type: RequestMethod.get,
      url: '/v2/tonconnect/payload');
  static const TonApiMethods gettrace = TonApiMethods._(
      name: 'GetTrace', type: RequestMethod.get, url: '/v2/traces/{trace_id}');
  static const TonApiMethods getwalletbackup = TonApiMethods._(
      name: 'GetWalletBackup',
      type: RequestMethod.get,
      url: '/v2/wallet/backup');
  static const TonApiMethods getwalletsbypublickey = TonApiMethods._(
      name: 'GetWalletsByPublicKey',
      type: RequestMethod.get,
      url: '/v2/pubkeys/{public_key}/wallets');
  static const TonApiMethods reindexaccount = TonApiMethods._(
      name: 'ReindexAccount',
      type: RequestMethod.post,
      url: '/v2/accounts/{account_id}/reindex');
  static const TonApiMethods searchaccounts = TonApiMethods._(
      name: 'SearchAccounts',
      type: RequestMethod.get,
      url: '/v2/accounts/search');
  static const TonApiMethods sendblockchainmessage = TonApiMethods._(
      name: 'SendBlockchainMessage',
      type: RequestMethod.post,
      url: '/v2/blockchain/message');
  static const TonApiMethods sendrawmessage = TonApiMethods._(
      name: 'SendRawMessage',
      type: RequestMethod.post,
      url: '/v2/liteserver/send_message');
  static const TonApiMethods setwalletbackup = TonApiMethods._(
      name: 'SetWalletBackup',
      type: RequestMethod.put,
      url: '/v2/wallet/backup');
  static const TonApiMethods status = TonApiMethods._(
      name: 'Status', type: RequestMethod.get, url: '/v2/status');
  static const TonApiMethods tonconnectproof = TonApiMethods._(
      name: 'TonConnectProof',
      type: RequestMethod.post,
      url: '/v2/wallet/auth/proof');
}
