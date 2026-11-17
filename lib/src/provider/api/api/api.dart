import 'dart:async';
import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models/common_message_info.dart';
import 'package:ton_dart/src/models/models/message.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/provider/models/account_state.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/provider/models/run_method_response.dart';
import 'package:ton_dart/src/contracts/wallet_contracts/types/state/order.dart';
import 'package:ton_dart/src/helper/ton_helper.dart';
import 'package:ton_dart/src/provider/api/models/api_models.dart';
import 'package:ton_dart/src/provider/core/core.dart';
import 'package:ton_dart/src/provider/cosntant/constant.dart';
import 'package:ton_dart/src/provider/generated/tonapi/tonapi_models.dart'
    as tonapi_models;
import 'package:ton_dart/src/provider/generated/tonapi/tonapi_requests.dart'
    as tonapi;
import 'package:ton_dart/src/provider/generated/toncenter/toncenter_models.dart'
    as toncenter;
import 'package:ton_dart/src/provider/generated/toncenter/toncenter_requests.dart'
    as toncenter;
import 'package:ton_dart/src/provider/generated/toncenter_v3/toncenter_v3_models.dart'
    as toncenter_v3_models;
import 'package:ton_dart/src/provider/generated/toncenter_v3/toncenter_v3_requests.dart'
    as toncenter_v3;
import 'package:ton_dart/src/provider/models/response/account_status.dart';
import 'package:ton_dart/src/provider/models/response/block_configs/block_configs.dart';
import 'package:ton_dart/src/provider/models/response/gas_limit_prices.dart';
import 'package:ton_dart/src/provider/models/response/msg_forward_prices.dart';
import 'package:ton_dart/src/tuple/tuple.dart';

