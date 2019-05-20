import 'dart:typed_data';

import 'package:pascaldart/src/common/model/AccountNumber.dart';
import 'package:pascaldart/src/common/Util.dart';

/// A special pascal type that can en/decode an account number
class AccountNumberCoder {
  /// Decode account number from given bytes
  AccountNumber decodeFromBytes(Uint8List bytes) {
    ByteData bd = bytes.buffer.asByteData();
    String accountNum = bd.getUint32(0, Endian.little).toRadixString(10);
    return AccountNumber(accountNum);
  }

  /// Encode an account number to bytes
  Uint8List encodeToBytes(AccountNumber accountNumber) {
    Uint32List encoded = Uint32List(1);
    ByteData bd = ByteData.view(encoded.buffer);
    bd.setUint32(0, accountNumber.account, Endian.little);
    return Uint8List.fromList([bd.getUint8(0), bd.getUint8(1), bd.getUint8(2), bd.getUint8(3)]);
  }
}
