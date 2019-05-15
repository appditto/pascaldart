import 'dart:typed_data';

import 'package:pascaldart/src/common/model/keys/Curves.dart';

// Represents a PascalCoin private key
class PrivateKey {
  Uint8List key;
  Curve curve;

  PrivateKey(this.key, { this.curve }) {
    // Try to assume curve based on length
    if (this.curve == null) {
      this.curve = Curve.guessCurveBasedOnPrivateKey(key);
      if (this.curve == null) {
        throw Exception('Could not determine curve for private key');
      }
    }
    if (this.key.lengthInBytes > this.curve.lPrivateKey()) {
      throw new Exception('Invalid private key length for ${this.curve.name} - expected <= ${this.key.lengthInBytes}, got ${this.key.length}');
    }
  }

  Uint8List ec() {
    return this.key;
  }
}