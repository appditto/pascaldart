import 'dart:typed_data';

/// Decode/Encopde Bytes to Base58 String
class Base58 {
  static const String ALPHABET =
      "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";

  // Encodes a byte-array to a base58 string
  static String encode(List<int> bytes) {
    if (bytes == null || bytes.isEmpty) {
      return "";
    }

    // copy bytes because we are going to change it
    bytes = Uint8List.fromList(bytes);

    // count number of leading zeros
    int leadingZeroes = 0;
    while (leadingZeroes < bytes.length && bytes[leadingZeroes] == 0) {
      leadingZeroes++;
    }

    String output = "";
    int startAt = leadingZeroes;
    while (startAt < bytes.length) {
      int mod = _divmod58(bytes, startAt);
      if (bytes[startAt] == 0) {
        startAt++;
      }
      output = ALPHABET[mod] + output;
    }

    if (output.isNotEmpty) {
      while (output[0] == ALPHABET[0]) {
        output = output.substring(1, output.length);
      }
    }
    while (leadingZeroes-- > 0) {
      output = ALPHABET[0] + output;
    }

    return output;
  }

  /// Decodes a base58 string into a byte-array
  static List<int> decode(String? input) {
    if (input == null || input.isEmpty) {
      return Uint8List(0);
    }

    // generate base 58 index list from input string
    List<int?> input58 = List.filled(input.length, 0);
    for (int i = 0; i < input.length; i++) {
      int charint = ALPHABET.indexOf(input[i]);
      if (charint < 0) {
        throw FormatException("Invalid input formatting for Base58 decoding.");
      }
      input58[i] = charint;
    }

    // count leading zeroes
    int leadingZeroes = 0;
    while (leadingZeroes < input58.length && input58[leadingZeroes] == 0) {
      leadingZeroes++;
    }

    // decode
    Uint8List output = Uint8List(input.length);
    int j = output.length;
    int startAt = leadingZeroes;
    while (startAt < input58.length) {
      int mod = _divmod256(input58, startAt);
      if (input58[startAt] == 0) {
        startAt++;
      }
      output[--j] = mod;
    }

    // remove unnecessary leading zeroes
    while (j < output.length && output[j] == 0) {
      j++;
    }
    return output.sublist(j - leadingZeroes);
  }

  /// number -> number / 58
  /// returns number % 58
  static int _divmod58(List<int> number, int startAt) {
    int remaining = 0;
    for (int i = startAt; i < number.length; i++) {
      int num = (0xFF & remaining) * 256 + number[i];
      number[i] = num ~/ 58;
      remaining = num % 58;
    }
    return remaining;
  }

  /// number -> number / 256
  /// returns number % 256
  static int _divmod256(List<int?> number58, int startAt) {
    int remaining = 0;
    for (int i = startAt; i < number58.length; i++) {
      int num = 58 * remaining + (number58[i]! & 0xFF);
      number58[i] = num ~/ 256;
      remaining = num % 256;
    }
    return remaining;
  }
}
