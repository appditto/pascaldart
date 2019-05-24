import 'dart:typed_data';

import 'package:pascaldart/src/common/coding/core/Int16.dart';
import 'package:pascaldart/src/common/model/keys/Curves.dart';

/// A special pascal type that can en/decode a curve id.
class CurveCoder {

  /// Decode curve from given bytes
  Curve decodeFromBytes(Uint8List bytes) {
    return Curve(Int16.decodeFromBytes(bytes));
  }

  /// Encode curve to bytes
  Uint8List encodeToBytes(int value) {
    // There's a 6-byte empty value in raw operations for some reason
    if (value == 0) {
      return Uint8List.fromList([0, 0, 0, 0, 0, 0]);
    }
    return Int16.encodeToBytes(value);
  }
}
