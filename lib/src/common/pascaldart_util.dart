import 'dart:convert';
import 'dart:typed_data';
import 'package:hex/hex.dart';
import 'package:pointycastle/export.dart';

class PDUtil {
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
      hex += PDUtil.byteToHex(v);
    });
    return PDUtil.hexToBytes(hex);
  }

  /// Get integer as byte array
  static Uint8List intToBytes(int inNum) {
    String hex = inNum.toRadixString(16);
    return PDUtil.hexToBytes(hex);
  }

  /// Get byte array as an integer
  static int bytesToInt(List<int> byteArray) {
    return int.parse(PDUtil.byteToHex(byteArray), radix: 16);
  }

  /// Convert string to byte array
  static Uint8List stringToBytesUtf8(String str) {
    return utf8.encode(str);
  } 

  /// Convert byte array to string utf-8
  static String bytesToUtf8String(Uint8List bytes) {
    return utf8.decode(bytes);
  }

  /// Switch endianness of a hex string
  static String switchEndian(String hexString) {
    String ret = "";
    RegExp(r'..').allMatches(hexString).forEach((match) {
      ret = match.group(0) + ret;
    });
    return ret;
  }

  /// Decode a BigInt from bytes using specified endianness
  static BigInt decodeBigInt(List<int> bytes, {Endian endian = Endian.little}) {
    BigInt result = BigInt.from(0);
    for (int i = 0; i < bytes.length; i++) {
      result += BigInt.from(bytes[endian == Endian.little ? i : bytes.length - i - 1]) << (8 * i);
    }
    return result;
  }

  /// Encode a BigInt into bytes using specified endianness.
  static Uint8List encodeBigInt(BigInt number, {Endian endian = Endian.little}) {
    int size = (number.bitLength + 7) >> 3;
    var result = Uint8List(size);
    for (int i = 0; i < size; i++) {
      result[endian == Endian.little ? i : size - i - 1] = (number & BigInt.from(0xff)).toInt();
      number = number >> 8;
    }
    return result;
  }

  static Uint8List hmacMd5(Uint8List data, Uint8List key) {
    HMac mac = HMac(new MD5Digest(), 64)..init(KeyParameter(key));
    return mac.process(data);
  }

  static int decodeLength(Uint8List lengthBytes) {
    return int.parse(PDUtil.switchEndian(PDUtil.byteToHex(lengthBytes)), radix: 16);    
  }

  static Uint8List encodeLength(int length) {
    return PDUtil.hexToBytes(PDUtil.byteToHex(PDUtil.intToBytes(length)).padRight(4, '0'));    
  }
}