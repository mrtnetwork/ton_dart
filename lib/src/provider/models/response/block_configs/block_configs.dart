import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:ton_dart/src/provider/models/response/workchain_descr.dart';
import 'package:ton_dart/src/provider/models/response/block_limits.dart';
import 'package:ton_dart/src/provider/models/response/config_proposal_setup.dart';
import 'package:ton_dart/src/provider/models/response/gas_limit_prices.dart';
import 'package:ton_dart/src/provider/models/response/jetton_bridge_params.dart';
import 'package:ton_dart/src/provider/models/response/misbehaviour_punishment_config.dart';
import 'package:ton_dart/src/provider/models/response/msg_forward_prices.dart';
import 'package:ton_dart/src/provider/models/response/oracle_bridge_params.dart';
import 'package:ton_dart/src/provider/models/response/size_limits_config.dart';

class BlockchainConfig82 {
  final JettonBridgeParamsResponse jettonBridgeParams;

  const BlockchainConfig82({required this.jettonBridgeParams});

  factory BlockchainConfig82.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig82(
      jettonBridgeParams:
          JettonBridgeParamsResponse.fromJson(json['jetton_bridge_params']),
    );
  }

  Map<String, dynamic> toJson() => {
        'jetton_bridge_params': jettonBridgeParams.toJson(),
      };
}

class BlockchainConfig81 {
  final JettonBridgeParamsResponse jettonBridgeParams;

  const BlockchainConfig81({required this.jettonBridgeParams});

  factory BlockchainConfig81.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig81(
      jettonBridgeParams:
          JettonBridgeParamsResponse.fromJson(json['jetton_bridge_params']),
    );
  }

  Map<String, dynamic> toJson() => {
        'jetton_bridge_params': jettonBridgeParams.toJson(),
      };
}

class BlockchainConfig79 {
  final JettonBridgeParamsResponse jettonBridgeParams;

  const BlockchainConfig79({required this.jettonBridgeParams});

  factory BlockchainConfig79.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig79(
      jettonBridgeParams:
          JettonBridgeParamsResponse.fromJson(json['jetton_bridge_params']),
    );
  }

  Map<String, dynamic> toJson() => {
        'jetton_bridge_params': jettonBridgeParams.toJson(),
      };
}

class BlockchainConfig73 {
  final OracleBridgeParamsResponse oracleBridgeParams;

  const BlockchainConfig73({required this.oracleBridgeParams});

  factory BlockchainConfig73.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig73(
      oracleBridgeParams:
          OracleBridgeParamsResponse.fromJson(json['oracle_bridge_params']),
    );
  }

  Map<String, dynamic> toJson() => {
        'oracle_bridge_params': oracleBridgeParams.toJson(),
      };
}

class BlockchainConfig72 {
  final OracleBridgeParamsResponse oracleBridgeParams;

  const BlockchainConfig72({required this.oracleBridgeParams});

  factory BlockchainConfig72.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig72(
      oracleBridgeParams:
          OracleBridgeParamsResponse.fromJson(json['oracle_bridge_params']),
    );
  }

  Map<String, dynamic> toJson() => {
        'oracle_bridge_params': oracleBridgeParams.toJson(),
      };
}

class BlockchainConfig71 {
  final OracleBridgeParamsResponse oracleBridgeParams;

  const BlockchainConfig71({required this.oracleBridgeParams});

  factory BlockchainConfig71.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig71(
      oracleBridgeParams:
          OracleBridgeParamsResponse.fromJson(json['oracle_bridge_params']),
    );
  }

  Map<String, dynamic> toJson() => {
        'oracle_bridge_params': oracleBridgeParams.toJson(),
      };
}

class BlockchainConfig44 {
  final List<String> accounts;
  final int suspendedUntil;

  const BlockchainConfig44(
      {required this.accounts, required this.suspendedUntil});

  factory BlockchainConfig44.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig44(
      accounts: List<String>.from(json['accounts']),
      suspendedUntil: json['suspended_until'],
    );
  }

  Map<String, dynamic> toJson() => {
        'accounts': accounts,
        'suspended_until': suspendedUntil,
      };
}

class BlockchainConfig43 {
  final SizeLimitsConfigResponse sizeLimitsConfig;

  const BlockchainConfig43({required this.sizeLimitsConfig});

  factory BlockchainConfig43.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig43(
      sizeLimitsConfig:
          SizeLimitsConfigResponse.fromJson(json['size_limits_config']),
    );
  }

  Map<String, dynamic> toJson() => {
        'size_limits_config': sizeLimitsConfig.toJson(),
      };
}

