import 'dart:typed_data';

import 'package:pascaldart/src/common/coding/core/int32.dart';
import 'package:pascaldart/src/common/model/accountnumber.dart';
import 'package:pascaldart/src/common/pascaldart_util.dart';

/// A special pascal type that can en/decode an account number
class AccountNumberCoder {
  /// Decode account number from given bytes
  AccountNumber decodeFromBytes(Uint8List bytes) {
    String accountNum = Int32.decodeFromBytes(bytes).toRadixString(10);
    return AccountNumber(accountNum);
  }

  /// Encode an account number to bytes
  Uint8List encodeToBytes(AccountNumber accountNumber) {
    return Int32.encodeToBytes(accountNumber.account);;
  }
}
