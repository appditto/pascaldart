import 'dart:typed_data';

import 'package:pascaldart/src/common/model/keys/Curves.dart';

// Represents a PascalCoin private key
class PrivateKey {
  Uint8List key;
  Curve curve;

  PrivateKey(this.key, this.curve) {
    if (this.key.lengthInBytes > this.curve.lPrivateKey()) {
      throw new Exception('Invalid private key length for ${this.curve.name} - expected <= ${this.key.lengthInBytes}, got ${this.key.length}');
    }
  }

  Uint8List ec() {
    return this.key;
  }
}