import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:pascaldart/src/common/pascaldart_util.dart';
import 'package:pascaldart/src/common/coding/core/int32.dart';
import 'package:pascaldart/src/common/coding/pascal/accountnumber_coder.dart';
import 'package:pascaldart/src/common/coding/pascal/currency_coder.dart';
import 'package:pascaldart/src/common/coding/pascal/optype_coder.dart';
import 'package:pascaldart/src/common/model/accountnumber.dart';
import 'package:pascaldart/src/common/model/currency.dart';
import 'package:pascaldart/src/crypto/model/signature.dart';
import 'package:pascaldart/src/signing/operations/base_operation.dart';

class DeListForSaleOperation extends BaseOperation {
  AccountNumber accountSigner;
  AccountNumber targetSigner;
  late Currency price;
  late AccountNumber accountToPay;
  late PublicKey newPublicKey;
  int? lockedUntilBlock;

  int opType() {
    return 5;
  }

  /// Creates a new List account for sale operation
  DeListForSaleOperation(
      {required this.accountSigner, required this.targetSigner})
      : super() {
    this.price = Currency('0');
    this.accountToPay = AccountNumber.fromInt(0);
    this.newPublicKey = PublicKey.empty();
    this.lockedUntilBlock = 0;
  }

  /// Decode this operation from raw bytes
  static DeListForSaleOperation decodeFromBytes(Uint8List bytes) {
    // Decode byte-by-byte
    int offset = 0;
    // Signer
    AccountNumberCoder acctNumCoder = AccountNumberCoder();
    Uint8List signerBytes = bytes.sublist(offset, offset + 4);
    AccountNumber signer = acctNumCoder.decodeFromBytes(signerBytes);
    offset += 4;
    // Target
    Uint8List targetBytes = bytes.sublist(offset, offset + 4);
    AccountNumber target = acctNumCoder.decodeFromBytes(targetBytes);
    offset += 4;
    // Optype
    Uint8List opTypeBytes = bytes.sublist(offset, offset + 2);
    //int opType = OpTypeCoder(2).decodeFromBytes(opTypeBytes);
    offset += 2;
    // nOp
    Uint8List nOperationBytes = bytes.sublist(offset, offset + 4);
    int nOperation = Int32.decodeFromBytes(nOperationBytes);
    offset += 4;
    // Fee
    Uint8List feeBytes = bytes.sublist(offset, offset + 8);
    Currency fee = CurrencyCoder().decodeFromBytes(feeBytes);
    offset += 8;
    // Payload
    int payloadLength = PDUtil.decodeLength(bytes.sublist(offset, offset + 2));
    offset += 2;
    Uint8List payload = bytes.sublist(offset, offset + payloadLength);
    offset += payloadLength;
    // Signature
    int rLength = PDUtil.decodeLength(bytes.sublist(offset, offset + 2));
    offset += 2;
    BigInt r = PDUtil.decodeBigInt(bytes.sublist(offset, offset + rLength));
    offset += rLength;
    int sLength = PDUtil.decodeLength(bytes.sublist(offset, offset + 2));
    offset += 2;
    BigInt s = PDUtil.decodeBigInt(bytes.sublist(offset, offset + sLength));
    Signature signature = Signature(r: r, s: s);

    // Return op
    return DeListForSaleOperation(accountSigner: signer, targetSigner: target)
      ..withNOperation(nOperation)
      ..withFee(fee)
      ..withPayload(payload)
      ..withSignature(signature);
  }

  /// Encode this operation into raw bytes
  Uint8List encodeToBytes() {
    Uint8List signer = AccountNumberCoder().encodeToBytes(this.accountSigner);
    Uint8List target = AccountNumberCoder().encodeToBytes(this.targetSigner);
    Uint8List opType = OpTypeCoder(2).encodeToBytes(this.opType());
    Uint8List nOperation = Int32.encodeToBytes(this.nOperation!);
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee!);
    Uint8List payloadLength = PDUtil.encodeLength(this.payload!.length);
    Uint8List? payload = this.payload;
    Uint8List r = PDUtil.encodeBigInt(signature!.r);
    Uint8List rLength = PDUtil.encodeLength(r.length);
    Uint8List s = PDUtil.encodeBigInt(signature!.s);
    Uint8List sLength = PDUtil.encodeLength(s.length);
    return PDUtil.concat([
      signer,
      target,
      opType,
      nOperation,
      fee,
      payloadLength,
      payload,
      rLength,
      r,
      sLength,
      s
    ]);
  }

  /// Gets the digest of this operation
  Uint8List digest() {
    Uint8List signer = AccountNumberCoder().encodeToBytes(this.accountSigner);
    Uint8List target = AccountNumberCoder().encodeToBytes(this.targetSigner);
    Uint8List nOperation = Int32.encodeToBytes(this.nOperation!);
    Uint8List price = CurrencyCoder().encodeToBytes(this.price);
    Uint8List accountToPay =
        AccountNumberCoder().encodeToBytes(this.accountToPay);
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee!);
    Uint8List? payload = this.payload;
    Uint8List v2publickey = PublicKeyCoder().encodeToBytes(PublicKey.empty());
    Uint8List newPublicKey = PublicKeyCoder().encodeToBytes(this.newPublicKey);
    //Uint8List lockedUntilBlock = Int32.encodeToBytes(this.lockedUntilBlock);
    Uint8List type = OpTypeCoder(1).encodeToBytes(this.opType());
    return PDUtil.concat([
      signer,
      target,
      nOperation,
      price,
      accountToPay,
      fee,
      payload,
      v2publickey,
      newPublicKey,
      type
    ]);
  }
}
