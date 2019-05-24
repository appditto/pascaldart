
import 'dart:typed_data';

import 'package:pascaldart/src/common/PascalCoinInfo.dart';
import 'package:pascaldart/src/common/model/Currency.dart';
import 'package:pascaldart/src/crypto/model/Signature.dart';

abstract class BaseOperation<T> {
  Uint8List payload;
  Signature signature;
  Currency fee;
  int nOperation;

  BaseOperation({this.payload, this.signature, this.fee}) {
    this.payload = this.payload ?? Uint8List(1);
    this.fee = this.fee ?? Currency('0');
  }

  /// Sets the payload of the transaction instance.
  BaseOperation withPayload(Uint8List payload) {
    this.payload = payload;
    return this;
  }

  /// Sets the fee.
  BaseOperation withFee(Currency fee) {
    this.fee = fee;
    return this;
  }

  /// Sets the fee to the minimum.
  BaseOperation withMinFee() {
    this.fee = PascalCoinInfo.MIN_FEE();
    return this;
  }

  BaseOperation withNOperation(int nOperation) {
    this.nOperation = nOperation;
    return this;
  }

  BaseOperation withSign(Signature signature) {
    this.signature = signature;
    return this;
  }

  /// Gets a value indicating whether the current operation is already signed.
  bool isSigned() {
    return this.signature != null;
  }

  bool usesDigestToSign() {
    return false;
  }

  Uint8List encodeToBytes();
  T decodeFromBytes(Uint8List bytes);
  int opType();
}