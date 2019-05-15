import 'dart:typed_data';

import 'package:pascaldart/src/common/types/AccountNumber.dart';

/// Holds information about an operation hash.
class OperationHash {
  int block;
  int nOperation;
  AccountNumber account;
  Uint8List md160;

  OperationHash(this.block, int account, this.nOperation, this.md160) {
    this.account = AccountNumber.fromInt(account);
    if (md160.lengthInBytes != 20) {
      throw Exception('Invalid operation hash - md160 size != 20 bytes.');
    }
  }
}