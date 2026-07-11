import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:test/test.dart';
import 'package:ton_dart/ton_dart.dart';

void main() {
  group('address', () {
    _testAddress();
    _frindlyForm();
    _equalAddresses();
  });
}

void _testAddress() {
  test('TonAddress', () {
    final address1 = TonAddressUtils.fromFriendlyAddress(
      '0QAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi4-QO',
    );
    final address2 = TonAddressUtils.fromFriendlyAddress(
      'kQAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi47nL',
    );
    final TonAddress address3 = TonAddress(
      '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3',
    );
    final TonAddress address4 = TonAddress(
      '-1:3333333333333333333333333333333333333333333333333333333333333333',
    );
    expect(
      TonAddress.deserializeIAddress(bytes: address3.encodeAsIAddress()),
      address3,
    );
    expect(
      TonAddress.deserializeIAddress(bytes: address4.encodeAsIAddress()),
      address4,
    );
    expect(address1.isBounceable, false);
    expect(address2.isBounceable, true);
    expect(address1.isTestOnly, true);
    expect(address2.isTestOnly, true);
    expect(address1.workchain, 0);
    expect(address2.workchain, 0);
    expect(address3.workchain.id, 0);
    expect(
      address1.hash,
      BytesUtils.fromHexString(
        '2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3',
      ),
    );
    expect(
      address2.hash,
      BytesUtils.fromHexString(
        '2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3',
      ),
    );
    expect(
      address3.hash,
      BytesUtils.fromHexString(
        '2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3',
      ),
    );
    expect(
      TonAddress.fromBytes(
        hash: address1.hash,
        config: TonAddressConfing.raw(TonWorkChain(address1.workchain)),
      ).toRawAddress(),
      '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3',
    );
    expect(
      TonAddress.fromBytes(
        hash: address2.hash,
        config: TonAddressConfing.raw(TonWorkChain(address2.workchain)),
      ).toRawAddress(),
      '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3',
    );
    expect(
      address3.toRawAddress(),
      '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3',
    );
    expect(address4.workchain.id, -1);
    expect(
      address4.hash,
      BytesUtils.fromHexString(
        '3333333333333333333333333333333333333333333333333333333333333333',
      ),
    );
  });
}

void _frindlyForm() {
  test('friendly form', () {
    final address = TonAddress(
      '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3',
    );
    expect(address.isFriendly, false);
    expect(
      TonAddress.deserializeIAddress(bytes: address.encodeAsIAddress()).address,
      '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3',
    );
    expect(address.toFriendly(bounceable: true).isFriendly, true);
    expect(
      address.toFriendly(bounceable: true, urlSafe: true).config.urlSafe,
      true,
    );
    expect(
      address.toFriendly(bounceable: true, urlSafe: false).config.urlSafe,
      false,
    );
    expect(
      (address
                  .toFriendly(bounceable: true, urlSafe: false, noPadding: true)
                  .config
              as TonAddressConfingFriendlyAddress)
          .noPadding,
      true,
    );
    expect(
      address.toFriendly(bounceable: true).address,
      'EQAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi4wJB',
    );
    expect(
      address.toFriendly(bounceable: true, testOnly: true).address,
      'kQAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi47nL',
    );
    expect(
      address.toFriendly(bounceable: true).address,
      'EQAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi4wJB',
    );
    expect(
      address.toFriendly(testOnly: true, bounceable: true).address,
      'kQAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi47nL',
    );

    // Non-Bounceable
    expect(
      address.toFriendly(bounceable: false).address,
      'UQAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi41-E',
    );
    expect(
      TonAddress.deserializeIAddress(
        bytes:
            address
                .toFriendly(bounceable: false, testOnly: true)
                .encodeAsIAddress(),
      ).address,
      '0QAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi4-QO',
    );
    expect(
      address.toFriendly(bounceable: false, testOnly: true).address,
      '0QAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi4-QO',
    );
    expect(
      address.toFriendly(bounceable: false).address,
      'UQAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi41-E',
    );
    expect(
      TonAddress.deserializeIAddress(
        bytes: address.toFriendly(bounceable: false).encodeAsIAddress(),
      ).address,
      'UQAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi41-E',
    );
    expect(
      address.toFriendly(bounceable: false, testOnly: true).address,
      '0QAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi4-QO',
    );
    expect(
      TonAddress.deserializeIAddress(
        bytes:
            address
                .toFriendly(bounceable: false, testOnly: true)
                .encodeAsIAddress(),
      ).address,
      '0QAs9VlT6S776tq3unJcP5Ogsj-ELLunLXuOb1EKcOQi4-QO',
    );
  });
}

void _equalAddresses() {
  test('equality', () {
    final address1 = TonAddress(
      '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3',
    );
    final address2 = TonAddress(
      '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3',
    );
    final address3 = TonAddress(
      '-1:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3',
    );
    final address4 = TonAddress(
      '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e5',
    );
    expect(address1.isFriendly, false);
    expect(address1, address2);
    expect(address2, address1);
    expect(address2 == address4, false);
    expect(address2 == address3, false);
    expect(address4 == address3, false);
  });
}
