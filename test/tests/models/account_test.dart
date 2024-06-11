import 'package:test/test.dart';
import 'package:ton_dart/src/address/address.dart';
import 'package:ton_dart/src/boc/boc.dart';
import 'package:ton_dart/src/models/models.dart';

void main() {
  group("Account", () => _test());
}

void _test() {
  test("State init", () {
    final state = StateInit(
        splitDepth: 12,
        special: const TickTock(tick: false, tock: true),
        code: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0="),
        data: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0="),
        libraries: {
          BigInt.one: SimpleLibrary(
              public: false, root: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0=")),
          BigInt.two: SimpleLibrary(
              public: true, root: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0="))
        });
    final cell = beginCell();
    state.store(cell);
    final sp = cell.endCell();
    final decode = StateInit.deserialize(sp.asSlice());
    final json = StateInit.fromJson(decode.toJson());
    expect(json.splitDepth, 12);
    expect(json.special?.tick, false);
    expect(json.special?.tock, true);

    expect(json.code?.toBase64(), "te6cckEBAQEAAgAAAEysuc0=");
    expect(json.data?.toBase64(), "te6cckEBAQEAAgAAAEysuc0=");
    expect(json.libraries?[BigInt.one]?.public, false);
    expect(json.libraries?[BigInt.two]?.public, true);
  });
  test("State init_2", () {
    final obj = StateInit();
    final cell = beginCell();
    obj.store(cell);
    final sp = cell.endCell();
    final decode = StateInit.deserialize(sp.asSlice());
    final json = StateInit.fromJson(decode.toJson());
    expect(json.splitDepth, null);
    expect(json.special?.tick, null);
    expect(json.special?.tock, null);

    expect(json.code, null);
    expect(json.data, null);
    expect(json.libraries, null);
    expect(json.libraries, null);
  });
  test("account state", () {
    final state = StateInit(
        splitDepth: 31,
        code: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0="),
        libraries: {
          BigInt.parse("111123123123897192837981237971238979831273892"):
              SimpleLibrary(
                  public: false,
                  root: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0=")),
          BigInt.two: SimpleLibrary(
              public: true, root: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0="))
        });
    final AccountStateActive account = AccountStateActive(state);
    final cell = beginCell();
    account.store(cell);
    final sp = cell.endCell();

    final decode = AccountState.deserialize(sp.asSlice());

    final json = AccountStateActive.fromJson(decode.toJson());
    expect(json.state.splitDepth, 31);
    expect(json.state.special, null);

    expect(json.state.code?.toBase64(), "te6cckEBAQEAAgAAAEysuc0=");
    expect(json.state.data, null);
    expect(
        json
            .state
            .libraries?[
                BigInt.parse("111123123123897192837981237971238979831273892")]
            ?.public,
        false);
    expect(json.state.libraries?[BigInt.two]?.public, true);
  });

  test("account state_2", () {
    final stateHash = BigInt.parse(
        "12312903791827398127398719827398127389172389172893718927389712");
    final AccountStateFrozen account = AccountStateFrozen(stateHash);
    final cell = beginCell();
    account.store(cell);
    final sp = cell.endCell();

    final decode = AccountState.deserialize(sp.asSlice());
    final json = AccountState.fromJson(decode.toJson()) as AccountStateFrozen;
    expect(json.stateHash, stateHash);
  });
  test("account state_3", () {
    final AccountStateUninit account = AccountStateUninit();
    final cell = beginCell();
    account.store(cell);
    final sp = cell.endCell();

    final decode = AccountState.deserialize(sp.asSlice());
    expect(decode.type, AccountStateType.uninit);
  });

  test("account storage", () {
    final state = StateInit(
        splitDepth: 12,
        special: const TickTock(tick: false, tock: true),
        code: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0="),
        data: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0="),
        libraries: {
          BigInt.one: SimpleLibrary(
              public: false, root: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0=")),
          BigInt.two: SimpleLibrary(
              public: true, root: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0="))
        });
    final accountState = AccountStateActive(state);
    final account = AccountStorage(
        lastTransLt: BigInt.from(888888),
        balance: CurrencyCollection(coins: BigInt.from(99999999), other: {
          1: BigInt.parse("11112312378912379127398123798"),
          7: BigInt.zero
        }),
        state: accountState);

    final cell = beginCell();
    account.store(cell);
    final sp = cell.endCell();
    final decode = AccountStorage.deserialize(sp.asSlice());
    final json = AccountStorage.fromJson(decode.toJson());
    final currentState = (json.state as AccountStateActive).state;
    expect(currentState.splitDepth, 12);
    expect(currentState.special?.tick, false);
    expect(currentState.special?.tock, true);
    expect(currentState.code?.toBase64(), "te6cckEBAQEAAgAAAEysuc0=");
    expect(currentState.data?.toBase64(), "te6cckEBAQEAAgAAAEysuc0=");
    expect(currentState.libraries?[BigInt.one]?.public, false);
    expect(currentState.libraries?[BigInt.two]?.public, true);
    expect(json.lastTransLt, BigInt.from(888888));
    expect(json.balance.coins, BigInt.from(99999999));
    expect(
        json.balance.other?[1], BigInt.parse("11112312378912379127398123798"));
    expect(json.balance.other?[7], BigInt.zero);
  });
  test("account", () {
    final state = StateInit(
        splitDepth: 12,
        code: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0="),
        data: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0="),
        libraries: {
          BigInt.one: SimpleLibrary(
              public: false, root: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0=")),
          BigInt.two: SimpleLibrary(
              public: true, root: Cell.fromBase64("te6cckEBAQEAAgAAAEysuc0="))
        });
    final accountState = AccountStateActive(state);
    final accountStorage = AccountStorage(
        lastTransLt: BigInt.from(888888),
        balance: CurrencyCollection(coins: BigInt.from(99999999), other: {
          1: BigInt.parse("11112312378912379127398123798"),
          7: BigInt.zero
        }),
        state: accountState);
    final account = TonAccount(
        addr: TonAddress(
            '0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3'),
        storageStats: StorageInfo(
            used: StorageUsed(
                cells: BigInt.from(999),
                bits: BigInt.from(777),
                publicCells: BigInt.from(122)),
            lastPaid: 12,
            duePayment: BigInt.from(100)),
        storage: accountStorage);
    final cell = beginCell();
    account.store(cell);
    final sp = cell.endCell();
    final decode = TonAccount.deserialize(sp.asSlice());
    final json = TonAccount.fromJson(decode.toJson());
    final currentState = (json.storage.state as AccountStateActive).state;
    expect(currentState.splitDepth, 12);
    expect(currentState.special, null);
    expect(currentState.code?.toBase64(), "te6cckEBAQEAAgAAAEysuc0=");
    expect(currentState.data?.toBase64(), "te6cckEBAQEAAgAAAEysuc0=");
    expect(currentState.libraries?[BigInt.one]?.public, false);
    expect(currentState.libraries?[BigInt.two]?.public, true);
    expect(json.storage.lastTransLt, BigInt.from(888888));
    expect(json.storage.balance.coins, BigInt.from(99999999));
    expect(json.storage.balance.other?[1],
        BigInt.parse("11112312378912379127398123798"));
    expect(json.storage.balance.other?[7], BigInt.zero);
    expect(json.addr.toRawAddress(),
        "0:2cf55953e92efbeadab7ba725c3f93a0b23f842cbba72d7b8e6f510a70e422e3");
    expect(json.storageStats.used.bits, BigInt.from(777));
    expect(json.storageStats.used.cells, BigInt.from(999));
    expect(json.storageStats.used.publicCells, BigInt.from(122));
    expect(json.storageStats.duePayment, BigInt.from(100));
    expect(json.storageStats.lastPaid, 12);
  });
}
