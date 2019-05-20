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
    int opType;
    ByteData bd = bytes.buffer.asByteData();
    if (byteSize == 2) {
      opType = bd.getUint16(0, Endian.little);
    } else {
      opType = bd.getUint32(0, Endian.little);
    }
    return opType;
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