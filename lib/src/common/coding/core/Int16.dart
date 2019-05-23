import 'dart:typed_data';

class Int16 {
  static int decodeFromBytes(Uint8List bytes) {
    Uint16List bytesU16 = Uint16List.fromList([bytes[0], bytes[1]]);
    ByteData bdView = ByteData.view(bytesU16.buffer);
    return bdView.getUint16(0, Endian.little) + bdView.getUint16(1, Endian.little);
  }

  static Uint8List encodeToBytes(int value) {
    Uint16List encoded = Uint16List(1);
    ByteData bd = ByteData.view(encoded.buffer);
    bd.setInt16(0, value, Endian.little);
    return Uint16List.fromList([bd.getUint16(0, Endian.little)]).buffer.asUint8List();
  }
}