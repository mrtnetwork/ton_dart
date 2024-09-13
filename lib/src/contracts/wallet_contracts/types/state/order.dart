import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/dict/dictionary.dart';
import 'package:ton_dart/src/models/models/state_init.dart';

class OrderContractState extends ContractState {
  final TonAddress multisig;
  final BigInt orderSeqno;
  final int? threshold;
  final bool? executed;
  final List<TonAddress> signers;
  final BigInt? approvals;
  final int? approvalsNum;
  final BigInt? expirationDate;
  final Cell? order;

  factory OrderContractState.deserialize(Slice slice) {
    final multisig = slice.loadAddress();
    final BigInt orderSeqno = slice.loadUint256();
    final threshold = slice.loadUint8();
    final executed = slice.loadBoolean();
    final signers = Dictionary.loadDirect<int, TonAddress>(
            key: DictionaryKey.uintCodec(8),
            value: DictionaryValue.addressCodec(),
            slice: slice.loadRef().beginParse())
        .asMap
        .values
        .toList();
    final BigInt approvalsMask = slice.loadUint256();
    final int approvalsNum = slice.loadUint8();
    final BigInt expirationDate = slice.loadUintBig(48);
    final order = slice.loadRef();
    return OrderContractState(
        multisig: multisig,
        orderSeqno: orderSeqno,
        threshold: threshold,
        executed: executed,
        signers: signers,
        approvals: approvalsMask,
        approvalsNum: approvalsNum,
        expirationDate: expirationDate,
        order: order);
  }

  OrderContractState({
    required this.multisig,
    required this.orderSeqno,
    this.threshold,
    this.executed,
    List<TonAddress> signers = const [],
    this.approvals,
    this.approvalsNum,
    this.expirationDate,
    this.order,
  }) : signers = List<TonAddress>.unmodifiable(signers);

  @override
  StateInit initialState() {
    return StateInit(
        code: Cell.fromHex(MultiOwnerContractConst.orderHashCode),
        data: initialData());
  }

  @override
  Cell initialData() {
    return beginCell()
        .storeAddress(multisig)
        .storeUint256(orderSeqno)
        .endCell();
  }

  Map<String, dynamic> toJson() {
    return {
      "multisig": multisig.toFriendlyAddress(),
      "orderSeqno": orderSeqno.toString(),
      "threshold": threshold,
      "executed": executed,
      "signers": signers.map((e) => e.toFriendlyAddress()).toList(),
      "approvals": approvals,
      "approvalsNum": approvalsNum,
      "expirationDate": expirationDate,
      "order": order?.toBase64()
    };
  }
}
