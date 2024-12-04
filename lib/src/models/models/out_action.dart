import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/address/core/ton_address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/dict/dictionary/dictionary.dart';
import 'package:ton_dart/src/dict/dictionary/key.dart';
import 'package:ton_dart/src/dict/dictionary/value.dart';
import 'package:ton_dart/src/exception/exception.dart';
import 'package:ton_dart/src/models/models/send_mode.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'message_relaxed.dart';

class OutActionType {
  final String name;
  final int tag;
  const OutActionType._({required this.name, required this.tag});
  static const OutActionType sendMsg =
      OutActionType._(name: "sendMsg", tag: 0x0ec3c86d);
  static const OutActionType multiSigSendMessage =
      OutActionType._(name: "multiSigSendMsg", tag: 0xf1381e5b);
  static const OutActionType updateMiltiSig =
      OutActionType._(name: "updateMultiSig", tag: 0x1d0cfbd3);

  static const OutActionType setCode =
      OutActionType._(name: "setCode", tag: 0xad4de08e);
  static const OutActionType addExtension =
      OutActionType._(name: "AddExtension", tag: 0x02);
  static const OutActionType removeExtension =
      OutActionType._(tag: 0x03, name: "RemoveExtension");
  static const OutActionType setIsPublicKeyEnabled =
      OutActionType._(tag: 0x04, name: "SetIsPublicKeyEnabled");
  static const List<OutActionType> values = [
    sendMsg,
    setCode,
    addExtension,
    removeExtension,
    setIsPublicKeyEnabled,
    multiSigSendMessage,
    updateMiltiSig
  ];
  factory OutActionType.fromValue(String? name) {
    return values.firstWhere((element) => element.name == name,
        orElse: () => throw TonDartPluginException(
            "Cannot find OutActionType from provided name",
            details: {"name": name}));
  }
  factory OutActionType.fromTag(int? tag) {
    return values.firstWhere((element) => element.tag == tag,
        orElse: () => throw TonDartPluginException(
            "Cannot find OutActionType from provided tag",
            details: {"tag": tag}));
  }
  @override
  String toString() {
    return "OutActionType.$name";
  }
}

class OutActionsV5 extends TonSerialization {
  final List<OutActionWalletV5> actions;
  OutActionsV5({required List<OutActionWalletV5> actions})
      : actions = List<OutActionWalletV5>.unmodifiable(actions);
  factory OutActionsV5.deserialize(Slice slice) {
    final List<OutActionWalletV5> actions = [];
    final outListPacked = slice.loadMaybeRef();
    if (outListPacked != null) {
      final sendMsgActions =
          OutActionUtils.loadOutList(outListPacked.beginParse());
      if (sendMsgActions.any((e) => e.type != OutActionType.sendMsg)) {
        throw const TonDartPluginException(
            "Can't deserialize actions list: only sendMsg actions are allowed for wallet v5r1");
      }
      actions.addAll(sendMsgActions.cast<OutActionWalletV5>());
    }
    if (slice.loadBoolean()) {
      actions.add(OutActionExtended.deserialize(slice));
    }
    while (slice.remainingRefs > 0) {
      slice = slice.loadRef().beginParse();
      actions.add(OutActionExtended.deserialize(slice));
    }
    return OutActionsV5(actions: actions);
  }

  Cell? get _msgOutList {
    final basicActions =
        actions.whereType<OutActionSendMsg>().toList().reversed.toList();
    if (basicActions.isEmpty) return null;

    final Cell cell = basicActions.fold<Cell>(
      beginCell().endCell(),
      (cell, action) {
        return beginCell().storeRef(cell).store(action).endCell();
      },
    );

    return cell;
  }

  @override
  void store(Builder builder) {
    final extendedActions = actions.whereType<OutActionExtended>().toList();
    builder.storeMaybeRef(cell: _msgOutList);
    if (extendedActions.isEmpty) {
      builder.storeUint(0, 1);
    } else {
      final first = extendedActions.first;
      final rest = extendedActions.sublist(1);
      builder.storeUint(1, 1).store(first);
      if (rest.isNotEmpty) {
        builder.storeRef(OutActionUtils.packExtendedActionsRec(rest));
      }
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {"actions": actions.map((e) => e.toJson()).toList()};
  }
}

class OutActionUtils {
  static List<OutAction> loadOutList(Slice slice) {
    final List<OutAction> actions = [];
    while (slice.remainingRefs != 0) {
      final nextCell = slice.loadRef();
      actions.add(OutAction.deserialize(slice));
      slice = nextCell.beginParse();
    }
    return actions.reversed.toList();
  }

