import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/common/coding/core/Int16.dart';
import 'package:pascaldart/src/common/coding/core/Int32.dart';
import 'package:pascaldart/src/common/coding/pascal/AccountNumberCoder.dart';
import 'package:pascaldart/src/common/coding/pascal/CurrencyCoder.dart';
import 'package:pascaldart/src/common/coding/pascal/OpTypeCoder.dart';
import 'package:pascaldart/src/common/model/AccountNumber.dart';
import 'package:pascaldart/src/common/model/Currency.dart';
import 'package:pascaldart/src/crypto/model/Signature.dart';
import 'package:pascaldart/src/signing/operations/BaseOperation.dart';

class DataOperation extends BaseOperation {
  AccountNumber signer;
  AccountNumber sender;
  AccountNumber target;
  int dataType;
  int dataSequence;
  Currency amount;

  int opType() {
    return 10;
  }

  /// Creates a new Change Key operation
  DataOperation(
      {@required this.signer,
      @required this.sender,
      @required this.target,
      this.amount,
      this.dataType = 0,
      this.dataSequence = 0})
      : super() {
    amount = Currency('0');
  }

  /// Decode this operation from raw bytes
  static DataOperation decodeFromBytes(Uint8List bytes) {
    // Decode byte-by-byte
    int offset = 0;
    // Signer
    AccountNumberCoder acctNumCoder = AccountNumberCoder();
    Uint8List signerBytes = bytes.sublist(offset, offset + 4);
    AccountNumber signer = acctNumCoder.decodeFromBytes(signerBytes);
    offset += 4;
    // Sender
    Uint8List senderBytes = bytes.sublist(offset, offset + 4);
    AccountNumber sender = acctNumCoder.decodeFromBytes(senderBytes);
    offset += 4;
    // Target
    Uint8List targetBytes = bytes.sublist(offset, offset + 4);
    AccountNumber target = acctNumCoder.decodeFromBytes(targetBytes);
    offset += 4;
    // nOp
    Uint8List nOperationBytes = bytes.sublist(offset, offset + 4);
    int nOperation = Int32.decodeFromBytes(nOperationBytes);
    offset += 4;
    // Data Type
    Uint8List dataTypeBytes = bytes.sublist(offset, offset + 2);
    int dataType = Int16.decodeFromBytes(dataTypeBytes);
    offset += 2;
    // Data Sequence
    Uint8List dataSequenceBytes = bytes.sublist(offset, offset + 2);
    int dataSequence = Int16.decodeFromBytes(dataSequenceBytes);
    offset += 2;
    // Amount
    Uint8List amountBytes = bytes.sublist(offset, offset + 8);
    Currency amount = CurrencyCoder().decodeFromBytes(amountBytes);
    offset += 8;
    // Fee
    Uint8List feeBytes = bytes.sublist(offset, offset + 8);
    Currency fee = CurrencyCoder().decodeFromBytes(feeBytes);
    offset += 8;
    // Payload
    int payloadLength = Util.decodeLength(bytes.sublist(offset, offset + 2));
    offset += 2;
    Uint8List payload = bytes.sublist(offset, offset + payloadLength);
    offset += payloadLength;
    // Signature
    int rLength = Util.decodeLength(bytes.sublist(offset, offset + 2));
    offset += 2;
    BigInt r = Util.decodeBigInt(bytes.sublist(offset, offset + rLength));
    offset += rLength;
    int sLength = Util.decodeLength(bytes.sublist(offset, offset + 2));
    offset += 2;
    BigInt s = Util.decodeBigInt(bytes.sublist(offset, offset + sLength));
    Signature signature = Signature(r: r, s: s);

    // Return op
    return DataOperation(
        signer: signer,
        sender: sender,
        target: target,
        amount: amount,
        dataType: dataType,
        dataSequence: dataSequence)
      ..withNOperation(nOperation)
      ..withFee(fee)
      ..withPayload(payload)
      ..withSignature(signature);
  }

  /// Encode this operation into raw bytes
  Uint8List encodeToBytes() {
    Uint8List signer = AccountNumberCoder().encodeToBytes(this.signer);
    Uint8List sender = AccountNumberCoder().encodeToBytes(this.sender);
    Uint8List target = AccountNumberCoder().encodeToBytes(this.target);
    Uint8List nOperation = Int32.encodeToBytes(this.nOperation);
    Uint8List dataType = Int16.encodeToBytes(this.dataType);
    Uint8List dataSequence = Int16.encodeToBytes(this.dataSequence);
    Uint8List amount = CurrencyCoder().encodeToBytes(this.amount);
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee);
    Uint8List payloadLength = Util.encodeLength(this.payload.length);
    Uint8List payload = this.payload;
    Uint8List r = Util.encodeBigInt(signature.r);
    Uint8List rLength = Util.encodeLength(r.length);
    Uint8List s = Util.encodeBigInt(signature.s);
    Uint8List sLength = Util.encodeLength(s.length);
    return Util.concat([
      signer,
      sender,
      target,
      nOperation,
      dataType,
      dataSequence,
      amount,
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
    Uint8List signer = AccountNumberCoder().encodeToBytes(this.signer);
    Uint8List sender = AccountNumberCoder().encodeToBytes(this.sender);
    Uint8List target = AccountNumberCoder().encodeToBytes(this.target);
    Uint8List nOperation = Int32.encodeToBytes(this.nOperation);
    Uint8List dataType = Int16.encodeToBytes(this.dataType);
    Uint8List dataSequence = Int16.encodeToBytes(this.dataSequence);
    Uint8List amount = CurrencyCoder().encodeToBytes(this.amount);
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee);
    Uint8List payloadLength = Util.encodeLength(this.payload.length);
    Uint8List payload = this.payload;
    Uint8List type = OpTypeCoder(1).encodeToBytes(this.opType());
    return Util.concat([
      signer,
      sender,
      target,
      nOperation,
      dataType,
      dataSequence,
      amount,
      fee,
      payloadLength,
      payload,
      type
    ]);
  }

  bool usesDigestToSign() {
    return true;
  }
}
