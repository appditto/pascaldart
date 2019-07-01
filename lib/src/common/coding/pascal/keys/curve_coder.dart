import 'dart:typed_data';

import 'package:pascaldart/src/common/coding/core/int16.dart';
import 'package:pascaldart/src/common/model/keys/curves.dart';

/// A special pascal type that can en/decode a curve id.
class CurveCoder {
  /// Decode curve from given bytes
  Curve decodeFromBytes(Uint8List bytes) {
    return Curve(Int16.decodeFromBytes(bytes));
  }

  /// Encode curve to bytes
  Uint8List encodeToBytes(int value) {
    return Int16.encodeToBytes(value);
  }
}
