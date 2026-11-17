# TON (ton_dart) testnet examples

All examples run against **TON testnet** on the **basechain** (`workchain = 0`),
using the shared `TestWallet` helper (`example/lib/examples/wallet/test_wallet.dart`).

## Setup

- Network: `TonChainId.testnet`
- Workchain: `TonWorkChain.basechain`
- RPC: `https://testnet.tonapi.io` (default `TonApiType.tonApi`)
- Wallet: `WalletV4`, seed `122` (BIP-32 ed25519 via `Bip32Slip10Ed25519`),
  index `0` = owner/sender, index `1` = receiver.
- The owner/sender address used for the live run:

```
kQAnuwtyUIvTOYAG2-CIuVYpjL5NHclMiXuzzBc16pdsJFM9
raw: 0:27bb0b72508bd3398006dbe088b956298cbe4d1dc94c897bb3cc1735ea976c24
```

The testnet faucet gives only a small amount per hour, so the account was funded
manually with 4 TON. Amounts in the examples are deliberately small.

## Examples

### 1. Simple TON transfer

```sh
cd example
dart run lib/examples/testnet/simple_transfer.dart
```

- Sends `0.01 TON` from index 0 to index 1.
- Checks the balance before/after and prints the external-message hash and
  Tonviewer link.

Live result:

```
balance before: 3.999999999 TON
tx: caf4575f1626ac343b1e937aa316f22c1b7303e79411e4789485bde345fc12e0
balance after:  3.989100129 TON
receiver:       0.01 TON
```

### 2. Jetton (token) deploy + mint + transfer

```sh
cd example
dart run lib/examples/testnet/jetton_transfer.dart
```

- Deploys a `JettonMinter` (on-chain snake metadata: `TDT`, 9 decimals) with the
  mint message's state-init.
- Mints `1000 TDT` to the owner.
- Transfers `100 TDT` to index 1.

Live result:

```
minter:   0:68286b9acb8daae5853270ac91a698d217f7d635efa080e2899c725cd400456e
mint tx:  de8705366c0ef2cde12a0f88c7f47843f2d0088ccba99cd530c760f2a8cfb356
owner jetton balance:   1000000000000
transfer tx: 65818aa113d2e3b0e53777298457c4b5fb8ec3ac37b90f345e9a990571a18b24
receiver jetton balance: 100000000000
```

On-chain `get_jetton_data` returned `total_supply = 1000000000000`,
`mintable = -1`, the owner admin address and the `TDT` metadata content.

### 3. NFT deploy + transfer

```sh
cd example
dart run lib/examples/testnet/nft_transfer.dart
```

- Deploys a collection-less NFT item (index 0, metadata URI
  `https://example.com/ton-dart-nft.json`) owned by index 0.
- Transfers the item to index 1.

Live result:

```
item:        0:b6d4332d920895a4a295252d0919ae35d28995e031fd4708c62fa0a0adcf8ea0
deploy tx:   0b0e6d1d695ce70ae1234994d177b6d1c2dd3e23602d9c85813eadbbfd861f87
transfer tx: beab1c3193a983da6f4147a51d0de100827a94234530132399985afe95725e33
owner after: 0:9a102449d7ab1143e54b3bc6a304eb062b907e566aa4dc56184116826eeb269b
```

On-chain `get_nft_data` returned `init = -1`, `index = 0`,
`collection_address = null` (collection-less) and the receiver as owner.

Note: rerunning the NFT example after the transfer fails because the wallet no
longer owns the item. That is expected for a deploy-and-transfer demo.

## Library issues found (not worked around in `lib/`)

1. **Contract factory addresses are mainnet-flagged on testnet.**
   `JettonMinter.create`, `NFTCollectionContract.create` and
   `NFTItemContract.create` build their address with
   `TonAddressConfing.friendly(owner.address.workchain)`, which defaults to
   `testOnly: false`. On testnet the derived friendly address starts with `EQ`
   instead of `kQ`:

   ```
   minter friendly:      EQB29e5a201hD74u9VYNznZq65C0DzmTB-AoydrEJmjfxhO_
   minter friendly test: kQB29e5a201hD74u9VYNznZq65C0DzmTB-AoydrEJmjfxqg1
   ```

   The raw address is correct, so RPC calls and the examples work, but any UI
   that prints the factory-derived friendly address shows a mainnet address.
   The factories do not accept a `chainId`/`testOnly` argument, so callers
   cannot correct it. Suggest deriving the flag from the owner wallet's
   `chainId` (or adding `chainId` to the factory).

2. **`sendBoc` returns the external-message hash, not the transaction hash.**
   `TonQuickClientApi.sendBoc` returns
   `Cell.fromBase64(boc).hash()` (the external-in message cell hash). Tonviewer
   accepts it (`https://testnet.tonviewer.com/transaction/<hash>` resolves to
   the transaction), but it is not the same as the transaction hash returned by
   TonAPI (`/v2/blockchain/accounts/.../transactions`). The examples print it
   as `tx`; it is the hash of the signed external message. The raw value is
   standard base64 and contains `/` and `+`, so it is **not URL-safe**: a
   direct explorer link built from the base64 value 404s for messages whose
   hash contains `/`. The examples convert it to hex in `tx.dart` before
   building the Tonviewer link. Suggest renaming / documenting the return as
   `external message hash` (or returning the transaction hash when the RPC
   provides one), and returning a URL-safe representation.

3. **`NFTItemTransfer` does not support `custom_payload`.**
   TEP-62 allows an optional `custom_payload` (first `Maybe ^Cell` after
   `response_destination`). The implementation always stores `0` for that bit
   and `deserialize` reads the bit without loading the referenced cell, so a
   transfer body with a custom payload cannot be parsed correctly. Not needed
   for a plain transfer, but it is an incomplete part of the operation.

4. **README examples are stale.**
   `README.md` uses `TonHelper.toNano(...)` (the current API is
   `TonHelper.toNanoGrams(...)`) and `MinterWalletState(chain:
   TonChain.testnet)` (no `chain` parameter exists). The checked-in example
   files use the current API.

## Notes

- No `lib/` or `blockchain_utils` changes were made.
- The testnet RPC and both `tonapi` and `toncenter` endpoints were reachable
  without a proxy.
- The examples use `DefaultTonQuickClient` (TonAPI) by default. `TestWallet`
  also accepts `rpcApiUse: TonApiType.tonCenter` if TonAPI is unavailable.