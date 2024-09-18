import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/ft/constants/constant/minter.dart';
import 'package:ton_dart/src/contracts/token/ft/constants/constant/wallet.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/contracts/utils/parser.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class JettonWalletOperationType extends ContractOperationType {
  const JettonWalletOperationType._(
      {required String name, required int operation})
      : super(name: name, operation: operation);
  static const JettonWalletOperationType transfer = JettonWalletOperationType._(
      name: "Transfer", operation: JettonWalletConst.transfer);
  static const JettonWalletOperationType burn = JettonWalletOperationType._(
      name: "Burn", operation: JettonWalletConst.burn);
  static const JettonWalletOperationType withdrawTon =
      JettonWalletOperationType._(
          name: "WithdrawTon", operation: JettonWalletConst.withdrawTon);
  static const JettonWalletOperationType withdrawJetton =
      JettonWalletOperationType._(
          name: "WithdrawJetton", operation: JettonWalletConst.withdrawJetton);

  static const List<JettonWalletOperationType> values = [
    transfer,
    burn,
    withdrawTon,
    withdrawJetton
  ];
  static JettonWalletOperationType fromTag(int? operation,
      {JettonWalletOperationType? excepted}) {
    final type = values.firstWhere((e) => e.operation == operation,
        orElse: () =>
            throw TonContractExceptionConst.invalidOperationId(tag: operation));
    if (excepted != null) {
      if (type != excepted) {
        throw TonContractExceptionConst.incorrectOperation(
            excepted: excepted.name, got: type.name);
      }
    }
    return type;
  }

  static JettonWalletOperationType fromName(String? name,
      {JettonWalletOperationType? excepted}) {
    final type = values.firstWhere((e) => e.name == name,
        orElse: () =>
            throw TonContractExceptionConst.invalidOperationId(tag: name));
    if (excepted != null) {
      if (type != excepted) {
        throw TonContractExceptionConst.incorrectOperation(
            excepted: excepted.name, got: type.name);
      }
    }
    return type;
  }
}

abstract class JettonWalletOperation extends TonSerialization
    implements ContractOperation {
  @override
  String get contractName => "Jetton Wallet";
  @override
  final JettonWalletOperationType type;
  final BigInt queryId;
  Cell toBody() => beginCell().store(this).endCell();

  @override
  Cell contractCode(TonChain chain) {
    return JettonWalletConst.code(chain.workchain);
  }

  JettonWalletOperation({required this.type, BigInt? queryId})
      : queryId = queryId ?? BigInt.zero;
  factory JettonWalletOperation.deserialize(Slice slice) {
    final type = JettonWalletOperationType.fromTag(slice.tryPreloadUint32());
    switch (type) {
      case JettonWalletOperationType.transfer:
        return JettonWalletTransfer.deserialize(slice);
      case JettonWalletOperationType.burn:
        return JettonWalletBurn.deserialize(slice);
      case JettonWalletOperationType.withdrawTon:
        return JettonWalletWithdrawTon.deserialize(slice);
      case JettonWalletOperationType.withdrawJetton:
        return JettonWalletWithdrawJetton.deserialize(slice);
      default:
        throw const TonContractException("unsuported jetton wallet operation.");
    }
  }
  factory JettonWalletOperation.fromJson(Map<String, dynamic>? json) {
    final type = JettonWalletOperationType.fromName(json?["type"]);
    switch (type) {
      case JettonWalletOperationType.transfer:
        return JettonWalletTransfer.fromJson(json!);
      case JettonWalletOperationType.burn:
        return JettonWalletBurn.fromJson(json!);
      case JettonWalletOperationType.withdrawTon:
        return JettonWalletWithdrawTon.fromJson(json!);
      case JettonWalletOperationType.withdrawJetton:
        return JettonWalletWithdrawJetton.fromJson(json!);
      default:
        throw const TonContractException("unsuported jetton wallet operation.");
    }
  }
  T cast<T extends JettonWalletOperation>() {
    if (this is! T) {
      throw TonContractException(
          "Incorrect Jetton wallet casting. excepted: $runtimeType got: $T");
    }
    return this as T;
  }
}

