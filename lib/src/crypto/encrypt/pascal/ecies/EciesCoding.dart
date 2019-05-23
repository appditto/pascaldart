import 'dart:typed_data';

import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/common/coding/core/Int16.dart';
import 'package:pascaldart/src/common/coding/core/Int8.dart';
import 'package:pascaldart/src/crypto/encrypt/pascal/ecies/EciesData.dart';

class EciesCoding {
  static EciesData decodeFromBytes(Uint8List bytes) {
    int publicKeyLength = Int8.decodeFromBytes(bytes.sublist(0, 1));
    int macLength = Int8.decodeFromBytes(bytes.sublist(1, 2));
    int originalDataLength = Int16.decodeFromBytes(bytes.sublist(2, 4));
    int originaDataLengthIncPadding = Int16.decodeFromBytes(bytes.sublist(4, 6));
    Uint8List pubKey = bytes.sublist(6, publicKeyLength);
    Uint8List mac = bytes.sublist(publicKeyLength, macLength);
    Uint8List encryptedData = bytes.sublist(macLength);

    return EciesData(
      publicKey: pubKey,
      mac: mac,
      encryptedData: encryptedData,
      originalDataLength: originalDataLength,
      originalDataLengthIncPadding: originaDataLengthIncPadding
    );  
  }

  static Uint8List encodeToBytes(EciesData data) {
    Uint8List publicKeyLength = Int8.encodeToBytes(data.publicKey.length);
    Uint8List macLength = Int8.encodeToBytes(data.mac.length);
    Uint8List originalDataLength = Int16.encodeToBytes(data.originalDataLength);
    Uint8List originalDataLengthIncPadding = Int16.encodeToBytes(data.originalDataLengthIncPadding);
    return Util.concat([
      publicKeyLength,
      macLength,
      originalDataLength,
      originalDataLengthIncPadding,
      data.publicKey,
      data.mac,
      data.encryptedData
    ]);
  }
}
