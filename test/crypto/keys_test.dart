
import 'package:pascaldart/common.dart';
import 'package:pascaldart/crypto.dart';
import 'package:test/test.dart';

import './fixtures/PrivateKey.dart';

void main() {
  group('crypto.keys', () {
    final List<Curve> CURVE_INSTANCES = [
      Curve.fromString(Curve.CN_SECP256K1),
      Curve.fromString(Curve.CN_SECP384R1),
      Curve.fromString(Curve.CN_SECP521R1),
      Curve(Curve.CI_SECT283K1),
      Curve(0)];
    
    PrivateKeyFixtures fixtures;

    setUp(() {
      fixtures = PrivateKeyFixtures();
    });
    test('can generate keypairs', () {
      CURVE_INSTANCES.forEach((curve) {
        if (curve.supported) {
          for (int i = 0; i < 100; i++) {
            KeyPair kp = Keys.generate(curve: curve);
            expect(kp is KeyPair, true);
            expect(kp.curve.id, curve.id);
            print(PrivateKeyCoder().encodeToHex(kp.privateKey));
            print(PublicKeyCoder().encodeToBase58(kp.publicKey));
            expect(Util.byteToHex(Keys.fromPrivateKey(kp.privateKey).publicKey.ec()), Util.byteToHex(kp.publicKey.ec()));
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
    test('can retrieve a keypair from a private key', () {
      fixtures.curve714.forEach((c) {
        if (Curve(714).supported) {
          KeyPair kp = Keys.fromPrivateKey(PrivateKeyCoder().decodeFromBytes(Util.hexToBytes(c['enc_privkey'])));
          expect(kp.curve.id, 714);
          expect(Util.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)), c['enc_privkey']);
          //print(Util.byteToHex(Base58.decode(PublicKeyCoder().encodeToBase58(kp.publicKey))));
          //print(Util.byteToHex(Base58.decode(c['b58_pubkey'])));
          expect(PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(() => Keys.fromPrivateKey(PrivateKeyCoder().decodeFromBytes(Util.hexToBytes(c['enc_privkey']))), throwsException);
        }
      });
      fixtures.curve715.forEach((c) {
        if (Curve(715).supported) {
          KeyPair kp = Keys.fromPrivateKey(PrivateKeyCoder().decodeFromBytes(Util.hexToBytes(c['enc_privkey'])));
          expect(kp.curve.id, 715);
          expect(Util.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)), c['enc_privkey']);
          expect(PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(() => Keys.fromPrivateKey(PrivateKeyCoder().decodeFromBytes(Util.hexToBytes(c['enc_privkey']))), throwsException);
        }
      });      
    });
  });
}
