import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:pascaldart/src/common/pascaldart_util.dart';
import 'package:pascaldart/src/common/coding/core/int32.dart';
import 'package:pascaldart/src/common/coding/pascal/accountnumber_coder.dart';
import 'package:pascaldart/src/common/coding/pascal/currency_coder.dart';
import 'package:pascaldart/src/common/coding/pascal/optype_coder.dart';
import 'package:pascaldart/src/common/coding/pascal/keys/publickey_coder.dart';
import 'package:pascaldart/src/common/model/accountnumber.dart';
import 'package:pascaldart/src/common/model/currency.dart';
import 'package:pascaldart/src/common/model/keys/publickey.dart';
import 'package:pascaldart/src/crypto/model/signature.dart';
import 'package:pascaldart/src/signing/operations/base_operation.dart';

class BuyAccountOperation extends BaseOperation {
  AccountNumber sender;
  AccountNumber target;
  Currency amount;
  Currency price;
  AccountNumber seller;
  PublicKey newPublicKey;

  int opType() {
    return 6;
  }

  /// Creates a new List account for sale operation
  BuyAccountOperation(
      {@required this.sender,
      @required this.target,
      this.amount,
      @required this.price,
      @required this.seller,
      this.newPublicKey})
      : super() {
    this.amount = this.amount ?? Currency('0');
    this.newPublicKey = this.newPublicKey ?? PublicKey.empty();
  }

  /// Decode this operation from raw bytes
  static BuyAccountOperation decodeFromBytes(Uint8List bytes) {
    // Decode byte-by-byte
    int offset = 0;
    // Signer
    AccountNumberCoder acctNumCoder = AccountNumberCoder();
    Uint8List senderBytes = bytes.sublist(offset, offset + 4);
    AccountNumber sender = acctNumCoder.decodeFromBytes(senderBytes);
    offset += 4;
    // nOp
    Uint8List nOperationBytes = bytes.sublist(offset, offset + 4);
    int nOperation = Int32.decodeFromBytes(nOperationBytes);
    offset += 4;
    // Target
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
    int payloadLength = PDUtil.decodeLength(bytes.sublist(offset, offset + 2));
    offset += 2;
    Uint8List payload = bytes.sublist(offset, offset + payloadLength);
    offset += payloadLength;
    // 6 zero-bytes are always here
    offset += 6;
    // Fixed type
    int fixedType = Int8.decodeFromBytes(bytes.sublist(offset, offset + 1));
    offset += 1;
    // Price
    Uint8List priceBytes = bytes.sublist(offset, offset + 8);
    Currency price = CurrencyCoder().decodeFromBytes(priceBytes);
    offset += 8;
    // Seller
    Uint8List sellerBytes = bytes.sublist(offset, offset + 4);
    AccountNumber seller = acctNumCoder.decodeFromBytes(sellerBytes);
    offset += 4;
    // New public key
    int newPublicKeyLength =
        PDUtil.decodeLength(bytes.sublist(offset, offset + 2));
    PublicKey newPublicKey;
    if (newPublicKeyLength == 0) {
      offset += 6;
      newPublicKey = PublicKey.empty();
    } else {
      offset += 2;
      Uint8List newPublicKeyBytes =
          bytes.sublist(offset, offset + newPublicKeyLength);
      newPublicKey = PublicKeyCoder().decodeFromBytes(newPublicKeyBytes);
      offset += newPublicKeyLength;
    }
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
    return BuyAccountOperation(
        sender: sender,
        target: target,
        amount: amount,
        price: price,
        seller: seller,
        newPublicKey: newPublicKey)
      ..withNOperation(nOperation)
      ..withFee(fee)
      ..withPayload(payload)
      ..withSignature(signature);
  }

  /// Encode this operation into raw bytes
  Uint8List encodeToBytes() {
    Uint8List sender = AccountNumberCoder().encodeToBytes(this.sender);
    Uint8List nOperation = Int32.encodeToBytes(this.nOperation);
    Uint8List target = AccountNumberCoder().encodeToBytes(this.target);
    Uint8List amount = CurrencyCoder().encodeToBytes(this.amount);
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee);
    Uint8List payloadLength = PDUtil.encodeLength(this.payload.length);
    Uint8List payload = this.payload;
    Uint8List v2publickey = PublicKeyCoder().encodeToBytes(PublicKey.empty());
    Uint8List fixedType = Int8.encodeToBytes(2);
    Uint8List price = CurrencyCoder().encodeToBytes(this.price);
    Uint8List seller = AccountNumberCoder().encodeToBytes(this.seller);
    Uint8List newPublicKey = PublicKeyCoder().encodeToBytes(this.newPublicKey);
    Uint8List newPublicKeyLength = PDUtil.encodeLength(newPublicKey.length);
    newPublicKeyLength =
        newPublicKey.length == 6 ? Uint8List(0) : newPublicKeyLength;
    Uint8List r = PDUtil.encodeBigInt(signature.r);
    Uint8List rLength = PDUtil.encodeLength(r.length);
    Uint8List s = PDUtil.encodeBigInt(signature.s);
    Uint8List sLength = PDUtil.encodeLength(s.length);
    return PDUtil.concat([
      sender,
      nOperation,
      target,
      amount,
      fee,
      payloadLength,
      payload,
      v2publickey,
      fixedType,
      price,
      seller,
      newPublicKeyLength,
      newPublicKey,
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
    Uint8List v2publickey = Uint8List.fromList([0, 0]);
    Uint8List price = CurrencyCoder().encodeToBytes(this.price);
    Uint8List seller = AccountNumberCoder().encodeToBytes(this.seller);
    Uint8List newPublicKey = PublicKeyCoder().encodeToBytes(this.newPublicKey);
    Uint8List type = OpTypeCoder(1).encodeToBytes(this.opType());
    return PDUtil.concat([
      sender,
      nOperation,
      target,
      amount,
      fee,
      payload,
      v2publickey,
      price,
      seller,
      newPublicKey,
      type
    ]);
  }
}
