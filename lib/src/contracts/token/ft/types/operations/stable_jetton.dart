import 'package:blockchain_utils/utils/numbers/utils/bigint_utils.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/utils/parser.dart';
import 'package:ton_dart/ton_dart.dart';

class StableJettonMinterOperationType {
  final int id;
  final String name;
  const StableJettonMinterOperationType._(
      {required this.id, required this.name});
  static const StableJettonMinterOperationType discovery =
      StableJettonMinterOperationType._(id: 0x2c76b973, name: "Discovery");
  static const StableJettonMinterOperationType topUp =
      StableJettonMinterOperationType._(id: 0xd372158c, name: "TopUp");
  static const StableJettonMinterOperationType changeAdmin =
      StableJettonMinterOperationType._(id: 0x6501f354, name: "ChangeAdmin");
  static const StableJettonMinterOperationType claimAdmin =
      StableJettonMinterOperationType._(id: 0xfb88e119, name: "ClaimAdmin");
  static const StableJettonMinterOperationType changeContent =
      StableJettonMinterOperationType._(id: 0xcb862902, name: "ChangeContent");
  static const StableJettonMinterOperationType callTo =
      StableJettonMinterOperationType._(id: 0x235caf52, name: "CallTo");
  static const StableJettonMinterOperationType mint =
      StableJettonMinterOperationType._(id: 0x642b7d07, name: "Mint");
  static const StableJettonMinterOperationType internalTransfer =
      StableJettonMinterOperationType._(
          id: 0x178d4519, name: "InternalTransfer");

  static const List<StableJettonMinterOperationType> values = [
    mint,
    discovery,
    topUp,
    changeAdmin,
    claimAdmin,
    changeContent,
    callTo,
    internalTransfer
  ];
  static StableJettonMinterOperationType fromTag(int? tag,
      {StableJettonMinterOperationType? excepted}) {
    final type = values.firstWhere((e) => e.id == tag,
        orElse: () =>
            throw TonContractExceptionConst.invalidOperationId(tag: tag));
    if (excepted != null) {
      if (type != excepted) {
        throw TonContractExceptionConst.incorrectOperation(
            excepted: excepted.name, got: type.name);
      }
    }
    return type;
  }

  static StableJettonMinterOperationType fromName(String? name,
      {StableJettonMinterOperationType? excepted}) {
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

class StableJettonWalletOperationType {
  final int id;
  final String name;
  const StableJettonWalletOperationType._(
      {required this.id, required this.name});
  static const StableJettonWalletOperationType setStatus =
      StableJettonWalletOperationType._(id: 0xeed236d3, name: "SetStatus");
  static const StableJettonWalletOperationType transfer =
      StableJettonWalletOperationType._(id: 0xf8a7ea5, name: "Transfer");
  static const StableJettonWalletOperationType burn =
      StableJettonWalletOperationType._(id: 0x595f07bc, name: "Burn");
  static const StableJettonWalletOperationType withdrawTon =
      StableJettonWalletOperationType._(id: 0x6d8e5e3c, name: "WithdrawTon");
  static const StableJettonWalletOperationType withdrawJetton =
      StableJettonWalletOperationType._(id: 0x768a50b2, name: "WithdrawJetton");

  ///
  static const List<StableJettonWalletOperationType> values = [
    setStatus,
    transfer,
    burn,
    withdrawTon,
    withdrawJetton
  ];
  static StableJettonWalletOperationType fromTag(int? tag,
      {StableJettonWalletOperationType? excepted}) {
    final type = values.firstWhere((e) => e.id == tag,
        orElse: () =>
            throw TonContractExceptionConst.invalidOperationId(tag: tag));
    if (excepted != null) {
      if (type != excepted) {
        throw TonContractExceptionConst.incorrectOperation(
            excepted: excepted.name, got: type.name);
      }
    }
    return type;
  }

  static StableJettonWalletOperationType fromName(String? name,
      {StableJettonWalletOperationType? excepted}) {
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

abstract class StableJettonMinterCallToOperations extends TonSerialization {
  abstract final StableJettonWalletOperationType type;
  Cell toBody() => beginCell().store(this).endCell();
  T cast<T extends StableJettonWalletOperation>() {
    if (this is! T) {
      throw TonContractException(
          "Incorrect stable jetton minter casting. excepted: $runtimeType got: $T");
    }
    return this as T;
  }

  factory StableJettonMinterCallToOperations.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          final type =
              StableJettonWalletOperationType.fromTag(slice.tryPreloadUint32());
          switch (type) {
            case StableJettonWalletOperationType.transfer:
              return StableJettonWalletTransfer.deserialize(slice);
            case StableJettonWalletOperationType.burn:
              return StableJettonWalletBurn.deserialize(slice);
            case StableJettonWalletOperationType.setStatus:
              return StableJettonWalletSetStatus.deserialize(slice);
            default:
              throw TonContractException("Invalid call to operation type.",
                  details: {"type": type.name});
          }
        },
        name: "CallTo");
  }
  factory StableJettonMinterCallToOperations.fromJson(
      Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          final type = StableJettonWalletOperationType.fromName(json["type"]);
          switch (type) {
            case StableJettonWalletOperationType.transfer:
              return StableJettonWalletTransfer.fromJson(json);
            case StableJettonWalletOperationType.burn:
              return StableJettonWalletBurn.fromJson(json);
            case StableJettonWalletOperationType.setStatus:
              return StableJettonWalletSetStatus.fromJson(json);
            default:
              throw TonContractException("Invalid call to operation type.",
                  details: {"type": type.name});
          }
        },
        name: "CallTo");
  }
}