class JettonWalletTransfer extends JettonWalletOperation {
  final TonAddress destination;
  final TonAddress? responseDestination;
  final BigInt forwardTonAmount;
  final BigInt amount;
  final Cell? customPayload;
  final Cell? forwardPayload;
  JettonWalletTransfer(
      {required this.amount,
      required this.destination,
      required this.forwardTonAmount,
      this.responseDestination,
      BigInt? queryId,
      this.customPayload,
      this.forwardPayload})
      : super(type: JettonWalletOperationType.transfer, queryId: queryId);

  factory JettonWalletTransfer.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          JettonWalletOperationType.fromTag(slice.tryLoadUint32(),
              excepted: JettonWalletOperationType.transfer);
          return JettonWalletTransfer(
            queryId: slice.loadUint64(),
            amount: slice.loadCoins(),
            destination: slice.loadAddress(),
            responseDestination: slice.loadMaybeAddress(),
            customPayload: slice.loadMaybeRef(),
            forwardTonAmount: slice.loadCoins(),
            forwardPayload: slice.loadMaybeRef(),
          );
        },
        name: JettonWalletOperationType.transfer.name);
  }
  factory JettonWalletTransfer.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          JettonWalletOperationType.fromName(json["type"],
              excepted: JettonWalletOperationType.transfer);
          return JettonWalletTransfer(
              queryId: BigintUtils.tryParse(json["queryId"]),
              amount: BigintUtils.parse(json["amount"]),
              destination: TonAddress(json["destination"]),
              forwardTonAmount: BigintUtils.parse(json["forwardTonAmount"]),
              responseDestination: json["responseDestination"] == null
                  ? null
                  : TonAddress(json["responseDestination"]),
              customPayload: json["customPayload"] == null
                  ? null
                  : Cell.fromBase64(json["customPayload"]),
              forwardPayload: json["forwardPayload"] == null
                  ? null
                  : Cell.fromBase64(json["forwardPayload"]));
        },
        name: JettonWalletOperationType.transfer.name,
        data: json);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.storeCoins(amount);
    builder.storeAddress(destination);
    builder.storeAddress(responseDestination);
    builder.storeMaybeRef(cell: customPayload);
    builder.storeCoins(forwardTonAmount);
    builder.storeMaybeRef(cell: forwardPayload);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "queryId": queryId.toString(),
      "amount": amount.toString(),
      "destination": destination.toRawAddress(),
      "responseDestination": responseDestination?.toRawAddress(),
      "customPayload": customPayload?.toBase64(),
      "forwardTonAmount": forwardTonAmount.toString(),
      "forwardPayload": forwardPayload?.toBase64(),
      "type": type.name
    };
  }
}

class JettonWalletBurn extends JettonWalletOperation {
  final TonAddress? from;
  final BigInt burnAmount;
  final Cell? customPayload;
  JettonWalletBurn({
    BigInt? queryId,
    this.from,
    required this.burnAmount,
    this.customPayload,
  }) : super(type: JettonWalletOperationType.burn, queryId: queryId);

  factory JettonWalletBurn.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          JettonWalletOperationType.fromTag(slice.tryLoadUint32(),
              excepted: JettonWalletOperationType.burn);
          return JettonWalletBurn(
            queryId: slice.loadUint64(),
            burnAmount: slice.loadCoins(),
            from: slice.loadMaybeAddress(),
            customPayload: slice.loadMaybeRef(),
          );
        },
        name: JettonWalletOperationType.burn.name);
  }
  factory JettonWalletBurn.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          JettonWalletOperationType.fromName(json["type"],
              excepted: JettonWalletOperationType.burn);
          return JettonWalletBurn(
              queryId: BigintUtils.tryParse(json["queryId"]),
              burnAmount: BigintUtils.parse(json["burnAmount"]),
              from: json["from"] == null ? null : TonAddress(json["from"]),
              customPayload: json["customPayload"] == null
                  ? null
                  : Cell.fromBase64(json["customPayload"]));
        },
        name: JettonWalletOperationType.burn.name,
        data: json);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.storeCoins(burnAmount);
    builder.storeAddress(from);
    builder.storeMaybeRef(cell: customPayload);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "queryId": queryId.toString(),
      "burnAmount": burnAmount.toString(),
      "from": from?.toRawAddress(),
      "customPayload": customPayload?.toBase64(),
      "type": type.name
    };
  }
}

