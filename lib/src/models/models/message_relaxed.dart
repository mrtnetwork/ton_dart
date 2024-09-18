import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/boc/cell/cell.dart';
import 'package:ton_dart/src/boc/cell/slice.dart';
import 'package:ton_dart/src/models/models/common_message_info_relaxed.dart';
import 'package:ton_dart/src/models/models/state_init.dart';
import 'package:ton_dart/src/serialization/serialization.dart';
import 'package:ton_dart/src/utils/utils/extensions.dart';

/// Source: https://github.com/ton-blockchain/ton/blob/24dc184a2ea67f9c47042b4104bbb4d82289fac1/crypto/block/block.tlb#L151
/// message$_ {X:Type} info:CommonMsgInfoRelaxed
///  init:(Maybe (Either StateInit ^StateInit))
///  body:(Either X ^X) = MessageRelaxed X;
class MessageRelaxed extends TonSerialization {
  final CommonMessageInfoRelaxed info;
  final StateInit? init;
  final Cell body;
  const MessageRelaxed({required this.info, this.init, required this.body});
  factory MessageRelaxed.deserialize(Slice slice) {
    final info = CommonMessageInfoRelaxed.deserialize(slice);
    StateInit? init;
    if (slice.loadBit()) {
      if (!slice.loadBit()) {
        init = StateInit.deserialize(slice);
      } else {
        init = StateInit.deserialize(slice.loadRef().beginParse());
      }
    }
    final body = slice.loadBit() ? slice.loadRef() : slice.asCell();
    return MessageRelaxed(info: info, body: body, init: init);
  }
  factory MessageRelaxed.fromJson(Map<String, dynamic> json) {
    return MessageRelaxed(
        info: CommonMessageInfoRelaxed.fromJson(json["info"]),
        body: Cell.fromBase64(json["body"]),
        init: (json["init"] as Object?)?.convertTo<StateInit, Map>(
            (result) => StateInit.fromJson(result.cast())));
  }

  @override
  void store(Builder builder, {bool forceRef = false}) {
    // Store CommonMsgInfo
    info.store(builder);

    // Store init
    if (init != null) {
      builder.storeBitBolean(true);
      final initCell = beginCell();
      init?.store(initCell);
      // Check if ref is needed
      bool needRef = false;
      if (forceRef) {
        needRef = true;
      } else {
        if (builder.availableBits - 2 /* At least on byte for ref flag */ >=
            initCell.bits) {
          needRef = false;
        } else {
          needRef = true;
        }
      }

      // Store ref
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
      /*
             1. If at least one bit for ref flag
             2. If enough space for refs
             3. If not exotic
            */

      if (builder.availableBits - 1 >= body.bits.length &&
          builder.refs + body.refs.length <= 4 &&
          !body.isExotic) {
        needRef = false;
      } else {
        needRef = true;
      }
    }
    if (needRef) {
      builder.storeBitBolean(true);
      builder.storeRef(body);
    } else {
      builder.storeBitBolean(false);
      builder.storeBuilder(body.asBuilder());
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "info": info.toJson(),
      "init": init?.toJson(),
      "body": body.toBase64()
    };
  }
}