abstract class StableJettonMinterOperation extends TonSerialization {
  final StableJettonMinterOperationType type;
  final BigInt queryId;
  StableJettonMinterOperation({required this.type, BigInt? queryId})
      : queryId = queryId ?? BigInt.zero;
  Cell toBody() => beginCell().store(this).endCell();
  factory StableJettonMinterOperation.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          final type =
              StableJettonMinterOperationType.fromTag(slice.tryPreloadUint32());
          switch (type) {
            case StableJettonMinterOperationType.topUp:
              return StableJettonMinterTopUp.deserialize(slice);
            case StableJettonMinterOperationType.mint:
              return StableJettonMinterMint.deserialize(slice);
            case StableJettonMinterOperationType.changeAdmin:
              return StableJettonMinterChangeAdmin.deserialize(slice);
            case StableJettonMinterOperationType.changeContent:
              return StableJettonMinterChangeContent.deserialize(slice);
            case StableJettonMinterOperationType.discovery:
              return StableJettonMinterDiscovery.deserialize(slice);
            case StableJettonMinterOperationType.internalTransfer:
              return StableJettonMinterInternalTransfer.deserialize(slice);
            case StableJettonMinterOperationType.claimAdmin:
              return StableJettonMinterClaimAdmin.deserialize(slice);
            case StableJettonMinterOperationType.callTo:
              return StableJettonMinterCallTo.deserialize(slice);
            default:
              throw TonContractException("Invalid Minter operation type.",
                  details: {"type": type.name});
          }
        },
        name: "Minter");
  }
  factory StableJettonMinterOperation.fromJson(Map<String, dynamic>? json) {
    return TonModelParser.parseJson(
        parse: () {
          final type = StableJettonMinterOperationType.fromName(json?["type"]);
          switch (type) {
            case StableJettonMinterOperationType.topUp:
              return StableJettonMinterTopUp.fromJson(json!);
            case StableJettonMinterOperationType.mint:
              return StableJettonMinterMint.fromJson(json!);
            case StableJettonMinterOperationType.changeAdmin:
              return StableJettonMinterChangeAdmin.fromJson(json!);
            case StableJettonMinterOperationType.changeContent:
              return StableJettonMinterChangeContent.fromJson(json!);
            case StableJettonMinterOperationType.discovery:
              return StableJettonMinterDiscovery.fromJson(json!);
            case StableJettonMinterOperationType.internalTransfer:
              return StableJettonMinterInternalTransfer.fromJson(json!);
            case StableJettonMinterOperationType.claimAdmin:
              return StableJettonMinterClaimAdmin.fromJson(json!);
            case StableJettonMinterOperationType.callTo:
              return StableJettonMinterCallTo.fromJson(json!);
            default:
              throw TonContractException("Invalid Minter operation type.",
                  details: {"type": type.name});
          }
        },
        name: "Minter");
  }

  T cast<T extends StableJettonMinterOperation>() {
    if (this is! T) {
      throw TonContractException(
          "Incorrect stable jetton minter casting. excepted: $runtimeType got: $T");
    }
    return this as T;
  }
}

