import 'package:blockchain_utils/utils/string/string.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/dict/dictionary.dart';
import 'package:ton_dart/src/models/models/common_message_info.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/extentions.dart';

class MessageCodec {
  static final DictionaryValue<Message> codec = DictionaryValue(
      serialize: (source, builder) {
        builder.storeRef(beginCell().store(source).endCell());
      },
      parse: (slice) => Message.deserialize(slice.loadRef().beginParse()));
}

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L147
/// message$_ {X:Type} info:CommonMsgInfo
///  init:(Maybe (Either StateInit ^StateInit))
///  body:(Either X ^X) = Message X;
class Message extends TonSerialization {
  final CommonMessageInfo info;
  final StateInit? init;
  final Cell body;
  const Message({required this.info, this.init, required this.body});
  factory Message.deserialize(Slice slice) {
    final info = CommonMessageInfo.deserialize(slice);
    StateInit? init;
    if (slice.loadBit()) {
      if (!slice.loadBit()) {
        init = StateInit.deserialize(slice);
      } else {
        init = StateInit.deserialize(slice.loadRef().beginParse());
      }
    }
    final body = slice.loadBit() ? slice.loadRef() : slice.asCell();
    return Message(info: info, body: body, init: init);
  }
  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
        info: CommonMessageInfo.fromJson(json["info"]),
        body: json["body"],
        init: (json["init"] as Object?)?.to<StateInit, Map>(
            (result) => StateInit.fromJson(result.cast())));
  }

  @override
  void store(Builder builder, {bool forceRef = false}) {
    // Store CommonMsgInfo
    info.store(builder);
    // Store init
    if (init != null) {
      builder.storeBitBolean(true);
      final initCell = beginCell().store(init!);

      // Check if need to store it in ref
      bool needRef = false;
      if (forceRef) {
        needRef = true;
      } else {
        needRef = builder.availableBits - 2 < initCell.bits + body.bits.length;
      }

      // Persist init
      if (needRef) {
        builder.storeBitBolean(true);
        builder.storeRef(initCell.endCell());
      } else {
        builder.storeBitBolean(false);
        builder.storeBuilder(initCell);
      }
    } else {
      builder.storeBitBolean(false);
    }

    // Store body
    bool needRef = false;
    if (forceRef) {
      needRef = true;
    } else {
      needRef = builder.availableBits - 1 < body.bits.length ||
          builder.refs + body.refs.length > 4;
    }
    if (needRef) {
      builder.storeBitBolean(true);
      builder.storeRef(body);
    } else {
      builder.storeBitBolean(false);
      builder.storeBuilder(body.asBuilder());
    }
  }

  String get hash =>
      StringUtils.decode(body.hash(), type: StringEncoding.base64);

  @override
  Map<String, dynamic> toJson() {
    return {"info": info.toJson(), "init": init?.toJson(), "body": body};
  }
}