class JettonWalletWithdrawTon extends JettonWalletOperation {
  final Cell? customPayload;
  JettonWalletWithdrawTon({
    BigInt? queryId,
    this.customPayload,
  }) : super(type: JettonWalletOperationType.withdrawTon, queryId: queryId);

  factory JettonWalletWithdrawTon.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          JettonWalletOperationType.fromTag(slice.tryLoadUint32(),
              excepted: JettonWalletOperationType.withdrawTon);
          return JettonWalletWithdrawTon(
            queryId: slice.loadUint64(),
            customPayload: slice.loadMaybeRef(),
          );
        },
        name: JettonWalletOperationType.withdrawTon.name);
  }
  factory JettonWalletWithdrawTon.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          JettonWalletOperationType.fromName(json["type"],
              excepted: JettonWalletOperationType.withdrawTon);
          return JettonWalletWithdrawTon(
              queryId: BigintUtils.tryParse(json["queryId"]),
              customPayload: json["customPayload"] == null
                  ? null
                  : Cell.fromBase64(json["customPayload"]));
        },
        name: JettonWalletOperationType.withdrawTon.name,
        data: json);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.storeMaybeRef(cell: customPayload);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "queryId": queryId.toString(),
      "customPayload": customPayload?.toBase64(),
      "type": type.name
    };
  }
}

class JettonWalletWithdrawJetton extends JettonWalletOperation {
  final Cell? customPayload;
  final TonAddress from;
  final BigInt amount;
  JettonWalletWithdrawJetton({
    BigInt? queryId,
    required this.from,
    required this.amount,
    this.customPayload,
  }) : super(type: JettonWalletOperationType.withdrawJetton, queryId: queryId);

  factory JettonWalletWithdrawJetton.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          JettonWalletOperationType.fromTag(slice.tryLoadUint32(),
              excepted: JettonWalletOperationType.withdrawJetton);
          return JettonWalletWithdrawJetton(
              queryId: slice.loadUint64(),
              from: slice.loadAddress(),
              amount: slice.loadCoins(),
              customPayload: slice.tryLoadRef());
        },
        name: JettonWalletOperationType.withdrawJetton.name);
  }
  factory JettonWalletWithdrawJetton.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          JettonWalletOperationType.fromName(json["type"],
              excepted: JettonWalletOperationType.withdrawJetton);
          return JettonWalletWithdrawJetton(
              queryId: BigintUtils.tryParse(json["queryId"]),
              from: TonAddress(json["from"]),
              amount: BigintUtils.parse(json["amount"]),
              customPayload: json["customPayload"] == null
                  ? null
                  : Cell.fromBase64(json["customPayload"]));
        },
        name: JettonWalletOperationType.withdrawJetton.name,
        data: json);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.storeAddress(from);
    builder.storeCoins(amount);
    builder.storeMaybeRef(cell: customPayload);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "queryId": queryId.toString(),
      "from": from.toRawAddress(),
      "amount": amount.toString(),
      "customPayload": customPayload?.toBase64(),
      "type": type.name
    };
  }
}