class StableJettonMinterMint extends StableJettonMinterOperation {
  final BigInt totalTonAmount;
  final TonAddress to;
  final StableJettonMinterInternalTransfer transfer;

  StableJettonMinterMint({
    required this.totalTonAmount,
    required this.to,
    required this.transfer,
    BigInt? queryId,
  }) : super(type: StableJettonMinterOperationType.mint, queryId: queryId);
  factory StableJettonMinterMint.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return StableJettonMinterMint(
              queryId: BigintUtils.parse(json["queryId"]),
              totalTonAmount: BigintUtils.parse(json["totalTonAmount"]),
              to: TonAddress(json["to"]),
              transfer: StableJettonMinterInternalTransfer.fromJson(
                  json["transfer"]));
        },
        name: StableJettonMinterOperationType.mint.name);
  }
  factory StableJettonMinterMint.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          StableJettonMinterOperationType.fromTag(slice.tryLoadUint32(),
              excepted: StableJettonMinterOperationType.mint);
          return StableJettonMinterMint(
              queryId: slice.loadUint64(),
              to: slice.loadAddress(),
              totalTonAmount: slice.loadCoins(),
              transfer: StableJettonMinterInternalTransfer.deserialize(
                  slice.loadRef().beginParse()));
        },
        name: StableJettonMinterOperationType.mint.name);
  }
  @override
  void store(Builder builder) {
    builder.storeUint32(type.id);
    builder.storeUint64(queryId);
    builder.storeAddress(to);
    builder.storeCoins(totalTonAmount);
    builder.storeRef(transfer.toBody());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "queryId": queryId.toString(),
      "to": to.toRawAddress(),
      "totalTonAmount": totalTonAmount.toString(),
      "transfer": transfer.toJson()
    };
  }
}

class StableJettonMinterInternalTransfer extends StableJettonMinterOperation {
  final BigInt jettonAmount;
  final TonAddress? from;
  final TonAddress? responseAddress;
  final Cell? customPayload;
  final BigInt forwardTonAmount;

  StableJettonMinterInternalTransfer({
    required this.jettonAmount,
    this.from,
    this.responseAddress,
    this.customPayload,
    required this.forwardTonAmount,
    BigInt? queryId,
  }) : super(
            type: StableJettonMinterOperationType.internalTransfer,
            queryId: queryId);
  factory StableJettonMinterInternalTransfer.fromJson(
      Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return StableJettonMinterInternalTransfer(
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
        name: StableJettonMinterOperationType.internalTransfer.name);
  }
  factory StableJettonMinterInternalTransfer.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          StableJettonMinterOperationType.fromTag(slice.tryLoadUint32(),
              excepted: StableJettonMinterOperationType.internalTransfer);
          return StableJettonMinterInternalTransfer(
            queryId: slice.loadUint64(),
            jettonAmount: slice.loadCoins(),
            from: slice.loadMaybeAddress(),
            responseAddress: slice.loadMaybeAddress(),
            forwardTonAmount: slice.loadCoins(),
            customPayload: slice.loadMaybeRef(),
          );
        },
        name: StableJettonMinterOperationType.internalTransfer.name);
  }
  @override
  void store(Builder builder) {
    builder.storeUint32(type.id);
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

class StableJettonMinterDiscovery extends StableJettonMinterOperation {
  final TonAddress owner;
  final bool includeAddress;
  StableJettonMinterDiscovery(
      {required this.owner, required this.includeAddress, BigInt? queryId})
      : super(
            type: StableJettonMinterOperationType.discovery, queryId: queryId);
  factory StableJettonMinterDiscovery.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return StableJettonMinterDiscovery(
              owner: TonAddress(json["owner"]),
              includeAddress: json["includeAddress"],
              queryId: BigintUtils.parse(json["queryId"]));
        },
        name: StableJettonMinterOperationType.discovery.name);
  }
  factory StableJettonMinterDiscovery.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          StableJettonMinterOperationType.fromTag(slice.tryLoadUint32(),
              excepted: StableJettonMinterOperationType.discovery);
          return StableJettonMinterDiscovery(
              queryId: slice.loadUint64(),
              owner: slice.loadAddress(),
              includeAddress: slice.loadBoolean());
        },
        name: StableJettonMinterOperationType.discovery.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.id);
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

