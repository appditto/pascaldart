
import 'dart:typed_data' show Uint8List;
import 'package:hex/hex.dart';

class Util {
  /// Converts a Uint8List to a hex string
  static String byteToHex(Uint8List bytes) {
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
}