mixin TonQuickClientApi {
  /// Single provider serving every call. The interface type also accepts
  /// wrapping providers (e.g. a `DefaultProvider` that converts errors), in
  /// which case backend-specific error mapping below stays dormant and the
  /// wrapper's mapping applies — same outcome either way.
  IProvider<IServiceProvider, TonRequestDetails> get provider;
  List<TonApiType> get availableProviders;

  Future<T> mapProviderApi<T>({
    required Future<T> Function() onTonCenter,
    required Future<T> Function() onTonApi,
  }) async {
    if (availableProviders.contains(TonApiType.tonCenter)) {
      return onTonCenter();
    }
    if (availableProviders.contains(TonApiType.tonApi)) {
      return onTonApi();
    }
    throw BuError(DefaultErrorType.invalidState, 'No available provider.');
  }

  /// TON balance of [address] in nanotons.
  Future<BigInt> getBalance(TonAddress address) {
    final addr = address.toString();
    return mapProviderApi(
      onTonCenter:
          () => provider.request(
            toncenter.TonCenterGetAddressBalancePost(address: addr),
          ),
      onTonApi: () async {
        final account = await provider.request(
          tonapi.TonApiGetAccount(accountId: addr),
        );
        return account.balance;
      },
    );
  }

  /// Full account state (balance, code, data, status).
  ///
  /// tonApi answers 404 for unknown accounts; like before, those map to an
  /// uninitialized empty state instead of throwing.
  Future<AccountStateResponse> getAccountState(TonAddress address) {
    final addr = address.toString();
    return mapProviderApi(
      onTonCenter: () async {
        final info = await provider.request(
          toncenter.TonCenterGetAddressInformationPost(address: addr),
        );
        return AccountStateResponse(
          balance: BigintUtils.parse(info.balance),
          code: TonHelper.tryToCell(info.code),
          data: TonHelper.tryToCell(info.data),
          state: AccountStatusResponse.fromName(info.state.value),
        );
      },
      onTonApi: () async {
        try {
          final state = await provider.request(
            tonapi.TonApiGetBlockchainRawAccount(accountId: addr),
          );
          return AccountStateResponse(
            balance: state.balance,
            code: TonHelper.tryToCell(state.code),
            data: TonHelper.tryToCell(state.data),
            state: AccountStatusResponse.fromName(state.status.value),
          );
        } on RPCError catch (e) {
          if (e.message == ApiProviderConst.tonApiEntityNotFound) {
            return AccountStateResponse(
              balance: BigInt.zero,
              code: null,
              data: null,
              state: AccountStatusResponse.uninit,
            );
          }
          rethrow;
        }
      },
    );
  }

  /// Runs a contract get-method. [args] are neutral [TupleItem]s, adapted
  /// per backend (`[['num', v]]` pairs for tonCenter, flat strings for
  /// tonApi — the exact wire shapes the old branches sent).
  Future<RunMethodResponse> runGetMethod({
    required TonAddress address,
    required String method,
    List<TupleItem> args = const [],
  }) {
    final addr = address.toString();
    return mapProviderApi(
      onTonCenter: () async {
        final res = await provider.request(
          toncenter.TonCenterRunGetMethodPost(
            address: addr,
            method_: toncenter.RunGetMethodRequestMethodStringValue(method),
            stack: _toTonCenterStack(args),
          ),
        );
        return RunMethodResponse(
          items: _parseTonCenterStack(res.stack),
          exitCode: res.exitCode,
        );
      },
      onTonApi: () async {
        final res = await provider.request(
          tonapi.TonApiExecGetMethodForBlockchainAccount(
            accountId: addr,
            methodName: method,
            // An empty list would encode as an empty `args` value, which the
            // API rejects — omit the parameter instead.
            args: args.isEmpty ? null : args.map(_tupleToStringArg).toList(),
          ),
        );
        return RunMethodResponse(
          items: res.stack.map(_tvmRecordToTuple).toList(),
          exitCode: res.exitCode,
        );
      },
    );
  }

  /// Broadcasts a base64 BoC, returning the message hash (same as before).
  Future<String> sendBoc(String bocBase64) async {
    await mapProviderApi(
      onTonCenter:
          () => provider.request(
            toncenter.TonCenterSendBocReturnHashPost(boc: bocBase64),
          ),
      onTonApi:
          () => provider.request(
            tonapi.TonApiSendBlockchainMessage(batch: const [], boc: bocBase64),
          ),
    );
    return StringUtils.decode(
      Cell.fromBase64(bocBase64).hash(),
      encoding: StringEncoding.base64,
    );
  }

  /// Current masterchain seqno.
  Future<int> getMasterchainSeqno() {
    return mapProviderApi(
      onTonCenter: () async {
        final info = await provider.request(
          toncenter.TonCenterGetMasterchainInfoPost(
            requestBody: const toncenter.MasterchainInfoRequest({}),
          ),
        );
        return info.last.seqno;
      },
      onTonApi: () async {
        final head = await provider.request(
          tonapi.TonApiGetBlockchainMasterchainHead(),
        );
        return head.seqno;
      },
    );
  }

  /// Chain global id (for network validation).
  Future<int> getGlobalId() {
    return mapProviderApi(
      onTonCenter: () async {
        final info = await provider.request(
          toncenter.TonCenterGetMasterchainInfoPost(
            requestBody: const toncenter.MasterchainInfoRequest({}),
          ),
        );
        final last = info.last;
        final header = await provider.request(
          toncenter.TonCenterGetBlockHeaderPost(
            workchain: toncenter.AddressWithSeqnoRequestSeqnoInteger(
              last.workchain,
            ),
            shard: BigintUtils.parse(last.shard),
            seqno: toncenter.AddressWithSeqnoRequestSeqnoInteger(last.seqno),
          ),
        );
        return header.globalId;
      },
      onTonApi: () async {
        final head = await provider.request(
          tonapi.TonApiGetBlockchainMasterchainHead(),
        );
        return head.globalId;
      },
    );
  }

  /// Message-forward prices for fee estimation.
  Future<MsgForwardPricesResponse> getMsgForwardPrices({
    bool isMasterChain = true,
  }) {
    return mapProviderApi(
      onTonCenter: () async {
        final info = await provider.request(
          toncenter.TonCenterGetConfigParamPost(
            configId: toncenter.AddressWithSeqnoRequestSeqnoInteger(
              isMasterChain ? 24 : 25,
            ),
          ),
        );
        final slice = TonHelper.toCell(info.config.bytes).beginParse();
        return BlockchainConfig24.derserialize(slice).msgForwardPrices;
      },
      onTonApi: () async {
        final config = await provider.request(
          tonapi.TonApiGetBlockchainConfig(),
        );
        final prices =
            (isMasterChain ? config.n24 : config.n25)?.msgForwardPrices;
        if (prices == null) {
          throw BuError(
            DefaultErrorType.invalidState,
            'Message forward prices missing from chain config.',
          );
        }
        return MsgForwardPricesResponse(
          lumpPrice: prices.lumpPrice,
          bitPrice: prices.bitPrice,
          cellPrice: prices.cellPrice,
          ihrPriceFactor: prices.ihrPriceFactor.toInt(),
          firstFrac: prices.firstFrac.toInt(),
          nextFrac: prices.nextFrac.toInt(),
        );
      },
    );
  }

  /// Gas limit prices for fee estimation.
  Future<GasLimitPricesResponse> getGasLimitPrices({
    bool isMasterChain = true,
  }) {
    return mapProviderApi(
      onTonCenter: () async {
        final info = await provider.request(
          toncenter.TonCenterGetConfigParamPost(
            configId: toncenter.AddressWithSeqnoRequestSeqnoInteger(
              isMasterChain ? 20 : 21,
            ),
          ),
        );
        final slice = TonHelper.toCell(info.config.bytes).beginParse();
        if (isMasterChain) {
          return BlockchainConfig20.deserialize(slice).gasLimitsPrices;
        }
        return BlockchainConfig21.deserialize(slice).gasLimitsPrices;
      },
      onTonApi: () async {
        final config = await provider.request(
          tonapi.TonApiGetBlockchainConfig(),
        );
        final prices =
            (isMasterChain ? config.n20 : config.n21)?.gasLimitsPrices;
        if (prices == null) {
          throw BuError(
            DefaultErrorType.invalidState,
            'Gas limit prices missing from chain config.',
          );
        }
        return GasLimitPricesResponse(
          specialGasLimit: prices.specialGasLimit,
          flatGasLimit: prices.flatGasLimit ?? BigInt.zero,
          flatGasPrice: prices.flatGasPrice ?? BigInt.zero,
          gasPrice: prices.gasPrice,
          gasLimit: prices.gasLimit,
          gasCredit: prices.gasCredit,
          blockGasLimit: prices.blockGasLimit,
          freezeDueLimit: prices.freezeDueLimit,
          deleteDueLimit: prices.deleteDueLimit,
        );
      },
    );
  }

  /// Storage prices for fee estimation.
  ///
  /// Both backends serve the same price list; [isMasterChain] is accepted
  /// for signature symmetry and currently ignored.
  Future<List<BlockchainConfig18StoragePricesItem>> getStoragePrices({
    bool isMasterChain = true,
  }) {
    return mapProviderApi(
      onTonCenter: () async {
        final info = await provider.request(
          toncenter.TonCenterGetConfigParamPost(
            configId: toncenter.AddressWithSeqnoRequestSeqnoInteger(18),
          ),
        );
        final slice = TonHelper.toCell(info.config.bytes).beginParse();
        return BlockchainConfig18.deserialize(slice).storagePrices;
      },
      onTonApi: () async {
        final config = await provider.request(
          tonapi.TonApiGetBlockchainConfig(),
        );
        final prices = config.n18?.storagePrices;
        if (prices == null) {
          throw BuError(
            DefaultErrorType.invalidState,
            'Storage prices missing from chain config.',
          );
        }
        return [
          for (final e in prices)
            BlockchainConfig18StoragePricesItem(
              utimeSince: e.utimeSince.toInt(),
              bitPricePs: e.bitPricePs,
              cellPricePs: e.cellPricePs,
              mcBitPricePs: e.mcBitPricePs,
              mcCellPricePs: e.mcCellPricePs,
            ),
        ];
      },
    );
  }

  /// Estimates fees for a message (base64 BoC parts). tonApi emulates the
  /// full trace (nested messages included); tonCenter returns query fees.
  ///
  /// tonApi's emulate endpoint needs the complete external message cell
  /// (header with the destination included): it is rebuilt here from
  /// [address] (destination), [body] and the init parts. Sending only the
  /// body cell leaves the message without a destination account.
  Future<TonFeeEstimation> estimateFee({
    required String address,
    required String body,
    String? initCode,
    String? initData,
    bool ignoreChksig = true,
  }) {
    return mapProviderApi(
      onTonCenter: () async {
        final res = await provider.request(
          toncenter.TonCenterEstimateFeePost(
            address: address,
            body_: body,
            initCode: initCode,
            initData: initData,
            ignoreChksig: ignoreChksig,
          ),
        );
        final source = res.sourceFees;
        return TonFeeEstimation(
          actionPhase: source.inFwdFee + source.fwdFee,
          storageFee: source.storageFee,
          gasFee: source.gasFee,
          success: true,
        );
      },
      onTonApi: () async {
        final external = Message(
          info: CommonMessageInfoExternalIn(
            dest: TonAddress(address),
            importFee: BigInt.zero,
          ),
          init:
              initCode == null && initData == null
                  ? null
                  : StateInit(
                    code: initCode == null ? null : Cell.fromBase64(initCode),
                    data: initData == null ? null : Cell.fromBase64(initData),
                  ),
          body: Cell.fromBase64(body),
        );
        final res = await provider.request(
          tonapi.TonApiEmulateMessageToTrace(
            boc: beginCell().store(external).endCell().toBase64(),
            ignoreSignatureCheck: ignoreChksig,
          ),
        );
        final tx = res.transaction;
        final internal = [
          for (final c in res.children ?? []) ..._emulateMessages(c),
        ];
        final success = tx.success && internal.every((e) => e.success);
        return TonFeeEstimation(
          actionPhase: tx.actionPhase?.totalFees ?? BigInt.zero,
          gasFee: tx.computePhase?.gasFees ?? BigInt.zero,
          storageFee: tx.storagePhase?.feesCollected ?? BigInt.zero,
          success: success,
          resultDescription:
              tx.actionPhase?.resultCodeDescription ?? _firstFailure(internal),
          internalMessages: internal,
        );
      },
    );
  }

  /// Status of a transaction by message hash, or transaction hash.
  Future<TonTxStatus> getTransactionStatus(
    String txId, {
    bool isMessageHash = true,
  }) {
    return mapProviderApi(
      onTonCenter: () async {
        final res = await provider.request(
          toncenter_v3.TonCenterV3GetTraces(
            msgHash: isMessageHash ? txId : null,
            txHash: isMessageHash ? null : txId,
            includeActions: 'true',
          ),
        );
        final traces = res.traces ?? const [];
        final want = _normHash(txId);
        TonTxStatus status = TonTxStatus.unknown;
        for (final t in traces) {
          final keys = <String?>[t.externalHash, ...?t.transactions?.keys];
          if (!keys.any((k) => k != null && _normHash(k) == want)) {
            continue;
          }
          final actions = t.actions;
          if (actions == null) return TonTxStatus.unknown;
          if (!actions.every((e) => e.success ?? false)) {
            return TonTxStatus.failed;
          }
          status = TonTxStatus.included;
        }
        return status;
      },
      onTonApi: () async {
        final tx = await provider.request(
          tonapi.TonApiGetBlockchainTransaction(transactionId: txId),
        );
        return tx.success ? TonTxStatus.included : TonTxStatus.failed;
      },
    );
  }

  /// Multisig orders for [multisig] (one page, server order). tonCenter
  /// serves the v3 multisig indexer (`/api/v3/multisig/orders`); tonApi
  /// serves `/v2/multisig/{account_id}`. Both are mapped to
  /// [MultisigOrderInfo], so callers never scan order seqnos and are immune
  /// to seqno gaps (arbitrary `order_id` when the multisig allows it).
  /// Returns an empty list when the multisig has no orders.
  Future<List<MultisigOrderInfo>> getMultisigOrders({
    required TonAddress multisig,
    int limit = 16,
    int offset = 0,
  }) {
    final address = multisig.address;
    return mapProviderApi(
      onTonCenter: () async {
        final res = await provider.request(
          toncenter_v3.TonCenterV3GetMultisigOrders(
            multisigAddress: address,
            limit: limit.toString(),
            offset: offset.toString(),
          ),
        );
        return (res.orders ?? const [])
            .map((e) => _multisigOrderV3ToInfo(multisig, e))
            .whereType<MultisigOrderInfo>()
            .toList();
      },
      onTonApi: () async {
        final res = await provider.request(
          tonapi.TonApiGetMultisigAccount(accountId: address),
        );
        return [
          for (final e in res.orders)
            MultisigOrderInfo(
              address: TonAddress(e.address),
              state: _tonApiOrderToState(e),
            ),
        ];
      },
    );
  }

  /// Jetton wallet address of [owner] for [jettonMaster]
  /// (`get_wallet_address`, swap parity). Throws when the method exits
  /// non-zero.
  Future<TonAddress> getJettonWalletAddress({
    required TonAddress owner,
    required TonAddress jettonMaster,
  }) async {
    final res = await runGetMethod(
      address: jettonMaster,
      method: 'get_wallet_address',
      args: [TupleItemSlice(beginCell().storeAddress(owner).endCell())],
    );
    if (res.exitCode != 0) {
      throw BuError(
        DefaultErrorType.network,
        "TON get-method 'get_wallet_address' failed.",
        details: {'exitCode': res.exitCode.toString()},
      );
    }
    return res.reader().readAddress();
  }

  /// Jetton balance of [jettonWallet] (`get_wallet_data`, swap parity).
  /// Throws when the method exits non-zero.
  Future<BigInt> getJettonBalance({required TonAddress jettonWallet}) async {
    final res = await runGetMethod(
      address: jettonWallet,
      method: 'get_wallet_data',
    );
    if (res.exitCode != 0) {
      throw BuError(
        DefaultErrorType.network,
        "TON get-method 'get_wallet_data' failed.",
        details: {'exitCode': res.exitCode.toString()},
      );
    }
    return res.reader().readBigNumber();
  }

  /// Current seqno of the wallet contract at [address] (`seqno`
  /// get-method). Throws when the method exits non-zero.
  Future<int> getWalletSeqno(TonAddress address) async {
    final res = await runGetMethod(address: address, method: 'seqno');
    if (res.exitCode != 0) {
      throw BuError(
        DefaultErrorType.network,
        "TON get-method 'seqno' failed.",
        details: {'exitCode': res.exitCode.toString()},
      );
    }
    return res.reader().readNumber();
  }

  /// Polls [getWalletSeqno] until [account]'s seqno exceeds [seqno]
  /// (swap `trackTransaction` parity). Transport and exit-code failures
  /// are ignored between polls; throws on [timeout].
  Future<void> trackWalletSeqno({
    required TonAddress account,
    required int seqno,
    Duration timeout = const Duration(minutes: 2),
    Duration periodicTimeOut = const Duration(seconds: 3),
  }) async {
    Timer? timer;
    try {
      final Completer<void> completer = Completer<void>();
      timer = Timer.periodic(periodicTimeOut, (_) async {
        if (completer.isCompleted) return;
        try {
          final current = await getWalletSeqno(account);
          if (current > seqno) completer.complete();
        } catch (_) {}
      });
      await completer.future.timeout(timeout);
    } on TimeoutException {
      throw BuError(
        DefaultErrorType.invalidState,
        'Transaction confirmation failed within the allotted timeout.',
      );
    } finally {
      timer?.cancel();
      timer = null;
    }
  }

  /// Jetton balances (single page). tonCenter joins wallet entries with
  /// master metadata; tonApi returns preview data directly.
  Future<List<TonJettonBalance>> getAccountJettons({
    required String owner,
    String? jetton,
    int? limit,
    int? offset,
  }) {
    return mapProviderApi(
      onTonCenter: () async {
        final res = await provider.request(
          toncenter_v3.TonCenterV3GetJettonWallets(
            ownerAddress: owner,
            jettonAddress: jetton,
            limit: limit?.toString(),
            offset: offset?.toString(),
          ),
        );
        final meta = res.metadata?.values ?? const {};
        return [
          for (final e
              in res.jettonWallets ??
                  const <toncenter_v3_models.JettonWallet>[])
            TonJettonBalance(
              minter: e.jetton ?? '',
              owner: e.owner,
              wallet: e.address ?? '',
              balance: BigintUtils.tryParse(e.balance ?? '') ?? BigInt.zero,
              name: _jettonToken(meta, e.jetton)?.name,
              symbol: _jettonToken(meta, e.jetton)?.symbol,
              decimals: _jettonMetaDecimals(meta, e.jetton),
              image: _jettonToken(meta, e.jetton)?.image,
            ),
        ];
      },
      onTonApi: () async {
        final res = await provider.request(
          tonapi.TonApiGetAccountJettonsBalances(
            accountId: owner,
            limit: limit,
            offset: offset,
          ),
        );
        return [
          for (final e in res.balances)
            TonJettonBalance(
              minter: e.jetton.address,
              owner: owner,
              wallet: e.walletAddress.address,
              balance: BigintUtils.parse(e.balance),
              name: e.jetton.name,
              symbol: e.jetton.symbol,
              decimals: e.jetton.decimals,
              image: e.jetton.image,
            ),
        ];
      },
    );
  }
}

