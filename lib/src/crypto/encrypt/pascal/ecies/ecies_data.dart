import 'dart:typed_data';

class EciesData {
  Uint8List publicKey;
  Uint8List mac;
  Uint8List encryptedData;
  int originalDataLength;
  int originalDataLengthIncPadding;

  EciesData(
      {this.publicKey,
      this.mac,
      this.encryptedData,
      this.originalDataLength,
      this.originalDataLengthIncPadding});
}
