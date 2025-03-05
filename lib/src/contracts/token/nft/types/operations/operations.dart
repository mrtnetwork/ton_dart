import 'package:blockchain_utils/utils/numbers/utils/bigint_utils.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/core/core.dart';
import 'package:ton_dart/src/contracts/exception/exception.dart';
import 'package:ton_dart/src/contracts/token/metadata/metadata.dart';
import 'package:ton_dart/src/contracts/token/nft/constant/constant.dart';
import 'package:ton_dart/src/contracts/token/nft/types/types.dart';
import 'package:ton_dart/src/contracts/utils/parser.dart';
import 'package:ton_dart/src/dict/dictionary.dart';
import 'package:ton_dart/src/serialization/serialization.dart';

class NFTItemOperationType extends ContractOperationType {
  const NFTItemOperationType._({required super.name, required super.operation});
  static const NFTItemOperationType transfer = NFTItemOperationType._(
      name: 'Transfer', operation: TonNftConst.nftTransferOperationId);
  static const NFTItemOperationType getStaticData = NFTItemOperationType._(
      name: 'GetStaticData', operation: TonNftConst.getStaticDataOperationId);
  static const List<NFTItemOperationType> values = [transfer, getStaticData];
  static NFTItemOperationType fromTag(int? operation,
      {NFTItemOperationType? expected}) {
    final type = values.firstWhere((e) => e.operation == operation,
        orElse: () =>
            throw TonContractExceptionConst.invalidOperationId(tag: operation));
    if (expected != null) {
      if (type != expected) {
        throw TonContractExceptionConst.incorrectOperation(
            expected: expected.name, got: type.name);
      }
    }
    return type;
  }

  static NFTItemOperationType fromName(String? name,
      {NFTItemOperationType? expected}) {
    final type = values.firstWhere((e) => e.name == name,
        orElse: () =>
            throw TonContractExceptionConst.invalidOperationId(tag: name));
    if (expected != null) {
      if (type != expected) {
        throw TonContractExceptionConst.incorrectOperation(
            expected: expected.name, got: type.name);
      }
    }
    return type;
  }
}

abstract class NFTItemOperation extends TonSerialization
    implements ContractOperation {
  @override
  final NFTItemOperationType type;
  final BigInt queryId;

  @override
  String get contractName => 'NFT Item';

  NFTItemOperation({required this.type, BigInt? queryId})
      : queryId = queryId ?? BigInt.zero;

  @override
  Cell contractCode(TonChain chain) {
    return TonNftConst.nftItemCode(chain.workchain);
  }

  Cell toBody() => beginCell().store(this).endCell();
  factory NFTItemOperation.deserialize(Slice slice) {
    return TonModelParser.parseBoc<NFTItemOperation>(
        parse: () {
          final type = NFTItemOperationType.fromTag(slice.tryPreloadUint32());
          switch (type) {
            case NFTItemOperationType.transfer:
              return NFTItemTransfer.deserialize(slice);
            case NFTItemOperationType.getStaticData:
              return NFTItemGetStaticData.deserialize(slice);
            default:
              throw TonContractException('Invalid NFT Item operation type.',
                  details: {'type': type.name});
          }
        },
        name: 'NFTItem');
  }
  factory NFTItemOperation.fromJson(Map<String, dynamic>? json) {
    return TonModelParser.parseJson(
        parse: () {
          final type = NFTItemOperationType.fromName(json?['type']);
          switch (type) {
            case NFTItemOperationType.transfer:
              return NFTItemTransfer.fromJson(json!);
            case NFTItemOperationType.getStaticData:
              return NFTItemGetStaticData.fromJson(json!);
            default:
              throw TonContractException('Invalid NFT Item operation type.',
                  details: {'type': type.name});
          }
        },
        name: 'NFTItem');
  }

  T cast<T extends NFTItemOperation>() {
    if (this is! T) {
      throw TonContractException('Incorrect NFTItemOperation casting.',
          details: {'expected': '$runtimeType', 'got': '$T'});
    }
    return this as T;
  }
}

class NFTItemTransfer extends NFTItemOperation {
  /// address of the new owner of the NFT item.
  final TonAddress newOwnerAddress;

  /// address where to send a response with confirmation of a
  /// successful transfer and the rest of the incoming message coins.
  final TonAddress? responseDestination;

  // /// optional custom data.
  // final Cell? customPayload;

  /// the amount of nanotons to be sent to the new owner.
  final BigInt forwardAmount;

