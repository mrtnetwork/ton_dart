import 'package:blockchain_utils/utils/numbers/utils/bigint_utils.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/ft/constants/constant/wallet.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/tuple/tuple/tuple_reader.dart';

class StableTokenWalletStatus {
  final int id;
  final String name;
  const StableTokenWalletStatus._({required this.id, required this.name});
  static const StableTokenWalletStatus statusUnlock =
      StableTokenWalletStatus._(id: 0, name: 'Unlock');
  static const StableTokenWalletStatus statusOut =
      StableTokenWalletStatus._(id: 1, name: 'Out');
  static const StableTokenWalletStatus statusIn =
      StableTokenWalletStatus._(id: 2, name: 'In');
  static const StableTokenWalletStatus statusFull =
      StableTokenWalletStatus._(id: 3, name: 'Full');

  static const List<StableTokenWalletStatus> values = [
    statusUnlock,
    statusOut,
    statusIn,
    statusFull
  ];
  static StableTokenWalletStatus fromTag(int? tag) {
    return values.firstWhere(
      (e) => e.id == tag,
      orElse: () => throw TonContractException(
          'Invalid stable token wallet status.',
          details: {
            'tag': tag,
            'availableTags': values.map((e) => e.id).join(', ')
          }),
    );
  }

  static StableTokenWalletStatus fromName(String? name) {
    return values.firstWhere(
      (e) => e.name == name,
      orElse: () => throw TonContractException(
          'Invalid stable token wallet status.',
          details: {
            'name': name,
            'availableName': values.map((e) => e.name).join(', ')
          }),
    );
  }

  @override
  String toString() {
    return 'StableTokenWalletStatus.$name';
  }
}

class StableJettonWalletState extends ContractState {
  final StableTokenWalletStatus? status;
  final BigInt balance;
  final TonAddress ownerAddress;
  final TonAddress jettonMasterAddress;
  final Cell? walletCode;
  const StableJettonWalletState(
      {required this.balance,
      required this.ownerAddress,
      required this.jettonMasterAddress,
      this.status,
      this.walletCode});
  Map<String, dynamic> toJson() {
    return {
      'status': status?.name,
      'balance': balance.toString(),
      'ownerAddress': ownerAddress.toRawAddress(),
      'jettonMasterAddress': jettonMasterAddress.toRawAddress(),
      'walletCode': walletCode?.toBase64()
    };
  }

  factory StableJettonWalletState.fromJson(Map<String, dynamic> json) {
    return StableJettonWalletState(
        balance: BigintUtils.parse(json['balance']),
        ownerAddress: TonAddress(json['ownerAddress']),
        jettonMasterAddress: TonAddress(json['jettonMasterAddress']),
        walletCode: json['walletCode'] == null
            ? null
            : Cell.fromBase64(json['walletCode']),
        status: json['status'] == null
            ? null
            : StableTokenWalletStatus.fromName(json['status']));
  }

  factory StableJettonWalletState.fromTuple(TupleReader reader) {
    final balance = reader.readBigNumber();
    return StableJettonWalletState(
        balance: balance,
        ownerAddress: reader.readAddress(),
        jettonMasterAddress: reader.readAddress(),
        walletCode: reader.readCell());
  }
  factory StableJettonWalletState.deserialize(Slice slice) {
    return StableJettonWalletState(
        status: StableTokenWalletStatus.fromTag(slice.loadUint4()),
        balance: slice.loadCoins(),
        ownerAddress: slice.loadAddress(),
        jettonMasterAddress: slice.loadAddress());
  }

  @override
  StateInit initialState() {
    final Cell code =
        walletCode ?? JettonWalletConst.stableCode(ownerAddress.workChain);
    return StateInit(data: initialData(), code: code);
  }

  @override
  Cell initialData() {
    final Cell code =
        walletCode ?? JettonWalletConst.stableCode(ownerAddress.workChain);
    return beginCell()
        .storeUint4(0)
        .storeCoins(BigInt.zero)
        .storeAddress(ownerAddress)
        .storeAddress(jettonMasterAddress)
        .storeRef(code)
        .endCell();
  }
}
