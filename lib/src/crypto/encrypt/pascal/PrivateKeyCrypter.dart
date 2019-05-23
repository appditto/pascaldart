import 'dart:typed_data';

import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/common/coding/pascal/keys/PrivateKeyCoder.dart';
import 'package:pascaldart/src/common/model/keys/PrivateKey.dart';
import 'package:pascaldart/src/crypto/encrypt/aes/CBCPKSC7.dart';
import 'package:pascaldart/src/crypto/encrypt/pascal/KDF.dart';
import 'package:pascaldart/src/crypto/model/encrypt/KeyIV.dart';

/// Crypter for pascal coin private keys
class PrivateKeyCrypter {
  /// Creates a new keypair from the given private key.
  static PrivateKey decrypt(Uint8List value, String password) {
    Uint8List salt = value.sublist(8, 16);
    KeyIV key = KDF.pascalCoin(password, salt: Util.byteToHex(salt));

    // Decrypt
    Uint8List encData = value.sublist(16);

    Uint8List privateKeyDecryptedAndEncoded = AesCbcPkcs7.decrypt(encData, key: key.key, iv: key.iv);

    return PrivateKeyCoder().decodeFromBytes(privateKeyDecryptedAndEncoded);
  }
}