  /// optional custom data that should be sent to the new owner.
  final Cell? forwardPayload;
  NFTItemTransfer(
      {super.queryId,
      required this.newOwnerAddress,
      this.responseDestination,
      required this.forwardAmount,
      this.forwardPayload})
      : super(type: NFTItemOperationType.transfer);
  factory NFTItemTransfer.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          NFTItemOperationType.fromTag(slice.tryLoadUint32());
          final BigInt queryId = slice.loadUint64();
          final TonAddress newOwnerAddress = slice.loadAddress();
          final TonAddress? responseDestination = slice.loadMaybeAddress();
          slice.loadBit();
          return NFTItemTransfer(
              queryId: queryId,
              newOwnerAddress: newOwnerAddress,
              responseDestination: responseDestination,
              forwardAmount: slice.loadCoins(),
              forwardPayload: slice.loadMaybeRef());
        },
        name: NFTItemOperationType.transfer.name);
  }
  factory NFTItemTransfer.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return NFTItemTransfer(
              queryId: BigintUtils.tryParse(json['queryId']),
              newOwnerAddress: TonAddress(json['newOwnerAddress']),
              responseDestination: json['responseDestination'] == null
                  ? null
                  : TonAddress(json['responseDestination']),
              forwardAmount: BigintUtils.parse(json['forwardAmount']),
              forwardPayload: json['forwardPayload'] == null
                  ? null
                  : Cell.fromBase64(json['forwardPayload']));
        },
        name: NFTItemOperationType.transfer.name);
  }
  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.storeAddress(newOwnerAddress);
    builder.storeAddress(responseDestination);
    builder.storeBit(0);
    builder.storeCoins(forwardAmount);
    builder.storeMaybeRef(cell: forwardPayload);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'queryId': queryId.toString(),
      'newOwnerAddress': newOwnerAddress.toFriendlyAddress(),
      'responseDestination': responseDestination?.toFriendlyAddress(),
      'forwardAmount': forwardAmount.toString(),
      'forwardPayload': forwardPayload?.toBase64(),
      'type': type.name
    };
  }
}

class NFTItemGetStaticData extends NFTItemOperation {
  NFTItemGetStaticData({required super.queryId})
      : super(type: NFTItemOperationType.getStaticData);

  factory NFTItemGetStaticData.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          NFTItemOperationType.fromTag(slice.tryLoadUint32());
          return NFTItemGetStaticData(queryId: slice.loadUint64());
        },
        name: NFTItemOperationType.getStaticData.name);
  }
  factory NFTItemGetStaticData.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return NFTItemGetStaticData(
              queryId: BigintUtils.parse(json['queryId']));
        },
        name: NFTItemOperationType.getStaticData.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'queryId': queryId.toString(), 'type': type.name};
  }
}

class NFTCollectionOperationType extends ContractOperationType {
  const NFTCollectionOperationType._(
      {required super.name, required super.operation});
  static const NFTCollectionOperationType mint = NFTCollectionOperationType._(
      name: 'Mint', operation: TonNftConst.mintNFtOperationId);
  static const NFTCollectionOperationType batchMint =
      NFTCollectionOperationType._(
          name: 'BatchMint', operation: TonNftConst.batchMintNFtOperationId);
  static const NFTCollectionOperationType changeOwner =
      NFTCollectionOperationType._(
          name: 'ChangeOwner',
          operation: TonNftConst.changeCollectionOwnerOperationId);
  static const NFTCollectionOperationType changeContent =
      NFTCollectionOperationType._(
          name: 'ChangeContent', operation: TonNftConst.changeContent);
  static const List<NFTCollectionOperationType> values = [
    mint,
    batchMint,
    changeOwner,
    changeContent
  ];
  static NFTCollectionOperationType fromTag(int? operation,
      {NFTCollectionOperationType? expected}) {
    final type = values.firstWhere((e) => e.operation == operation,
        orElse: () =>
            throw TonContractExceptionConst.invalidOperationId(tag: operation));
    if (expected != null) {
      if (type != expected) {
        throw TonContractExceptionConst.incorrectOperation(
            expected: expected.name, got: type.name);
      }
    }
    return type;
  }

  static NFTCollectionOperationType fromName(String? name,
      {NFTCollectionOperationType? expected}) {
    final type = values.firstWhere((e) => e.name == name,
        orElse: () =>
            throw TonContractExceptionConst.invalidOperationId(tag: name));
    if (expected != null) {
      if (type != expected) {
        throw TonContractExceptionConst.incorrectOperation(
            expected: expected.name, got: type.name);
      }
    }
    return type;
  }

  @override
  String toString() {
    return 'NFTCollectionOperationType.$name';
  }
}

