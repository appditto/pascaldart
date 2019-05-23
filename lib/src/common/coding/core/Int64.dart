import 'dart:typed_data';

import 'package:pascaldart/src/common/Util.dart';

class Int64 {
  static BigInt decodeFromBytes(Uint8List bytes) {
    return Util.decodeBigInt(bytes, endian: Endian.little);
  }

  static Uint8List encodeToBytes(BigInt value) {
    Uint8List bigIntEncoded = Util.encodeBigInt(value, endian: Endian.little);
    // Right pad to 8-byte (64-bit integer)
    Uint8List rightPaddedEncoded = Uint8List(8);
    for (int i = 0; i < bigIntEncoded.lengthInBytes; i++) {
      rightPaddedEncoded[i] = bigIntEncoded[i];
    }
    for (int i = bigIntEncoded.lengthInBytes; i < 8; i++) {
      rightPaddedEncoded[i] = 0;
    }
    return rightPaddedEncoded;
  }
}