class StableJettonMinterTopUp extends StableJettonMinterOperation {
  StableJettonMinterTopUp({BigInt? queryId})
      : super(type: StableJettonMinterOperationType.topUp, queryId: queryId);
  factory StableJettonMinterTopUp.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return StableJettonMinterTopUp(
              queryId: BigintUtils.parse(json["queryId"]));
        },
        name: StableJettonMinterOperationType.topUp.name);
  }
  factory StableJettonMinterTopUp.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          StableJettonMinterOperationType.fromTag(slice.tryLoadUint32(),
              excepted: StableJettonMinterOperationType.topUp);
          return StableJettonMinterTopUp(queryId: slice.loadUint64());
        },
        name: StableJettonMinterOperationType.topUp.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.id);
    builder.storeUint64(queryId);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "queryId": queryId.toString()};
  }
}

class StableJettonMinterChangeAdmin extends StableJettonMinterOperation {
  final TonAddress newOwner;
  StableJettonMinterChangeAdmin({required this.newOwner, BigInt? queryId})
      : super(
            type: StableJettonMinterOperationType.changeAdmin,
            queryId: queryId);
  factory StableJettonMinterChangeAdmin.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return StableJettonMinterChangeAdmin(
              newOwner: TonAddress(json["newOwner"]),
              queryId: BigintUtils.parse(json["queryId"]));
        },
        name: StableJettonMinterOperationType.changeAdmin.name);
  }
  factory StableJettonMinterChangeAdmin.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          StableJettonMinterOperationType.fromTag(slice.tryLoadUint32(),
              excepted: StableJettonMinterOperationType.changeAdmin);
          return StableJettonMinterChangeAdmin(
              queryId: slice.loadUint64(), newOwner: slice.loadAddress());
        },
        name: StableJettonMinterOperationType.changeAdmin.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.id);
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

class StableJettonMinterClaimAdmin extends StableJettonMinterOperation {
  StableJettonMinterClaimAdmin({BigInt? queryId})
      : super(
            type: StableJettonMinterOperationType.claimAdmin, queryId: queryId);
  factory StableJettonMinterClaimAdmin.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return StableJettonMinterClaimAdmin(
              queryId: BigintUtils.parse(json["queryId"]));
        },
        name: StableJettonMinterOperationType.claimAdmin.name);
  }
  factory StableJettonMinterClaimAdmin.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          StableJettonMinterOperationType.fromTag(slice.tryLoadUint32(),
              excepted: StableJettonMinterOperationType.claimAdmin);
          return StableJettonMinterClaimAdmin(queryId: slice.loadUint64());
        },
        name: StableJettonMinterOperationType.claimAdmin.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.id);
    builder.storeUint64(queryId);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "queryId": queryId.toString()};
  }
}

class StableJettonMinterChangeContent extends StableJettonMinterOperation {
  final String url;
  StableJettonMinterChangeContent({required this.url, BigInt? queryId})
      : super(
            type: StableJettonMinterOperationType.changeContent,
            queryId: queryId);
  factory StableJettonMinterChangeContent.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return StableJettonMinterChangeContent(
              url: json["url"], queryId: BigintUtils.parse(json["queryId"]));
        },
        name: StableJettonMinterOperationType.changeContent.name);
  }
  factory StableJettonMinterChangeContent.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          StableJettonMinterOperationType.fromTag(slice.tryLoadUint32(),
              excepted: StableJettonMinterOperationType.changeContent);
          return StableJettonMinterChangeContent(
              queryId: slice.loadUint64(), url: slice.loadStringTail());
        },
        name: StableJettonMinterOperationType.changeContent.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.id);
    builder.storeUint64(queryId);
    builder.storeStringTail(url);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name, "url": url, "queryId": queryId.toString()};
  }
}

class StableJettonMinterCallTo extends StableJettonMinterOperation {
  final TonAddress address;
  final BigInt amount;
  final StableJettonMinterCallToOperations operation;

