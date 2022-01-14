import 'dart:typed_data';
import 'package:pascaldart/src/common/coding/pascal/keys/curve_coder.dart';
import 'package:pascaldart/src/common/model/keys/curves.dart';
import 'package:pascaldart/src/common/model/keys/privatekey.dart';
import 'package:pascaldart/src/common/pascaldart_util.dart';

/// Pascal Private Key encoder/decoder
class PrivateKeyCoder {
  late CurveCoder curveCoder;
  int? encodedSize;

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
    return PDUtil.hexToBytes(encodeToHex(privKey));
  }

  String encodeToHex(PrivateKey privKey) {
    Uint8List curveBytes = curveCoder.encodeToBytes(privKey.curve.id!);
    String length =
        PDUtil.byteToHex(PDUtil.intToBytes(privKey.key.lengthInBytes))
            .padRight(4, '0');
    String hex =
        PDUtil.byteToHex(curveBytes) + length + PDUtil.byteToHex(privKey.key);
    return hex;
  }
}
