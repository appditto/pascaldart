import 'dart:typed_data';

import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/common/coding/core/Int16.dart';
import 'package:pascaldart/src/common/coding/core/Int8.dart';
import 'package:pascaldart/src/crypto/encrypt/pascal/ecies/EciesData.dart';

class EciesCoding {
  static EciesData decodeFromBytes(Uint8List bytes) {
    int publicKeyLength = Int8.decodeFromBytes(bytes.sublist(0, 1));
    print(publicKeyLength);
    int macLength = Int8.decodeFromBytes(bytes.sublist(1, 2));
    print(macLength);
    int originalDataLength = Int16.decodeFromBytes(bytes.sublist(2, 4));
    print(originalDataLength);
    int originaDataLengthIncPadding = Int16.decodeFromBytes(bytes.sublist(4, 6));
    print(originaDataLengthIncPadding);
    Uint8List pubKey = bytes.sublist(6, 6+publicKeyLength);
    print(Util.byteToHex(pubKey));
    Uint8List mac = bytes.sublist(publicKeyLength, 6+publicKeyLength+macLength);
    Uint8List encryptedData = bytes.sublist(6+publicKeyLength+macLength);
    print(Util.byteToHex(encryptedData));

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
