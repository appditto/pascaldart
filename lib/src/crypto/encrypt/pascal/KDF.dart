
import 'dart:typed_data';

import 'package:pascaldart/src/common/Sha.dart';
import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/crypto/model/encrypt/KeyIV.dart';

/// Pascal key derivation function
class KDF {
  /// Gets the key and iv for pascalcoin.
  static KeyIV pascalCoin(String password, { Uint8List salt }) {
    Uint8List pwBytes = Util.stringToBytesUtf8(password);
    Uint8List saltBytes = salt == null ? Uint8List(1) : salt;

    // Key = sha256 (password + salt);
    Uint8List key = Sha.sha256([pwBytes, saltBytes]);
    // iv = sha256 (KEY + password + salt);
    Uint8List iv = Sha.sha256([key, pwBytes, saltBytes]);

    return KeyIV(key, iv);
  }
}