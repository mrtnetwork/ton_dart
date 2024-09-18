# TON Dart

Ton Dart is a versatile package tailored for seamless integration with TonApi and TonCenter RPC APIs. It empowers developers to effortlessly create, sign, and dispatch transactions while offering robust support for Boc Serialization.

Designed to streamline interactions with Ton wallets such as Basic wallets 1 to 4, Highload Wallet V3, and Jetton Wallet, Ton Dart ensures smooth communication and transaction management within the Ton network.

With Ton Dart, you can harness advanced cryptographic capabilities for secure transaction signing and verification, enhancing the integrity of your operations. Whether you're executing runtime calls or querying accounts, TonDart provides a comprehensive toolkit to handle various data formats and cryptographic operations effectively.

To leverage Ton Dart's capabilities optimally, familiarity with TonApi and TonCenter RPC APIs is recommended. Ton Dart simplifies complex tasks, making it an indispensable tool for developers navigating the Ton ecosystem.

## Futures

- **Transaction Management**
  - Create, sign, and verify transactions using ED25519.

- **JSON-RPC**
  - Communication with TonApi and TonCenter.

- **BOC serialization**
  - TON BOC serialization is a method for encoding and decoding data structures into a binary format within the Telegram Open Network.

- **Contract**
  - Provides support for Basic wallets 1 through 5.
  - Offers support for deploying tokens and transferring Jettons with Minter and Jetton wallets (Jetton, StableJetton).
  - Highload Wallet v3.
  - Support for MultiOwner contracts (MultiOwner, Order).
  - Support for NFTs contracts (NFTCollection, EditableCollection, NFTItem).