  static Dictionary<int, TonBaseAddress> signersToDict<V>(
      List<TonAddress> obj) {
    final dict = Dictionary.empty<int, TonBaseAddress>(
        key: DictionaryKey.uintCodec(8), value: DictionaryValue.addressCodec());
    for (int i = 0; i < obj.length; i++) {
      dict[i] = obj[i];
    }
    return dict;
  }

  static List<TonAddress> signerCellToList<V>(Cell? cell) {
    if (cell == null) return [];
    final dict = Dictionary.empty<int, TonBaseAddress>(
        key: DictionaryKey.uintCodec(8), value: DictionaryValue.addressCodec());
    dict.loadFromClice(cell.beginParse());
    return dict.asMap.values.whereType<TonAddress>().toList();
  }

  static Slice storeOutList(List<OutAction> actions) {
    final Cell cell = actions.fold<Cell>(
      beginCell().endCell(),
      (cell, action) {
        return beginCell().storeRef(cell).store(action).endCell();
      },
    );

    return cell.beginParse();
  }

  static Cell packExtendedActionsRec(List<OutActionExtended> extendedActions) {
    final first = extendedActions.first;
    final rest = extendedActions.sublist(1);

    Builder builder = beginCell().store(first);
    if (rest.isNotEmpty) {
      builder = builder.storeRef(packExtendedActionsRec(rest));
    }
    return builder.endCell();
  }
}

abstract class OutActionWalletV5 extends OutAction {
  const OutActionWalletV5();
}

abstract class OutAction extends TonSerialization {
  abstract final OutActionType type;
  const OutAction();
  factory OutAction.deserialize(Slice slice) {
    int? tag = slice.tryPreloadUint32();
    OutActionType type;
    try {
      type = OutActionType.fromTag(tag);
    } on TonDartPluginException {
      tag = slice.tryPreLoadUint8();
      type = OutActionType.fromTag(tag);
    }
    switch (type) {
      case OutActionType.sendMsg:
        return OutActionSendMsg.deserialize(slice);
      case OutActionType.setCode:
        return OutActionSetCode.deserialize(slice);
      case OutActionType.addExtension:
        return OutActionAddExtension.deserialize(slice);
      case OutActionType.removeExtension:
        return OutActionRemoveExtension.deserialize(slice);
      case OutActionType.setIsPublicKeyEnabled:
        return OutActionSetIsPublicKeyEnabled.deserialize(slice);
      case OutActionType.updateMiltiSig:
        return OutActionUpdateMultiSig.deserialize(slice);
      case OutActionType.multiSigSendMessage:
        return OutActionMultiSigSendMsg.deserialize(slice);
      default:
        throw TonDartPluginException("Invalid OutAction tag.", details: {
          "excepted": OutActionType.values.map((e) => e.tag).join(", "),
          "tag": tag
        });
    }
  }
  factory OutAction.fromJson(Map<String, dynamic> json) {
    final type = OutActionType.fromValue(json["type"]);
    switch (type) {
      case OutActionType.sendMsg:
        return OutActionSendMsg.fromJson(json);
      case OutActionType.addExtension:
        return OutActionAddExtension.fromJson(json);
      case OutActionType.removeExtension:
        return OutActionRemoveExtension.fromJson(json);
      case OutActionType.setIsPublicKeyEnabled:
        return OutActionSetIsPublicKeyEnabled.fromJson(json);
      case OutActionType.setCode:
        return OutActionSetCode.fromJson(json);
      default:
        throw UnimplementedError("Invalid or unsupported OutActionType.");
    }
  }
}

class OutActionSendMsg extends OutActionWalletV5 {
  final int mode;
  final MessageRelaxed outMessage;
  const OutActionSendMsg(
      {this.mode = SendModeConst.payGasSeparately, required this.outMessage});
  factory OutActionSendMsg.deserialize(Slice slice) {
    final tag = slice.tryLoadUint32();
    if (tag != OutActionType.sendMsg.tag) {
      throw const TonDartPluginException("Invalid OutActionSendMsg tag");
    }
    return OutActionSendMsg(
        mode: slice.loadUint(8),
        outMessage: MessageRelaxed.deserialize(slice.loadRef().beginParse()));
  }
  factory OutActionSendMsg.fromJson(Map<String, dynamic> json) {
    return OutActionSendMsg(
        mode: json["mode"],
        outMessage: MessageRelaxed.fromJson(json["out_message"]));
  }

