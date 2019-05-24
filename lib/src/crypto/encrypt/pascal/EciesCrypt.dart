import 'dart:typed_data';

import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/common/coding/pascal/keys/PublicKeyCoder.dart';
import 'package:pascaldart/src/common/model/keys/PrivateKey.dart';
import 'package:pascaldart/src/common/model/keys/PublicKey.dart';
import 'package:pascaldart/src/crypto/encrypt/ECDHCrypt.dart';
import 'package:pascaldart/src/crypto/encrypt/pascal/ecies/EciesCoding.dart';
import 'package:pascaldart/src/crypto/encrypt/pascal/ecies/EciesData.dart';
import 'package:pascaldart/src/crypto/model/encrypt/ECDHResult.dart';

/// A class that can en-/decrypt payloads based on a public key / private key.
class EciesCrypt {
  /// Decrypts the given encrypted value using the given key pair.
  /*
   * @param {Buffer|Uint8Array|BC|String} value
   * @param {Object} options
   *
   * @return {BC|false}
   */
  static Uint8List decrypt(Uint8List value, PrivateKey privateKey) {
    EciesData keyData = EciesCoding.decodeFromBytes(value);  

    ECDHResult dec = ECDHCrypt.decrypt(value, privateKey, publicKey: keyData.publicKey, origMsgLength: keyData.originalDataLength);

    Uint8List mac = Util.hmacMd5(keyData.encryptedData, dec.key);

    // var mac5 = hmac3.update(keyData.encryptedData.toString(), 'utf8').digest('hex');

    if (keyData.mac == mac) {
      return dec.data;
    }

    throw Exception('Unable to decrypt value.');
  }

  /// Encrypts the given value using the given public key.
  static Uint8List encrypt(Uint8List value, PublicKey publicKey) {
    ECDHResult enc = ECDHCrypt.encrypt(value, publicKey: publicKey);

    String mac = Util.bytesToUtf8String(Util.hmacMd5(enc.data, enc.key));

    int originalDataLength = value.length;
    int originalDataLengthIncPadLength = (originalDataLength % 16) == 0 ?
      0 : 16 - (originalDataLength % 16);

    EciesData keyData = EciesData(
      publicKey: enc.publicKey,
      mac: Util.stringToBytesUtf8(mac),
      encryptedData: enc.data,
      originalDataLength: originalDataLength,
      originalDataLengthIncPadding: originalDataLengthIncPadLength
    );
    return EciesCoding.encodeToBytes(keyData);
  }
}
