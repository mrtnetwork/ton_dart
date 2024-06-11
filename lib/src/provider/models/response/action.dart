import 'package:ton_dart/src/serialization/serialization.dart';
import 'action_simple_preview.dart';
import 'action_status.dart';
import 'action_type.dart';
import 'auction_bid_action.dart';
import 'contract_deploy_action.dart';
import 'deposit_stake_action.dart';
import 'domain_renew_action.dart';
import 'elections_deposit_stake_action.dart';
import 'elections_recover_stake_action.dart';
import 'inscription_mint_action.dart';
import 'inscription_transfer_action.dart';
import 'jetton_burn_action.dart';
import 'jetton_mint_action.dart';
import 'jetton_swap_action.dart';
import 'jetton_transfer_action.dart';
import 'nft_item_transfer_action.dart';
import 'nft_purchase_action.dart';
import 'smart_contract_action.dart';
import 'subscription_action.dart';
import 'ton_transfer_action.dart';
import 'unsubscription_action.dart';
import 'withdraw_stake_action.dart';
import 'withdraw_stake_request_action.dart';

class ActionResponse with JsonSerialization {
  final ActionTypeResponse type;
  final ActionStatusResponse status;
  final TonTransferActionResponse? tonTransfer;
  final ContractDeployActionResponse? contractDeploy;
  final JettonTransferActionResponse? jettonTransfer;
  final JettonBurnActionResponse? jettonBurn;
  final JettonMintActionResponse? jettonMint;
  final NftItemTransferActionResponse? nftItemTransfer;
  final SubscriptionActionResponse? subscribe;
  final UnSubscriptionActionResponse? unSubscribe;
  final AuctionBidActionResponse? auctionBid;
  final NftPurchaseActionResponse? nftPurchase;
  final DepositStakeActionResponse? depositStake;
  final WithdrawStakeActionResponse? withdrawStake;
  final WithdrawStakeRequestActionResponse? withdrawStakeRequest;
  final ElectionsDepositStakeActionResponse? electionsDepositStake;
  final ElectionsRecoverStakeActionResponse? electionsRecoverStake;
  final JettonSwapActionResponse? jettonSwap;
  final SmartContractActionResponse? smartContractExec;
  final DomainRenewActionResponse? domainRenew;
  final InscriptionTransferActionResponse? inscriptionTransfer;
  final InscriptionMintActionResponse? inscriptionMint;
  final ActionSimplePreviewResponse simplePreview;
  final List<String> baseTransactions;

  ActionResponse({
    required this.type,
    required this.status,
    this.tonTransfer,
    this.contractDeploy,
    this.jettonTransfer,
    this.jettonBurn,
    this.jettonMint,
    this.nftItemTransfer,
    this.subscribe,
    this.unSubscribe,
    this.auctionBid,
    this.nftPurchase,
    this.depositStake,
    this.withdrawStake,
    this.withdrawStakeRequest,
    this.electionsDepositStake,
    this.electionsRecoverStake,
    this.jettonSwap,
    this.smartContractExec,
    this.domainRenew,
    this.inscriptionTransfer,
    this.inscriptionMint,
    required this.simplePreview,
    required this.baseTransactions,
  });