class JettonMinterOperationType extends ContractOperationType {
  const JettonMinterOperationType._(
      {required String name, required int operation})
      : super(name: name, operation: operation);
  static const JettonMinterOperationType mint = JettonMinterOperationType._(
      name: "Mint", operation: JettonMinterConst.mintOperation);
  static const JettonMinterOperationType discovery =
      JettonMinterOperationType._(
          name: "Discovery",
          operation: JettonMinterConst.discoverMessageOperation);
  static const JettonMinterOperationType changeAdmin =
      JettonMinterOperationType._(
          name: "ChangeAdmin",
          operation: JettonMinterConst.changeAdminOperation);
  static const JettonMinterOperationType changeContent =
      JettonMinterOperationType._(
          name: "ChangeContent",
          operation: JettonMinterConst.changeContentOperation);
  static const JettonMinterOperationType internalTransfer =
      JettonMinterOperationType._(
          name: "InternalTransfer",
          operation: JettonMinterConst.internalTransferOperation);
  static List<JettonMinterOperationType> values = [
    discovery,
    changeAdmin,
    changeContent,
    internalTransfer,
    mint
  ];
  static JettonMinterOperationType fromTag(int? operation,
      {JettonMinterOperationType? excepted}) {
    final type = values.firstWhere((e) => e.operation == operation,
        orElse: () =>
            throw TonContractExceptionConst.invalidOperationId(tag: operation));
    if (excepted != null) {
      if (type != excepted) {
        throw TonContractExceptionConst.incorrectOperation(
            excepted: excepted.name, got: type.name);
      }
    }
    return type;
  }

  static JettonMinterOperationType fromName(String? name,
      {JettonMinterOperationType? excepted}) {
    final type = values.firstWhere((e) => e.name == name,
        orElse: () =>
            throw TonContractExceptionConst.invalidOperationId(tag: name));
    if (excepted != null) {
      if (type != excepted) {
        throw TonContractExceptionConst.incorrectOperation(
            excepted: excepted.name, got: type.name);
      }
    }
    return type;
  }

  @override
  String toString() {
    return "JettonMinterOperationType.$name";
  }
}

abstract class JettonMinterOperation extends TonSerialization
    implements ContractOperation {
  @override
  final JettonMinterOperationType type;
  @override
  String get contractName => "Jetton Minter";
  final BigInt queryId;
  @override
  Cell contractCode(TonChain chain) {
    return JettonMinterConst.code(chain.workchain);
  }

  JettonMinterOperation({required this.type, BigInt? queryId})
      : queryId = queryId ?? BigInt.zero;
  Cell toBody() => beginCell().store(this).endCell();
  factory JettonMinterOperation.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          final type =
              JettonMinterOperationType.fromTag(slice.tryPreloadUint32());
          switch (type) {
            case JettonMinterOperationType.mint:
              return JettonMinterMint.deserialize(slice);
            case JettonMinterOperationType.changeAdmin:
              return JettonMinterChangeAdmin.deserialize(slice);
            case JettonMinterOperationType.changeContent:
              return JettonMinterChangeContent.deserialize(slice);
            case JettonMinterOperationType.discovery:
              return JettonMinterDiscovery.deserialize(slice);
            case JettonMinterOperationType.internalTransfer:
              return JettonMinterInternalTransfer.deserialize(slice);

            default:
              throw TonContractException("Invalid Minter operation type.",
                  details: {"type": type.name});
          }
        },
        name: "Minter");
  }
  factory JettonMinterOperation.fromJson(Map<String, dynamic>? json) {
    return TonModelParser.parseJson(
        parse: () {
          final type = JettonMinterOperationType.fromName(json?["type"]);
          switch (type) {
            case JettonMinterOperationType.mint:
              return JettonMinterMint.fromJson(json!);
            case JettonMinterOperationType.changeAdmin:
              return JettonMinterChangeAdmin.fromJson(json!);
            case JettonMinterOperationType.changeContent:
              return JettonMinterChangeContent.fromJson(json!);
            case JettonMinterOperationType.discovery:
              return JettonMinterDiscovery.fromJson(json!);
            case JettonMinterOperationType.internalTransfer:
              return JettonMinterInternalTransfer.fromJson(json!);
            default:
              throw TonContractException("Invalid Minter operation type.",
                  details: {"type": type.name});
          }
        },
        name: "Minter");
  }
  T cast<T extends JettonMinterOperation>() {
    if (this is! T) {
      throw TonContractException("Incorrect JettonMinterOperation casting.",
          details: {"excepted": "$runtimeType", "got": "$T"});
    }
    return this as T;
  }
}