/// Normalizes a hash to lowercase hex so hex and base64(/url) spellings of
/// the same bytes compare equal. Returns the input untouched when it cannot
/// be decoded.
String _normHash(String hash) {
  try {
    if (hash.length == 64 && RegExp(r'^[0-9a-fA-F]+$').hasMatch(hash)) {
      return hash.toLowerCase();
    }
    var norm = hash.replaceAll('-', '+').replaceAll('_', '/');
    while (norm.length % 4 != 0) {
      norm += '=';
    }
    return BytesUtils.toHexString(base64Decode(norm)).toLowerCase();
  } catch (_) {
    return hash;
  }
}

/// Neutral [TupleItem] args to tonCenter `[type, value]` stack pairs.
List<toncenter.LegacyStackEntry> _toTonCenterStack(List<TupleItem> args) {
  return args.map((e) {
    final toncenter.LegacyStackEntryItem type;
    final toncenter.LegacyStackEntryItem value;
    if (e is TupleItemInt) {
      type = const toncenter.LegacyStackEntryItemStringValue('num');
      value = toncenter.LegacyStackEntryItemStringValue(e.value.toString());
    } else if (e is TupleItemSlice) {
      // Matches the long-standing wire shape (e.g. jetton get_wallet_address).
      type = const toncenter.LegacyStackEntryItemStringValue('tvm.Slice');
      value = toncenter.LegacyStackEntryItemStringValue(e.cell.toBase64());
    } else if (e is TupleItemCell) {
      // Matches the long-standing wire shape (e.g. nft get_nft_content).
      type = const toncenter.LegacyStackEntryItemStringValue('tvm.Cell');
      value = toncenter.LegacyStackEntryItemStringValue(e.cell.toBase64());
    } else {
      throw BuError(
        DefaultErrorType.unsupported,
        'Unsupported stack argument for tonCenter.',
        details: {'type': e.type.name},
      );
    }
    return <toncenter.LegacyStackEntryItem>[type, value];
  }).toList();
}

