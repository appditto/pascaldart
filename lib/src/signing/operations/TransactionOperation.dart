import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:pascaldart/crypto.dart';
import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/common/coding/core/Int32.dart';
import 'package:pascaldart/src/common/coding/pascal/AccountNumberCoder.dart';
import 'package:pascaldart/src/common/coding/pascal/CurrencyCoder.dart';
import 'package:pascaldart/src/common/coding/pascal/OpTypeCoder.dart';
import 'package:pascaldart/src/common/coding/pascal/keys/CurveCoder.dart';
import 'package:pascaldart/src/common/model/AccountNumber.dart';
import 'package:pascaldart/src/common/model/Currency.dart';
import 'package:pascaldart/src/signing/operations/BaseOperation.dart';

/// Representation of a signable Transaction operation.
class TransactionOperation extends BaseOperation {
  AccountNumber sender;
  AccountNumber target;
  Currency amount;

  int opType() {
    return 1;
  }

  /// Creates a new Transaction instance with the given data. The payload is
  /// empty by default and not encoded.
  TransactionOperation({@required this.sender, @required this.target, @required this.amount}) : super();

  /// Decode this operation from raw bytes
  static TransactionOperation decodeFromBytes(Uint8List bytes) {
    // Decode byte-by-byte
    int offset = 0;
    // Sender
    AccountNumberCoder acctNumCoder = AccountNumberCoder();
    Uint8List senderBytes = bytes.sublist(offset, offset + 4);
    AccountNumber sender = acctNumCoder.decodeFromBytes(senderBytes);
    offset += 4;
    // nOp
    Uint8List nOperationBytes = bytes.sublist(offset, offset + 4);
    int nOperation = Int32.decodeFromBytes(nOperationBytes);
    offset += 4;
    // Receiver
    Uint8List targetBytes = bytes.sublist(offset, offset + 4);
    AccountNumber target = acctNumCoder.decodeFromBytes(targetBytes);
    offset += 4;
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
    // Skip curve bytes
    // 6 zero-bytes are always here
    offset += 6;
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
    return TransactionOperation(
      sender: sender,
      target: target,
      amount: amount
    )..withNOperation(nOperation)
     ..withFee(fee)
     ..withPayload(payload)
     ..withSign(signature);
  }

  /// Encode this operation into raw bytes
  Uint8List encodeToBytes() {
    Uint8List sender = AccountNumberCoder().encodeToBytes(this.sender);
    Uint8List nOperation = Int32.encodeToBytes(this.nOperation);
    Uint8List target = AccountNumberCoder().encodeToBytes(this.target);
    Uint8List amount = CurrencyCoder().encodeToBytes(this.amount);
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee);
    Uint8List payloadLength = Util.encodeLength(this.payload.length);
    Uint8List payload = this.payload;
    // Not used in modern pascal coin?
    Uint8List curve = CurveCoder().encodeToBytes(0);
    Uint8List r = Util.encodeBigInt(signature.r);
    Uint8List rLength = Util.encodeLength(r.length);
    Uint8List s = Util.encodeBigInt(signature.s);
    Uint8List sLength = Util.encodeLength(s.length);
    return Util.concat([
      sender,
      nOperation,
      target,
      amount,
      fee,
      payloadLength,
      payload,
      curve,
      rLength,
      r,
      sLength,
      s
    ]);
  }

  /// Gets the digest of this operation
  Uint8List digest() {
    Uint8List sender = AccountNumberCoder().encodeToBytes(this.sender);
    Uint8List nOperation = Int32.encodeToBytes(this.nOperation);
    Uint8List target = AccountNumberCoder().encodeToBytes(this.target);
    Uint8List amount = CurrencyCoder().encodeToBytes(this.amount);
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee);
    Uint8List payload = this.payload;
    // Not used in modern pascal coin?
    Uint8List curve = CurveCoder().encodeToBytes(0);
    Uint8List type = OpTypeCoder(1).encodeToBytes(this.opType());
    return Util.concat([
      sender,
      nOperation,
      target,
      amount,
      fee,
      payload,
      curve,
      type
    ]);
  }
}