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
  - Provides support for Basic wallets 1 through 4.
  - Offers support for deploying tokens and transferring jettos with Minter and Jetton wallets.
  - Highload Wallet v3

### Examples

- Check [examples](https://github.com/mrtnetwork/ton_dart/tree/main/example/lib/examples) folder

#### Transfer TON

- transfer

```dart

    /// Initialize TonApiProvider with HTTPProvider for Testnet
  final rpc = TonApiProvider(HTTPProvider(
    tonApiUrl: "https://testnet.tonapi.io",
    tonCenterUrl: "https://testnet.toncenter.com/api/v2/jsonRPC",
  ));

  /// Define private key
  final privateKey = TonPrivateKey.fromBytes(List<int>.filled(32, 39));

  /// Create WalletV4 instance
  final wallet = WalletV4(
    workChain: -1,
    publicKey: privateKey.toPublicKey().toBytes(),
  );

  /// Define destination address
  final destination =
      TonAddress("Ef_GHcGwnw-bASoxTGQRMNwMQ6w9iCQnTqrv1REDfJ5fCYD2");

  /// Construct transfer message and send to the network
  await wallet.sendTransfer(
    messages: [
      wallet.createMessageInfo(
        amount: TonHelper.toNano("0.1"),
        destination: destination,
      )
    ],
    privateKey: privateKey,
    rpc: rpc,
  );


```

- Deploy Jetton minter and mint token

```dart

  /// Define owner wallet with WalletV4
  final ownerWallet = WalletV4(
    workChain: -1,
    publicKey: privateKey.toPublicKey().toBytes(),
  );

  /// Create JettonMinter with owner and content
  final minter = JettonMinter.create(
    owner: ownerWallet,
    content: "https://github.com/mrtnetwork",
  );

  /// Deploy JettonMinter contract (TOKEN)
  await minter.deploy(
    ownerPrivateKey: privateKey,
    rpc: rpc,
    amount: TonHelper.toNano("0.5"),
  );

  await Future.delayed(const Duration(seconds: 5));

  /// Define the address to which tokens will be minted
  final addressToMint =
      TonAddress("Ef__48F3wya3lEgIHRtpK8jPzYpQCIrfwZfFSEFmjaPQfC56");

  /// Define amounts
  final amount = TonHelper.toNano("0.5");
  final forwardAmount = TonHelper.toNano("0.3");
  final totalAmount = TonHelper.toNano("0.4");
  final jettonAmountForMint = BigInt.parse("1${"0" * 15}");

  /// Mint tokens
  await minter.mint(
    privateKey: privateKey,
    rpc: rpc,
    jettonAmout: jettonAmountForMint,
    forwardTonAmount: forwardAmount,
    totalTonAmount: totalAmount,
    amount: amount + totalAmount,
    to: addressToMint,
  );

```

- Transfer jetton

```dart
   /// Create JettonMinter to query jetton wallet address
  final minter = JettonMinter(
      owner: ownerWallet,
      address: TonAddress("Ef8ns7A4eSwJC1mJf72JDE9byKY9n_xxb1hhloly9heQi_rY"));

  /// Get the address of the Jetton Wallet
  final jettonWalletAddress = await minter.getWalletAddress(
    rpc: rpc,
    owner: ownerWallet.address,
  );

  /// Create JettonWallet instance from the address
  final jettonWallet = JettonWallet.fromAddress(
    jettonWalletAddress: jettonWalletAddress,
    owner: ownerWallet,
  );

  /// Get the balance of the Jetton Wallet
  final balance = await jettonWallet.getBalance(rpc);

  /// Define amounts
  final forwardTonAmount = TonHelper.toNano("0.1");
  final transferAmount = BigInt.from(1000000000);
  final BigInt amount = TonHelper.toNano("0.3");

  /// Transfer tokens from Jetton Wallet
  await jettonWallet.transfer(
    privateKey: privateKey,
    rpc: rpc,
    destination: destination,
    forwardTonAmount: forwardTonAmount,
    jettonAmount: transferAmount,
    amount: amount + forwardTonAmount,
  );
```

#### JSON-RPC

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


  /// Initialize TonApiProvider with HTTPProvider for Testnet
  final rpc = TonApiProvider(HTTPProvider(
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

#### Addresses and KeyManagment

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
  final wallet = WalletV4(workChain: -1, publicKey: publicKey.toBytes());

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
