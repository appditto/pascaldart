import 'dart:typed_data';

import 'package:pascaldart/src/common/Sha.dart';
import 'package:pascaldart/src/common/model/keys/PrivateKey.dart';
import 'package:pascaldart/src/crypto/keys.dart';
import 'package:pascaldart/src/crypto/model/Signature.dart';
import 'package:pascaldart/src/signing/operations/BaseOperation.dart';

class Signer {
    /// Sign the sha256 of the given digest and return r and s
    static Signature signWithHash(PrivateKey privateKey, Uint8List digest) {
      return Keys.sign(privateKey, Sha.sha256([digest]));
    }

    /// Sign digest
    static Signature signDigest(PrivateKey privateKey, Uint8List digest) {
      return Keys.sign(privateKey, digest);
    }

    /// Sign an operation
    static Signature signOperation(PrivateKey privateKey, BaseOperation operation) {
      Uint8List digest = operation.digest();

      if (operation.usesDigestToSign()) {
        return Signer.signDigest(privateKey, digest);
      }
      return Signer.signWithHash(privateKey, digest);
    }
}