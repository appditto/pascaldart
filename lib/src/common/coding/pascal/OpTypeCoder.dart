import 'dart:typed_data';

import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/common/coding/core/Int16.dart';
import 'package:pascaldart/src/common/coding/core/Int32.dart';
import 'package:pascaldart/src/common/coding/core/Int8.dart';

class OpTypeCoder {
  int byteSize;

  OpTypeCoder(this.byteSize) {
    if (![1, 2, 4].contains(this.byteSize)) {
      throw Exception('Invalid bytesize $byteSize');
    }
  }

  int decodeFromBytes(Uint8List bytes) {
    if (byteSize == 1) {
      return Int8.decodeFromBytes(bytes);
    }
    int opType = byteSize == 2 ? Int16.decodeFromBytes(bytes) : Int32.decodeFromBytes(bytes);
    return opType;
  }

  Uint8List encodeToBytes(int opType) {
    if (byteSize == 1) {
      return Int8.encodeToBytes(opType);
    } else if (byteSize == 2) {
      return Int16.encodeToBytes(opType);
    }
    return Int32.encodeToBytes(opType);
  }
}