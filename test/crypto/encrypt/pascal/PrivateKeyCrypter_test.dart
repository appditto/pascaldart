
import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:pascaldart/crypto.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:test/test.dart';

import '../../fixtures/PrivateKey.dart';

void main() {
  group('crypto.encrypt.pascal.PrivateKeyCryptor', () {   
    PrivateKeyFixtures fixtures;

    setUp(() {
      fixtures = PrivateKeyFixtures();
    });  

    test('can encrypt and decrypt a private key', () {
      fixtures.curve714.forEach((c) {
        PrivateKey pkDecrypted = PrivateKeyCrypter.decrypt(Util.hexToBytes(c['encrypted']), c['password']);

        // encrypt and get private key encrpted
        Uint8List pkEncrypted = PrivateKeyCrypter.encrypt(pkDecrypted, 'test123');

        // decrypt and get keypair
        PrivateKey pkDecrypted2 = PrivateKeyCrypter.decrypt(pkEncrypted, 'test123');

        expect(Util.byteToHex(PrivateKeyCoder().encodeToBytes(pkDecrypted2)), c['enc_privkey']);        
      });
    });
  });
}
