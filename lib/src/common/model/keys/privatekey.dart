import 'dart:typed_data';

import 'package:pascaldart/src/common/model/keys/curves.dart';

// Represents a PascalCoin private key
class PrivateKey {
  Uint8List key;
  Curve curve;

  PrivateKey(this.key, this.curve) {
    if (this.key.length > this.curve.lPrivateKey()!) {
      throw Exception(
          'Invalid private key length for ${this.curve.name} - expected <= ${this.curve.lPrivateKey()}, got ${this.key.length}');
    }
  }

  Uint8List ec() {
    return this.key;
  }
}
