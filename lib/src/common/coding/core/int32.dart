import 'dart:typed_data';

class Int32 {
  static int decodeFromBytes(Uint8List bytes) {
    ByteData bd = bytes.buffer.asByteData();
    return bd.getUint32(0, Endian.little);
  }

  static Uint8List encodeToBytes(int value) {
    Uint32List encoded = Uint32List(1);
    ByteData bd = ByteData.view(encoded.buffer);
    bd.setUint32(0, value, Endian.little);
    return Uint8List.fromList([bd.getUint8(0), bd.getUint8(1), bd.getUint8(2), bd.getUint8(3)]);
  }
}