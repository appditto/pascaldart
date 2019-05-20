import 'dart:typed_data';

import 'package:pascaldart/src/common/Util.dart';

class OpTypeCoder {
  int byteSize;

  OpTypeCoder(this.byteSize) {
    if (![1, 2, 4].contains(this.byteSize)) {
      throw Exception('Invalid bytesize $byteSize');
    }
  }

  int decodeFromBytes(Uint8List bytes) {
    if (byteSize == 1) {
      return Util.bytesToInt(bytes);
    }
    ByteData bd = bytes.buffer.asByteData();
    List<int> typeDigits = List();
    for (int i = 0; i < bd.lengthInBytes / byteSize; i++) {
      if (byteSize == 2) {
        typeDigits.add(bd.getUint16(i, Endian.little));
      } else {
        typeDigits.add(bd.getUint32(i, Endian.little));        
      }
    }
    String digits = "";
    typeDigits.forEach((i) {
      digits = digits + i.toRadixString(10);
    });
    return int.parse(digits);
  }

  Uint8List encodeToBytes(int opType) {
    if (byteSize == 1) {
      return Util.intToBytes(opType);
    } else if (byteSize == 2) {
      Uint16List encoded = Uint16List(1);
      ByteData bd = ByteData.view(encoded.buffer);
      bd.setUint16(0, opType, Endian.little);
      return Uint8List.fromList([bd.getUint8(0), bd.getUint8(1)]);
    }
    Uint32List encoded = Uint32List(1);
    ByteData bd = ByteData.view(encoded.buffer);
    bd.setUint32(0, opType, Endian.little);
    return Uint8List.fromList([bd.getUint8(0), bd.getUint8(1), bd.getUint8(2), bd.getUint8(3)]);
  }
}