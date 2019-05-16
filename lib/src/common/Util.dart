import 'dart:convert';
import 'dart:typed_data' show Uint8List;
import 'package:hex/hex.dart';

class Util {
  /// Converts a Uint8List to a hex string
  static String byteToHex(List<int> bytes) {
    return HEX.encode(bytes).toUpperCase();
  }  

  /// Converts a hex string to a Uint8List
  static Uint8List hexToBytes(String hex) {
    return Uint8List.fromList(HEX.decode(hex));
  }

  /// Converts a hex string to a binary string
  static String hexToBinary(String hex) {
    return BigInt.parse(hex, radix: 16).toRadixString(2);
  }

  /// Converts a binary string into a hex string
  static String binaryToHex(String binary) {
    return BigInt.parse(binary, radix: 2).toRadixString(16).toUpperCase();
  }

  /// https://github.com/MauroJr/escape-regex/blob/master/index.js
  static String escapeRegex(string) {
    return ('' + string).replaceAllMapped(RegExp(r'([?!${}*:()|=^[\]\/\\.+])'), (match) => '\\${match.group(0)}');
  }

  /// Concatenates one or more byte arrays
  ///
  /// @param {List<Uint8List>} bytes
  /// @returns {Uint8List}
  static Uint8List concat(List<Uint8List> bytes) {
    String hex = '';
    bytes.forEach((v) {
      hex += Util.byteToHex(v);
    });
    return Util.hexToBytes(hex);
  }

  /// Get integer as byte array
  static Uint8List intToBytes(int inNum) {
    String hex = inNum.toRadixString(16);
    return Util.hexToBytes(hex);
  }

  /// Get byte array as an integer
  static int bytesToInt(Uint8List byteArray) {
    return int.parse(Util.byteToHex(byteArray), radix: 16);
  }

  /// Convert string to byte array
  static Uint8List stringToBytesUtf8(String str) {
    return utf8.encode(str);
  } 

  /// Convert byte array to string utf-8
  static String bytesToUtf8String(Uint8List bytes) {
    return utf8.decode(bytes);
  }
}