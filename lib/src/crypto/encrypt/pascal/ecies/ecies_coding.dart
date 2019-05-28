import 'dart:typed_data';

import 'package:pascaldart/src/common/pascaldart_util.dart';
import 'package:pascaldart/src/common/coding/core/int16.dart';
import 'package:pascaldart/src/common/coding/core/int8.dart';
import 'package:pascaldart/src/crypto/encrypt/pascal/ecies/ecies_data.dart';

class EciesCoding {
  static EciesData decodeFromBytes(Uint8List bytes) {
    int offset = 0;
    int publicKeyLength = Int8.decodeFromBytes(bytes.sublist(offset, offset+1));
    offset++;
    int macLength = Int8.decodeFromBytes(bytes.sublist(offset, offset+1));
    offset++;
    int originalDataLength = Int16.decodeFromBytes(bytes.sublist(offset, offset+2));
    offset+=2;
    int originaDataLengthIncPadding = Int16.decodeFromBytes(bytes.sublist(offset, offset+2));
    offset+=2;
    Uint8List pubKey = bytes.sublist(offset, offset+publicKeyLength);
    offset+=publicKeyLength;
    Uint8List mac = bytes.sublist(offset, offset+macLength);
    offset+=macLength;
    Uint8List encryptedData = bytes.sublist(offset);

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
    return PDUtil.concat([
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