  StableJettonMinterCallTo(
      {required this.address,
      required this.amount,
      required this.operation,
      BigInt? queryId})
      : super(type: StableJettonMinterOperationType.callTo, queryId: queryId);
  factory StableJettonMinterCallTo.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return StableJettonMinterCallTo(
            address: TonAddress(json["address"]),
            amount: BigintUtils.parse(json["amount"]),
            queryId: BigintUtils.parse(json["queryId"]),
            operation:
                StableJettonMinterCallToOperations.fromJson(json["operation"]),
          );
        },
        name: StableJettonMinterOperationType.callTo.name);
  }
  factory StableJettonMinterCallTo.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          StableJettonMinterOperationType.fromTag(slice.tryLoadUint32(),
              excepted: StableJettonMinterOperationType.callTo);
          return StableJettonMinterCallTo(
              queryId: slice.loadUint64(),
              address: slice.loadAddress(),
              amount: slice.loadCoins(),
              operation: StableJettonMinterCallToOperations.deserialize(
                  slice.loadRef().beginParse()));
        },
        name: StableJettonMinterOperationType.callTo.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.id);
    builder.storeUint64(queryId);
    builder.storeAddress(address);
    builder.storeCoins(amount);
    builder.storeRef(operation.toBody());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "address": address.toRawAddress(),
      "amount": amount.toString(),
      "queryId": queryId.toString(),
      "operation": operation.toJson()
    };
  }
}

abstract class StableJettonWalletOperation extends TonSerialization {
  final StableJettonWalletOperationType type;
  final BigInt queryId;
  Cell toBody() => beginCell().store(this).endCell();

  T cast<T extends StableJettonWalletOperation>() {
    if (this is! T) {
      throw TonContractException(
          "Incorrect stable jetton wallet casting. excepted: $runtimeType got: $T");
    }
    return this as T;
  }

  StableJettonWalletOperation({required this.type, BigInt? queryId})
      : queryId = queryId ?? BigInt.zero;

  factory StableJettonWalletOperation.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          final type =
              StableJettonWalletOperationType.fromTag(slice.tryPreloadUint32());
          switch (type) {
            case StableJettonWalletOperationType.transfer:
              return StableJettonWalletTransfer.deserialize(slice);
            case StableJettonWalletOperationType.burn:
              return StableJettonWalletBurn.deserialize(slice);
            case StableJettonWalletOperationType.setStatus:
              return StableJettonWalletSetStatus.deserialize(slice);
            default:
              throw TonContractException("Invalid Token Wallet operation type.",
                  details: {"type": type.name});
          }
        },
        name: "Token Wallet");
  }
  factory StableJettonWalletOperation.fromJson(Map<String, dynamic>? json) {
    return TonModelParser.parseJson(
        parse: () {
          final type = StableJettonWalletOperationType.fromName(json?["type"]);
          switch (type) {
            case StableJettonWalletOperationType.transfer:
              return StableJettonWalletTransfer.fromJson(json!);
            case StableJettonWalletOperationType.burn:
              return StableJettonWalletBurn.fromJson(json!);
            case StableJettonWalletOperationType.setStatus:
              return StableJettonWalletSetStatus.fromJson(json!);
            default:
              throw TonContractException("Invalid Token Wallet operation type.",
                  details: {"type": type.name});
          }
        },
        name: "Token Wallet");
  }
}

class StableJettonWalletSetStatus extends StableJettonWalletOperation
    implements StableJettonMinterCallToOperations {
  final StableTokenWalletStatus status;
  StableJettonWalletSetStatus({required this.status, BigInt? queryId})
      : super(
            type: StableJettonWalletOperationType.setStatus, queryId: queryId);
  factory StableJettonWalletSetStatus.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return StableJettonWalletSetStatus(
              status: StableTokenWalletStatus.fromName(json["status"]),
              queryId: BigintUtils.parse(json["queryId"]));
        },
        name: StableJettonWalletOperationType.setStatus.name);
  }
  factory StableJettonWalletSetStatus.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          StableJettonWalletOperationType.fromTag(slice.tryLoadUint32(),
              excepted: StableJettonWalletOperationType.setStatus);
          return StableJettonWalletSetStatus(
              queryId: slice.loadUint64(),
              status: StableTokenWalletStatus.fromTag(slice.loadUint4()));
        },
        name: StableJettonWalletOperationType.setStatus.name);
  }
  @override
  Cell toBody() => beginCell().store(this).endCell();
  @override
  void store(Builder builder) {
    builder.storeUint32(type.id);
    builder.storeUint64(queryId);
    builder.storeUint4(status.id);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "status": status.name,
      "queryId": queryId.toString()
    };
  }
}

