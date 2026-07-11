// ignore_for_file: avoid_print

import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:example/examples/http.dart';
import 'package:ton_dart/ton_dart.dart';

class TestWallet<T extends VersionedWalletContract> {
  final T wallet;
  final TonPrivateKey signer;
  final TonProvider rpc;
  final String? name;
  final TonChainId chainId;
  const TestWallet._(
      {required this.wallet,
      required this.signer,
      required this.rpc,
      this.name,
      required this.chainId});
  TonAddress get address => wallet.address;
  TonAddress getAddress({bool bounceableAddress = true}) {
    return TonAddress(
        wallet.address.toFriendly(bounceable: bounceableAddress).address);
  }

  @override
  String toString() {
    final toJson = {
      "address": address
          .toFriendly(
              testOnly: chainId == TonChainId.testnet ? true : false,
              bounceable: true)
          .address,
      "privateKey": signer.toHex(),
      "publickKey": signer.toPublicKey().toHex(),
      "version": wallet.type.name,
    };
    if (name != null) {
      return "$name$toJson";
    }
    return "$toJson";
  }

  factory TestWallet(
      {required WalletVersion version,
      TonChainId chainId = TonChainId.testnet,
      TonWorkChain workchain = TonWorkChain.basechain,
      int index = 0,
      bool bounceableAddress = false,
      String tonApiUrl = "https://testnet.tonapi.io",
      String tonCenterUrl = "https://testnet.toncenter.com",
      TonApiType rpcApiUse = TonApiType.tonApi,
      String? name,
      bool log = true}) {
    final rpc = TonProvider(
        HTTPProvider(
            tonApiUrl: tonApiUrl, tonCenterUrl: tonCenterUrl, api: rpcApiUse),
        rpcApiUse);
    final hdWallet = Bip32Slip10Ed25519.fromSeed(List<int>.filled(32, 122))
        .childKey(Bip32KeyIndex.hardenIndex(index));
    // final hdWallet = Bip32Slip10Ed25519.fromSeed(List<int>.filled(32, 56))
    //     .childKey(Bip32KeyIndex.hardenIndex(index));
    final privateKey = TonPrivateKey.fromBytes(hdWallet.privateKey.raw);
    final List<int> publicKey = privateKey.toPublicKey().toBytes();
    VersionedWalletContract contract;
    switch (version) {
      case WalletVersion.v1R1:
        contract = WalletV1R1.create(
            workchain: workchain,
            chainId: chainId,
            publicKey: publicKey,
            bounceableAddress: bounceableAddress);
        break;
      case WalletVersion.v1R2:
        contract = WalletV1R2.create(
            workchain: workchain,
            publicKey: publicKey,
            chainId: chainId,
            bounceableAddress: bounceableAddress);
        break;
      case WalletVersion.v1R3:
        contract = WalletV1R3.create(
            workchain: workchain,
            publicKey: publicKey,
            chainId: chainId,
            bounceableAddress: bounceableAddress);
        break;
      case WalletVersion.v2R1:
        contract = WalletV2R1.create(
            workchain: workchain,
            publicKey: publicKey,
            chainId: chainId,
            bounceableAddress: bounceableAddress);
        break;
      case WalletVersion.v2R2:
        contract = WalletV2R2.create(
            workchain: workchain,
            publicKey: publicKey,
            chainId: chainId,
            bounceableAddress: bounceableAddress);
        break;
      case WalletVersion.v3R1:
        contract = WalletV3R1.create(
            workchain: workchain,
            publicKey: publicKey,
            chainId: chainId,
            bounceableAddress: bounceableAddress);
        break;
      case WalletVersion.v3R2:
        contract = WalletV3R2.create(
            workchain: workchain,
            publicKey: publicKey,
            chainId: chainId,
            bounceableAddress: bounceableAddress);
        break;
      case WalletVersion.v4:
        contract = WalletV4.create(
            workchain: workchain,
            chainId: chainId,
            publicKey: publicKey,
            bounceableAddress: bounceableAddress);
        break;
      case WalletVersion.v5R1:
        contract = WalletV5R1.create(
            workchain: workchain,
            chainId: chainId,
            publicKey: publicKey,
            bounceableAddress: bounceableAddress,
            context: V5R1ClientContext(
                subwalletNumber: 0, chainId: chainId, workchain: workchain));
        break;
    }
    if (contract is! T) {
      throw TypeError();
    }
    final wallet = TestWallet._(
        signer: privateKey,
        wallet: contract,
        rpc: rpc,
        name: name,
        chainId: chainId);
    if (log) {
      print(wallet);
    }
    return wallet;
  }
}

class TestWalletHighLoadWallet {
  final HighloadWalletV3 wallet;
  final TonPrivateKey signer;
  final TonProvider rpc;
  final String? name;
  final TonChainId chainId;
  const TestWalletHighLoadWallet._(
      {required this.wallet,
      required this.signer,
      required this.rpc,
      this.name,
      required this.chainId});
  TonAddress get address => wallet.address;
  TonAddress getAddress({bool bounceableAddress = true}) {
    return TonAddress(
        wallet.address.toFriendly(bounceable: bounceableAddress).address);
  }

  @override
  String toString() {
    final toJson = {
      "address": address
          .toFriendly(
              testOnly: chainId == TonChainId.testnet ? true : false,
              bounceable: true)
          .address,
      "rawAddress": address.toRawAddress(),
      "privateKey": signer.toHex(),
      "publickKey": signer.toPublicKey().toHex(),
    };
    if (name != null) {
      return "$name$toJson";
    }
    return "$toJson";
  }

