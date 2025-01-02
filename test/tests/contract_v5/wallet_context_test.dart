import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

void main() {
  group('Wallet V5 context', () {
    _walletV5ClientContext();
    _walletV5ClientContextDeserialize();
    _deserializeWalletCustomWalletContext();
    _serializeWalletCustomWalletContext();
  });
}

void _walletV5ClientContext() {
  test('client context', () {
    final walletContext =
        V5R1ClientContext(chain: TonChain.mainnet, subwalletNumber: 0);

    final actual = beginCell().store(walletContext).endCell();

    final context = beginCell()
        .storeUint(1, 1)
        .storeInt(0, 8)
        .storeUint(0, 8)
        .storeUint(0, 15)
        .endCell()
        .beginParse()
        .loadInt(32);

    final expected = beginCell()
        .storeInt(BigInt.from(context) ^ BigInt.from(-239), 32)
        .endCell();
    expect(actual, expected);
    expect(actual.toBase64(), 'te6cckEBAQEABgAACH///xHZat+l');
  });
}

void _walletV5ClientContextDeserialize() {
  test('deserialize client wallet context', () {
    final walletContext =
        V5R1ClientContext(chain: TonChain.mainnet, subwalletNumber: 0);
    final context = beginCell()
        .storeUint(1, 1)
        .storeInt(walletContext.chain.workchain, 8)
        .storeUint(0, 8)
        .storeUint(walletContext.subwalletNumber, 15)
        .endCell()
        .beginParse()
        .loadInt(32);
    final actual = beginCell()
        .storeInt(
            BigInt.from(context) ^ BigInt.from(walletContext.chain.id), 32)
        .endCell()
        .beginParse();
    final load = VersionedWalletUtils.loadV5Context(
        contextBytes: actual.loadBuffer(4), chain: walletContext.chain);
    expect(load, walletContext);
  });
}

void _serializeWalletCustomWalletContext() {
  test('serialize custom wallet context', () {
    const walletContext = V5R1CustomContext(
      context: 239239239,
      chain: TonChain.testnet,
    );
    final context = beginCell()
        .storeUint(0, 1)
        .storeUint(walletContext.context, 31)
        .endCell()
        .beginParse()
        .loadInt(32);
    final actual = beginCell().store(walletContext).endCell();
    final expected = beginCell()
        .storeInt(
            BigInt.from(context) ^ BigInt.from(walletContext.chain.id), 32)
        .endCell();
    expect(actual, expected);
    expect(expected.toBase64(), 'te6cckEBAQEABgAACPG9f7rC5HWN');
  });
}

void _deserializeWalletCustomWalletContext() {
  test('deserialize custom wallet context', () {
    const walletContext =
        V5R1CustomContext(context: 239239239, chain: TonChain.testnet);
    final context = beginCell()
        .storeUint(0, 1)
        .storeUint(walletContext.context, 31)
        .endCell()
        .beginParse()
        .loadInt(32);

    final actual = beginCell()
        .storeInt(
            BigInt.from(context) ^ BigInt.from(walletContext.chain.id), 32)
        .endCell()
        .beginParse();
    final load = VersionedWalletUtils.loadV5Context(
        contextBytes: actual.loadBuffer(4), chain: walletContext.chain);
    expect(walletContext, load);
  });
}
