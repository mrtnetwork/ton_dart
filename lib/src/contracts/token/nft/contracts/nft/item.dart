import 'package:ton_dart/src/address/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/contracts/contracts.dart';
import 'package:ton_dart/src/helper/ton_helper.dart';
import 'package:ton_dart/src/models/models.dart';
import 'package:ton_dart/src/provider/provider/provider.dart';

/// https://github.com/ton-blockchain/TEPs/blob/master/text/0062-nft-standard.md
class NFTItemContract<E extends WalletContractTransferParams>
    extends TonContract<NFTItemState> {
  final WalletContract<dynamic, E> owner;
  @override
  final TonAddress address;
  @override
  final NFTItemState? state;

  factory NFTItemContract.create(
      {required WalletContract<dynamic, E> owner,
      required NFTItemState state}) {
    return NFTItemContract(
        address: TonAddress.fromState(
            state: state.initialState(), workChain: owner.address.workChain),
        owner: owner,
        state: state);
  }
  static Future<NFTItemContract>
      fromAddress<E extends WalletContractTransferParams>(
          {required WalletContract<dynamic, E> owner,
          required TonAddress address,
          required TonProvider rpc}) async {
    final stateData =
        await ContractProvider.getActiveState(address: address, rpc: rpc);
    final state = NFTItemState.deserialize(stateData.data!.beginParse());
    return NFTItemContract(address: address, owner: owner, state: state);
  }

  const NFTItemContract(
      {required this.address, required this.owner, this.state});

  Future<String> _sendTransaction({
    required E params,
    required TonProvider rpc,
    required BigInt amount,
    int sendMode = SendModeConst.payGasSeparately,
    int? timeout,
    bool? bounce,
    bool bounced = false,
    Cell? body,
  }) async {
    final active = await isActive(rpc);
    if (!active && state == null) {
      throw const TonContractException(
          "The account is inactive and requires state initialization.");
    }
    final message = TonHelper.internal(
      destination: address,
      amount: amount,
      initState: active ? null : state!.initialState(),
      bounced: bounced,
      body: body,
      bounce: bounce ?? address.isBounceable,
    );
    return await owner.sendTransfer(
        params: params,
        messages: [
          message,
        ],
        rpc: rpc,
        timeout: timeout,
        sendMode: sendMode);
  }

  Future<String> deploy(
      {required E params,
      required TonProvider rpc,
      required BigInt amount,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body}) async {
    return _sendTransaction(
        params: params,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: body,
        bounce: bounce,
        bounced: bounced,
        timeout: timeout);
  }

  Future<String> sendOperation(
      {required E params,
      required TonProvider rpc,
      required BigInt amount,
      required NFTItemOperation operation,
      int sendMode = SendModeConst.payGasSeparately,
      int? timeout,
      bool? bounce,
      bool bounced = false,
      Cell? body}) async {
    return _sendTransaction(
        params: params,
        rpc: rpc,
        amount: amount,
        sendMode: sendMode,
        body: operation.toBody(),
        bounce: bounce,
        bounced: bounced,
        timeout: timeout);
  }

  Future<NFTItemData> getNftData(TonProvider rpc) async {
    final result = await getStateStack(rpc: rpc, method: "get_nft_data");
    final reader = result.reader();
    final bool init = reader.readNumber() != 0;
    final index = reader.readBigNumber();
    if (!init) {
      return NFTItemData(init: init, index: index);
    }
    final collectionAddress = reader.readAddressOpt();
    final ownerAddress = reader.readAddressOpt();
    final content = reader.readCell();

    return NFTItemData(
        init: init,
        collectionAddress: collectionAddress,
        content: content,
        ownerAddress: ownerAddress,
        index: index);
  }
}