  factory TestWalletHighLoadWallet(
      {TonChainId chainId = TonChainId.testnet,
      TonWorkChain workchain = TonWorkChain.basechain,
      int index = 0,
      bool bounceableAddress = false,
      String tonApiUrl = "https://testnet.tonapi.io",
      String tonCenterUrl = "https://testnet.toncenter.com",
      TonApiType rpcApiUse = TonApiType.tonApi,
      String? name,
      bool log = true}) {
    final rpc = TonProvider(
        HTTPProvider(
            tonApiUrl: tonApiUrl, tonCenterUrl: tonCenterUrl, api: rpcApiUse),
        rpcApiUse);
    final hdWallet = Bip32Slip10Ed25519.fromSeed(List<int>.filled(32, 25))
        .childKey(Bip32KeyIndex.hardenIndex(index));
    final privateKey = TonPrivateKey.fromBytes(hdWallet.privateKey.raw);
    final List<int> publicKey = privateKey.toPublicKey().toBytes();
    final wallet = TestWalletHighLoadWallet._(
        signer: privateKey,
        wallet:
            HighloadWalletV3.create(workchain: workchain, publicKey: publicKey),
        rpc: rpc,
        chainId: chainId,
        name: name);
    if (log) {
      print(wallet);
    }
    return wallet;
  }
}

class TestWalletMultiOwner {
  final MultiOwnerContract wallet;
  final List<WalletV5R1> signerWalletes;
  final WalletV4 proposer;
  final TonPrivateKey proposerKey;
  final List<TonPrivateKey> signers;
  TonPrivateKey get ownerKey => signers[0];
  final int thereshHold;
  final TonProvider rpc;
  final String? name;
  final TonChainId chainId;
  final TonWorkChain workchainn;
  const TestWalletMultiOwner._(
      {required this.wallet,
      required this.proposerKey,
      required this.signerWalletes,
      required this.signers,
      required this.proposer,
      required this.rpc,
      required this.thereshHold,
      required this.workchainn,
      required this.chainId,
      this.name});
  TonAddress get address => wallet.address;
  TonAddress getAddress({bool bounceableAddress = true}) {
    return TonAddress(
        wallet.address.toFriendly(bounceable: bounceableAddress).address);
  }

  @override
  String toString() {
    final toJson = {
      "address": address
          .toFriendly(
              testOnly: chainId == TonChainId.testnet ? true : false,
              bounceable: true)
          .address,
      "rawAddress": address.toRawAddress(),
      "signerWallets": signerWalletes.map((e) => e.address).toList(),
      "proposer": proposer.address
    };
    if (name != null) {
      return "$name$toJson";
    }
    return "$toJson";
  }

  factory TestWalletMultiOwner(
      {TonChainId chainId = TonChainId.testnet,
      TonWorkChain workchain = TonWorkChain.basechain,
      int startIndex = 0,
      int proposIndex = 144,
      int threshHold = 2,
      bool bounceableAddress = false,
      String tonApiUrl = "https://testnet.tonapi.io",
      String tonCenterUrl = "https://testnet.toncenter.com",
      TonApiType rpcApiUse = TonApiType.tonApi,
      String? name,
      bool log = true}) {
    final rpc = TonProvider(
        HTTPProvider(
            tonApiUrl: tonApiUrl, tonCenterUrl: tonCenterUrl, api: rpcApiUse),
        rpcApiUse);
    final masterWallet = Bip32Slip10Ed25519.fromSeed(List<int>.filled(32, 25));
    final proposerHdWallet =
        Bip32Slip10Ed25519.fromSeed(List<int>.filled(32, 25))
            .childKey(Bip32KeyIndex.hardenIndex(proposIndex));
    final proposerPrivateKey =
        TonPrivateKey.fromBytes(proposerHdWallet.privateKey.raw);
    final proposer = WalletV4.create(
        publicKey: proposerPrivateKey.toPublicKey().toBytes(),
        workchain: workchain);
    List<WalletV5R1> signersWallet = [];
    final List<TonPrivateKey> signers = [];
    for (int i = 0; i < threshHold; i++) {
      final hdWallet = masterWallet.childKey(Bip32KeyIndex.hardenIndex(i));
      final privateKey = TonPrivateKey.fromBytes(hdWallet.privateKey.raw);

      final List<int> publicKey = privateKey.toPublicKey().toBytes();
      final walletV5 = WalletV5R1.create(
          context: V5R1CustomContext(
            context: startIndex,
            chainId: chainId,
          ),
          publicKey: publicKey);
      signersWallet.add(walletV5);
      signers.add(privateKey);
    }
    final multiOwner = MultiOwnerContract.create(
        workchain: workchain,
        owner: signersWallet[0],
        threshold: threshHold,
        signers: signersWallet.map((e) => e.address).toList(),
        proposers: [proposer.address],
        allowArbitrarySeqno: false);
    final wallet = TestWalletMultiOwner._(
        wallet: multiOwner,
        proposerKey: proposerPrivateKey,
        signerWalletes: signersWallet,
        signers: signers,
        chainId: chainId,
        workchainn: workchain,
        proposer: proposer,
        rpc: rpc,
        thereshHold: threshHold,
        name: name);
    if (log) {
      print(wallet);
    }
    return wallet;
  }
}