/// tonCenter typed stack entries back to the legacy raw pairs understood by
/// [TupleUtils.parseStackItemAsList].
List<TupleItem> _parseTonCenterStack(List<toncenter.LegacyStackEntry> stack) {
  final raw =
      stack.map((entry) {
        return entry.map((item) {
          return switch (item) {
            toncenter.LegacyStackEntryItemStringValue(value: final v) => v,
            toncenter.LegacyStackEntryItemInteger(value: final v) =>
              v.toString(),
            toncenter.LegacyStackEntryItemLegacyStackEntryCell(
              value: final v,
            ) =>
              {'bytes': v.bytes},
            _ =>
              throw BuError(
                DefaultErrorType.unsupported,
                'Unsupported tonCenter stack entry.',
                details: {'item': item.toJson()},
              ),
          };
        }).toList();
      }).toList();
  return TupleUtils.parseStackItemAsList(raw);
}

/// Neutral [TupleItem] args to tonApi flat string args.
String _tupleToStringArg(TupleItem e) {
  if (e is TupleItemInt) return e.value.toString();
  if (e is TupleItemCell) {
    // tonApi historically receives the address string for slice args.
    try {
      return e.cell.beginParse().loadAddress().toString();
    } catch (_) {
      return e.cell.toBase64();
    }
  }
  throw BuError(
    DefaultErrorType.unsupported,
    'Unsupported stack argument for tonApi.',
    details: {'type': e.type.name},
  );
}

