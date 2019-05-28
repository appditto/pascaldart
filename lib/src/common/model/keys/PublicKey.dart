import 'dart:typed_data';

import 'package:pascaldart/src/common/pascaldart_util.dart';
import 'package:pascaldart/src/common/model/keys/curves.dart';

/// Represents a pascal coin public key
class PublicKey {
  Uint8List x;
  Uint8List y;
  int xLength;
  int yLength;
  Curve curve;

  PublicKey(this.x, this.y, this.curve) {
    this.xLength = x.lengthInBytes;
    this.yLength = y.lengthInBytes;
    if (this.xLength > this.curve.xylPublicKey() || this.yLength > curve.xylPublicKey(getYLength: true)) {
      throw Exception('Invalid x and/or y length for curve ${this.curve.name} - ' +
          'expected <= X${curve.xylPublicKey()}:Y${curve.xylPublicKey(getYLength: true)}, ' +
          'got X${this.xLength}:Y${this.yLength}'
      );
    }
  }

  // Return empty public key instance
  PublicKey.empty() {
    this.x = Uint8List(0);
    this.y = Uint8List(0);
    this.curve = Curve(0);
  }

  String xlHex() {
    return PDUtil.byteToHex(PDUtil.intToBytes(xLength)).padRight(4, '0');
  }

  String ylHex() {
    return PDUtil.byteToHex(PDUtil.intToBytes(yLength)).padRight(4, '0');
  }

  /// Gets the ec key.
  Uint8List ec() {
    return PDUtil.concat([this.x, this.y]);
  }

  /// Gets ecdh key
  Uint8List ecdh() {
    if (this.curve.id == Curve.CI_SECP521R1) {
      return PDUtil.concat([PDUtil.hexToBytes('0400'), this.x, this.y]);
    }
    return PDUtil.concat([PDUtil.hexToBytes('04'), this.x, this.y]);
  }
}