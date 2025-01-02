import 'package:test/test.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/bit/builder.dart';
import 'package:ton_dart/src/models/models/common_message_info.dart';
import 'package:ton_dart/src/models/models/currency_collection.dart';

void main() {
  group('CommonMessageInfo', () => _test());
}

void _test() {
  test('CommonMessageInfoExternalIn', () {
    final msg = CommonMessageInfoExternalIn(
        dest: TonAddress(
            '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3'),
        importFee: BigInt.from(12));
    final cell = beginCell();
    msg.store(cell);
    final slice = cell.endCell();
    final decode = CommonMessageInfo.deserialize(slice.asSlice())
        as CommonMessageInfoExternalIn;
    expect(decode.dest.toRawAddress(),
        '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3');
    expect(decode.importFee, BigInt.from(12));
    expect(decode.src, null);
    final json = decode.toJson();
    CommonMessageInfo.fromJson(json);
  });
  test('CommonMessageInfoExternalout', () {
    final ext = ExternalAddress(BigInt.from(11111), 48);
    final msg = CommonMessageInfoExternalOut(
        dest: ext,
        createdAt: 12,
        createdLt: BigInt.parse('123123123123123'),
        src: TonAddress(
            '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3'));
    final cell = beginCell();
    msg.store(cell);
    final slice = cell.endCell();
    final decode = CommonMessageInfo.deserialize(slice.asSlice())
        as CommonMessageInfoExternalOut;
    expect(decode.src.toRawAddress(),
        '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3');
    expect(decode.createdAt, 12);
    expect(decode.dest?.value, BigInt.from(11111));
    expect(decode.createdLt, BigInt.parse('123123123123123'));
    final json = decode.toJson();
    CommonMessageInfo.fromJson(json);
  });
  test('CommonMessageInfoExternalIn_2', () {
    final ext = ExternalAddress(BigInt.from(11111), 48);
    final msg = CommonMessageInfoExternalIn(
        dest: TonAddress(
            '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3'),
        importFee: BigInt.from(12),
        src: ext);
    final cell = beginCell();
    msg.store(cell);
    final slice = cell.endCell();
    final decode = CommonMessageInfo.deserialize(slice.asSlice())
        as CommonMessageInfoExternalIn;
    expect(decode.dest.toRawAddress(),
        '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3');
    expect(decode.importFee, BigInt.from(12));
    expect(decode.src?.value, BigInt.from(11111));
    final json = decode.toJson();
    CommonMessageInfo.fromJson(json);
  });
  test('CommonMessageInfoInternal', () {
    final msg = CommonMessageInfoInternal(
        dest: TonAddress(
            '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3'),
        bounce: false,
        bounced: false,
        createdAt: 123123,
        createdLt: BigInt.from(1),
        forwardFee: BigInt.from(10000000),
        ihrDisabled: true,
        ihrFee: BigInt.from(100),
        src: TonAddress(
            '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3'),
        value: CurrencyCollection(coins: BigInt.from(12)));
    final cell = beginCell();
    msg.store(cell);
    final slice = cell.endCell();
    final decode = CommonMessageInfo.deserialize(slice.asSlice())
        as CommonMessageInfoInternal;
    expect(decode.dest.toRawAddress(),
        '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3');
    expect(decode.bounce, false);
    expect(decode.bounced, false);
    expect(decode.createdAt, 123123);
    expect(decode.createdLt, BigInt.from(1));
    expect(decode.forwardFee, BigInt.from(10000000));
    expect(decode.ihrDisabled, true);
    expect(decode.ihrFee, BigInt.from(100));
    expect(decode.src.toRawAddress(),
        '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3');
    expect(decode.value.coins, BigInt.from(12));
    final json = decode.toJson();
    CommonMessageInfo.fromJson(json);
  });
  test('CommonMessageInfoInternal_2', () {
    final Map<int, BigInt> other = {
      1: BigInt.one,
      2: BigInt.two,
      3: BigInt.from(3),
      100: BigInt.from(1000000)
    };
    final msg = CommonMessageInfoInternal(
        dest: TonAddress(
            '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3'),
        bounce: false,
        bounced: false,
        createdAt: 123123,
        createdLt: BigInt.from(1),
        forwardFee: BigInt.from(10000000),
        ihrDisabled: true,
        ihrFee: BigInt.from(100),
        src: TonAddress(
            '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3'),
        value: CurrencyCollection(coins: BigInt.from(12), other: other));
    final cell = beginCell();
    msg.store(cell);
    final slice = cell.endCell();
    final decode = CommonMessageInfo.deserialize(slice.asSlice())
        as CommonMessageInfoInternal;
    expect(decode.dest.toRawAddress(),
        '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3');
    expect(decode.bounce, false);
    expect(decode.bounced, false);
    expect(decode.createdAt, 123123);
    expect(decode.createdLt, BigInt.from(1));
    expect(decode.forwardFee, BigInt.from(10000000));
    expect(decode.ihrDisabled, true);
    expect(decode.ihrFee, BigInt.from(100));
    expect(decode.src.toRawAddress(),
        '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3');
    expect(decode.value.coins, BigInt.from(12));
    expect(decode.value.other, other);
    final json = decode.toJson();
    CommonMessageInfo.fromJson(json);
  });
}
