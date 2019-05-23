import 'dart:typed_data';

import 'package:pascaldart/src/common/Util.dart';

class Int8 {
  static int decodeFromBytes(Uint8List bytes) {
    return Util.bytesToInt(bytes);
  }

  static Uint8List encodeToBytes(int inNum) {
    return Util.intToBytes(inNum);
  }
}