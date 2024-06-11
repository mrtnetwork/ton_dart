import 'package:blockchain_utils/binary/binary.dart';
import 'package:blockchain_utils/binary/utils.dart';
import 'package:ton_dart/src/address/address/address.dart';
import 'package:test/test.dart';
import 'package:ton_dart/src/address/utils/utils.dart';

void main() {
  group("address", () {
    _testAddress();
    _frindlyForm();
    _equalAddresses();
  });
}

void _testAddress() {
  test("TonAddress", () {
    final address1 = TonAddressUtils.fromFriendlyAddress(
        "0QAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi4-QO");
    final address2 = TonAddressUtils.fromFriendlyAddress(
        'kQAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi47nL');
    final TonAddress address3 = TonAddress(
        '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3');
    final TonAddress address4 = TonAddress(
        '-1:3333333333333333333333333333333333333333333333333333333333333333');
    expect(address1.isBounceable, false);
    expect(address2.isBounceable, true);
    expect(address1.isTestOnly, true);
    expect(address2.isTestOnly, true);
    expect(address1.address.workChain, 0);
    expect(address2.address.workChain, 0);
    expect(address3.workChain, 0);
    expect(
        address1.address.hash,
        BytesUtils.fromHexString(
            '2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3'));
    expect(
        address2.address.hash,
        BytesUtils.fromHexString(
            '2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3'));
    expect(
        address3.hash,
        BytesUtils.fromHexString(
            '2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3'));
    expect(address1.address.toRawAddress(),
        "0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3");
    expect(address2.address.toRawAddress(),
        "0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3");
    expect(address3.toRawAddress(),
        "0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3");
    expect(address4.workChain, -1);
    expect(
        address4.hash,
        BytesUtils.fromHexString(
            "3333333333333333333333333333333333333333333333333333333333333333"));
  });
}

void _frindlyForm() {
  test("friendly form", () {
    final address = TonAddress(
        '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3');

    // Bounceable
    expect(
        address.toString(), "EQAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi4wJB");
    expect(address.toString(testOnly: true),
        "kQAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi47nL");
    expect(address.toString(urlSafe: false),
        "EQAs9VlT6S776tq3unJcP5Ogsj+ELLunLXuOb1EKcOQi4wJB");
    expect(address.toString(urlSafe: false, testOnly: true),
        "kQAs9VlT6S776tq3unJcP5Ogsj+ELLunLXuOb1EKcOQi47nL");

    // Non-Bounceable
    expect(address.toString(bounceable: false),
        "UQAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi41-E");
    expect(address.toString(bounceable: false, testOnly: true),
        "0QAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi4-QO");
    expect(address.toString(bounceable: false, urlSafe: false),
        "UQAs9VlT6S776tq3unJcP5Ogsj+ELLunLXuOb1EKcOQi41+E");
    expect(address.toString(bounceable: false, urlSafe: false, testOnly: true),
        "0QAs9VlT6S776tq3unJcP5Ogsj+ELLunLXuOb1EKcOQi4+QO");
  });
}

void _equalAddresses() {
  test("equality", () {
    final address1 = TonAddress(
        '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3');
    final address2 = TonAddress(
        '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3');
    final address3 = TonAddress(
        '-1:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3');
    final address4 = TonAddress(
        '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e5');
    expect(address1, address2);
    expect(address2, address1);
    expect(address2 == address4, false);
    expect(address2 == address3, false);
    expect(address4 == address3, false);
  });
}