/// tonApi stack records to [TupleItem] (ports `TvmStackRecordResponse.toTuple`
/// onto the generated model).
TupleItem _tvmRecordToTuple(tonapi_models.TvmStackRecord rec) {
  switch (rec.type) {
    case tonapi_models.TvmStackRecordType.cell:
      final cell = rec.cell;
      if (cell == null) {
        throw BuError(
          DefaultErrorType.invalidArgument,
          'Missing cell in stack record.',
        );
      }
      return TupleItemCell(
        StringUtils.isHexBytes(cell)
            ? Cell.fromBytes(BytesUtils.fromHexString(cell))
            : Cell.fromBase64(cell),
      );
    case tonapi_models.TvmStackRecordType.nan:
      return const TupleItemNaN();
    case tonapi_models.TvmStackRecordType.null_:
      return const TupleItemNull();
    case tonapi_models.TvmStackRecordType.tuple:
      return TupleItemTuple(rec.tuple?.map(_tvmRecordToTuple).toList() ?? []);
    case tonapi_models.TvmStackRecordType.num_:
      return TupleItemInt(BigintUtils.parse(rec.num_));
  }
}

/// tonApi emulated trace (+ children) to unified message infos.
List<TonEmulatedMessageInfo> _emulateMessages(tonapi_models.Trace trace) {
  TonEmulatedMessageInfo mapOne(tonapi_models.Trace e) {
    final tx = e.transaction;
    final computeOk = tx.computePhase?.success ?? true;
    final actionOk = tx.actionPhase?.success ?? true;
    final success = computeOk && actionOk && tx.success;
    String? error;
    if (!success) {
      if (!computeOk) {
        error =
            tx.computePhase?.exitCodeDescription ??
            tx.computePhase?.exitCode?.toString();
      } else if (!actionOk) {
        error = tx.actionPhase?.resultCodeDescription;
      }
    }
    return TonEmulatedMessageInfo(
      destination: tx.inMsg?.destination?.address,
      actionPhase: tx.actionPhase?.fwdFees ?? BigInt.zero,
      gasFee: tx.computePhase?.gasFees ?? BigInt.zero,
      storageFee: tx.storagePhase?.feesCollected ?? BigInt.zero,
      success: success,
      resultDescription: error,
      internalMessages: [for (final c in e.children ?? const []) mapOne(c)],
    );
  }

  return [mapOne(trace)];
}