class JettonMinterMint extends JettonMinterOperation {
  final BigInt totalTonAmount;
  final BigInt jettonAmount;
  final TonAddress to;
  final JettonMinterInternalTransfer transfer;

  JettonMinterMint({
    required this.totalTonAmount,
    required this.to,
    required this.transfer,
    required this.jettonAmount,
    BigInt? queryId,
  }) : super(type: JettonMinterOperationType.mint, queryId: queryId);
  factory JettonMinterMint.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return JettonMinterMint(
              queryId: BigintUtils.parse(json["queryId"]),
              totalTonAmount: BigintUtils.parse(json["totalTonAmount"]),
              to: TonAddress(json["to"]),
              jettonAmount: BigintUtils.parse(json["jettonAmount"]),
              transfer:
                  JettonMinterInternalTransfer.fromJson(json["transfer"]));
        },
        name: JettonMinterOperationType.mint.name);
  }
  factory JettonMinterMint.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          JettonMinterOperationType.fromTag(slice.tryLoadUint32(),
              excepted: JettonMinterOperationType.mint);
          return JettonMinterMint(
            queryId: slice.loadUint64(),
            to: slice.loadAddress(),
            totalTonAmount: slice.loadCoins(),
            jettonAmount: slice.loadCoins(),
            transfer: JettonMinterInternalTransfer.deserialize(
                slice.loadRef().beginParse()),
          );
        },
        name: JettonMinterOperationType.mint.name);
  }
  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.storeAddress(to);
    builder.storeCoins(totalTonAmount);
    builder.storeCoins(jettonAmount);
    builder.storeRef(transfer.toBody());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "queryId": queryId.toString(),
      "to": to.toRawAddress(),
      "totalTonAmount": totalTonAmount.toString(),
      "jettonAmount": jettonAmount.toString(),
      "transfer": transfer.toJson(),
    };
  }
}

class JettonMinterInternalTransfer extends JettonMinterOperation {
  final BigInt jettonAmount;
  final TonAddress? from;
  final TonAddress? responseAddress;
  final Cell? customPayload;
  final BigInt forwardTonAmount;

  JettonMinterInternalTransfer({
    required this.jettonAmount,
    this.from,
    this.responseAddress,
    this.customPayload,
    required this.forwardTonAmount,
    BigInt? queryId,
  }) : super(
            type: JettonMinterOperationType.internalTransfer, queryId: queryId);
  factory JettonMinterInternalTransfer.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return JettonMinterInternalTransfer(
              queryId: BigintUtils.parse(json["queryId"]),
              forwardTonAmount: BigintUtils.parse(json["forwardTonAmount"]),
              jettonAmount: BigintUtils.parse(json["jettonAmount"]),
              customPayload: json["customPayload"] == null
                  ? null
                  : Cell.fromBase64(json["customPayload"]),
              from: json["from"] == null ? null : TonAddress(json["from"]),
              responseAddress: json["responseAddress"] == null
                  ? null
                  : TonAddress(json["responseAddress"]));
        },
        name: JettonMinterOperationType.internalTransfer.name);
  }
  factory JettonMinterInternalTransfer.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          JettonMinterOperationType.fromTag(slice.tryLoadUint32(),
              excepted: JettonMinterOperationType.internalTransfer);
          return JettonMinterInternalTransfer(
            queryId: slice.loadUint64(),
            jettonAmount: slice.loadCoins(),
            from: slice.loadMaybeAddress(),
            responseAddress: slice.loadMaybeAddress(),
            forwardTonAmount: slice.loadCoins(),
            customPayload: slice.loadMaybeRef(),
          );
        },
        name: JettonMinterOperationType.internalTransfer.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.storeCoins(jettonAmount);
    builder.storeAddress(from);
    builder.storeAddress(responseAddress);
    builder.storeCoins(forwardTonAmount);
    builder.storeMaybeRef(cell: customPayload);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "queryId": queryId.toString(),
      "jettonAmount": jettonAmount.toString(),
      "responseAddress": responseAddress?.toRawAddress(),
      "customPayload": customPayload?.toBase64(),
      "forwardTonAmount": forwardTonAmount.toString(),
    };
  }
}

