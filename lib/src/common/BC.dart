import 'dart:convert';
import 'dart:typed_data';

import 'package:collection/equality.dart';
import 'package:pascaldart/src/common/Util.dart';

/// A BC value as defined in PascalCoin. In essence its a wrapper for
/// a buffer.
class BC {
  static const String HEX_ALPHABET = "0123456789abcdef";
 
  ByteBuffer buffer;

  BC(dynamic buffer) {
    if (buffer is ByteBuffer) {
      this.buffer = buffer;
    } else if (buffer is Uint8List) {
      this.buffer = buffer.buffer;;
    } else {
      throw Exception("BC Expected ByteBuffer or Uint8List argument");
    }
  }

  /// Gets a BC instance from the given value. If a string it expects it to be
  /// in hex format.
  ///
  /// This method it called everywhere, so we make sure that
  ///
  /// @param {Buffer|Uint8Array|BC|String} data
  /// @param {String} stringType
  /// @returns {BC}
  static BC from(dynamic data, { String stringType = 'hex' }) {
    if (data is BC) {
      return data;
    } else if (data is ByteBuffer || data is Uint8List) {
      return BC(data);
    }

    if (stringType == 'hex') {
      try {
        return BC.fromHex(data);
      } catch (e) {
        return BC.fromString(data);
      }
    }

    return BC.fromString(data);
  }

  /// Gets an empty BC.
  ///
  /// @returns {BC}
  static BC empty() {
    return BC.from([]);
  }

  ///
  /// Creates a new BC instance from the given hex string.
  /// 
  /// @param {string} hex
  /// @param {Boolean} strict
  /// @returns {BC}
  static BC fromHex(String hex, { bool strict = true }) {
    if (hex.length % 2 == 1) {
      if (strict) {
        throw Exception('Invalid hex - number of nibbles need to be divideable by 2');
      } else {
        hex = '0$hex';
      }
    }

    if (hex.isNotEmpty) {
      for (int i = 0; i < hex.length; i++) {
        if (!HEX_ALPHABET.contains(hex[i].toLowerCase())) {
          throw Exception('Invalid hex $hex');
        }
      }
    }

    return new BC(Util.hexToBytes(hex));
  }

  /// Creates a new BC instance from the given string.
  ///
  /// @param {string} str
  /// @returns {BC}
  static BC fromString(String str) {
    return new BC(utf8.encode(str));
  }

  /// Gets a new BC from an integer.
  ///
  /// @param {Number} int
  /// @param {Number} nBytes
  /// @returns {BC}
  static BC fromInt(int inNum, {int nBytes}) {
    String hex = inNum.toRadixString(16);

    final BC instance = BC.fromHex(hex, strict: false);
    

    if (nBytes != null && instance.length < nBytes) {
      return instance.prepend(BC.fromHex('00' * (nBytes - instance.length)));
    }
    return instance;
  }

  /// Gets the binary presentation of the hex string.
  /// 
  /// @returns {string}
  String toBinary() {
    return Util.hexToBinary(Util.byteToHex(buffer.asUint8List()));
  }

  /// Gets the BC as a string.
  ///
  /// @returns {string}
  @override
  String toString() {
    return utf8.decode(buffer.asUint8List());
  }

  /// Gets the BC as hex.
  ///
  /// @returns {string}
  String toHex({ bool lowerCase = false }) {
    if (lowerCase) {
      return Util.byteToHex(buffer.asUint8List()).toLowerCase();
    }

    return Util.byteToHex(buffer.asUint8List()).toUpperCase();
  }

  /// Gets the integer value of the BC.
  ///
  /// @return {Number}
  int toInt() {
    return int.parse(this.toHex(), radix: 16);
  }

  /// Gets the length of BC bytes.
  /// 
  /// @returns {number}
  get length {
    return buffer.lengthInBytes;
  }

  /// Gets the length of the parsed BC (the bytes).
  ///
  /// @returns {number}
  get hexLength {
    return this.length * 2;
  }

  /// Gets a copy of the current buffer.
  /// 
  /// @returns {ByteBuffer}
  ByteBuffer copyBuffer() {
    return Uint8List.fromList(buffer.asUint8List()).buffer;
  }

  /// Switches the endianness of the BC.
  ///
  // @returns {BC}
  BC switchEndian() {
    String ret = "";
    RegExp(r'..').allMatches(this.toHex()).forEach((match) {
      ret = match.group(0) + ret;
    });
    return BC.fromHex(ret);
  }

  /// Switches the endianness of the BC.
  /// 
  /// @returns {BC}
  BC switchEndianIf(Endian targetEndian) {
    if (Endian.host != targetEndian) {
      return this.switchEndian();
    }

    return this;
  }

  /// Returns a sub-BC defined by the start and end position.
  ///
  /// @param {Number}start
  /// @param {Number} end
  /// @returns {BC}
  BC slice(int start, { int end }) {
    if (end == null) {
      return BC(buffer.asUint8List().sublist(start));
    }

    return BC(buffer.asUint8List().sublist(start, end));
  }

  /// Concatenates one or more BC instances and returns a new instance.
  ///
  /// @param {List<BC>} bytes
  /// @returns {BC}
  static BC concat(List<BC> bytes) {
    String hex = '';
    bytes.forEach((v) {
      hex += v.toHex();
    });
    return BC.fromHex(hex);
  }

  /// Appends a single BC instance to the current BC and
  /// returns a new instance.
  ///
  /// @param {BC|Buffer|Uint8Array|String} bytes
  /// @returns {BC}
  BC append(dynamic bytes) {
    return BC.concat([this, BC.from(bytes)]);
  }

  /// Appends a single BC instance to the current BC and
  /// returns a new instance.
  ///
  /// @param {BC|Buffer|Uint8Array|String} bytes
  /// @returns {BC}
  BC prepend(dynamic bytes) {
    return BC.concat([BC.from(bytes), this]);
  }

  /// Override equals operator
  bool operator == (bc) => IterableEquality().equals(bc.buffer.asUint8List(), buffer.asUint8List());

  /// Reads an 8 bit integer value from the bc from the given offset.
  ///
  /// @param {Number} offset
  /// @param {Boolean} unsigned
  /// @returns {Number}
  int readInt8(offset, { bool unsigned = true }) {
    if (unsigned) {
      return buffer.asByteData().getUint8(offset);
    }
    return buffer.asByteData().getInt8(offset);
  }

  /// Reads a 16 bit integer value from the bc from the given offset.
  ///
  /// @param {Number} offset
  /// @param {Boolean} unsigned
  /// @param {String} endian
  /// @returns {Number}
  int readInt16(int offset, { bool unsigned = true, Endian endian }) {
    if (endian == null) {
      endian = Endian.host;
    }
    if (unsigned) {
      buffer.asByteData().getUint16(offset, endian);
    }
    buffer.asByteData().getInt16(offset, endian);
  }

  /// Reads a 32 bit integer value from the bc from the given offset.
  ///
  /// @param {Number} offset
  /// @param {Boolean} unsigned
  /// @param {String} endian
  /// @returns {Number}
  int readInt32(int offset, { bool unsigned = true, Endian endian }) {
    if (endian == null) {
      endian = Endian.host;
    }
    if (unsigned) {
      buffer.asByteData().getUint32(offset, endian);
    }
    buffer.asByteData().getInt32(offset, endian);
  }

  /// TODO - Implement fromInt8/fromInt16/fromInt32
}
