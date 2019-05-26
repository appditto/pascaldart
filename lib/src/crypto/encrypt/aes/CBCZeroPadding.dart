import 'dart:typed_data';

import 'package:pascaldart/src/crypto/encrypt/aes/ZeroBytePadding.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/src/registry/registry.dart';

/// AES Encrypt/Decrypt using CBC block cipher and no padding
class AesCbcZeroPadding {
  /// AES/CBC/ZeroByte Encrypt
  static Uint8List encrypt(Uint8List value, { Uint8List key, Uint8List iv }) {
    registry.register(ZeroBytePadding.FACTORY_CONFIG);
    if (key == null) {
      key = Uint8List(1);
    }
    if (iv == null) {
      iv = Uint8List(1);
    }
    CipherParameters params = PaddedBlockCipherParameters(
        ParametersWithIV(KeyParameter(key), iv), null);
    BlockCipher encryptionCipher = PaddedBlockCipher("AES/CBC/ZeroByte");
    encryptionCipher.init(true, params);
    return encryptionCipher.process(value);    
  }

  /// AES/CBC/ZeroByte Decrypt
  static Uint8List decrypt(Uint8List encrypted, { Uint8List key, Uint8List iv }) {
    registry.register(ZeroBytePadding.FACTORY_CONFIG);
    if (key == null) {
      key = Uint8List(1);
    }
    if (iv == null) {
      iv = Uint8List(1);
    }
    CipherParameters params = PaddedBlockCipherParameters(
        ParametersWithIV(KeyParameter(key), iv), null);
    BlockCipher decryptionCipher = PaddedBlockCipher("AES/CBC/ZeroByte");
    decryptionCipher.init(false, params);
    return decryptionCipher.process(encrypted);    
  }
}