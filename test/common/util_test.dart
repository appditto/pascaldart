import 'dart:typed_data';

import 'package:pascaldart/common.dart';
import 'package:test/test.dart';

void main() {
  group('Common.Util', () {
    test('test hex to byte array and back', () {
      String hex = '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6';
      Uint8List byteArray = Util.hexToBytes('67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6');
      expect(Util.byteToHex(byteArray), hex);
    });
    test('test hex to binary and back', () {
      String hex = '67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6';
      String binary = Util.hexToBinary('67EDBC8F904091738DF33B4B6917261DB91DD9002D3985A7BA090345264A46C6');
      expect(Util.binaryToHex(binary), hex);
    });
    test('can concat one or more byte arrays', () {
      final List<Uint8List> hexas = ['ABCD', '0020', 'FFFFFFDD'].map((hex) => Util.hexToBytes(hex)).toList();

      expect(Util.byteToHex(Util.concat(hexas)), 'ABCD0020FFFFFFDD');
    });
    test('can convert int to byte array and back', () {
      final Uint8List h = Util.intToBytes(714);

      expect(Util.bytesToInt(h), 714);
    });
    test('can decode and encode a bigint to little-endian byte array', () {
      BigInt a = BigInt.from(1000);
      Uint8List encoded = Util.encodeBigInt(a);
      String hex = 'E803';
      expect(Util.byteToHex(encoded), hex);
      expect(Util.decodeBigInt(encoded), a);
    });

  });
}
