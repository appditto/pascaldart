import 'dart:ffi';
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
    int sizeEncoded;
    Curve curve = curveCoder.decodeFromBytes(bytes);
    Uint8List key = bytes.sublist(2, bytes.length);
    ByteData bdView = ByteData.view(key.buffer);
    sizeEncoded = bdView.getInt16(0, Endian.little);// + bdView.getInt16(1, Endian.little);
    Uint8List pkDec = bytes.sublist(2, sizeEncoded + 2);
    return PrivateKey(pkDec.buffer.asUint16List(), curve);
  }

  /// Encode curve to bytes
  Uint8List encodeToBytes(PrivateKey privKey) {
    Uint16List key = privKey.key.buffer.asUint16List();
    Uint16List curveBytes = curveCoder.encodeToBytes(privKey.curve.id);
    String hex = Util.byteToHex(curveBytes.buffer.asUint8List());
    key.forEach((c) {
      hex = hex + c.toRadixString(16);
    });
    return Util.hexToBytes(hex);
  }

  String encodeToHex(PrivateKey privKey) {
    Uint16List key = privKey.key.buffer.asUint16List();
    Uint16List curveBytes = curveCoder.encodeToBytes(privKey.curve.id);
    String hex = Util.byteToHex(curveBytes.buffer.asUint8List());
    key.forEach((c) {
      hex = hex + c.toRadixString(16);
    });
    return hex;
  }
}