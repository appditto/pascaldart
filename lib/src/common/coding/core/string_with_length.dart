import 'dart:typed_data';

import 'package:pascaldart/src/common/pascaldart_util.dart';

/// A string where the preceeding bytes are a length
class StringWithLength {
  int byteSize;

  StringWithLength({this.byteSize = 2});

  String decodeFromBytes(Uint8List bytes) {
    int length;
    if (byteSize == 2) {
      length = PDUtil.decodeLength(bytes.sublist(0, 2));
    } else {
      length = PDUtil.bytesToInt([bytes[0]]);
      this.byteSize = 1;
    }
    Uint8List nameBytes = bytes.sublist(byteSize, length+byteSize);
    return PDUtil.bytesToUtf8String(nameBytes);
  }

  Uint8List encodeToBytes(String value) {
    int length = value.toString().length;
    String lengthHex = PDUtil.byteToHex(PDUtil.intToBytes(length)).padRight(byteSize == 2 ? 4 : 2, '0');
    return PDUtil.hexToBytes(lengthHex + PDUtil.byteToHex(PDUtil.stringToBytesUtf8(value)));
  }
}