import 'dart:typed_data';
import 'package:pascaldart/src/common/coding/pascal/keys/CurveCoder.dart';
import 'package:pascaldart/src/common/model/keys/Curves.dart';
import 'package:pascaldart/src/common/model/keys/PublicKey.dart';
import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/common/Base58.dart';
import 'package:pascaldart/src/common/Sha.dart';

/// A pascal coin Public Key
class PublicKeyCoder {
  bool omitXYLengths;
  CurveCoder curveCoder;
  PublicKeyCoder({this.omitXYLengths = false}) {
    this.curveCoder = CurveCoder();
  }

  /// Decode public key from given bytes
  PublicKey decodeFromBytes(Uint8List bytes) {
    // First 2 bytes are curve
    Curve curve = curveCoder.decodeFromBytes(bytes);
    // Next 2 bytes indicate length of X
    int xPos = 4;
    int xl = Util.decodeLength(bytes.sublist(2, 4));
    // Next 2 bytes after xLength + xPos indicate y length
    int yl = Util.decodeLength(bytes.sublist(xPos + xl, xPos + xl + 2));
    int yPos = xPos + xl + 2;
    // Read x and y
    Uint8List x = bytes.sublist(xPos, xPos + xl);
    Uint8List y = bytes.sublist(yPos, yPos + yl);
    return PublicKey(x, y, curve);
  }

  /// Encode public key to bytes
  Uint8List encodeToBytes(PublicKey pubKey) {
    if (pubKey.curve.id == 0) {
      return Uint8List.fromList([0, 0, 0, 0, 0, 0]);
    }
    Uint8List curveBytes = curveCoder.encodeToBytes(pubKey.curve.id);
    String hex = Util.byteToHex(curveBytes) +
        pubKey.xlHex() +
        Util.byteToHex(pubKey.x) +
        pubKey.ylHex() +
        Util.byteToHex(pubKey.y);
    return Util.hexToBytes(hex);
  }

  // Get base58 representation of public key
  String encodeToBase58(PublicKey pubKey) {
    Uint8List prefix = Util.hexToBytes('01');
    Uint8List encoded = encodeToBytes(pubKey);
    Uint8List aux = Sha.sha256([encoded]);
    Uint8List suffix = aux.sublist(0, 4);
    Uint8List raw = Util.concat([prefix, encoded, suffix]);

    return Base58.encode(raw);
  }

  /// Gets a public key instance from the given base58 string.
  PublicKey decodeFromBase58(String base58) {
    Uint8List decoded = Base58.decode(base58);

    return this.decodeFromBytes(decoded.sublist(1, decoded.lengthInBytes - 4));
  }
}