  OutActionSendMsg copyWith({int? mode, MessageRelaxed? outMessage}) {
    return OutActionSendMsg(
        mode: mode ?? this.mode, outMessage: outMessage ?? this.outMessage);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.tag);
    builder.storeUint(mode, 8);
    final messageCell = beginCell();
    outMessage.store(messageCell);
    builder.storeRef(messageCell.endCell());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "mode": mode,
      "out_message": outMessage.toJson(),
      "type": type.name
    };
  }

  @override
  OutActionType get type => OutActionType.sendMsg;
}

class OutActionSetCode extends OutAction {
  final Cell newCode;
  const OutActionSetCode(this.newCode);
  factory OutActionSetCode.deserialize(Slice slice) {
    final tag = slice.tryLoadUint32();
    if (tag != OutActionType.setCode.tag) {
      throw const TonDartPluginException("Invalid OutActionSetCode tag");
    }
    return OutActionSetCode(slice.loadRef());
  }
  factory OutActionSetCode.fromJson(Map<String, dynamic> json) {
    return OutActionSetCode(Cell.fromBase64(json["new_code"]));
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.tag);
    builder.storeRef(newCode);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"new_code": newCode.toBase64(), "type": type.name};
  }

  @override
  OutActionType get type => OutActionType.setCode;
}

abstract class OutActionExtended extends OutActionWalletV5 {
  const OutActionExtended();
  factory OutActionExtended.deserialize(Slice slice) {
    final tag = slice.tryPreLoadUint8();
    final type = OutActionType.fromTag(tag);
    switch (type) {
      case OutActionType.addExtension:
        return OutActionAddExtension.deserialize(slice);
      case OutActionType.removeExtension:
        return OutActionRemoveExtension.deserialize(slice);
      case OutActionType.setIsPublicKeyEnabled:
        return OutActionSetIsPublicKeyEnabled.deserialize(slice);
      default:
        throw TonDartPluginException("Invalid OutAction extended tag.",
            details: {"tag": tag});
    }
  }
}

class OutActionAddExtension extends OutActionExtended {
  final TonAddress address;
  const OutActionAddExtension(this.address);
  factory OutActionAddExtension.deserialize(Slice slice) {
    final tag = slice.tryLoadUint8();
    if (tag != OutActionType.addExtension.tag) {
      throw const TonDartPluginException("Invalid OutActionAddExtension tag");
    }
    return OutActionAddExtension(slice.loadAddress());
  }
  factory OutActionAddExtension.fromJson(Map<String, dynamic> json) {
    return OutActionAddExtension(TonAddress(json["address"]));
  }
  @override
  void store(Builder builder) {
    builder.storeUint(type.tag, 8);
    builder.storeAddress(address);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"address": address.toFriendlyAddress()};
  }

  @override
  OutActionType get type => OutActionType.addExtension;
}

class OutActionRemoveExtension extends OutActionExtended {
  final TonAddress address;
  const OutActionRemoveExtension(this.address);
  factory OutActionRemoveExtension.deserialize(Slice slice) {
    final tag = slice.tryLoadUint8();
    if (tag != OutActionType.removeExtension.tag) {
      throw const TonDartPluginException(
          "Invalid OutActionRemoveExtension tag");
    }
    return OutActionRemoveExtension(slice.loadAddress());
  }
  factory OutActionRemoveExtension.fromJson(Map<String, dynamic> json) {
    return OutActionRemoveExtension(TonAddress(json["address"]));
  }
  @override
  void store(Builder builder) {
    builder.storeUint(type.tag, 8);
    builder.storeAddress(address);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"address": address.toFriendlyAddress()};
  }

  @override
  OutActionType get type => OutActionType.removeExtension;
}

