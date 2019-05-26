
import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:pascaldart/crypto.dart';
import 'package:test/test.dart';

import '../../fixtures/ECIES.dart';

void main() {
  group('crypto.encrypt.pascal.EciesCrypt', () {
    test('can decrypt an PascalCoin payload', () {
      KeyPair keyPair = Keys.fromPrivateKey(
        PrivateKeyCrypt.decrypt(
          Util.hexToBytes('53616C7465645F5F1CD34699BAFAD73EAE8A574154F08760BF8E8B9A554CA9691819BA06962D4A3774B9ACADA4B75471A85A10B2C418A56B1AFFF8F560AC6F66'),
          'test123'
      ));

      eciesTestData.forEach((d) {
        expect(Util.bytesToUtf8String(EciesCrypt.decrypt(Util.hexToBytes(d['encrypted']), keyPair.privateKey)), d['decrypted']);
      });
    });
    test('can encrypt and decrypt a value', () {
      KeyPair keyPair = Keys.fromPrivateKey(
        PrivateKeyCrypt.decrypt(
          Util.hexToBytes('53616C7465645F5F1CD34699BAFAD73EAE8A574154F08760BF8E8B9A554CA9691819BA06962D4A3774B9ACADA4B75471A85A10B2C418A56B1AFFF8F560AC6F66'),
          'test123'
      ));

      Uint8List encrypted = EciesCrypt.encrypt(Util.stringToBytesUtf8('test123'), keyPair.publicKey);
      print(Util.byteToHex(encrypted));
      expect(Util.bytesToUtf8String(EciesCrypt.decrypt(encrypted, keyPair.privateKey)), 'test123');
    });
    /*
    test('can will throw an error if decryption fails', () {
      let keyPair = Keys.fromPrivateKey(
        PrivateKeyCrypt.decrypt(
          BC.from('53616C7465645F5F1CD34699BAFAD73EAE8A574154F08760BF8E8B9A554CA9691819BA06962D4A3774B9ACADA4B75471A85A10B2C418A56B1AFFF8F560AC6F66'),
          {password: 'test123'}
        )
      );

      expect(() => ECIES.decrypt(BC.fromString('Hello'), {keyPair})).to.throw();
    });*/
  });
}
