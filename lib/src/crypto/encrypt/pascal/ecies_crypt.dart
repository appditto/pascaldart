import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:pascaldart/src/common/pascaldart_util.dart';
import 'package:pascaldart/src/common/model/keys/privatekey.dart';
import 'package:pascaldart/src/common/model/keys/publickey.dart';
import 'package:pascaldart/src/crypto/encrypt/ecdh_crypt.dart';
import 'package:pascaldart/src/crypto/encrypt/pascal/ecies/ecies_coding.dart';
import 'package:pascaldart/src/crypto/encrypt/pascal/ecies/ecies_data.dart';
import 'package:pascaldart/src/crypto/model/encrypt/ecdh_result.dart';

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

    ECDHResult dec = ECDHCrypt.decrypt(keyData.encryptedData, privateKey,
        publicKey: keyData.publicKey,
        origMsgLength: keyData.originalDataLength);

    Uint8List mac = PDUtil.hmacMd5(keyData.encryptedData, dec.key);

    if (ListEquality().equals(keyData.mac, mac)) {
      return dec.data;
    }

    throw Exception('Unable to decrypt value.');
  }

  /// Encrypts the given value using the given public key.
  static Uint8List encrypt(Uint8List value, PublicKey publicKey) {
    ECDHResult enc = ECDHCrypt.encrypt(value, publicKey: publicKey);

    String mac = PDUtil.byteToHex(PDUtil.hmacMd5(enc.data, enc.key));

    int originalDataLength = value.length;
    int originalDataLengthIncPadLength =
        (originalDataLength % 16) == 0 ? 0 : 16 - (originalDataLength % 16);

    EciesData keyData = EciesData(
        publicKey: enc.publicKey,
        mac: PDUtil.hexToBytes(mac),
        encryptedData: enc.data,
        originalDataLength: originalDataLength,
        originalDataLengthIncPadding: originalDataLengthIncPadLength);
    return EciesCoding.encodeToBytes(keyData);
  }
}