abstract class NFTCollectionOperation extends TonSerialization
    implements ContractOperation {
  @override
  final NFTCollectionOperationType type;
  final BigInt queryId;
  @override
  String get contractName => 'NFT Collection';

  @override
  Cell contractCode(TonChain chain) {
    return TonNftConst.nftCollectionCode(chain.workchain);
  }

  NFTCollectionOperation({required this.type, BigInt? queryId})
      : queryId = queryId ?? BigInt.zero;
  Cell toBody() => beginCell().store(this).endCell();
  factory NFTCollectionOperation.deserialize(Slice slice) {
    return TonModelParser.parseBoc<NFTCollectionOperation>(
        parse: () {
          final type =
              NFTCollectionOperationType.fromTag(slice.tryPreloadUint32());
          switch (type) {
            case NFTCollectionOperationType.batchMint:
              return NFTCollectionBatchMint.deserialize(slice);
            case NFTCollectionOperationType.changeContent:
              return NFTEditableCollectionChangeContent.deserialize(slice);
            case NFTCollectionOperationType.changeOwner:
              return NFTCollectionChangeOwner.deserialize(slice);
            case NFTCollectionOperationType.mint:
              return NFTCollectionMint.deserialize(slice);
            default:
              throw TonContractException(
                  'Invalid NFT Collection operation type.',
                  details: {'type': type.name});
          }
        },
        name: 'NFTCollection');
  }
  factory NFTCollectionOperation.fromJson(Map<String, dynamic>? json) {
    return TonModelParser.parseJson(
        parse: () {
          final type = NFTCollectionOperationType.fromName(json?['type']);
          switch (type) {
            case NFTCollectionOperationType.batchMint:
              return NFTCollectionBatchMint.fromJson(json!);
            case NFTCollectionOperationType.changeContent:
              return NFTEditableCollectionChangeContent.fromJson(json!);
            case NFTCollectionOperationType.changeOwner:
              return NFTCollectionChangeOwner.fromJson(json!);
            case NFTCollectionOperationType.mint:
              return NFTCollectionMint.fromJson(json!);
            default:
              throw TonContractException(
                  'Invalid NFT Collection operation type.',
                  details: {'type': type.name});
          }
        },
        name: 'NFTCollection');
  }
  T cast<T extends NFTCollectionOperation>() {
    if (this is! T) {
      throw TonContractException('Incorrect NFTCollectionOperation casting.',
          details: {'expected': '$runtimeType', 'got': '$T'});
    }
    return this as T;
  }
}

class NFTCollectionMint extends NFTCollectionOperation {
  final NFTMintParams mint;

  NFTCollectionMint({super.queryId, required this.mint})
      : super(type: NFTCollectionOperationType.mint);
  factory NFTCollectionMint.deserialize(Slice slice) {
    NFTCollectionOperationType.fromTag(slice.tryLoadUint32());
    return NFTCollectionMint(
        queryId: slice.loadUint64(), mint: NFTMintParams.deserialize(slice));
  }
  factory NFTCollectionMint.fromJson(Map<String, dynamic> json) {
    return NFTCollectionMint(
        queryId: BigintUtils.parse(json['queryId']),
        mint: NFTMintParams.fromJson(json['mint']));
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.store(mint);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'queryId': queryId.toString(),
      'mint': mint.toJson(),
      'type': type.name
    };
  }
}

class _BatchNFTsMintParamsUtils {
  static final DictionaryValue<NFTMintParams> nftBatchMintsCodec =
      DictionaryValue(
          serialize: (source, builder) {
            builder.storeCoins(source.initAmount);
            final content = beginCell();
            content.storeAddress(source.ownerAddress);
            source.metadata.store(content);
            builder.storeRef(content.endCell());
          },
          parse: (slice) =>
              NFTMintParams.deserialize(slice, index: BigInt.from(-1)));
  static Dictionary<BigInt, NFTMintParams> getDict(
      {Map<BigInt, NFTMintParams> enteries = const {}}) {
    return Dictionary.fromEnteries(
        key: DictionaryKey.bigIntCodec(64),
        value: nftBatchMintsCodec,
        map: enteries);
  }

  static List<NFTMintParams> load(Slice slice) {
    final dict = Dictionary.fromEnteries<BigInt, NFTMintParams>(
        key: DictionaryKey.bigIntCodec(64),
        value: nftBatchMintsCodec,
        map: const {});
    dict.loadFromClice(slice);
    final asMap = dict.asMap;
    return asMap.entries
        .map((e) => e.value.copyWith(itemIndex: e.key))
        .toList();
  }
}

class NFTCollectionBatchMint extends NFTCollectionOperation {
  final List<NFTMintParams> nfts;

