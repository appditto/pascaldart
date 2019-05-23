import 'dart:typed_data';

import 'package:pascaldart/src/common/coding/core/Int64.dart';
import 'package:pascaldart/src/common/model/Currency.dart';
import 'package:pascaldart/src/common/Util.dart';

/// A special pascal type that can en/decode an amount
class CurrencyCoder {
  /// Decode account number from given bytes
  Currency decodeFromBytes(Uint8List bytes) {
    String molinaStr = Int64.decodeFromBytes(bytes).toRadixString(10);
    return Currency.fromMolina(molinaStr);
  }

  /// Encode an amount to bytes
  Uint8List encodeToBytes(Currency amount) {
    return Int64.encodeToBytes(BigInt.parse(amount.toMolina()));
  }
}
