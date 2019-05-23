import 'dart:typed_data';

import 'package:pascaldart/src/common/Util.dart';

/// A string where the preceeding bytes are a length
class StringWithLength {
  int byteSize;

  StringWithLength({this.byteSize = 2});

  String decodeFromBytes(Uint8List bytes) {
    int length;
    if (byteSize == 2) {
      length = int.parse(Util.switchEndian(Util.byteToHex(bytes.sublist(0, 2))), radix: 16);
    } else {
      length = Util.bytesToInt([bytes[0]]);
      this.byteSize = 1;
    }
    Uint8List nameBytes = bytes.sublist(byteSize, length+byteSize);
    return Util.bytesToUtf8String(nameBytes);
  }

  Uint8List encodeToBytes(String value) {
    int length = value.toString().length;
    String lengthHex = Util.byteToHex(Util.intToBytes(length)).padRight(byteSize == 2 ? 4 : 2, '0');
    return Util.hexToBytes(lengthHex + Util.byteToHex(Util.stringToBytesUtf8(value)));
  }
}