class BlockchainConfig40 {
  final MisbehaviourPunishmentConfigResponse misbehaviourPunishmentConfig;

  const BlockchainConfig40({required this.misbehaviourPunishmentConfig});

  factory BlockchainConfig40.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig40(
      misbehaviourPunishmentConfig:
          MisbehaviourPunishmentConfigResponse.fromJson(
              json['misbehaviour_punishment_config']),
    );
  }

  Map<String, dynamic> toJson() => {
        'misbehaviour_punishment_config': misbehaviourPunishmentConfig.toJson(),
      };
}

class BlockchainConfig31 {
  final List<String> fundamentalSmcAddr;

  const BlockchainConfig31({required this.fundamentalSmcAddr});

  factory BlockchainConfig31.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig31(
      fundamentalSmcAddr: List<String>.from(json['fundamental_smc_addr']),
    );
  }

  Map<String, dynamic> toJson() => {
        'fundamental_smc_addr': fundamentalSmcAddr,
      };
}

class BlockchainConfig29 {
  final int? flags;
  final bool? newCatchainIds;
  final BigInt roundCandidates;
  final BigInt nextCandidateDelayMs;
  final BigInt consensusTimeoutMs;
  final BigInt fastAttempts;
  final BigInt attemptDuration;
  final BigInt catchainMaxDeps;
  final BigInt maxBlockBytes;
  final BigInt maxCollatedBytes;
  final BigInt? protoVersion;
  final BigInt? catchainMaxBlocksCoeff;

  const BlockchainConfig29({
    this.flags,
    this.newCatchainIds,
    required this.roundCandidates,
    required this.nextCandidateDelayMs,
    required this.consensusTimeoutMs,
    required this.fastAttempts,
    required this.attemptDuration,
    required this.catchainMaxDeps,
    required this.maxBlockBytes,
    required this.maxCollatedBytes,
    this.protoVersion,
    this.catchainMaxBlocksCoeff,
  });

  factory BlockchainConfig29.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig29(
      flags: json['flags'],
      newCatchainIds: json['new_catchain_ids'],
      roundCandidates: BigintUtils.parse(json['round_candidates']),
      nextCandidateDelayMs: BigintUtils.parse(json['next_candidate_delay_ms']),
      consensusTimeoutMs: BigintUtils.parse(json['consensus_timeout_ms']),
      fastAttempts: BigintUtils.parse(json['fast_attempts']),
      attemptDuration: BigintUtils.parse(json['attempt_duration']),
      catchainMaxDeps: BigintUtils.parse(json['catchain_max_deps']),
      maxBlockBytes: BigintUtils.parse(json['max_block_bytes']),
      maxCollatedBytes: BigintUtils.parse(json['max_collated_bytes']),
      protoVersion: BigintUtils.tryParse(json['proto_version']),
      catchainMaxBlocksCoeff:
          BigintUtils.tryParse(json['catchain_max_blocks_coeff']),
    );
  }

  Map<String, dynamic> toJson() => {
        'flags': flags,
        'new_catchain_ids': newCatchainIds,
        'round_candidates': roundCandidates.toString(),
        'next_candidate_delay_ms': nextCandidateDelayMs.toString(),
        'consensus_timeout_ms': consensusTimeoutMs.toString(),
        'fast_attempts': fastAttempts.toString(),
        'attempt_duration': attemptDuration.toString(),
        'catchain_max_deps': catchainMaxDeps.toString(),
        'max_block_bytes': maxBlockBytes.toString(),
        'max_collated_bytes': maxCollatedBytes.toString(),
        'proto_version': protoVersion?.toString(),
        'catchain_max_blocks_coeff': catchainMaxBlocksCoeff?.toString(),
      };
}

class BlockchainConfig28 {
  final BigInt mcCatchainLifetime;
  final BigInt shardCatchainLifetime;
  final BigInt shardValidatorsLifetime;
  final BigInt shardValidatorsNum;
  final int? flags;
  final bool? shuffleMcValidators;

  const BlockchainConfig28({
    required this.mcCatchainLifetime,
    required this.shardCatchainLifetime,
    required this.shardValidatorsLifetime,
    required this.shardValidatorsNum,
    this.flags,
    this.shuffleMcValidators,
  });

