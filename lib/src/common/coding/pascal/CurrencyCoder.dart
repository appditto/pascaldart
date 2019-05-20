import 'dart:typed_data';

import 'package:pascaldart/src/common/model/Currency.dart';

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
    Uint64List encoded = Uint64List(1);
    ByteData bd = ByteData.view(encoded.buffer);
    bd.setUint64(0, int.parse(amount.toMolina()), Endian.little);
    return Uint8List.fromList([bd.getUint8(0), bd.getUint8(1), bd.getUint8(2), bd.getUint8(3),
                               bd.getUint8(4), bd.getUint8(5), bd.getUint8(6), bd.getUint8(7)]);
  }
}
