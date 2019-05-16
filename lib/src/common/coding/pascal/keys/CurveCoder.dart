import 'dart:typed_data';

import 'package:pascaldart/src/common/model/keys/Curves.dart';

/// A special pascal type that can en/decode a curve id.
class CurveCoder {

  /// Decode curve from given bytes
  Curve decodeFromBytes(Uint8List bytes) {
    Uint16List bytesU16 = Uint16List.fromList(bytes);
    ByteData bdView = ByteData.view(bytesU16.buffer);
    return Curve(bdView.getInt16(0, Endian.little) + bdView.getInt16(1, Endian.little));
  }

  /// Encode curve to bytes
  Uint16List encodeToBytes(int value) {
    Uint16List encoded = Uint16List(1);
    ByteData bd = ByteData.view(encoded.buffer);
    bd.setInt16(0, value, Endian.little);
    return Uint16List.fromList([bd.getUint16(0, Endian.little)]);
  }
}
