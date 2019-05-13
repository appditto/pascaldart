import 'dart:typed_data';

import 'package:pointycastle/pointycastle.dart';

import 'package:pascaldart/pascaldart.dart';

class Sha {
  /// Calculates the sha256 hash from the given buffers.
  ///
  /// @param {List<BC>} buffers
  /// @returns {BC}
  static BC sha256(List<BC> buffers) {
    Digest digest = Digest("SHA-256");
    Uint8List hashed = Uint8List(32);
    buffers.forEach((bc) {
      digest.update(bc.buffer.asUint8List(), 0, bc.buffer.asUint8List().length);
    });
    digest.doFinal(hashed, 0);
    return BC(hashed);
  }

  /// Calculates the sha512 hash from the given buffers.
  ///
  /// @param {List<BC>} buffers
  /// @returns {BC}
  static BC sha512(List<BC> buffers) {
    Digest digest = Digest("SHA-512");
    Uint8List hashed = Uint8List(64);
    buffers.forEach((bc) {
      digest.update(bc.buffer.asUint8List(), 0, bc.buffer.asUint8List().length);
    });
    digest.doFinal(hashed, 0);

    return BC(hashed);
  }
}