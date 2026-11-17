import 'dart:convert';

import 'package:blockchain_utils/blockchain_utils.dart';

/// `TonQuickClient.sendBoc` returns the external-message hash as standard
/// base64. Explorers expect the hex form (base64 also contains `/`, which is
/// not URL-safe).
String txHash(String base64Hash) {
  return BytesUtils.toHexString(base64Decode(base64Hash));
}

String txExplorer(String base64Hash) {
  return 'https://testnet.tonviewer.com/transaction/${txHash(base64Hash)}';
}