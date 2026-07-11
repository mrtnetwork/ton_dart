import 'package:blockchain_utils/utils/equatable/equatable.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

abstract class V5R1Context extends TonSerialization with Equality {
  const V5R1Context({required this.chainId});
  final TonChainId chainId;
  abstract final int contextID;
  @override
  void store(Builder builder) {
    final id = (BigInt.from(chainId.id) ^ BigInt.from(contextID)).toInt();
    builder.storeInt(id, 32);
  }
}

class V5R1CustomContext extends V5R1Context {
  final int context;
  const V5R1CustomContext({required this.context, required super.chainId});

  @override
  Map<String, dynamic> toJson() {
    return {'context': context, 'networkGlobalId': chainId.id};
  }

  @override
  int get contextID => beginCell()
      .storeUint(0, 1)
      .storeUint(context, 31)
      .endCell()
      .beginParse()
      .loadInt(32);

  @override
  List<dynamic> get variables => [context, chainId];
}

class V5R1ClientContext extends V5R1Context {
  final int walletVersion = 0;
  final int subwalletNumber;
  final TonWorkChain workchain;

  V5R1ClientContext({
    required this.subwalletNumber,
    required super.chainId,
    required this.workchain,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'networkGlobalId': chainId.id,
      'subwalletNumber': subwalletNumber,
      'workchain': workchain.id,
    };
  }

  @override
  int get contextID => beginCell()
      .storeUint(1, 1)
      .storeInt(workchain.id, 8)
      .storeUint(walletVersion, 8)
      .storeUint(subwalletNumber, 15)
      .endCell()
      .beginParse()
      .loadInt(32);

  @override
  List<dynamic> get variables => [subwalletNumber, chainId, workchain];
}
