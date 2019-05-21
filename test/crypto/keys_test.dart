
import 'package:pascaldart/common.dart';
import 'package:pascaldart/crypto.dart';
import 'package:test/test.dart';

void main() {
  group('crypto.keys', () {
    final List<Curve> CURVE_INSTANCES = [
      Curve.fromString(Curve.CN_SECP256K1),
      Curve.fromString(Curve.CN_SECP384R1),
      Curve.fromString(Curve.CN_SECP521R1),
      Curve(Curve.CI_SECT283K1),
      Curve(0)];

    test('can generate keypairs', () {
      CURVE_INSTANCES.forEach((curve) {
        if (curve.supported) {
          for (int i = 0; i < 100; i++) {
            KeyPair kp = Keys.generate(curve: curve);
            expect(kp is KeyPair, true);
            expect(kp.curve.id, curve.id);
          }
        }
      });
    });

    test('cannot generate unsupported curves', () {
      CURVE_INSTANCES.forEach((curve) {
        if (!curve.supported) {
          expect(() => Keys.generate(curve: curve), throwsUnsupportedError);
        }
      });
    });
  });
}