  factory BlockchainConfig28.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig28(
      mcCatchainLifetime: BigintUtils.parse(json['mc_catchain_lifetime']),
      shardCatchainLifetime: BigintUtils.parse(json['shard_catchain_lifetime']),
      shardValidatorsLifetime:
          BigintUtils.parse(json['shard_validators_lifetime']),
      shardValidatorsNum: BigintUtils.parse(json['shard_validators_num']),
      flags: json['flags'],
      shuffleMcValidators: json['shuffle_mc_validators'],
    );
  }

  Map<String, dynamic> toJson() => {
        'mc_catchain_lifetime': mcCatchainLifetime.toString(),
        'shard_catchain_lifetime': shardCatchainLifetime.toString(),
        'shard_validators_lifetime': shardValidatorsLifetime.toString(),
        'shard_validators_num': shardValidatorsNum.toString(),
        'flags': flags,
        'shuffle_mc_validators': shuffleMcValidators,
      };
}

class BlockchainConfig25 {
  final MsgForwardPricesResponse msgForwardPrices;

  const BlockchainConfig25({required this.msgForwardPrices});

  factory BlockchainConfig25.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig25(
      msgForwardPrices:
          MsgForwardPricesResponse.fromJson(json['msg_forward_prices']),
    );
  }

  Map<String, dynamic> toJson() => {
        'msg_forward_prices': msgForwardPrices.toJson(),
      };
}

class BlockchainConfig24 {
  final MsgForwardPricesResponse msgForwardPrices;

  const BlockchainConfig24({required this.msgForwardPrices});

  factory BlockchainConfig24.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig24(
      msgForwardPrices:
          MsgForwardPricesResponse.fromJson(json['msg_forward_prices']),
    );
  }

  Map<String, dynamic> toJson() => {
        'msg_forward_prices': msgForwardPrices.toJson(),
      };
}

class BlockchainConfig23 {
  final BlockLimitsResponse blockLimits;

  const BlockchainConfig23({required this.blockLimits});

  factory BlockchainConfig23.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig23(
      blockLimits: BlockLimitsResponse.fromJson(json['block_limits']),
    );
  }

  Map<String, dynamic> toJson() => {
        'block_limits': blockLimits.toJson(),
      };
}

class BlockchainConfig22 {
  final BlockLimitsResponse blockLimits;

  const BlockchainConfig22({required this.blockLimits});

  factory BlockchainConfig22.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig22(
      blockLimits: BlockLimitsResponse.fromJson(json['block_limits']),
    );
  }

  Map<String, dynamic> toJson() => {
        'block_limits': blockLimits.toJson(),
      };
}

class BlockchainConfig21 {
  final GasLimitPricesResponse gasLimitsPrices;

  const BlockchainConfig21({required this.gasLimitsPrices});

  factory BlockchainConfig21.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig21(
      gasLimitsPrices:
          GasLimitPricesResponse.fromJson(json['gas_limits_prices']),
    );
  }

  Map<String, dynamic> toJson() => {
        'gas_limits_prices': gasLimitsPrices.toJson(),
      };
}

class BlockchainConfig20 {
  final GasLimitPricesResponse gasLimitsPrices;

  const BlockchainConfig20({required this.gasLimitsPrices});

  factory BlockchainConfig20.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig20(
      gasLimitsPrices:
          GasLimitPricesResponse.fromJson(json['gas_limits_prices']),
    );
  }

  Map<String, dynamic> toJson() => {
        'gas_limits_prices': gasLimitsPrices.toJson(),
      };
}

class BlockchainConfig18StoragePricesItem {
  final BigInt utimeSince;
  final BigInt bitPricePs;
  final BigInt cellPricePs;
  final BigInt mcBitPricePs;
  final BigInt mcCellPricePs;

  const BlockchainConfig18StoragePricesItem({
    required this.utimeSince,
    required this.bitPricePs,
    required this.cellPricePs,
    required this.mcBitPricePs,
    required this.mcCellPricePs,
  });

  factory BlockchainConfig18StoragePricesItem.fromJson(
      Map<String, dynamic> json) {
    return BlockchainConfig18StoragePricesItem(
      utimeSince: BigintUtils.parse(json['utime_since']),
      bitPricePs: BigintUtils.parse(json['bit_price_ps']),
      cellPricePs: BigintUtils.parse(json['cell_price_ps']),
      mcBitPricePs: BigintUtils.parse(json['mc_bit_price_ps']),
      mcCellPricePs: BigintUtils.parse(json['mc_cell_price_ps']),
    );
  }

