import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/dict/dictionary.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/models/models/state_init.dart';

class MultiOwnerWalletState extends ContractState {
  final int threshold;
  final List<TonAddress> signers;
  final List<TonAddress> proposers;
  final bool allowArbitrarySeqno;
  final BigInt nextOrderSeqno;
  final int signersNum;

  factory MultiOwnerWalletState.deserialize(Slice slice) {
    final next = slice.loadUint256();
    final threshHold = slice.loadUint8();
    final signers = Dictionary.loadDirect<int, TonAddress>(
            key: DictionaryKey.uintCodec(8),
            value: DictionaryValue.addressCodec(),
            slice: slice.loadRef().beginParse())
        .asMap
        .values
        .toList();
    final int signerNum = slice.loadUint8();
    final proposers = Dictionary.load<int, TonAddress>(
        DictionaryKey.uintCodec(8), DictionaryValue.addressCodec(), slice);
    return MultiOwnerWalletState(
      nextOrderSeqno: next,
      threshold: threshHold,
      signers: signers,
      signersNum: signerNum,
      proposers: proposers.values.toList(),
      allowArbitrarySeqno: slice.loadBoolean(),
    );
  }
  MultiOwnerWalletState({
    required this.threshold,
    required this.allowArbitrarySeqno,
    BigInt? nextOrderSeqno,
    int? signersNum,
    List<TonAddress> signers = const [],
    List<TonAddress> proposers = const [],
  })  : signers = List<TonAddress>.unmodifiable(signers),
        proposers = List<TonAddress>.unmodifiable(proposers),
        nextOrderSeqno = nextOrderSeqno ?? BigInt.zero,
        signersNum = signersNum ?? signers.length;

  @override
  StateInit initialState({TonChainId? chain}) {
    Cell? code;
    if (chain == TonChainId.testnet) {
      code = Cell.fromHex(MultiOwnerContractConst.multiSigCodeTestNet);
    }
    code ??= Cell.fromHex(MultiOwnerContractConst.multisigCode);
    return StateInit(code: code, data: initialData());
  }

  @override
  Cell initialData() {
    final signersDict = Dictionary.fromEnteries<int, TonAddress>(
        key: DictionaryKey.uintCodec(8),
        value: DictionaryValue.addressCodec(),
        map: {for (int i = 0; i < signers.length; i++) i: signers[i]});
    final proposersDict = Dictionary.fromEnteries<int, TonAddress>(
        key: DictionaryKey.uintCodec(8),
        value: DictionaryValue.addressCodec(),
        map: {for (int i = 0; i < proposers.length; i++) i: proposers[i]});
    return beginCell()
        .storeUint256(0)
        .storeUint8(threshold)
        .storeRef(beginCell().storeDictDirect(signersDict).endCell())
        .storeUint8(signers.length)
        .storeDict(dict: proposersDict)
        .storeBitBolean(allowArbitrarySeqno)
        .endCell();
  }

  Map<String, dynamic> toJson() {
    return {
      'threshold': threshold,
      'signers': signers.map((e) => e.toFriendlyAddress()).toList(),
      'proposers': proposers.map((e) => e.toFriendlyAddress()).toList(),
      'nextOrderSeqno': nextOrderSeqno.toString(),
      'allowArbitrarySeqno': allowArbitrarySeqno,
      'signersNum': signersNum
    };
  }
}
