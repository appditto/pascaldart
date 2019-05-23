import 'dart:math';
import 'dart:typed_data';

import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/common/coding/pascal/keys/PrivateKeyCoder.dart';
import 'package:pascaldart/src/common/model/keys/PrivateKey.dart';
import 'package:pascaldart/src/crypto/encrypt/aes/CBCPKSC7.dart';
import 'package:pascaldart/src/crypto/encrypt/pascal/KDF.dart';
import 'package:pascaldart/src/crypto/model/encrypt/KeyIV.dart';

/// Crypter for pascal coin private keys
class PrivateKeyCrypt {
  /// Decrypts a private key
  static PrivateKey decrypt(Uint8List value, String password) {
    Uint8List salt = value.sublist(8, 16);
    KeyIV key = KDF.pascalCoin(password, salt: salt);

    // Decrypt
    Uint8List encData = value.sublist(16);

    Uint8List privateKeyDecryptedAndEncoded = AesCbcPkcs7.decrypt(encData, key: key.key, iv: key.iv);

    return PrivateKeyCoder().decodeFromBytes(privateKeyDecryptedAndEncoded);
  }

  /// Encrypts a private key
  static Uint8List encrypt(PrivateKey privateKey, String password) {
    Uint8List privateKeyEncoded = PrivateKeyCoder().encodeToBytes(privateKey);

    Random randomGenerator = Random.secure();
    Uint8List salt = Uint8List(8);
    for (int i = 0; i < 8; i++) {
      salt[i] = randomGenerator.nextInt(255);
    }

    KeyIV keyInfo = KDF.pascalCoin(password, salt: salt);

    Uint8List privateKeyEncrypted = AesCbcPkcs7.encrypt(privateKeyEncoded, key: keyInfo.key, iv: keyInfo.iv);

    return Util.concat([Util.stringToBytesUtf8("Salted__"), salt, privateKeyEncrypted]);
  }
}