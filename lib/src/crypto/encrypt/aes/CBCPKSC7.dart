import 'dart:typed_data';

import 'package:pascaldart/src/common/Util.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';

/// AES Encrypt/Decrypt using CBC block cipher and PKCS7 padding
class AesCbcPkcs7 {
  /// AES/CBC/PKCS7 Encrypt
  static Uint8List encrypt(Uint8List value, { Uint8List key, Uint8List iv }) {
    if (key == null) {
      key = Uint8List(1);
    }
    if (iv == null) {
      iv = Uint8List(1);
    }
    CipherParameters params = PaddedBlockCipherParameters(
        ParametersWithIV(KeyParameter(key), iv), null);
    BlockCipher encryptionCipher = new PaddedBlockCipher("AES/CBC/PKCS7");
    encryptionCipher.init(true, params);
    return encryptionCipher.process(value);    
  }

  /// AES?CBC/PKCS7 Decrypt
  static Uint8List decrypt(Uint8List encrypted, { Uint8List key, Uint8List iv }) {
    if (key == null) {
      key = Uint8List(1);
    }
    if (iv == null) {
      iv = Uint8List(1);
    }
    CipherParameters params = PaddedBlockCipherParameters(
        ParametersWithIV(KeyParameter(key), iv), null);
    BlockCipher decryptionCipher = new PaddedBlockCipher("AES/CBC/PKCS7");
    decryptionCipher.init(false, params);
    return decryptionCipher.process(encrypted);    
  }
}