class StableJettonWalletTransfer extends StableJettonWalletOperation
    implements StableJettonMinterCallToOperations {
  final BigInt jettonAmount;
  final TonAddress to;
  final TonAddress? responseAddress;
  final Cell? customPayload;
  final BigInt forwardTonAmount;
  final Cell? forwardPayload;

  StableJettonWalletTransfer({
    required this.jettonAmount,
    required this.to,
    this.responseAddress,
    this.customPayload,
    required this.forwardTonAmount,
    this.forwardPayload,
    BigInt? queryId,
  }) : super(type: StableJettonWalletOperationType.transfer, queryId: queryId);
  factory StableJettonWalletTransfer.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return StableJettonWalletTransfer(
              queryId: BigintUtils.parse(json["queryId"]),
              forwardTonAmount: BigintUtils.parse(json["forwardTonAmount"]),
              jettonAmount: BigintUtils.parse(json["jettonAmount"]),
              customPayload: json["customPayload"] == null
                  ? null
                  : Cell.fromBase64(json["customPayload"]),
              forwardPayload: json["forwardPayload"] == null
                  ? null
                  : Cell.fromBase64(json["forwardPayload"]),
              to: TonAddress(json["to"]),
              responseAddress: json["responseAddress"] == null
                  ? null
                  : TonAddress(json["responseAddress"]));
        },
        name: StableJettonWalletOperationType.transfer.name);
  }
  factory StableJettonWalletTransfer.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          StableJettonWalletOperationType.fromTag(slice.tryLoadUint32(),
              excepted: StableJettonWalletOperationType.transfer);
          return StableJettonWalletTransfer(
              queryId: slice.loadUint64(),
              jettonAmount: slice.loadCoins(),
              to: slice.loadAddress(),
              responseAddress: slice.loadMaybeAddress(),
              customPayload: slice.loadMaybeRef(),
              forwardTonAmount: slice.loadCoins(),
              forwardPayload: slice.loadMaybeRef());
        },
        name: StableJettonWalletOperationType.transfer.name);
  }
  @override
  Cell toBody() => beginCell().store(this).endCell();
  @override
  void store(Builder builder) {
    builder.storeUint32(type.id);
    builder.storeUint64(queryId);
    builder.storeCoins(jettonAmount);
    builder.storeAddress(to);
    builder.storeAddress(responseAddress);
    builder.storeMaybeRef(cell: customPayload);
    builder.storeCoins(forwardTonAmount);
    builder.storeMaybeRef(cell: forwardPayload);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "queryId": queryId.toString(),
      "jettonAmount": jettonAmount.toString(),
      "to": to.toRawAddress(),
      "responseAddress": responseAddress?.toRawAddress(),
      "customPayload": customPayload?.toBase64(),
      "forwardTonAmount": forwardTonAmount.toString(),
      "forwardPayload": forwardPayload?.toBase64()
    };
  }
}

class StableJettonWalletBurn extends StableJettonWalletOperation
    implements StableJettonMinterCallToOperations {
  final BigInt jettonAmount;
  final TonAddress? responseAddress;
  final Cell? customPayload;

  StableJettonWalletBurn({
    required this.jettonAmount,
    this.responseAddress,
    this.customPayload,
    BigInt? queryId,
  }) : super(type: StableJettonWalletOperationType.burn, queryId: queryId);
  factory StableJettonWalletBurn.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return StableJettonWalletBurn(
              queryId: BigintUtils.parse(json["queryId"]),
              jettonAmount: BigintUtils.parse(json["jettonAmount"]),
              customPayload: json["customPayload"] == null
                  ? null
                  : Cell.fromBase64(json["customPayload"]),
              responseAddress: json["responseAddress"] == null
                  ? null
                  : TonAddress(json["responseAddress"]));
        },
        name: StableJettonWalletOperationType.burn.name);
  }
  factory StableJettonWalletBurn.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          StableJettonWalletOperationType.fromTag(slice.tryLoadUint32(),
              excepted: StableJettonWalletOperationType.burn);
          return StableJettonWalletBurn(
              queryId: slice.loadUint64(),
              jettonAmount: slice.loadCoins(),
              responseAddress: slice.loadMaybeAddress(),
              customPayload: slice.loadMaybeRef());
        },
        name: StableJettonWalletOperationType.burn.name);
  }
  @override
  Cell toBody() => beginCell().store(this).endCell();
  @override
  void store(Builder builder) {
    builder.storeUint32(type.id);
    builder.storeUint64(queryId);
    builder.storeCoins(jettonAmount);
    builder.storeAddress(responseAddress);
    builder.storeMaybeRef(cell: customPayload);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "queryId": queryId.toString(),
      "jettonAmount": jettonAmount.toString(),
      "responseAddress": responseAddress?.toRawAddress(),
      "customPayload": customPayload?.toBase64()
    };
  }
}

