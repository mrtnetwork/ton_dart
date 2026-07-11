class TonApiMethods {
  final String name;
  final String url;
  const TonApiMethods._({required this.name, required this.url});

  static const TonApiMethods accountdnsbackresolve = TonApiMethods._(
    name: 'AccountDnsBackResolve',

    url: '/v2/accounts/{account_id}/dns/backresolve',
  );
  static const TonApiMethods addressparse = TonApiMethods._(
    name: 'AddressParse',

    url: '/v2/address/{account_id}/parse',
  );
  static const TonApiMethods blockchainaccountinspect = TonApiMethods._(
    name: 'BlockchainAccountInspectResponse',

    url: '/v2/blockchain/accounts/{account_id}/inspect',
  );
  static const TonApiMethods decodemessage = TonApiMethods._(
    name: 'DecodeMessage',

    url: '/v2/message/decode',
  );
  static const TonApiMethods dnsresolve = TonApiMethods._(
    name: 'DnsResolve',

    url: '/v2/dns/{domain_name}/resolve',
  );
  static const TonApiMethods emulatemessagetoaccountevent = TonApiMethods._(
    name: 'EmulateMessageToAccountEvent',

    url: '/v2/accounts/{account_id}/events/emulate',
  );
  static const TonApiMethods emulatemessagetoevent = TonApiMethods._(
    name: 'EmulateMessageToEvent',

    url: '/v2/events/emulate',
  );
  static const TonApiMethods emulatemessagetotrace = TonApiMethods._(
    name: 'EmulateMessageToTrace',

    url: '/v2/traces/emulate',
  );
  static const TonApiMethods emulatemessagetowallet = TonApiMethods._(
    name: 'EmulateMessageToWallet',

    url: '/v2/wallet/emulate',
  );
  static const TonApiMethods execgetmethodforblockchainaccount =
      TonApiMethods._(
        name: 'ExecGetMethodForBlockchainAccount',

        url: '/v2/blockchain/accounts/{account_id}/methods/{method_name}',
      );
  static const TonApiMethods getaccount = TonApiMethods._(
    name: 'GetAccount',

    url: '/v2/accounts/{account_id}',
  );
  static const TonApiMethods getaccountdiff = TonApiMethods._(
    name: 'GetAccountDiff',

    url: '/v2/accounts/{account_id}/diff',
  );
  static const TonApiMethods getaccountdnsexpiring = TonApiMethods._(
    name: 'GetAccountDnsExpiring',

    url: '/v2/accounts/{account_id}/dns/expiring',
  );
  static const TonApiMethods getaccountevent = TonApiMethods._(
    name: 'GetAccountEvent',

    url: '/v2/accounts/{account_id}/events/{event_id}',
  );
  static const TonApiMethods getaccountevents = TonApiMethods._(
    name: 'GetAccountEvents',

    url: '/v2/accounts/{account_id}/events',
  );
  static const TonApiMethods getaccountinfobystateinit = TonApiMethods._(
    name: 'GetAccountInfoByStateInit',

    url: '/v2/tonconnect/stateinit',
  );
  static const TonApiMethods getaccountinscriptions = TonApiMethods._(
    name: 'GetAccountInscriptions',

    url: '/v2/experimental/accounts/{account_id}/inscriptions',
  );
  static const TonApiMethods getaccountinscriptionshistory = TonApiMethods._(
    name: 'GetAccountInscriptionsHistory',

    url: '/v2/experimental/accounts/{account_id}/inscriptions/history',
  );
  static const TonApiMethods
  getaccountinscriptionshistorybyticker = TonApiMethods._(
    name: 'GetAccountInscriptionsHistoryByTicker',

    url: '/v2/experimental/accounts/{account_id}/inscriptions/{ticker}/history',
  );
  static const TonApiMethods getaccountjettonhistorybyid = TonApiMethods._(
    name: 'GetAccountJettonHistoryByID',

    url: '/v2/accounts/{account_id}/jettons/{jetton_id}/history',
  );
  static const TonApiMethods getaccountjettonsbalances = TonApiMethods._(
    name: 'GetAccountJettonsBalances',

    url: '/v2/accounts/{account_id}/jettons',
  );
  static const TonApiMethods getaccountjettonshistory = TonApiMethods._(
    name: 'GetAccountJettonsHistory',

    url: '/v2/accounts/{account_id}/jettons/history',
  );
  static const TonApiMethods getaccountnfthistory = TonApiMethods._(
    name: 'GetAccountNftHistory',

    url: '/v2/accounts/{account_id}/nfts/history',
  );
  static const TonApiMethods getaccountnftitems = TonApiMethods._(
    name: 'GetAccountNftItems',

    url: '/v2/accounts/{account_id}/nfts',
  );
  static const TonApiMethods getaccountnominatorspools = TonApiMethods._(
    name: 'GetAccountNominatorsPools',

    url: '/v2/staking/nominator/{account_id}/pools',
  );
  static const TonApiMethods getaccountpublickey = TonApiMethods._(
    name: 'GetAccountPublicKey',

    url: '/v2/accounts/{account_id}/publickey',
  );
  static const TonApiMethods getaccountseqno = TonApiMethods._(
    name: 'GetAccountSeqno',

    url: '/v2/wallet/{account_id}/seqno',
  );
  static const TonApiMethods getaccountsubscriptions = TonApiMethods._(
    name: 'GetAccountSubscriptions',

    url: '/v2/accounts/{account_id}/subscriptions',
  );
  static const TonApiMethods getaccounttraces = TonApiMethods._(
    name: 'GetAccountTraces',

    url: '/v2/accounts/{account_id}/traces',
  );
  static const TonApiMethods getaccounts = TonApiMethods._(
    name: 'GetAccounts',

    url: '/v2/accounts/_bulk',
  );
  static const TonApiMethods getallauctions = TonApiMethods._(
    name: 'GetAllAuctions',

    url: '/v2/dns/auctions',
  );
  static const TonApiMethods getallrawshardsinfo = TonApiMethods._(
    name: 'GetAllRawShardsInfo',

    url: '/v2/liteserver/get_all_shards_info/{block_id}',
  );
  static const TonApiMethods getblockchainaccounttransactions = TonApiMethods._(
    name: 'GetBlockchainAccountTransactions',

    url: '/v2/blockchain/accounts/{account_id}/transactions',
  );
  static const TonApiMethods getblockchainblock = TonApiMethods._(
    name: 'GetBlockchainBlock',

    url: '/v2/blockchain/blocks/{block_id}',
  );
  static const TonApiMethods getblockchainblocktransactions = TonApiMethods._(
    name: 'GetBlockchainBlockTransactions',

    url: '/v2/blockchain/blocks/{block_id}/transactions',
  );
  static const TonApiMethods getblockchainconfig = TonApiMethods._(
    name: 'GetBlockchainConfig',

    url: '/v2/blockchain/config',
  );
  static const TonApiMethods getblockchainconfigfromblock = TonApiMethods._(
    name: 'GetBlockchainConfigFromBlock',

    url: '/v2/blockchain/masterchain/{masterchain_seqno}/config',
  );
  static const TonApiMethods getblockchainmasterchainblocks = TonApiMethods._(
    name: 'GetBlockchainMasterchainBlocks',

    url: '/v2/blockchain/masterchain/{masterchain_seqno}/blocks',
  );
  static const TonApiMethods getblockchainmasterchainhead = TonApiMethods._(
    name: 'GetBlockchainMasterchainHead',

    url: '/v2/blockchain/masterchain-head',
  );
  static const TonApiMethods getblockchainmasterchainshards = TonApiMethods._(
    name: 'GetBlockchainMasterchainShards',

    url: '/v2/blockchain/masterchain/{masterchain_seqno}/shards',
  );
  static const TonApiMethods getblockchainmasterchaintransactions =
      TonApiMethods._(
        name: 'GetBlockchainMasterchainTransactions',

        url: '/v2/blockchain/masterchain/{masterchain_seqno}/transactions',
      );
  static const TonApiMethods getblockchainrawaccount = TonApiMethods._(
    name: 'GetBlockchainRawAccount',

    url: '/v2/blockchain/accounts/{account_id}',
  );
  static const TonApiMethods getblockchaintransaction = TonApiMethods._(
    name: 'GetBlockchainTransaction',

    url: '/v2/blockchain/transactions/{transaction_id}',
  );
  static const TonApiMethods getblockchaintransactionbymessagehash =
      TonApiMethods._(
        name: 'GetBlockchainTransactionByMessageHash',

        url: '/v2/blockchain/messages/{msg_id}/transaction',
      );
  static const TonApiMethods getblockchainvalidators = TonApiMethods._(
    name: 'GetBlockchainValidators',

    url: '/v2/blockchain/validators',
  );
  static const TonApiMethods getchartrates = TonApiMethods._(
    name: 'GetChartRates',

    url: '/v2/rates/chart',
  );
  static const TonApiMethods getdnsinfo = TonApiMethods._(
    name: 'GetDnsInfo',

    url: '/v2/dns/{domain_name}',
  );
  static const TonApiMethods getdomainbids = TonApiMethods._(
    name: 'GetDomainBids',

    url: '/v2/dns/{domain_name}/bids',
  );
  static const TonApiMethods getevent = TonApiMethods._(
    name: 'GetEvent',

    url: '/v2/events/{event_id}',
  );
  static const TonApiMethods getinscriptionoptemplate = TonApiMethods._(
    name: 'GetInscriptionOpTemplate',

    url: '/v2/experimental/inscriptions/op-template',
  );
  static const TonApiMethods getitemsfromcollection = TonApiMethods._(
    name: 'GetItemsFromCollection',

    url: '/v2/nfts/collections/{account_id}/items',
  );
  static const TonApiMethods getjettonholders = TonApiMethods._(
    name: 'GetJettonHolders',

    url: '/v2/jettons/{account_id}/holders',
  );
  static const TonApiMethods getjettoninfo = TonApiMethods._(
    name: 'GetJettonInfo',

    url: '/v2/jettons/{account_id}',
  );
  static const TonApiMethods getjettons = TonApiMethods._(
    name: 'GetJettons',

    url: '/v2/jettons',
  );
  static const TonApiMethods getjettonsevents = TonApiMethods._(
    name: 'GetJettonsEvents',

    url: '/v2/events/{event_id}/jettons',
  );
  static const TonApiMethods getmarketsrates = TonApiMethods._(
    name: 'GetMarketsRates',

    url: '/v2/rates/markets',
  );
  static const TonApiMethods getnftcollection = TonApiMethods._(
    name: 'GetNftCollection',

    url: '/v2/nfts/collections/{account_id}',
  );
  static const TonApiMethods getnftcollections = TonApiMethods._(
    name: 'GetNftCollections',

    url: '/v2/nfts/collections',
  );
  static const TonApiMethods getnfthistorybyid = TonApiMethods._(
    name: 'GetNftHistoryByID',

    url: '/v2/nfts/{account_id}/history',
  );
  static const TonApiMethods getnftitembyaddress = TonApiMethods._(
    name: 'GetNftItemByAddress',

    url: '/v2/nfts/{account_id}',
  );
  static const TonApiMethods getnftitemsbyaddresses = TonApiMethods._(
    name: 'GetNftItemsByAddresses',

    url: '/v2/nfts/_bulk',
  );
  static const TonApiMethods getoutmsgqueuesizes = TonApiMethods._(
    name: 'GetOutMsgQueueSizes',

    url: '/v2/liteserver/get_out_msg_queue_sizes',
  );
  static const TonApiMethods getrates = TonApiMethods._(
    name: 'GetRates',

    url: '/v2/rates',
  );
  static const TonApiMethods getrawaccountstate = TonApiMethods._(
    name: 'GetRawAccountState',

    url: '/v2/liteserver/get_account_state/{account_id}',
  );
  static const TonApiMethods getrawblockproof = TonApiMethods._(
    name: 'GetRawBlockProof',

    url: '/v2/liteserver/get_block_proof',
  );
  static const TonApiMethods getrawblockchainblock = TonApiMethods._(
    name: 'GetRawBlockchainBlock',

    url: '/v2/liteserver/get_block/{block_id}',
  );
  static const TonApiMethods getrawblockchainblockheader = TonApiMethods._(
    name: 'GetRawBlockchainBlockHeader',

    url: '/v2/liteserver/get_block_header/{block_id}',
  );
  static const TonApiMethods getrawblockchainblockstate = TonApiMethods._(
    name: 'GetRawBlockchainBlockState',

    url: '/v2/liteserver/get_state/{block_id}',
  );
  static const TonApiMethods getrawblockchainconfig = TonApiMethods._(
    name: 'GetRawBlockchainConfig',

    url: '/v2/blockchain/config/raw',
  );
  static const TonApiMethods getrawblockchainconfigfromblock = TonApiMethods._(
    name: 'GetRawBlockchainConfigFromBlock',

    url: '/v2/blockchain/masterchain/{masterchain_seqno}/config/raw',
  );
  static const TonApiMethods getrawconfig = TonApiMethods._(
    name: 'GetRawConfig',

    url: '/v2/liteserver/get_config_all/{block_id}',
  );
  static const TonApiMethods getrawlistblocktransactions = TonApiMethods._(
    name: 'GetRawListBlockTransactions',

    url: '/v2/liteserver/list_block_transactions/{block_id}',
  );
  static const TonApiMethods getrawmasterchaininfo = TonApiMethods._(
    name: 'GetRawMasterchainInfo',

    url: '/v2/liteserver/get_masterchain_info',
  );
  static const TonApiMethods getrawmasterchaininfoext = TonApiMethods._(
    name: 'GetRawMasterchainInfoExt',

    url: '/v2/liteserver/get_masterchain_info_ext',
  );
  static const TonApiMethods getrawshardblockproof = TonApiMethods._(
    name: 'GetRawShardBlockProof',

    url: '/v2/liteserver/get_shard_block_proof/{block_id}',
  );
  static const TonApiMethods getrawshardinfo = TonApiMethods._(
    name: 'GetRawShardInfo',

    url: '/v2/liteserver/get_shard_info/{block_id}',
  );
  static const TonApiMethods getrawtime = TonApiMethods._(
    name: 'GetRawTime',

    url: '/v2/liteserver/get_time',
  );
  static const TonApiMethods getrawtransactions = TonApiMethods._(
    name: 'GetRawTransactions',

    url: '/v2/liteserver/get_transactions/{account_id}',
  );
  static const TonApiMethods getstakingpoolhistory = TonApiMethods._(
    name: 'GetStakingPoolHistory',

    url: '/v2/staking/pool/{account_id}/history',
  );
  static const TonApiMethods getstakingpoolinfo = TonApiMethods._(
    name: 'GetStakingPoolInfo',

    url: '/v2/staking/pool/{account_id}',
  );
  static const TonApiMethods getstakingpools = TonApiMethods._(
    name: 'GetStakingPools',

    url: '/v2/staking/pools',
  );
  static const TonApiMethods getstorageproviders = TonApiMethods._(
    name: 'GetStorageProviders',

    url: '/v2/storage/providers',
  );
  static const TonApiMethods gettonconnectpayload = TonApiMethods._(
    name: 'GetTonConnectPayload',

    url: '/v2/tonconnect/payload',
  );
  static const TonApiMethods gettrace = TonApiMethods._(
    name: 'GetTrace',

    url: '/v2/traces/{trace_id}',
  );
  static const TonApiMethods getwalletbackup = TonApiMethods._(
    name: 'GetWalletBackup',

    url: '/v2/wallet/backup',
  );
  static const TonApiMethods getwalletsbypublickey = TonApiMethods._(
    name: 'GetWalletsByPublicKey',

    url: '/v2/pubkeys/{public_key}/wallets',
  );
  static const TonApiMethods reindexaccount = TonApiMethods._(
    name: 'ReindexAccount',

    url: '/v2/accounts/{account_id}/reindex',
  );
  static const TonApiMethods searchaccounts = TonApiMethods._(
    name: 'SearchAccounts',

    url: '/v2/accounts/search',
  );
  static const TonApiMethods sendblockchainmessage = TonApiMethods._(
    name: 'SendBlockchainMessage',

    url: '/v2/blockchain/message',
  );
  static const TonApiMethods sendrawmessage = TonApiMethods._(
    name: 'SendRawMessage',

    url: '/v2/liteserver/send_message',
  );

  static const TonApiMethods status = TonApiMethods._(
    name: 'Status',
    url: '/v2/status',
  );
  static const TonApiMethods tonconnectproof = TonApiMethods._(
    name: 'TonConnectProof',

    url: '/v2/wallet/auth/proof',
  );
}
