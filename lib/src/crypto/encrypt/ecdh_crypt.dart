import 'dart:typed_data';

import 'package:pascaldart/src/common/sha.dart';
import 'package:pascaldart/src/common/pascaldart_util.dart';
import 'package:pascaldart/src/common/model/keys/keypair.dart';
import 'package:pascaldart/src/common/model/keys/privatekey.dart' as pdp;
import 'package:pascaldart/src/common/model/keys/publickey.dart' as pd;
import 'package:pascaldart/src/crypto/encrypt/aes/aes_cbczerobyte.dart';
import 'package:pascaldart/src/crypto/keys.dart';
import 'package:pascaldart/src/crypto/model/encrypt/ecdh_result.dart';
import 'package:pointycastle/export.dart';

class ECDHCrypt {
  /// Encrypts the given data with the given public key.
  static ECDHResult encrypt(Uint8List value, {pd.PublicKey publicKey}) {
    publicKey = publicKey == null ? pd.PublicKey.empty() : publicKey;
    KeyPair tempKey = Keys.generate(curve: publicKey.curve);
    ECDomainParameters domainParams = ECDomainParameters(publicKey.curve.name);
    ECPoint Q = domainParams.curve.decodePoint(publicKey.ecdh());
    BigInt d = PDUtil.decodeBigInt(tempKey.privateKey.ec(), endian: Endian.big);
    Uint8List sharedSecret =
        PDUtil.encodeBigInt((Q * d).x.toBigInteger(), endian: Endian.big);
    Uint8List secretKey = Sha.sha512([sharedSecret]);
    Uint8List encryptedData = AesCbcZeroPadding.encrypt(value,
        key: secretKey.sublist(0, 32), iv: Uint8List(16));

    return ECDHResult(
        isEncrypted: true,
        data: encryptedData,
        key: secretKey.sublist(32, 64),
        publicKey: tempKey.publicKey.ecdh());
  }

  /// Decrypts the given data.
  static ECDHResult decrypt(Uint8List value, pdp.PrivateKey privateKey,
      {Uint8List publicKey, int origMsgLength = 0}) {
    publicKey = publicKey == null ? Uint8List(1) : publicKey;
    ECDomainParameters domainParams = ECDomainParameters(privateKey.curve.name);
    ECPoint Q = domainParams.curve.decodePoint(publicKey);
    BigInt d = PDUtil.decodeBigInt(privateKey.ec(), endian: Endian.big);
    Uint8List sharedSecret =
        PDUtil.encodeBigInt((Q * d).x.toBigInteger(), endian: Endian.big);
    Uint8List secretKey = Sha.sha512([sharedSecret]);
    Uint8List decryptedData = AesCbcZeroPadding.decrypt(value,
        key: secretKey.sublist(0, 32), iv: Uint8List(16));
    Uint8List decryptedDataWithPaddingRemoved =
        decryptedData.sublist(0, origMsgLength);

    return ECDHResult(
        isEncrypted: false,
        data: decryptedDataWithPaddingRemoved,
        key: secretKey.sublist(32, 64));
  }
}
