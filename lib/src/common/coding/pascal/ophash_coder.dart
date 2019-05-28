import 'dart:typed_data';

import 'package:pascaldart/src/common/coding/core/int32.dart';
import 'package:pascaldart/src/common/model/operation_hash.dart';
import 'package:pascaldart/src/common/pascaldart_util.dart';

class OperationHashCoder {
  OperationHash decodeFromBytes(Uint8List bytes) {
    // Block number is an uint32 in first 4 bytes
    int blockNoInt = Int32.decodeFromBytes(bytes.sublist(0, 4));
    // Account # is next 4 bytes
    int accountNoInt = Int32.decodeFromBytes(bytes.sublist(4, 8));
    // NOperation is next 4 bytes
    int nOpInt = Int32.decodeFromBytes(bytes.sublist(8, 12));
    // md160 is final bytes
    Uint8List md160 = bytes.sublist(12);
    return OperationHash(blockNoInt, accountNoInt, nOpInt, md160);
  }

  Uint8List encodeToBytes(OperationHash opHash) {
    // Block number is 4-byte uint32
    Uint8List blockNo = Int32.encodeToBytes(opHash.block);
    // Account # is 4-byte uint32
    Uint8List accountNo = Int32.encodeToBytes(opHash.account.account);
    // NOperation is 4-byte uint32
    Uint8List nOp = Int32.encodeToBytes(opHash.nOperation);
    // md160 is remaining bytes
    return PDUtil.concat([blockNo, accountNo, nOp, opHash.md160]);
  }
}