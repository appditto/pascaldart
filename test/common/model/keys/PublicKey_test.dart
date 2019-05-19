
import 'package:pascaldart/common.dart';
import 'package:test/test.dart';

import '../../fixtures/PublicKey.dart';

void main() {
  group('common.model.keys.PublicKey', () {
    const List<int> curves = [
      Curve.CI_SECP256K1,
      Curve.CI_SECT283K1,
      Curve.CI_P521,
      Curve.CI_P384
    ];
    PublicKeyFixtures fixtures;
    PublicKeyCoder coder;

    setUp(() {
      coder = PublicKeyCoder();
      fixtures = PublicKeyFixtures();
    });

    test('can be created as an empty key (used by pasc v2)', () {
      PublicKey pubkey = PublicKey.empty();

      expect(pubkey.curve.id, 0);
      expect(pubkey.x.length, 0);
      expect(pubkey.y.length, 0);
    });

    test('cannot be created with wronfues managed by the curve', () {
      curves.forEach((c) {
        Curve curve = Curve(c);

        expect(() => {
          PublicKey(
            Util.hexToBytes(List.filled(curve.xylPublicKey() + 1, '00').join()),
            Util.hexToBytes(List.filled(curve.xylPublicKey(), '00').join()),
            curve
          )
        }, throwsException);
        expect(() => {
          PublicKey(
            Util.hexToBytes(List.filled(curve.xylPublicKey(), '00').join()),
            Util.hexToBytes(List.filled(curve.xylPublicKey() + 1, '00').join()),
            curve
          )
        }, throwsException);
      });
    });

    test('can return a value only containing x and y', () {
      fixtures.curve714.forEach((c) {
        PublicKey key = coder.decodeFromBytes(Util.hexToBytes(c['enc_pubkey'])); 
        expect(Util.byteToHex(key.ec()), c['x'] + c['y']);
      });
      fixtures.curve715.forEach((c) {
        PublicKey key = coder.decodeFromBytes(Util.hexToBytes(c['enc_pubkey'])); 
        expect(Util.byteToHex(key.ec()), c['x'] + c['y']);
      });
      fixtures.curve716.forEach((c) {
        PublicKey key = coder.decodeFromBytes(Util.hexToBytes(c['enc_pubkey'])); 
        expect(Util.byteToHex(key.ec()), c['x'] + c['y']);
      });
      fixtures.curve729.forEach((c) {
        PublicKey key = coder.decodeFromBytes(Util.hexToBytes(c['enc_pubkey'])); 
        expect(Util.byteToHex(key.ec()), c['x'] + c['y']);
      });
    });
  });
}
