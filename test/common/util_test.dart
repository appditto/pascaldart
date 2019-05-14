import 'dart:convert';
import 'dart:typed_data';

import 'package:pascaldart/pascaldart.dart';
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
  });
}
