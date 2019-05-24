
import 'dart:typed_data';

import 'package:pascaldart/src/common/PascalCoinInfo.dart';
import 'package:pascaldart/src/common/model/Currency.dart';
import 'package:pascaldart/src/common/model/keys/PrivateKey.dart';
import 'package:pascaldart/src/crypto/model/Signature.dart';
import 'package:pascaldart/src/signing/Signer.dart';

abstract class BaseOperation {
  Uint8List payload;
  Signature signature;
  Currency fee;
  int nOperation;

  BaseOperation({this.payload, this.signature, this.fee}) {
    this.payload = this.payload ?? Uint8List(1);
    this.fee = this.fee ?? Currency('0');
  }

  /// Sets the payload of the transaction instance.
  void withPayload(Uint8List payload) {
    this.payload = payload;
  }

  /// Sets the fee.
  void withFee(Currency fee) {
    this.fee = fee;
  }

  /// Sets the fee to the minimum.
  void withMinFee() {
    this.fee = PascalCoinInfo.MIN_FEE();
  }

  void withNOperation(int nOperation) {
    this.nOperation = nOperation;
  }

  void withSignature(Signature signature) {
    this.signature = signature;
  }

  /// Gets a value indicating whether the current operation is already signed.
  bool isSigned() {
    return this.signature != null;
  }

  bool usesDigestToSign() {
    return false;
  }

  Uint8List digest();
  Uint8List encodeToBytes();
  int opType();

  /// Sign the operation
  void sign(PrivateKey privateKey) {
    Uint8List digest = this.digest();

    if (this.usesDigestToSign()) {
      this.signature = Signer.signDigest(privateKey, digest);
    } else {
      this.signature = Signer.signWithHash(privateKey, digest);
    }
  }
}