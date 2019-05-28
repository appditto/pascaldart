import 'dart:typed_data';

import 'package:pascaldart/src/common/pascaldart_util.dart';

class Int8 {
  static int decodeFromBytes(Uint8List bytes) {
    return PDUtil.bytesToInt(bytes);
  }

  static Uint8List encodeToBytes(int inNum) {
    return PDUtil.intToBytes(inNum);
  }
}