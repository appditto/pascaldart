import 'dart:typed_data';
import 'package:pascaldart/src/common/coding/pascal/keys/CurveCoder.dart';
import 'package:pascaldart/src/common/model/keys/Curves.dart';
import 'package:pascaldart/src/common/model/keys/PrivateKey.dart';
import 'package:pascaldart/src/common/Util.dart';

/// Pascal Private Key encoder/decoder
class PrivateKeyCoder {
  CurveCoder curveCoder;
  int encodedSize;

  PrivateKeyCoder() {
    curveCoder = CurveCoder();
  }

  /// Decode private key from given bytes
  PrivateKey decodeFromBytes(Uint8List bytes) {
    Curve curve = curveCoder.decodeFromBytes(bytes);
    Uint8List pkDec = bytes.sublist(4, bytes.length);
    return PrivateKey(pkDec, curve);
  }

  /// Encode curve to bytes
  Uint8List encodeToBytes(PrivateKey privKey) {
    return Util.hexToBytes(encodeToHex(privKey));
  }

  String encodeToHex(PrivateKey privKey) {
    Uint8List curveBytes = curveCoder.encodeToBytes(privKey.curve.id);
    String length = Util.byteToHex(Util.intToBytes(privKey.key.lengthInBytes)).padRight(4, '0');
    String hex = Util.byteToHex(curveBytes) + length + Util.byteToHex(privKey.key);
    return hex;
  }
}