import 'package:pascaldart/src/common/model/keys/curves.dart';
import 'package:pascaldart/src/common/model/keys/privatekey.dart';
import 'package:pascaldart/src/common/model/keys/publickey.dart';

/// Represents a pub/private key pair
class KeyPair {
  Curve curve;
  PrivateKey privateKey;
  PublicKey publicKey;

  KeyPair(this.privateKey, this.publicKey) {
    this.curve = this.privateKey.curve;

    if (this.privateKey.curve.id != this.publicKey.curve.id) {
      throw Exception('Mixed up curves between private an public key');
    }
  }
}