/// First failing nested message description, if any.
String? _firstFailure(List<TonEmulatedMessageInfo> messages) {
  for (final e in messages) {
    if (!e.success && e.resultDescription != null) return e.resultDescription;
    final nested = _firstFailure(e.internalMessages);
    if (nested != null) return nested;
  }
  return null;
}

/// First named token entry for a v3 jetton master address, if any.
toncenter_v3_models.TokenInfo? _jettonToken(
  Map<String, toncenter_v3_models.AddressMetadata> meta,
  String? jetton,
) {
  if (jetton == null) return null;
  final infos = meta[jetton]?.tokenInfo;
  if (infos == null) return null;
  for (final info in infos) {
    if (info.name != null) return info;
  }
  return null;
}

/// Decimals may ride inside the metadata `extra` map.
int? _jettonMetaDecimals(
  Map<String, toncenter_v3_models.AddressMetadata> meta,
  String? jetton,
) {
  final extra = _jettonToken(meta, jetton)?.extra;
  final raw = extra?['decimals'];
  if (raw is int) return raw;
  if (raw is String) return IntUtils.tryParse(raw);
  return null;
}

/// v3 `/api/v3/multisig/orders` entry to [MultisigOrderInfo]. Null when the
/// entry carries no order address and cannot be used.
MultisigOrderInfo? _multisigOrderV3ToInfo(
  TonAddress multisig,
  toncenter_v3_models.MultisigOrder order,
) {
  final address = order.address;
  if (address == null) return null;
  return MultisigOrderInfo(
    address: TonAddress(address),
    state: OrderContractState(
      multisig:
          order.multisigAddress == null
              ? multisig
              : TonAddress(order.multisigAddress!),
      orderSeqno: BigintUtils.tryParse(order.orderSeqno ?? '') ?? BigInt.zero,
      threshold: order.threshold,
      executed: order.sentForExecution,
      signers: [for (final s in order.signers ?? const []) TonAddress(s)],
      approvals: BigintUtils.tryParse(order.approvalsMask),
      approvalsNum: order.approvalsNum,
      expirationDate:
          order.expirationDate == null
              ? null
              : BigInt.from(order.expirationDate!),
      order: TonHelper.tryToCell(order.orderBoc),
    ),
  );
}

/// tonApi `/v2/multisig/{account_id}` order entry to [OrderContractState].
/// tonApi reports approvers as addresses ([signedBy]) instead of a bitmask,
/// so the mask is rebuilt from the approvers' signer indexes.
OrderContractState _tonApiOrderToState(tonapi_models.MultisigOrder order) {
  final signers = [for (final s in order.signers) TonAddress(s)];
  BigInt approvals = BigInt.zero;
  for (final by in order.signedBy) {
    final idx = signers.indexWhere((e) => e == TonAddress(by));
    if (idx >= 0) approvals |= (BigInt.one << idx);
  }
  return OrderContractState(
    multisig: TonAddress(order.multisigAddress),
    orderSeqno: BigintUtils.tryParse(order.orderSeqno) ?? BigInt.zero,
    threshold: order.threshold,
    executed: order.sentForExecution,
    signers: signers,
    approvals: approvals,
    approvalsNum: order.approvalsNum,
    expirationDate: order.expirationDate,
  );
}
