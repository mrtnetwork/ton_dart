import 'package:ton_dart/src/exception/exception.dart';

class ActionTypeResponse {
  final String _value;

  const ActionTypeResponse._(this._value);

  static const ActionTypeResponse tonTransfer =
      ActionTypeResponse._("TonTransfer");
  static const ActionTypeResponse jettonTransfer =
      ActionTypeResponse._("JettonTransfer");
  static const ActionTypeResponse jettonBurn =
      ActionTypeResponse._("JettonBurn");
  static const ActionTypeResponse jettonMint =
      ActionTypeResponse._("JettonMint");
  static const ActionTypeResponse nftItemTransfer =
      ActionTypeResponse._("NftItemTransfer");
  static const ActionTypeResponse contractDeploy =
      ActionTypeResponse._("ContractDeploy");
  static const ActionTypeResponse subscribe = ActionTypeResponse._("Subscribe");
  static const ActionTypeResponse unSubscribe =
      ActionTypeResponse._("UnSubscribe");
  static const ActionTypeResponse auctionBid =
      ActionTypeResponse._("AuctionBid");
  static const ActionTypeResponse nftPurchase =
      ActionTypeResponse._("NftPurchase");
  static const ActionTypeResponse depositStake =
      ActionTypeResponse._("DepositStake");
  static const ActionTypeResponse withdrawStake =
      ActionTypeResponse._("WithdrawStake");
  static const ActionTypeResponse withdrawStakeRequest =
      ActionTypeResponse._("WithdrawStakeRequest");
  static const ActionTypeResponse jettonSwap =
      ActionTypeResponse._("JettonSwap");
  static const ActionTypeResponse smartContractExec =
      ActionTypeResponse._("SmartContractExec");
  static const ActionTypeResponse electionsRecoverStake =
      ActionTypeResponse._("ElectionsRecoverStake");
  static const ActionTypeResponse electionsDepositStake =
      ActionTypeResponse._("ElectionsDepositStake");
  static const ActionTypeResponse domainRenew =
      ActionTypeResponse._("DomainRenew");
  static const ActionTypeResponse inscriptionTransfer =
      ActionTypeResponse._("InscriptionTransfer");
  static const ActionTypeResponse inscriptionMint =
      ActionTypeResponse._("InscriptionMint");
  static const ActionTypeResponse unknown = ActionTypeResponse._("Unknown");

  static const List<ActionTypeResponse> values = [
    tonTransfer,
    jettonTransfer,
    jettonBurn,
    jettonMint,
    nftItemTransfer,
    contractDeploy,
    subscribe,
    unSubscribe,
    auctionBid,
    nftPurchase,
    depositStake,
    withdrawStake,
    withdrawStakeRequest,
    jettonSwap,
    smartContractExec,
    electionsRecoverStake,
    electionsDepositStake,
    domainRenew,
    inscriptionTransfer,
    inscriptionMint,
    unknown,
  ];

  String get value => _value;

  static ActionTypeResponse fromName(String? name) {
    return values.firstWhere(
      (element) => element.value == name,
      orElse: () => throw TonDartPluginException(
          "No ActionTypeResponse found with the provided name: $name"),
    );
  }
}
