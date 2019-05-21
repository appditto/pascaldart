import 'dart:typed_data';

import 'package:pascaldart/src/common/model/Currency.dart';
import 'package:pascaldart/src/common/Util.dart';

/// A special pascal type that can en/decode an amount
class CurrencyCoder {
  /// Decode account number from given bytes
  Currency decodeFromBytes(Uint8List bytes) {
    ByteData bd = bytes.buffer.asByteData();
    String molinaStr = bd.getUint64(0, Endian.little).toRadixString(10);
    return Currency.fromMolina(molinaStr);
  }

  /// Encode an amount to bytes
  Uint8List encodeToBytes(Currency amount) {
    Uint8List bigIntEncoded = Util.encodeBigInt(BigInt.parse(amount.toMolina()));
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
