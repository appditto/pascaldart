import 'package:quiver/core.dart';

/// Available curves in PascalCoin
const Map<int, String> CURVES = {
  0: 'empty',
  714: 'secp256k1',
  715: 'secp384r1',
  729: 'sect283k1',
  716: 'secp521r1'
};

class XYPubKey {
  int x;
  int y;
  XYPubKey(this.x, this.y);

  /// Operator overrides
  bool operator ==(o) => (o != null && o.hashCode == hashCode);
  int get hashCode => hash2(x.hashCode, x.hashCode);
}

final Map<int, XYPubKey> XYL_PUBKEYS = {
  714: XYPubKey(32, 32),
  715: XYPubKey(48, 48),
  716: XYPubKey(66, 66),
  729: XYPubKey(36, 36),
  0: XYPubKey(0, 0),
};

const Map<int, int> L_PRIVKEYS = {714: 32, 715: 48, 716: 66, 729: 36};

const ID = Symbol('id');
const NAME = Symbol('name');

/// Simple elliptic curve representation of keys in pascalcoin.
class Curve {
  static const String CN_SECP256K1 = 'secp256k1'; // secp256k1 curve
  static const String CN_SECP384R1 = 'secp384r1'; // secp384r1 curve
  static const String CN_SECT283K1 = 'sect283k1'; // sect283k1 curve
  static const String CN_SECP521R1 = 'secp521r1'; // secp521r1 curve

  static const int CI_SECP256K1 = 714; // secp256k1 curve ID
  static const int CI_SECP384R1 = 715; // secp384r1 curve ID
  static const int CI_SECT283K1 = 729; // sect283k1 curve ID
  static const int CI_SECP521R1 = 716; // secp521r1 curve ID

  int id;
  String name;

  Curve(int curveId) {
    if (!CURVES.containsKey(curveId)) {
      throw Exception('Unknown Curve ID $curveId');
    }

    this.id = curveId;
    this.name = CURVES[id];
  }

  Curve.fromString(String curveName) {
    if (!CURVES.containsValue(curveName)) {
      throw Exception('Unknown Curve NAME  $curveName');
    }
    this.name = curveName;
    this.id = CURVES.keys.firstWhere((k) => CURVES[k] == curveName);
  }

  @override
  String toString() {
    return this.name;
  }

  /// Gets the default curve.
  static Curve getDefaultCurve() {
    return Curve(Curve.CI_SECP256K1);
  }

  /// Gets the length of either x and y for validation.
  int xylPublicKey({bool getYLength = false}) {
    return getYLength ? XYL_PUBKEYS[this.id].y : XYL_PUBKEYS[this.id].x;
  }

  /// Gets the length of either x and y for validation.
  int lPrivateKey() {
    return L_PRIVKEYS[this.id];
  }

  /// Gets a value indicating whether the key is supported for signing /
  ///generation etc.
  get supported {
    return this.id != Curve.CI_SECT283K1 && this.id != 0;
  }
}