// class StableTokenWalletWithrawTon extends StableJettonWalletOperation {
//   StableTokenWalletWithrawTon({
//     BigInt? queryId,
//   }) : super(
//             type: StableJettonWalletOperationType.withdrawTon, queryId: queryId);
//   factory StableTokenWalletWithrawTon.fromJson(Map<String, dynamic> json) {
//     return TonModelParser.parseJson(
//         parse: () {
//           return StableTokenWalletWithrawTon(
//               queryId: BigintUtils.parse(json["queryId"]));
//         },
//         name: StableJettonWalletOperationType.withdrawTon.name);
//   }
//   factory StableTokenWalletWithrawTon.deserialize(Slice slice) {
//     return TonModelParser.parseBoc(
//         parse: () {
//           StableJettonWalletOperationType.fromTag(slice.tryLoadUint32(),
//               excepted: StableJettonWalletOperationType.withdrawTon);
//           return StableTokenWalletWithrawTon(queryId: slice.loadUint64());
//         },
//         name: StableJettonWalletOperationType.withdrawTon.name);
//   }

//   @override
//   void store(Builder builder) {
//     builder.storeUint32(type.id);
//     builder.storeUint64(queryId);
//   }

//   @override
//   Map<String, dynamic> toJson() {
//     return {"type": type.name, "queryId": queryId.toString()};
//   }
// }

// class StableTokenWalletWithrawJetton extends StableJettonWalletOperation {
//   final BigInt amount;
//   final TonAddress address;
//   final Cell? customPayload;

//   StableTokenWalletWithrawJetton({
//     required this.amount,
//     required this.address,
//     this.customPayload,
//     BigInt? queryId,
//   }) : super(
//             type: StableJettonWalletOperationType.withdrawJetton,
//             queryId: queryId);
//   factory StableTokenWalletWithrawJetton.fromJson(Map<String, dynamic> json) {
//     return TonModelParser.parseJson(
//         parse: () {
//           return StableTokenWalletWithrawJetton(
//               queryId: BigintUtils.parse(json["queryId"]),
//               amount: BigintUtils.parse(json["amount"]),
//               customPayload: json["customPayload"] == null
//                   ? null
//                   : Cell.fromBase64(json["customPayload"]),
//               address: TonAddress(json["address"]));
//         },
//         name: StableJettonWalletOperationType.withdrawJetton.name);
//   }
//   factory StableTokenWalletWithrawJetton.deserialize(Slice slice) {
//     return TonModelParser.parseBoc(
//         parse: () {
//           StableJettonWalletOperationType.fromTag(slice.tryLoadUint32(),
//               excepted: StableJettonWalletOperationType.withdrawJetton);
//           return StableTokenWalletWithrawJetton(
//               queryId: slice.loadUint64(),
//               address: slice.loadAddress(),
//               amount: slice.loadCoins(),
//               customPayload: slice.loadMaybeRef());
//         },
//         name: StableJettonWalletOperationType.withdrawJetton.name);
//   }

//   @override
//   void store(Builder builder) {
//     builder.storeUint32(type.id);
//     builder.storeUint64(queryId);
//     builder.storeAddress(address);
//     builder.storeCoins(amount);
//     builder.storeMaybeRef(cell: customPayload);
//   }

//   @override
//   Map<String, dynamic> toJson() {
//     return {
//       "type": type.name,
//       "queryId": queryId.toString(),
//       "amount": amount.toString(),
//       "address": address.toRawAddress(),
//       "customPayload": customPayload?.toBase64()
//     };
//   }
// }
