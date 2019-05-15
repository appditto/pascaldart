import 'package:pascaldart/src/common/model/keys/Curves.dart';
import 'package:pascaldart/src/common/model/keys/PrivateKey.dart';
import 'package:pascaldart/src/common/model/keys/PublicKey.dart';

/// Represents a pub/private key pair
class KeyPair {
  Curve curve;
  PrivateKey privateKey;
  PublicKey publicKey;

  KeyPair(this.privateKey, this.publicKey) {
    this.curve = this.privateKey.curve;

    if (this.privateKey.curve.id != this.publicKey.curve.id) {
      throw new Exception('Mixed up curves between private an public key');
    }
  }
}