
import 'package:pascaldart/pascaldart.dart';
import 'package:test/test.dart';

void main() {
  group('common.types.keys.Curves', () {
    test('can be created from a number', () {
      Curve c = Curve(714); // secp256k1

      expect(c.id, 714);
      expect(c.name, 'secp256k1');

      c = Curve(715); // p384
      expect(c.id, 715);
      expect(c.name, 'p384');

      c = Curve(716); // p384
      expect(c.id, 716);
      expect(c.name, 'p521');

      c = Curve(729); // p384
      expect(c.id, 729);
      expect(c.name, 'sect283k1');
    });
    test('can be created from a name', () {
      Curve c = Curve.fromString('secp256k1');

      expect(c.id, 714);
      expect(c.name, 'secp256k1');

      c = Curve.fromString('p384');
      expect(c.id, 715);
      expect(c.name, 'p384');

      c = Curve.fromString('p521');
      expect(c.id, 716);
      expect(c.name, 'p521');

      c = Curve.fromString('sect283k1');
      expect(c.id, 729);
      expect(c.name, 'sect283k1');
    });
    test('will return false for sect283k1 supported', () {
      expect(Curve(Curve.CI_SECT283K1).supported, false);
      expect(Curve(Curve.CI_SECP256K1).supported, true);
      expect(Curve(Curve.CI_P384).supported, true);
      expect(Curve(Curve.CI_P521).supported, true);
    });
    test('will throw an error with unknown curve', () {
      expect(() => Curve.fromString('abc'), throwsException);
      expect(() => Curve(100101), throwsException);
    });
    test('will return the name on toString()', () {
      Curve c = Curve.fromString('p521');

      expect(c.toString(), 'p521');
    });
    test('will return secp256k1 as default curve()', () {
      Curve c = Curve.getDefaultCurve();

      expect(c.id, 714);
      expect(c.name, 'secp256k1');
    });
    test('provides constants to access the name in a controlled manner', () {
      expect(Curve.CN_SECP256K1, 'secp256k1');
      expect(Curve.CN_P384, 'p384');
      expect(Curve.CN_SECT283K1, 'sect283k1');
      expect(Curve.CN_P521, 'p521');
    });
  });
}
