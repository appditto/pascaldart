import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:pascaldart/crypto.dart';
import 'package:pascaldart/signing.dart';
import 'package:pascaldart/src/common/model/AccountNumber.dart';
import 'package:test/test.dart';

void main() {
  group('signing.operations.DeListForSaleOperation', () {
    Map<String, dynamic> fixture;

    setUp(() {
      fixture = {
        'signer': 1554325,
        'target': 1554326,
        'seller': 0,
        'price': 0,
        'fee': 0.0001,
        'payload': 'test',
        'n_operation': 1,
        'lockedUntilBlock': 0,
        'r': '270B996CE47B3C725223A87799BF74E32E1800102B3442F271ED81396708C4EB',
        's': '932D3542356861815F5A794E80D8945042B5A3852F5D99D1F30EE5C718522C0E',
        'digest':
            '95B7170096B717000200000000000000000000000000000001000000000000007465737400000000000000000000000005',
        'raw':
            '010000000500000095B7170096B7170005000100000001000000000000000400746573742000270B996CE47B3C725223A87799BF74E32E1800102B3442F271ED81396708C4EB2000932D3542356861815F5A794E80D8945042B5A3852F5D99D1F30EE5C718522C0E'
      };
    });

    test('can be decode a signed operation', () {
      DeListForSaleOperation decoded =
          RawOperationCoder.decodeFromBytes(Util.hexToBytes(fixture['raw']));

      expect(
          Util.byteToHex(Util.encodeBigInt(decoded.signature.r)), fixture['r']);
      expect(
          Util.byteToHex(Util.encodeBigInt(decoded.signature.s)), fixture['s']);
      expect(decoded.accountSigner.account, fixture['signer']);
      expect(decoded.targetSigner.account, fixture['target']);
      expect(decoded.accountToPay.account, fixture['seller']);
      expect(decoded.price.toStringOpt(), fixture['price'].toString());
      expect(decoded.fee.toStringOpt(), fixture['fee'].toString());
      expect(decoded.nOperation, fixture['n_operation']);
      expect(decoded.lockedUntilBlock, fixture['lockedUntilBlock']);
      expect(Util.bytesToUtf8String(decoded.payload), fixture['payload']);
    });
    test('can be decode signed operation and encode it again', () {
      DeListForSaleOperation decoded =
          RawOperationCoder.decodeFromBytes(Util.hexToBytes(fixture['raw']));

      expect(Util.byteToHex(RawOperationCoder.encodeToBytes(decoded)),
          fixture['raw']);
    });
    test('can be built by hand', () {
      DeListForSaleOperation op = DeListForSaleOperation(
          accountSigner: AccountNumber.fromInt(fixture['signer']),
          targetSigner: AccountNumber.fromInt(fixture['target']))
        ..withNOperation(fixture['n_operation'])
        ..withPayload(Util.stringToBytesUtf8(fixture['payload']))
        ..withFee(Currency(fixture['fee'].toString()))
        ..withSignature(Signature(
            r: Util.decodeBigInt(Util.hexToBytes(fixture['r'])),
            s: Util.decodeBigInt(Util.hexToBytes(fixture['s']))));

      Uint8List encoded = RawOperationCoder.encodeToBytes(op);

      expect(Util.byteToHex(encoded), fixture['raw']);
    });
    test('can be built by hand and signed', () {
      PrivateKey pk = PrivateKeyCoder().decodeFromBytes(Util.hexToBytes(
          'CA02200046D101363B3330D65373A70F6E47BB7745FC8EE1F9B3F71992D6B82648158D73'));
      DeListForSaleOperation op = DeListForSaleOperation(
          accountSigner: AccountNumber.fromInt(fixture['signer']),
          targetSigner: AccountNumber.fromInt(fixture['target']))
        ..withNOperation(fixture['n_operation'])
        ..withPayload(Util.stringToBytesUtf8(fixture['payload']))
        ..withFee(Currency(fixture['fee'].toString()))
        ..sign(pk);

      expect(op.signature.r.toString().length > 30, true);
      expect(op.signature.s.toString().length > 30, true);
    });
    test('can generate correct digest', () {
      DeListForSaleOperation decoded =
          RawOperationCoder.decodeFromBytes(Util.hexToBytes(fixture['raw']));
      expect(Util.byteToHex(decoded.digest()), fixture['digest']);
    });
  });
}