### Examples

  - [JettonMinter](https://github.com/mrtnetwork/ton_dart/tree/main/example/lib/examples/jetton/minter)
  - [JettonWallet](https://github.com/mrtnetwork/ton_dart/tree/main/example/lib/examples/jetton/minter)
  - [StableJettonMinter](https://github.com/mrtnetwork/ton_dart/tree/main/example/lib/examples/jetton/stable_minter)
  - [StableJettonWallet](https://github.com/mrtnetwork/ton_dart/tree/main/example/lib/examples/jetton/stable_minter)
  - [NFTs](https://github.com/mrtnetwork/ton_dart/tree/main/example/lib/examples/nft)
  - [MultiOwner](https://github.com/mrtnetwork/ton_dart/tree/main/example/lib/examples/wallet/multi_owner)
  - [Highload](https://github.com/mrtnetwork/ton_dart/tree/main/example/lib/examples/wallet/highload)
  - [VersionedWallets](https://github.com/mrtnetwork/ton_dart/tree/main/example/lib/examples/wallet/versioned_wallet)

- transfer

```dart
  /// TestWallet is a utility for quickly generating and testing wallet contracts from a specified version. 
  /// The code for this is available in the example folder.
  final TestWallet<WalletV5R1> wallet = TestWallet(version: WalletVersion.v5R1);

  final destination = TestWallet(version: WalletVersion.v1R1);
  final destination2 = TestWallet(version: WalletVersion.v1R2);
  final destination3 = TestWallet(version: WalletVersion.v1R3);
  final destination4 = TestWallet(version: WalletVersion.v2R1);
  final destination5 = TestWallet(version: WalletVersion.v2R2);
  final destination6 = TestWallet(version: WalletVersion.v3R1);
  final destination7 = TestWallet(version: WalletVersion.v3R2);
  final destination8 = TestWallet(version: WalletVersion.v4);
  final destination9 = TestWallet(version: WalletVersion.v5R1, index: 1);

  await wallet.wallet.sendTransfer(
      params:
          VersionedV5TransferParams.external(signer: wallet.signer, messages: [
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination.address,
                amount: TonHelper.toNano("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination2.address,
                amount: TonHelper.toNano("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination3.address,
                amount: TonHelper.toNano("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination4.address,
                amount: TonHelper.toNano("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination5.address,
                amount: TonHelper.toNano("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination6.address,
                amount: TonHelper.toNano("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination7.address,
                amount: TonHelper.toNano("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination8.address,
                amount: TonHelper.toNano("0.01"))),
        OutActionSendMsg(
            outMessage: TonHelper.internal(
                destination: destination9.address,
                amount: TonHelper.toNano("0.01"))),
      ]),
      rpc: wallet.rpc);


```

- Deploy Jetton minter and mint token

```dart
 final wallet = TestWallet<WalletV5R1>(version: WalletVersion.v5R1, index: 96);

  final metadata = JettonOnChainMetadata.snakeFormat(
      name: "MRT NETWORK",
      image: "https://avatars.githubusercontent.com/u/56779182?s=96&v=4",
      symbol: "MRT",
      decimals: 9,
      description: "https://github.com/mrtnetwork/ton_dart");

  final jetton = JettonMinter.create(
      owner: wallet.wallet,
      state: MinterWalletState(
        owner: wallet.address,
        chain: TonChain.testnet,
        metadata: metadata,
      ));

  await jetton.sendOperation(
      signerParams: VersionedV5TransferParams.external(signer: wallet.signer),
      rpc: wallet.rpc,
      amount: TonHelper.toNano("0.9"),
      operation: JettonMinterMint(
          totalTonAmount: TonHelper.toNano("0.5"),
          to: wallet.address,
          transfer: JettonMinterInternalTransfer(
              jettonAmount: TonHelper.toNano("100000"),
              forwardTonAmount: TonHelper.toNano("0.01")),
          jettonAmount: TonHelper.toNano("100000")));

```


### JSON-RPC

```dart

/// HTTPProvider class implements TonServiceProvider interface
/// for handling HTTP requests to TonApi and TonCenter.
class HTTPProvider implements TonServiceProvider {
  /// Constructor for HTTPProvider.
  HTTPProvider({
    required this.tonApiUrl,
    required this.tonCenterUrl,
    http.Client? client,
    this.defaultRequestTimeout = const Duration(seconds: 30),
  }) : client = client ?? http.Client();

  /// TonApi URL.
  final String? tonApiUrl;

  /// TonCenter URL.
  final String? tonCenterUrl;

  /// HTTP client.
  final http.Client client;

  /// Default request timeout.
  final Duration defaultRequestTimeout;

  @override
  Future<dynamic> get(TonRequestInfo params, [Duration? timeout]) async {
    /// Check examples file
    /// ...
  }

  @override
  Future<dynamic> post(TonRequestInfo params, [Duration? timeout]) async {
    /// Check examples file
    /// ...
  }
}


  /// Initialize TonProvider with HTTPProvider for Testnet
  final rpc = TonProvider(HTTPProvider(
    tonApiUrl: "https://testnet.tonapi.io",
    tonCenterUrl: "https://testnet.toncenter.com/api/v2/jsonRPC",
  ));

  /// Define TonAddress
  final address =
      TonAddress("Ef_GHcGwnw-bASoxTGQRMNwMQ6w9iCQnTqrv1REDfJ5fCYD2");

  /// Get balance of the address
  final balance =
      await rpc.request(TonCenterGetAddressBalance(address.toString()));

  /// Get account details
  final account = await rpc.request(TonApiGetAccount(address.toString()));

  /// Get transactions related to the address
  final transaction =
      rpc.request(TonCenterGetTransactions(address: address.toString()));

  /// ...


```

### Addresses and KeyManagment

```dart

  /// Define password for mnemonic generation
  const String password = "MRTNETWORK";

  /// Generate mnemonic from specified number of words and password
  final mnemonic =
      TonMnemonicGenerator().fromWordsNumber(24, password: password);

  /// Generate seed from mnemonic
  final seed = TonSeedGenerator(mnemonic)
      .generate(password: password, validateTonMnemonic: true);

  /// Derive private key from seed
  final privateKey = TonPrivateKey.fromBytes(seed);

  /// Derive public key from private key
  final publicKey = privateKey.toPublicKey();

  /// Create WalletV4 instance with derived public key
  final wallet = WalletV4(chain: TonChain.testnet, , publicKey: publicKey.toBytes());

  /// Get address from wallet
  final address = wallet.address;

  /// sign transaction
  final signature = privateKey.sign(digest);

```

## Resources

- Comprehensive Testing: All functionalities have been thoroughly tested, ensuring reliability and accuracy.

## Contributing

Contributions are welcome! Please follow these guidelines:

- Fork the repository and create a new branch.
- Make your changes and ensure tests pass.
- Submit a pull request with a detailed description of your changes.

## Feature requests and bugs

Please file feature requests and bugs in the issue tracker.
