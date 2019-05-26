import 'dart:typed_data';

import 'package:pascaldart/src/common/Sha.dart';
import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/common/model/keys/KeyPair.dart';
import 'package:pascaldart/src/common/model/keys/PrivateKey.dart' as pdp;
import 'package:pascaldart/src/common/model/keys/PublicKey.dart' as pd;
import 'package:pascaldart/src/crypto/encrypt/aes/CBCZeroPadding.dart';
import 'package:pascaldart/src/crypto/keys.dart';
import 'package:pascaldart/src/crypto/model/encrypt/ECDHResult.dart';
import 'package:pointycastle/export.dart';

class ECDHCrypt {
  /// Encrypts the given data with the given public key.
  static ECDHResult encrypt(Uint8List value, { pd.PublicKey publicKey }) {
    publicKey = publicKey == null ? pd.PublicKey.empty() : publicKey;
    KeyPair tempKey = Keys.generate(curve: publicKey.curve);
    ECDomainParameters domainParams = ECDomainParameters(publicKey.curve.name);
    ECPoint Q = domainParams.curve.createPoint(Util.decodeBigInt(publicKey.x, endian: Endian.big), Util.decodeBigInt(publicKey.y, endian: Endian.big));
    BigInt d = Util.decodeBigInt(tempKey.privateKey.ec(), endian: Endian.big);
    Uint8List sharedSecret = Util.encodeBigInt((Q * d).x.toBigInteger(), endian: Endian.big);
    Uint8List secretKey = Sha.sha512([sharedSecret]);
    Uint8List encryptedData = AesCbcZeroPadding.encrypt(value, key:secretKey.sublist(0, 32), iv: Uint8List(16));

    return ECDHResult(
      isEncrypted: true,
      data: encryptedData,
      key: secretKey.sublist(32, 64),
      publicKey: tempKey.publicKey.ec()
    );
  }

  /// Decrypts the given data.
  static ECDHResult decrypt(Uint8List value, pdp.PrivateKey privateKey, { Uint8List publicKey, int origMsgLength = 0}) {
    publicKey = publicKey == null ? Uint8List(1) : publicKey;
    ECDomainParameters domainParams = ECDomainParameters(privateKey.curve.name);
    ECPoint Q = domainParams.curve.decodePoint(publicKey);
    BigInt d = Util.decodeBigInt(privateKey.ec(), endian: Endian.big);
    Uint8List sharedSecret = Util.encodeBigInt((Q * d).x.toBigInteger(), endian: Endian.big);
    Uint8List secretKey = Sha.sha512([sharedSecret]);
    Uint8List decryptedData = AesCbcZeroPadding.decrypt(value, key:secretKey.sublist(0, 32), iv: Uint8List(16));
    Uint8List decryptedDataWithPaddingRemoved = decryptedData.sublist(0, origMsgLength);

    return ECDHResult(
      isEncrypted: false,
      data: decryptedDataWithPaddingRemoved,
      key: secretKey.sublist(32, 64)
    );
  }
}