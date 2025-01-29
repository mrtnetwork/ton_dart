import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

void main() {
  _v5R1Actions();
}

final _mockMessageRelaxed1 = MessageRelaxed(
    info: CommonMessageInfoRelaxedExternalOut(
        src: null, createdLt: BigInt.zero, createdAt: 0, dest: null),
    body: beginCell().storeUint(0, 8).endCell());
final _mockMessageRelaxed2 = MessageRelaxed(
    info: CommonMessageInfoRelaxedInternal(
        src: null,
        createdLt: BigInt.from(12345),
        bounce: false,
        bounced: false,
        ihrDisabled: true,
        value: CurrencyCollection(coins: BigInt.one),
        createdAt: 123456,
        ihrFee: BigInt.one,
        forwardFee: BigInt.one,
        dest: TonAddress("0:${'2' * 64}")),
    body: beginCell().storeUint(0, 8).endCell());

final mockAddress = TonAddress("0:${'1' * 64}");

void _v5R1Actions() {
  const outActionSetIsPublicKeyEnabledTag = 0x04;
  const outActionAddExtensionTag = 0x02;
  const outActionRemoveExtensionTag = 0x03;
  test('Should serialise setIsPublicKeyEnabled action with true flag', () {
    const action = OutActionSetIsPublicKeyEnabled(true);

    final actual = beginCell().store(action).endCell();

    final expected = beginCell()
        .storeUint(outActionSetIsPublicKeyEnabledTag, 8)
        .storeBit(1)
        .endCell();

    expect(expected, actual);
    expect(expected.toBase64(), 'te6cckEBAQEABAAAAwTAorSwPA==');
  });
  test('Should serialise setIsPublicKeyEnabled action with false flag', () {
    const action = OutActionSetIsPublicKeyEnabled(false);

    final actual = beginCell().store(action).endCell();

    final expected = beginCell()
        .storeUint(outActionSetIsPublicKeyEnabledTag, 8)
        .storeBit(0)
        .endCell();

    expect(expected, actual);
    expect(expected.toBase64(), 'te6cckEBAQEABAAAAwRA2o9Gvg==');
  });
  test('Should serialise add extension action', () {
    final action = OutActionAddExtension(mockAddress);

    final actual = beginCell().store(action).endCell();

    final expected = beginCell()
        .storeUint(outActionAddExtensionTag, 8)
        .storeAddress(mockAddress)
        .endCell();
    expect(expected, actual);
    expect(expected.toBase64(),
        'te6cckEBAQEAJQAARQKAAiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIwCCDtAg==');
  });
  test('Should serialise remove extension action', () {
    final action = OutActionRemoveExtension(mockAddress);

    final actual = beginCell().store(action).endCell();

    final expected = beginCell()
        .storeUint(outActionRemoveExtensionTag, 8)
        .storeAddress(mockAddress)
        .endCell();
    expect(expected, actual);
    expect(expected.toBase64(),
        'te6cckEBAQEAJQAARQOAAiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIwK7YrIw==');
  });

  test('Should serialize extended out list', () {
    final List<OutActionWalletV5> v5Actions = [
      OutActionAddExtension(mockAddress),
      const OutActionSetIsPublicKeyEnabled(false),
      OutActionSendMsg(
          mode: SendMode.payGasSeparately.mode,
          outMessage: _mockMessageRelaxed1)
    ];
    final actions = OutActionsV5(actions: v5Actions);
    final actual = beginCell().store(actions).endCell();
    expect(actual.toBase64(),
        'te6cckEBBQEARgACRcCgAIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiMAQQCCg7DyG0BAgMAAAAcwAAAAAAAAAAAAAAAAAAAAwRAppFI0w==');
  });
  test('Should serialize extended out list and produce the expected boc', () {
    final List<OutActionWalletV5> v5Actions = [
      OutActionAddExtension(mockAddress),
      const OutActionSetIsPublicKeyEnabled(false),
      OutActionSendMsg(
          mode: SendMode.payGasSeparately.mode + SendMode.ignoreErrors.mode,
          outMessage: _mockMessageRelaxed1)
    ];
    final actions = OutActionsV5(actions: v5Actions);
    final actual = beginCell().store(actions).endCell();
    expect(actual.toBase64(),
        'te6cckEBBQEARgACRcCgAIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiMAQQCCg7DyG0DAgMAAAAcwAAAAAAAAAAAAAAAAAAAAwRAnAYhjw==');
  });
  test(
      'Should serialize extended out list and produce the expected boc for complex structures',
      () {
    final List<OutActionWalletV5> v5Actions = [
      OutActionAddExtension(mockAddress),
      const OutActionSetIsPublicKeyEnabled(false),
      OutActionRemoveExtension(mockAddress),
      OutActionSendMsg(
          mode: SendMode.payGasSeparately.mode + SendMode.ignoreErrors.mode,
          outMessage: _mockMessageRelaxed1),
      OutActionSendMsg(
          mode: SendMode.none.mode, outMessage: _mockMessageRelaxed2)
    ];
    final actions = OutActionsV5(actions: v5Actions);
    final actual = beginCell().store(actions).endCell();
    expect(actual.toBase64(),
        'te6cckEBCAEAqwACRcCgAIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiMAQYCCg7DyG0DAgUCCg7DyG0AAwQAAABoQgAREREREREREREREREREREREREREREREREREREREREREQgIQEQEAAAAAAAAwOQAB4kAAAAcwAAAAAAAAAAAAAAAAAABAwRABwBFA4ACIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIjA3zHHW');
  });
  test('Should deserialize extended out list', () {
    final List<OutActionWalletV5> v5Actions = [
      OutActionSendMsg(
          mode: SendMode.payGasSeparately.mode,
          outMessage: _mockMessageRelaxed1),
      OutActionAddExtension(mockAddress),
      const OutActionSetIsPublicKeyEnabled(true),
    ];
    final actions = OutActionsV5(actions: v5Actions);
    final actual = beginCell().store(actions).endCell();
    final boc = Cell.fromBase64(
        'te6cckEBBQEARgACRcCgAIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiIiMAQQCCg7DyG0BAgMAAAAcwAAAAAAAAAAAAAAAAAAAAwTA3qq+UQ==');
    expect(actual.toBase64(), boc.toBase64());
    final deserialize = OutActionsV5.deserialize(boc.beginParse());
    expect(deserialize.serialize().toBase64(), boc.toBase64());
  });
}