class OutActionSetIsPublicKeyEnabled extends OutActionExtended {
  final bool isEnabled;
  const OutActionSetIsPublicKeyEnabled(this.isEnabled);
  factory OutActionSetIsPublicKeyEnabled.fromJson(Map<String, dynamic> json) {
    return OutActionSetIsPublicKeyEnabled(json["isEnabled"]);
  }
  factory OutActionSetIsPublicKeyEnabled.deserialize(Slice slice) {
    final tag = slice.tryLoadUint8();
    if (tag != OutActionType.setIsPublicKeyEnabled.tag) {
      throw const TonDartPluginException(
          "Invalid OutActionSetIsPublicKeyEnabled tag");
    }
    return OutActionSetIsPublicKeyEnabled(slice.loadBoolean());
  }
  @override
  void store(Builder builder) {
    builder.storeUint(type.tag, 8);
    builder.storeBitBolean(isEnabled);
  }

  @override
  OutActionType get type => OutActionType.setIsPublicKeyEnabled;
  @override
  Map<String, dynamic> toJson() {
    return {"isEnabled": isEnabled};
  }
}

abstract class OutActionMultiSig extends OutAction {
  const OutActionMultiSig();
}

class OutActionMultiSigSendMsg extends OutActionMultiSig {
  final int mode;
  final MessageRelaxed outMessage;
  const OutActionMultiSigSendMsg(
      {this.mode = SendModeConst.payGasSeparately, required this.outMessage});
  factory OutActionMultiSigSendMsg.deserialize(Slice slice) {
    final tag = slice.tryLoadUint32();
    if (tag != OutActionType.multiSigSendMessage.tag) {
      throw const TonDartPluginException(
          "Invalid OutActionMultiSigSendMsg tag");
    }
    return OutActionMultiSigSendMsg(
        mode: slice.loadUint(8),
        outMessage: MessageRelaxed.deserialize(slice.loadRef().beginParse()));
  }
  factory OutActionMultiSigSendMsg.fromJson(Map<String, dynamic> json) {
    return OutActionMultiSigSendMsg(
        mode: json["mode"],
        outMessage: MessageRelaxed.fromJson(json["out_message"]));
  }

  OutActionMultiSigSendMsg copyWith({int? mode, MessageRelaxed? outMessage}) {
    return OutActionMultiSigSendMsg(
        mode: mode ?? this.mode, outMessage: outMessage ?? this.outMessage);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.tag);
    builder.storeUint8(mode);
    final messageCell = beginCell();
    outMessage.store(messageCell);
    builder.storeRef(messageCell.endCell());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "mode": mode,
      "out_message": outMessage.toJson(),
      "type": type.name
    };
  }

  @override
  OutActionType get type => OutActionType.multiSigSendMessage;
}

class OutActionUpdateMultiSig extends OutActionMultiSig {
  final int threshold;
  final List<TonAddress> signers;
  final List<TonAddress> proposers;

  OutActionUpdateMultiSig({
    required this.threshold,
    required List<TonAddress> signers,
    required List<TonAddress> proposers,
  })  : signers = List<TonAddress>.unmodifiable(signers),
        proposers = List<TonAddress>.unmodifiable(proposers);
  factory OutActionUpdateMultiSig.deserialize(Slice slice) {
    final tag = slice.tryLoadUint32();
    if (tag != OutActionType.updateMiltiSig.tag) {
      throw const TonDartPluginException("Invalid OutActionUpdateMultiSig tag");
    }
    final threshhold = slice.loadUint8();
    final signers = OutActionUtils.signerCellToList(slice.loadMaybeRef());
    final proposers = slice.loadDict(
        DictionaryKey.uintCodec(8), DictionaryValue.addressCodec());

    return OutActionUpdateMultiSig(
        threshold: threshhold,
        signers: signers,
        proposers: proposers.asMap.values.whereType<TonAddress>().toList());
  }
  factory OutActionUpdateMultiSig.fromJson(Map<String, dynamic> json) {
    return OutActionUpdateMultiSig(
        signers: (json["signers"] as List).map((e) => TonAddress(e)).toList(),
        proposers:
            (json["proposers"] as List).map((e) => TonAddress(e)).toList(),
        threshold: json["threshold"]);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.tag);
    builder.storeUint8(threshold);
    builder.storeRef(beginCell()
        .storeDictDirect(OutActionUtils.signersToDict(signers))
        .endCell());
    builder.storeDict(dict: OutActionUtils.signersToDict(proposers));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "type": type.name,
      "threshold": threshold,
      "signers": signers.map((e) => e.toFriendlyAddress()).toList(),
      "proposers": proposers.map((e) => e.toFriendlyAddress()).toList()
    };
  }

  @override
  OutActionType get type => OutActionType.updateMiltiSig;
}
