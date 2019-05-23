
import 'dart:typed_data';

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
      fixtures.curve716.forEach((c) {
        if (Curve(716).supported) {
          KeyPair kp = Keys.fromPrivateKey(PrivateKeyCoder().decodeFromBytes(Util.hexToBytes(c['enc_privkey'])));
          expect(kp.curve.id, 716);
          expect(Util.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)), c['enc_privkey']);
          expect(PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(() => Keys.fromPrivateKey(PrivateKeyCoder().decodeFromBytes(Util.hexToBytes(c['enc_privkey']))), throwsException);
        }
      });        
      fixtures.curve729.forEach((c) {
        if (Curve(729).supported) {
          KeyPair kp = Keys.fromPrivateKey(PrivateKeyCoder().decodeFromBytes(Util.hexToBytes(c['enc_privkey'])));
          expect(kp.curve.id, 729);
          expect(Util.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)), c['enc_privkey']);
          expect(PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(() => Keys.fromPrivateKey(PrivateKeyCoder().decodeFromBytes(Util.hexToBytes(c['enc_privkey']))), throwsException);
        }
      });  
    });
    test('can sign a value', () {
        fixtures.curve714.forEach((c) {
          if (Curve(714).supported) {
            PrivateKey pk = PrivateKeyCoder().decodeFromBytes(Util.hexToBytes(c['enc_privkey']));
            Signature sig = Keys.sign(pk, Util.stringToBytesUtf8('test123'));
            expect(Util.byteToHex(Util.encodeBigInt(sig.r)).length == 64, true);
            expect(Util.byteToHex(Util.encodeBigInt(sig.s)).length == 64, true);
          }    
        });
        fixtures.curve715.forEach((c) {
          if (Curve(715).supported) {
            PrivateKey pk = PrivateKeyCoder().decodeFromBytes(Util.hexToBytes(c['enc_privkey']));
            Signature sig = Keys.sign(pk, Util.stringToBytesUtf8('test123'));
            expect(Util.byteToHex(Util.encodeBigInt(sig.r)).length == 96, true);
            expect(Util.byteToHex(Util.encodeBigInt(sig.s)).length == 96, true);
          }    
        });
        fixtures.curve716.forEach((c) {
          if (Curve(716).supported) {
            PrivateKey pk = PrivateKeyCoder().decodeFromBytes(Util.hexToBytes(c['enc_privkey']));
            Signature sig = Keys.sign(pk, Util.stringToBytesUtf8('test123'));
            expect(Util.byteToHex(Util.encodeBigInt(sig.r)).isNotEmpty, true);
            expect(Util.byteToHex(Util.encodeBigInt(sig.s)).isNotEmpty, true);
          }    
        });
        fixtures.curve729.forEach((c) {
          if (Curve(729).supported) {
            PrivateKey pk = PrivateKeyCoder().decodeFromBytes(Util.hexToBytes(c['enc_privkey']));
            Signature sig = Keys.sign(pk, Util.stringToBytesUtf8('test123'));
            expect(Util.byteToHex(Util.encodeBigInt(sig.r)).isNotEmpty, true);
            expect(Util.byteToHex(Util.encodeBigInt(sig.s)).isNotEmpty, true);
          }    
        });
    });    
    test('can retrieve a keypair from an encrypted private key', () {
      fixtures.curve714.forEach((c) {
        if (Curve(714).supported) {
          PrivateKey pKey = PrivateKeyCrypt.decrypt(Util.hexToBytes(c['encrypted']), c['password']);
          KeyPair kp = Keys.fromPrivateKey(pKey);
          expect(kp.curve.id, 714);
          expect(Util.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)), c['enc_privkey']);
          expect(PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(() {
            PrivateKey pKey = PrivateKeyCrypt.decrypt(Util.hexToBytes(c['encrypted']), c['password']);
            Keys.fromPrivateKey(pKey);
          }, throwsException);
        }
      });     
      fixtures.curve715.forEach((c) {
        if (Curve(715).supported) {
          PrivateKey pKey = PrivateKeyCrypt.decrypt(Util.hexToBytes(c['encrypted']), c['password']);
          KeyPair kp = Keys.fromPrivateKey(pKey);
          expect(kp.curve.id, 715);
          expect(Util.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)), c['enc_privkey']);
          expect(PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(() {
            PrivateKey pKey = PrivateKeyCrypt.decrypt(Util.hexToBytes(c['encrypted']), c['password']);
            Keys.fromPrivateKey(pKey);
          }, throwsException);
        }
      }); 
      fixtures.curve716.forEach((c) {
        if (Curve(716).supported) {
          PrivateKey pKey = PrivateKeyCrypt.decrypt(Util.hexToBytes(c['encrypted']), c['password']);
          KeyPair kp = Keys.fromPrivateKey(pKey);
          expect(kp.curve.id, 716);
          expect(Util.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)), c['enc_privkey']);
          expect(PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(() {
            PrivateKey pKey = PrivateKeyCrypt.decrypt(Util.hexToBytes(c['encrypted']), c['password']);
            Keys.fromPrivateKey(pKey);
          }, throwsException);
        }
      });     
      fixtures.curve729.forEach((c) {
        if (Curve(729).supported) {
          PrivateKey pKey = PrivateKeyCrypt.decrypt(Util.hexToBytes(c['encrypted']), c['password']);
          KeyPair kp = Keys.fromPrivateKey(pKey);
          expect(kp.curve.id, 729);
          expect(Util.byteToHex(PrivateKeyCoder().encodeToBytes(kp.privateKey)), c['enc_privkey']);
          expect(PublicKeyCoder().encodeToBase58(kp.publicKey), c['b58_pubkey']);
        } else {
          expect(() {
            PrivateKey pKey = PrivateKeyCrypt.decrypt(Util.hexToBytes(c['encrypted']), c['password']);
            Keys.fromPrivateKey(pKey);
          }, throwsException);
        }
      });            
    });
  });
}
