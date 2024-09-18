import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

abstract class V5R1Context extends TonSerialization {
  const V5R1Context({required this.chain});
  final TonChain chain;
  abstract final int contextID;
  @override
  void store(Builder builder) {
    final id = (BigInt.from(chain.id) ^ BigInt.from(contextID)).toInt();
    builder.storeInt(id, 32);
  }
}

class V5R1CustomContext extends V5R1Context {
  final int context;
  const V5R1CustomContext({required this.context, required TonChain chain})
      : super(chain: chain);

  @override
  Map<String, dynamic> toJson() {
    return {"context": context, "networkGlobalId": chain.id};
  }

  @override
  int get contextID => beginCell()
      .storeUint(0, 1)
      .storeUint(context, 31)
      .endCell()
      .beginParse()
      .loadInt(32);

  @override
  operator ==(other) {
    if (other is! V5R1CustomContext) return false;
    return other.context == context && other.chain == chain;
  }

  @override
  int get hashCode => Object.hashAll([context, chain.id]);
}

class V5R1ClientContext extends V5R1Context {
  final int walletVersion = 0;
  final int subwalletNumber;

  V5R1ClientContext({required this.subwalletNumber, required TonChain chain})
      : super(chain: chain);

  @override
  Map<String, dynamic> toJson() {
    return {
      "networkGlobalId": chain.id,
      "subwalletNumber": subwalletNumber,
      "workchain": chain.workchain
    };
  }

  @override
  int get contextID => beginCell()
      .storeUint(1, 1)
      .storeInt(chain.workchain, 8)
      .storeUint(walletVersion, 8)
      .storeUint(subwalletNumber, 15)
      .endCell()
      .beginParse()
      .loadInt(32);

  @override
  operator ==(other) {
    if (other is! V5R1ClientContext) return false;
    return other.subwalletNumber == subwalletNumber && other.chain == chain;
  }

  @override
  int get hashCode => Object.hashAll([subwalletNumber, chain.id]);
}
