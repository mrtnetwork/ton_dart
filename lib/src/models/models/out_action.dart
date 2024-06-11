import 'package:blockchain_utils/exception/exceptions.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'message_relaxed.dart';
import 'send_mode.dart';

class _OutActionTypeConst {
  static const outActionSendMsgTag = 0x0ec3c86d;
  static const outActionSetCodeTag = 0xad4de08e;
}

class OutActionType {
  final String name;
  const OutActionType._(this.name);
  static const OutActionType sendMsg = OutActionType._("sendMsg");
  static const OutActionType setCode = OutActionType._("setCode");
  static const List<OutActionType> values = [sendMsg, setCode];
  factory OutActionType.fromValue(String? name) {
    return values.firstWhere(
      (element) => element.name == name,
      orElse: () => throw MessageException(
          "Cannot find OutActionType from provided name",
          details: {"name": name}),
    );
  }
  @override
  String toString() {
    return "OutActionType.$name";
  }
}

class OutActionUtils {
  static Slice storeOutList(List<OutAction> actions) {
    Cell cell = actions.fold<Cell>(
      beginCell().endCell(),
      (cell, action) {
        return beginCell().storeRef(cell).store(action).endCell();
      },
    );

    return cell.beginParse();
  }
}

abstract class OutAction extends TonSerialization {
  abstract final OutActionType type;
  const OutAction();
  factory OutAction.deserialize(Slice slice) {
    final tag = slice.loadUint(32);
    switch (tag) {
      case _OutActionTypeConst.outActionSendMsgTag:
        return OutActionSendMsg.deserialize(slice);
      case _OutActionTypeConst.outActionSetCodeTag:
        return OutActionSetCode.deserialize(slice);
      default:
        throw MessageException("Invalid OutAction tag.", details: {
          "excepted": [
            _OutActionTypeConst.outActionSendMsgTag,
            _OutActionTypeConst.outActionSetCodeTag
          ].join(", "),
          "tag": tag
        });
    }
  }
  factory OutAction.fromJson(Map<String, dynamic> json) {
    final type = OutActionType.fromValue(json["type"]);
    switch (type) {
      case OutActionType.sendMsg:
        return OutActionSendMsg.fromJson(json);
      default:
        return OutActionSetCode.fromJson(json);
    }
  }
}

class OutActionSendMsg extends OutAction {
  final SendMode mode;
  final MessageRelaxed outMessage;
  const OutActionSendMsg({required this.mode, required this.outMessage});
  factory OutActionSendMsg.deserialize(Slice slice) {
    return OutActionSendMsg(
      mode: SendMode.fromMode(slice.loadUint(8)),
      outMessage: MessageRelaxed.deserialize(slice.loadRef().beginParse()),
    );
  }
  factory OutActionSendMsg.fromJson(Map<String, dynamic> json) {
    return OutActionSendMsg(
        mode: SendMode.fromValue(json["mode"]),
        outMessage: MessageRelaxed.fromJson(json["out_message"]));
  }

  @override
  void store(Builder builder) {
    builder.storeUint(_OutActionTypeConst.outActionSendMsgTag, 32);
    builder.storeUint(mode.mode, 8);
    final messageCell = beginCell();
    outMessage.store(messageCell);
    builder.storeRef(messageCell.endCell());
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "mode": mode.name,
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
    return OutActionSetCode(slice.loadRef());
  }
  factory OutActionSetCode.fromJson(Map<String, dynamic> json) {
    return OutActionSetCode(Cell.fromBase64(json["new_code"]));
  }

  @override
  void store(Builder builder) {
    builder.storeUint(_OutActionTypeConst.outActionSetCodeTag, 32);
    builder.storeRef(newCode);
  }

  @override
  Map<String, dynamic> toJson() {
    return {"new_code": newCode.toBase64(), "type": type.name};
  }

  @override
  OutActionType get type => OutActionType.setCode;
}