class JettonMinterDiscovery extends JettonMinterOperation {
  final TonAddress owner;
  final bool includeAddress;
  JettonMinterDiscovery(
      {required this.owner, required this.includeAddress, BigInt? queryId})
      : super(type: JettonMinterOperationType.discovery, queryId: queryId);
  factory JettonMinterDiscovery.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return JettonMinterDiscovery(
              owner: TonAddress(json["owner"]),
              includeAddress: json["includeAddress"],
              queryId: BigintUtils.parse(json["queryId"]));
        },
        name: JettonMinterOperationType.discovery.name);
  }
  factory JettonMinterDiscovery.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          JettonMinterOperationType.fromTag(slice.tryLoadUint32(),
              excepted: JettonMinterOperationType.discovery);
          return JettonMinterDiscovery(
              queryId: slice.loadUint64(),
              owner: slice.loadAddress(),
              includeAddress: slice.loadBoolean());
        },
        name: JettonMinterOperationType.discovery.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.storeAddress(owner);
    builder.storeBitBolean(includeAddress);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "owner": owner.toRawAddress(),
      "includeAddress": includeAddress,
      "queryId": queryId.toString()
    };
  }
}

class JettonMinterChangeAdmin extends JettonMinterOperation {
  final TonAddress newOwner;
  JettonMinterChangeAdmin({required this.newOwner, BigInt? queryId})
      : super(type: JettonMinterOperationType.changeAdmin, queryId: queryId);
  factory JettonMinterChangeAdmin.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return JettonMinterChangeAdmin(
              newOwner: TonAddress(json["newOwner"]),
              queryId: BigintUtils.parse(json["queryId"]));
        },
        name: JettonMinterOperationType.changeAdmin.name);
  }
  factory JettonMinterChangeAdmin.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          JettonMinterOperationType.fromTag(slice.tryLoadUint32(),
              excepted: JettonMinterOperationType.changeAdmin);
          return JettonMinterChangeAdmin(
              queryId: slice.loadUint64(), newOwner: slice.loadAddress());
        },
        name: JettonMinterOperationType.changeAdmin.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.storeAddress(newOwner);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "newOwner": newOwner.toRawAddress(),
      "queryId": queryId.toString()
    };
  }
}

class JettonMinterChangeContent extends JettonMinterOperation {
  final Cell content;
  JettonMinterChangeContent({required this.content, BigInt? queryId})
      : super(type: JettonMinterOperationType.changeContent, queryId: queryId);
  factory JettonMinterChangeContent.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return JettonMinterChangeContent(
              content: Cell.fromBase64(json["content"]),
              queryId: BigintUtils.parse(json["queryId"]));
        },
        name: JettonMinterOperationType.changeContent.name);
  }
  factory JettonMinterChangeContent.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          JettonMinterOperationType.fromTag(slice.tryLoadUint32(),
              excepted: JettonMinterOperationType.changeContent);
          return JettonMinterChangeContent(
              queryId: slice.loadUint64(), content: slice.loadRef());
        },
        name: JettonMinterOperationType.changeContent.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.storeRef(content);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "content": content.toBase64(),
      "queryId": queryId.toString()
    };
  }

  TokenMetadata get contentMetaData {
    return TokneMetadataUtils.loadContent(content);
  }
}