  Map<String, dynamic> toJson() => {
        'utime_since': utimeSince.toString(),
        'bit_price_ps': bitPricePs.toString(),
        'cell_price_ps': cellPricePs.toString(),
        'mc_bit_price_ps': mcBitPricePs.toString(),
        'mc_cell_price_ps': mcCellPricePs.toString(),
      };
}

class BlockchainConfig18 {
  final List<BlockchainConfig18StoragePricesItem> storagePrices;

  const BlockchainConfig18({required this.storagePrices});

  factory BlockchainConfig18.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig18(
      storagePrices: (json['storage_prices'] as List<dynamic>)
          .map((item) => BlockchainConfig18StoragePricesItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {'storage_prices': storagePrices.map((item) => item.toJson()).toList()};
}

class BlockchainConfig17 {
  final String minStake;
  final String maxStake;
  final String minTotalStake;
  final BigInt maxStakeFactor;

  const BlockchainConfig17({
    required this.minStake,
    required this.maxStake,
    required this.minTotalStake,
    required this.maxStakeFactor,
  });

  factory BlockchainConfig17.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig17(
      minStake: json['min_stake'],
      maxStake: json['max_stake'],
      minTotalStake: json['min_total_stake'],
      maxStakeFactor: BigintUtils.parse(json['max_stake_factor']),
    );
  }

  Map<String, dynamic> toJson() => {
        'min_stake': minStake,
        'max_stake': maxStake,
        'min_total_stake': minTotalStake,
        'max_stake_factor': maxStakeFactor.toString(),
      };
}

class BlockchainConfig16 {
  final int maxValidators;
  final int maxMainValidators;
  final int minValidators;

  const BlockchainConfig16({
    required this.maxValidators,
    required this.maxMainValidators,
    required this.minValidators,
  });

  factory BlockchainConfig16.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig16(
      maxValidators: json['max_validators'],
      maxMainValidators: json['max_main_validators'],
      minValidators: json['min_validators'],
    );
  }

  Map<String, dynamic> toJson() => {
        'max_validators': maxValidators,
        'max_main_validators': maxMainValidators,
        'min_validators': minValidators,
      };
}

class BlockchainConfig15 {
  final BigInt validatorsElectedFor;
  final BigInt electionsStartBefore;
  final BigInt electionsEndBefore;
  final BigInt stakeHeldFor;

  const BlockchainConfig15({
    required this.validatorsElectedFor,
    required this.electionsStartBefore,
    required this.electionsEndBefore,
    required this.stakeHeldFor,
  });

  factory BlockchainConfig15.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig15(
      validatorsElectedFor: BigintUtils.parse(json['validators_elected_for']),
      electionsStartBefore: BigintUtils.parse(json['elections_start_before']),
      electionsEndBefore: BigintUtils.parse(json['elections_end_before']),
      stakeHeldFor: BigintUtils.parse(json['stake_held_for']),
    );
  }

  Map<String, dynamic> toJson() => {
        'validators_elected_for': validatorsElectedFor.toString(),
        'elections_start_before': electionsStartBefore.toString(),
        'elections_end_before': electionsEndBefore.toString(),
        'stake_held_for': stakeHeldFor.toString(),
      };
}

class BlockchainConfig14 {
  final BigInt masterchainBlockFee;
  final BigInt basechainBlockFee;

  const BlockchainConfig14(
      {required this.masterchainBlockFee, required this.basechainBlockFee});

  factory BlockchainConfig14.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig14(
      masterchainBlockFee: BigintUtils.parse(json['masterchain_block_fee']),
      basechainBlockFee: BigintUtils.parse(json['basechain_block_fee']),
    );
  }

  Map<String, dynamic> toJson() => {
        'masterchain_block_fee': masterchainBlockFee.toString(),
        'basechain_block_fee': basechainBlockFee.toString(),
      };
}

class BlockchainConfig13 {
  final BigInt deposit;
  final BigInt bitPrice;
  final BigInt cellPrice;

  const BlockchainConfig13({
    required this.deposit,
    required this.bitPrice,
    required this.cellPrice,
  });

  factory BlockchainConfig13.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig13(
      deposit: BigintUtils.parse(json['deposit']),
      bitPrice: BigintUtils.parse(json['bit_price']),
      cellPrice: BigintUtils.parse(json['cell_price']),
    );
  }

  Map<String, dynamic> toJson() => {
        'deposit': deposit.toString(),
        'bit_price': bitPrice.toString(),
        'cell_price': cellPrice.toString(),
      };
}

