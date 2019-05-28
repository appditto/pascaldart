import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/export.dart';
import "package:pointycastle/src/impl/base_padding.dart";
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

/// transferred from ZeroBytePadding.java from bouncycastle
class ZeroBytePadding extends BasePadding {
  static final FactoryConfig FACTORY_CONFIG =
  StaticFactoryConfig(Padding, "ZeroByte", () => ZeroBytePadding());
  @override
  String get algorithmName => "ZeroByte";

  @override
  int padCount(Uint8List data) {
    int count = data.length;
    while (count > 0) {
      if (data[count - 1] != 0) {
        break;
      }
      count--;
    }
    return data.length - count;
  }

  @override
  int addPadding(Uint8List data, int offset) {
    int added = (data.length - offset);
    while (offset < data.length) {
      data[offset] = 0;
      offset++;
    }
    return added;
  }

  @override
  void init([CipherParameters params]) {

  }
}