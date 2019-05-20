import 'dart:typed_data';

import 'package:pascaldart/src/common/model/OperationHash.dart';
import 'package:pascaldart/src/common/Util.dart';

class OperationHashCoder {
  OperationHash decodeFromBytes(Uint8List bytes) {
    // Block number is an uint32 in first 4 bytes
    Uint8List blockNo = bytes.sublist(0, 4);
    int blockNoInt = blockNo.buffer.asByteData().getUint32(0, Endian.little);
    // Account # is next 4 bytes
    Uint8List accountNo = bytes.sublist(4, 8);
    int accountNoInt = accountNo.buffer.asByteData().getUint32(0, Endian.little);
    // NOperation is next 4 bytes
    Uint8List nOp = bytes.sublist(8, 12);
    int nOpInt = nOp.buffer.asByteData().getUint32(0, Endian.little);
    // md160 is final bytes
    Uint8List md160 = bytes.sublist(12);
    return OperationHash(blockNoInt, accountNoInt, nOpInt, md160);
  }

  Uint8List encodeToBytes(OperationHash opHash) {
    // Block number is 4-byte uint32
    Uint32List blockNoU32 = Uint32List(1);
    blockNoU32.buffer.asByteData().setUint32(0, opHash.block, Endian.little);
    // Account # is 4-byte uint32
    Uint32List accountNoU32 = Uint32List(1);
    accountNoU32.buffer.asByteData().setUint32(0, opHash.account.account, Endian.little);
    // NOperation is 4-byte uint32
    Uint32List nOpU32 = Uint32List(1);
    nOpU32.buffer.asByteData().setUint32(0, opHash.nOperation, Endian.little);
    // md160 is remaining bytes
    return Util.concat([blockNoU32.buffer.asUint8List(), accountNoU32.buffer.asUint8List(), nOpU32.buffer.asUint8List(), opHash.md160]);
  }
}