  factory ActionResponse.fromJson(Map<String, dynamic> json) {
    return ActionResponse(
      type: ActionTypeResponse.fromName(json['type']),
      status: ActionStatusResponse.fromName(json['status']),
      tonTransfer: json['TonTransfer'] != null
          ? TonTransferActionResponse.fromJson(json['TonTransfer'])
          : null,
      contractDeploy: json['ContractDeploy'] != null
          ? ContractDeployActionResponse.fromJson(json['ContractDeploy'])
          : null,
      jettonTransfer: json['JettonTransfer'] != null
          ? JettonTransferActionResponse.fromJson(json['JettonTransfer'])
          : null,
      jettonBurn: json['JettonBurn'] != null
          ? JettonBurnActionResponse.fromJson(json['JettonBurn'])
          : null,
      jettonMint: json['JettonMint'] != null
          ? JettonMintActionResponse.fromJson(json['JettonMint'])
          : null,
      nftItemTransfer: json['NftItemTransfer'] != null
          ? NftItemTransferActionResponse.fromJson(json['NftItemTransfer'])
          : null,
      subscribe: json['Subscribe'] != null
          ? SubscriptionActionResponse.fromJson(json['Subscribe'])
          : null,
      unSubscribe: json['UnSubscribe'] != null
          ? UnSubscriptionActionResponse.fromJson(json['UnSubscribe'])
          : null,
      auctionBid: json['AuctionBid'] != null
          ? AuctionBidActionResponse.fromJson(json['AuctionBid'])
          : null,
      nftPurchase: json['NftPurchase'] != null
          ? NftPurchaseActionResponse.fromJson(json['NftPurchase'])
          : null,
      depositStake: json['DepositStake'] != null
          ? DepositStakeActionResponse.fromJson(json['DepositStake'])
          : null,
      withdrawStake: json['WithdrawStake'] != null
          ? WithdrawStakeActionResponse.fromJson(json['WithdrawStake'])
          : null,
      withdrawStakeRequest: json['WithdrawStakeRequest'] != null
          ? WithdrawStakeRequestActionResponse.fromJson(
              json['WithdrawStakeRequest'])
          : null,
      electionsDepositStake: json['ElectionsDepositStake'] != null
          ? ElectionsDepositStakeActionResponse.fromJson(
              json['ElectionsDepositStake'])
          : null,
      electionsRecoverStake: json['ElectionsRecoverStake'] != null
          ? ElectionsRecoverStakeActionResponse.fromJson(
              json['ElectionsRecoverStake'])
          : null,
      jettonSwap: json['JettonSwap'] != null
          ? JettonSwapActionResponse.fromJson(json['JettonSwap'])
          : null,
      smartContractExec: json['SmartContractExec'] != null
          ? SmartContractActionResponse.fromJson(json['SmartContractExec'])
          : null,
      domainRenew: json['DomainRenew'] != null
          ? DomainRenewActionResponse.fromJson(json['DomainRenew'])
          : null,
      inscriptionTransfer: json['InscriptionTransfer'] != null
          ? InscriptionTransferActionResponse.fromJson(
              json['InscriptionTransfer'])
          : null,
      inscriptionMint: json['InscriptionMint'] != null
          ? InscriptionMintActionResponse.fromJson(json['InscriptionMint'])
          : null,
      simplePreview:
          ActionSimplePreviewResponse.fromJson(json['simple_preview']),
      baseTransactions: List<String>.from(json['base_transactions']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'type': type.value,
      'status': status.value,
      'TonTransfer': tonTransfer?.toJson(),
      'ContractDeploy': contractDeploy?.toJson(),
      'JettonTransfer': jettonTransfer?.toJson(),
      'JettonBurn': jettonBurn?.toJson(),
      'JettonMint': jettonMint?.toJson(),
      'NftItemTransfer': nftItemTransfer?.toJson(),
      'Subscribe': subscribe?.toJson(),
      'UnSubscribe': unSubscribe?.toJson(),
      'AuctionBid': auctionBid?.toJson(),
      'NftPurchase': nftPurchase?.toJson(),
      'DepositStake': depositStake?.toJson(),
      'WithdrawStake': withdrawStake?.toJson(),
      'WithdrawStakeRequest': withdrawStakeRequest?.toJson(),
      'ElectionsDepositStake': electionsDepositStake?.toJson(),
      'ElectionsRecoverStake': electionsRecoverStake?.toJson(),
      'JettonSwap': jettonSwap?.toJson(),
      'SmartContractExec': smartContractExec?.toJson(),
      'DomainRenew': domainRenew?.toJson(),
      'InscriptionTransfer': inscriptionTransfer?.toJson(),
      'InscriptionMint': inscriptionMint?.toJson(),
      'simple_preview': simplePreview.toJson(),
      'base_transactions': baseTransactions,
    };
  }
}
