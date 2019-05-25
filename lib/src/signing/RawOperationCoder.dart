import 'dart:typed_data';

import 'package:pascaldart/signing.dart';
import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/common/coding/core/Int32.dart';
import 'package:pascaldart/src/signing/operations/BaseOperation.dart';
import 'package:pascaldart/src/signing/operations/ChangeKeyOperation.dart';
import 'package:pascaldart/src/signing/operations/ChangeKeySignedOperation.dart';
import 'package:pascaldart/src/signing/operations/TransactionOperation.dart';
import 'package:pascaldart/src/signing/operations/ListForSaleOperation.dart';
import 'package:pascaldart/src/signing/operations/DeListForSaleOperation.dart';
import 'package:pascaldart/src/signing/operations/BuyAccountOperation.dart';

class RawOperationCoder {
  static BaseOperation decodeFromBytes(Uint8List bytes) {
    // Numer of operations in these raw bytes
    // TODO support multi-ops
    int count = Int32.decodeFromBytes(bytes.sublist(0, 4));
    int type = Int32.decodeFromBytes(bytes.sublist(4, 8));
    switch (type) {
      case 1:
        return TransactionOperation.decodeFromBytes(
            bytes.sublist(8, bytes.length));
      case 2:
        return ChangeKeyOperation.decodeFromBytes(
            bytes.sublist(8, bytes.length));
      case 4:
        return ListForSaleOperation.decodeFromBytes(
            bytes.sublist(8, bytes.length));
      case 5:
        return DeListForSaleOperation.decodeFromBytes(
            bytes.sublist(8, bytes.length));
      case 6:
        return BuyAccountOperation.decodeFromBytes(
            bytes.sublist(8, bytes.length));
      case 7:
        return ChangeKeySignedOperation.decodeFromBytes(
            bytes.sublist(8, bytes.length));
      case 8:
        return ChangeAccountInfoOperation.decodeFromBytes(
            bytes.sublist(8, bytes.length));
      default:
        throw Exception("Couldn't decode operation type");
    }
  }

  static Uint8List encodeToBytes(BaseOperation operation) {
    // TODO - multi-op support
    Uint8List count = Int32.encodeToBytes(1);
    // Type
    Uint8List type = Int32.encodeToBytes(operation.opType());
    // Op
    Uint8List op = operation.encodeToBytes();
    return Util.concat([count, type, op]);
  }
}
