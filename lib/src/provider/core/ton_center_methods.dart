class TonCenterMethods {
  final String name;

  const TonCenterMethods._(this.name);

  static const TonCenterMethods getAddressInformation =
      TonCenterMethods._("getAddressInformation");
  static const TonCenterMethods getExtendedAddressInformation =
      TonCenterMethods._("getExtendedAddressInformation");
  static const TonCenterMethods getWalletInformation =
      TonCenterMethods._("getWalletInformation");
  static const TonCenterMethods getTransactions =
      TonCenterMethods._("getTransactions");
  static const TonCenterMethods getAddressBalance =
      TonCenterMethods._("getAddressBalance");
  static const TonCenterMethods getAddressState =
      TonCenterMethods._("getAddressState");
  static const TonCenterMethods packAddress = TonCenterMethods._("packAddress");
  static const TonCenterMethods unpackAddress =
      TonCenterMethods._("unpackAddress");
  static const TonCenterMethods getTokenData =
      TonCenterMethods._("getTokenData");
  static const TonCenterMethods detectAddress =
      TonCenterMethods._("detectAddress");
  static const TonCenterMethods getMasterchainInfo =
      TonCenterMethods._("getMasterchainInfo");
  static const TonCenterMethods getMasterchainBlockSignatures =
      TonCenterMethods._("getMasterchainBlockSignatures");
  static const TonCenterMethods getShardBlockProof =
      TonCenterMethods._("getShardBlockProof");
  static const TonCenterMethods getConsensusBlock =
      TonCenterMethods._("getConsensusBlock");
  static const TonCenterMethods shards = TonCenterMethods._("shards");
  static const TonCenterMethods getBlockTransactions =
      TonCenterMethods._("getBlockTransactions");
  static const TonCenterMethods getBlockHeader =
      TonCenterMethods._("getBlockHeader");
  static const TonCenterMethods tryLocateTx = TonCenterMethods._("tryLocateTx");
  static const TonCenterMethods tryLocateResultTx =
      TonCenterMethods._("tryLocateResultTx");
  static const TonCenterMethods tryLocateSourceTx =
      TonCenterMethods._("tryLocateSourceTx");
  static const TonCenterMethods getConfigParam =
      TonCenterMethods._("getConfigParam");
  static const TonCenterMethods runGetMethod =
      TonCenterMethods._("runGetMethod");
  static const TonCenterMethods sendBoc = TonCenterMethods._("sendBoc");
  static const TonCenterMethods sendBocReturnHash =
      TonCenterMethods._("sendBocReturnHash");
  static const TonCenterMethods sendQuery = TonCenterMethods._("sendQuery");
  static const TonCenterMethods lookupBlock = TonCenterMethods._("lookupBlock");
  static const TonCenterMethods estimateFee = TonCenterMethods._("estimateFee");
  static const TonCenterMethods jsonRPC = TonCenterMethods._("jsonRPC");

  static List<TonCenterMethods> get values => [
        getAddressInformation,
        getExtendedAddressInformation,
        getWalletInformation,
        getTransactions,
        getAddressBalance,
        getAddressState,
        packAddress,
        getTokenData,
        detectAddress,
        getMasterchainInfo,
        getMasterchainBlockSignatures,
        getShardBlockProof,
        getConsensusBlock,
        shards,
        getBlockTransactions,
        getBlockHeader,
        tryLocateTx,
        tryLocateResultTx,
        getConfigParam,
        runGetMethod,
        sendBoc,
        sendBocReturnHash,
        sendQuery,
        jsonRPC,
      ];
}