class BlockchainConfig12 {
  final List<WorkchainDescr> workchains;

  const BlockchainConfig12({required this.workchains});

  factory BlockchainConfig12.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig12(
      workchains: (json['workchains'] as List<dynamic>)
          .map((item) => WorkchainDescr.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() =>
      {'workchains': workchains.map((item) => item.toJson()).toList()};
}

class BlockchainConfig11 {
  final ConfigProposalSetupResponse normalParams;
  final ConfigProposalSetupResponse criticalParams;

  const BlockchainConfig11({
    required this.normalParams,
    required this.criticalParams,
  });

  factory BlockchainConfig11.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig11(
      normalParams: ConfigProposalSetupResponse.fromJson(json['normal_params']),
      criticalParams:
          ConfigProposalSetupResponse.fromJson(json['critical_params']),
    );
  }

  Map<String, dynamic> toJson() => {
        'normal_params': normalParams.toJson(),
        'critical_params': criticalParams.toJson()
      };
}

class BlockchainConfig10 {
  final List<int> criticalParams;

  const BlockchainConfig10({
    required this.criticalParams,
  });

  factory BlockchainConfig10.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig10(
      criticalParams: List<int>.from(json['critical_params']),
    );
  }

  Map<String, dynamic> toJson() => {
        'critical_params': criticalParams,
      };
}

class BlockchainConfig9 {
  final List<int> mandatoryParams;

  const BlockchainConfig9({
    required this.mandatoryParams,
  });

  factory BlockchainConfig9.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig9(
      mandatoryParams: List<int>.from(json['mandatory_params']),
    );
  }

  Map<String, dynamic> toJson() => {'mandatory_params': mandatoryParams};
}

class BlockchainConfig8 {
  final BigInt version;
  final BigInt capabilities;

  const BlockchainConfig8({required this.version, required this.capabilities});

  factory BlockchainConfig8.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig8(
      version: BigintUtils.parse(json['version']),
      capabilities: BigintUtils.parse(json['capabilities']),
    );
  }

  Map<String, dynamic> toJson() =>
      {'version': version.toString(), 'capabilities': capabilities.toString()};
}

class BlockchainConfig7CurrenciesItem {
  final BigInt currencyId;
  final String amount;

  const BlockchainConfig7CurrenciesItem({
    required this.currencyId,
    required this.amount,
  });

  factory BlockchainConfig7CurrenciesItem.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig7CurrenciesItem(
      currencyId: BigintUtils.parse(json['currency_id']),
      amount: json['amount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'currency_id': currencyId.toString(),
        'amount': amount,
      };
}

class BlockchainConfig7 {
  final List<BlockchainConfig7CurrenciesItem> currencies;

  const BlockchainConfig7({required this.currencies});

  factory BlockchainConfig7.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig7(
        currencies: (json['currencies'] as List)
            .map((item) => BlockchainConfig7CurrenciesItem.fromJson(item))
            .toList());
  }

  Map<String, dynamic> toJson() =>
      {'currencies': currencies.map((item) => item.toJson()).toList()};
}

class BlockchainConfig6 {
  final BigInt mintNewPrice;
  final BigInt mintAddPrice;

  const BlockchainConfig6(
      {required this.mintNewPrice, required this.mintAddPrice});

  factory BlockchainConfig6.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig6(
      mintNewPrice: BigintUtils.parse(json['mint_new_price']),
      mintAddPrice: BigintUtils.parse(json['mint_add_price']),
    );
  }

  Map<String, dynamic> toJson() => {
        'mint_new_price': mintNewPrice.toString(),
        'mint_add_price': mintAddPrice.toString()
      };
}

class BlockchainConfig5 {
  final String? blackholeAddr;
  final BigInt feeBurnNom;
  final BigInt feeBurnDenom;

  const BlockchainConfig5({
    this.blackholeAddr,
    required this.feeBurnNom,
    required this.feeBurnDenom,
  });

  factory BlockchainConfig5.fromJson(Map<String, dynamic> json) {
    return BlockchainConfig5(
      blackholeAddr: json['blackhole_addr'],
      feeBurnNom: BigintUtils.parse(json['fee_burn_nom']),
      feeBurnDenom: BigintUtils.parse(json['fee_burn_denom']),
    );
  }

  Map<String, dynamic> toJson() => {
        'blackhole_addr': blackholeAddr,
        'fee_burn_nom': feeBurnNom.toString(),
        'fee_burn_denom': feeBurnDenom.toString()
      };
}
