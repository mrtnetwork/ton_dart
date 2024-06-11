import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:blockchain_utils/numbers/numbers.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class AccountStateType {
  final String name;
  const AccountStateType._(this.name);
  static const AccountStateType uninit = AccountStateType._("uninit");
  static const AccountStateType active = AccountStateType._("active");
  static const AccountStateType frozen = AccountStateType._("frozen");
  static const List<AccountStateType> values = [uninit, active, frozen];
  factory AccountStateType.fromValue(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw MessageException(
          "Cannot find AccountStateType from provided name",
          details: {"name": name}),
    );
  }
  @override
  String toString() {
    return "AccountStateType.$name";
  }
}

abstract class AccountState extends TonSerialization {
  abstract final AccountStateType type;
  const AccountState();
  factory AccountState.deserialize(Slice slice) {
    if (slice.loadBit()) {
      return AccountStateActive.deserialize(slice);
    }
    if (slice.loadBit()) {
      return AccountStateFrozen.deserialize(slice);
    }
    return AccountStateUninit();
  }
  factory AccountState.fromJson(Map<String, dynamic> json) {
    final type = AccountStateType.fromValue(json["type"]);
    switch (type) {
      case AccountStateType.active:
        return AccountStateActive.fromJson(json);
      case AccountStateType.frozen:
        return AccountStateFrozen.fromJson(json);
      default:
        return AccountStateUninit();
    }
  }
}

class AccountStateUninit extends AccountState {
  @override
  void store(Builder builder) {
    builder.storeBitBolean(false);
    builder.storeBitBolean(false);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"type": type.name};
  }

  @override
  AccountStateType get type => AccountStateType.uninit;
}

class AccountStateFrozen extends AccountState {
  final BigInt stateHash;
  const AccountStateFrozen(this.stateHash);
  factory AccountStateFrozen.deserialize(Slice slice) {
    return AccountStateFrozen(slice.loadUintBig(256));
  }
  factory AccountStateFrozen.fromJson(Map<String, dynamic> json) {
    return AccountStateFrozen(BigintUtils.parse(json["stateHash"]));
  }
  @override
  void store(Builder builder) {
    builder.storeBitBolean(false);
    builder.storeBitBolean(true);
    builder.storeUint(stateHash, 256);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"stateHash": stateHash.toString(), "type": type.name};
  }

  @override
  AccountStateType get type => AccountStateType.frozen;
}

class AccountStateActive extends AccountState {
  final StateInit state;
  const AccountStateActive(this.state);
  factory AccountStateActive.deserialize(Slice slice) {
    return AccountStateActive(StateInit.deserialize(slice));
  }
  factory AccountStateActive.fromJson(Map<String, dynamic> json) {
    return AccountStateActive(StateInit.fromJson(json["state"]));
  }
  @override
  void store(Builder builder) {
    builder.storeBitBolean(true);
    state.store(builder);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"state": state.toJson(), "type": type.name};
  }

  @override
  AccountStateType get type => AccountStateType.active;
}