  NFTCollectionBatchMint({super.queryId, required List<NFTMintParams> nfts})
      : nfts = List<NFTMintParams>.unmodifiable(nfts),
        super(type: NFTCollectionOperationType.batchMint);
  factory NFTCollectionBatchMint.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          NFTCollectionOperationType.fromTag(slice.tryLoadUint32());
          final BigInt queryId = slice.loadUint64();
          final nfts = _BatchNFTsMintParamsUtils.load(slice);
          return NFTCollectionBatchMint(queryId: queryId, nfts: nfts);
        },
        name: NFTCollectionOperationType.batchMint.name);
  }
  factory NFTCollectionBatchMint.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseBoc(
        parse: () {
          return NFTCollectionBatchMint(
              queryId: BigintUtils.parse(json['queryId']),
              nfts: (json['nfts'] as List)
                  .map((e) => NFTMintParams.fromJson(e))
                  .toList());
        },
        name: NFTCollectionOperationType.batchMint.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    final Map<BigInt, NFTMintParams> nftOBjects =
        Map.fromEntries(nfts.map((e) => MapEntry(e.itemIndex, e)));
    final dict = _BatchNFTsMintParamsUtils.getDict(enteries: nftOBjects);
    builder.storeDict(dict: dict);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'queryId': queryId.toString(),
      'nfts': nfts.map((e) => e.toJson()).toList(),
      'type': type.name
    };
  }
}

class NFTCollectionChangeOwner extends NFTCollectionOperation {
  final TonAddress newOwnerAddress;
  NFTCollectionChangeOwner({super.queryId, required this.newOwnerAddress})
      : super(type: NFTCollectionOperationType.changeOwner);
  factory NFTCollectionChangeOwner.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          NFTCollectionOperationType.fromTag(slice.tryLoadUint32());
          return NFTCollectionChangeOwner(
              queryId: slice.loadUint64(),
              newOwnerAddress: slice.loadAddress());
        },
        name: NFTCollectionOperationType.changeOwner.name);
  }
  factory NFTCollectionChangeOwner.fromJson(Map<String, dynamic> json) {
    return TonModelParser.parseBoc(
        parse: () {
          return NFTCollectionChangeOwner(
              queryId: BigintUtils.parse(json['queryId']),
              newOwnerAddress: TonAddress(json['newOwnerAddress']));
        },
        name: NFTCollectionOperationType.changeOwner.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.storeAddress(newOwnerAddress);
  }

  @override
  NFTCollectionOperationType get type => NFTCollectionOperationType.changeOwner;
  @override
  Map<String, dynamic> toJson() {
    return {
      'queryId': queryId.toString(),
      'newOwnerAddress': newOwnerAddress.toRawAddress(),
      'type': type.name
    };
  }
}

class NFTEditableCollectionChangeContent extends NFTCollectionOperation {
  final RoyaltyParams royaltyParams;
  final Cell content;
  NFTEditableCollectionChangeContent(
      {required super.queryId,
      required this.royaltyParams,
      required this.content})
      : super(type: NFTCollectionOperationType.changeContent);
  factory NFTEditableCollectionChangeContent.deserialize(Slice slice) {
    return TonModelParser.parseBoc(
        parse: () {
          NFTCollectionOperationType.fromTag(slice.tryLoadUint32(),
              expected: NFTCollectionOperationType.changeContent);
          return NFTEditableCollectionChangeContent(
              queryId: slice.loadUint64(),
              content: slice.loadRef(),
              royaltyParams:
                  RoyaltyParams.deserialize(slice.loadRef().beginParse()));
        },
        name: NFTCollectionOperationType.changeContent.name);
  }
  factory NFTEditableCollectionChangeContent.fromJson(
      Map<String, dynamic> json) {
    return TonModelParser.parseJson(
        parse: () {
          return NFTEditableCollectionChangeContent(
              queryId: BigintUtils.parse(json['queryId']),
              content: Cell.fromBase64(json['content']),
              royaltyParams: RoyaltyParams.fromJson(json['royaltyParams']));
        },
        name: NFTCollectionOperationType.changeContent.name);
  }

  @override
  void store(Builder builder) {
    builder.storeUint32(type.operation);
    builder.storeUint64(queryId);
    builder.storeRef(content);
    builder.store(royaltyParams);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'queryId': queryId.toString(),
      'royaltyParams': royaltyParams.toJson(),
      'content': content.toBase64(),
      'metadata': metadata.toJson(),
      'type': type.name
    };
  }

  NFTMetadata get metadata => NFTMetadata.deserialize(content.beginParse());
}
