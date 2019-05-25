import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:pascaldart/pascaldart.dart';
import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/common/coding/core/Int32.dart';
import 'package:pascaldart/src/common/coding/pascal/AccountNumberCoder.dart';
import 'package:pascaldart/src/common/coding/pascal/CurrencyCoder.dart';
import 'package:pascaldart/src/common/coding/pascal/OpTypeCoder.dart';
import 'package:pascaldart/src/common/coding/pascal/keys/PublicKeyCoder.dart';
import 'package:pascaldart/src/common/model/AccountNumber.dart';
import 'package:pascaldart/src/common/model/Currency.dart';
import 'package:pascaldart/src/common/model/keys/PublicKey.dart';
import 'package:pascaldart/src/crypto/model/Signature.dart';
import 'package:pascaldart/src/signing/operations/BaseOperation.dart';

class ListForSaleOperation extends BaseOperation {
  AccountNumber accountSigner;
  AccountNumber targetSigner;
  Currency price;
  AccountNumber accountToPay;
  PublicKey newPublicKey;
  int lockedUntilBlock;

  int opType() {
    return 4;
  }

  /// Creates a new List account for sale operation
  ListForSaleOperation(
      {@required this.accountSigner,
      @required this.targetSigner,
      @required this.price,
      @required this.accountToPay,
      this.newPublicKey,
      this.lockedUntilBlock})
      : super() {
    this.newPublicKey = this.newPublicKey ?? PublicKey.empty();
    this.lockedUntilBlock = this.lockedUntilBlock ?? 0;
  }

  void asPrivateSale(PublicKey newPublicKey, int lockedUntilBlock) {
    this.newPublicKey = newPublicKey;
    this.lockedUntilBlock = lockedUntilBlock;
  }

  /// Decode this operation from raw bytes
  static ListForSaleOperation decodeFromBytes(Uint8List bytes) {
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
    int opType = OpTypeCoder(2).decodeFromBytes(opTypeBytes);
    offset += 2;
    // nOp
    Uint8List nOperationBytes = bytes.sublist(offset, offset + 4);
    int nOperation = Int32.decodeFromBytes(nOperationBytes);
    offset += 4;
    // Price
    Uint8List priceBytes = bytes.sublist(offset, offset + 8);
    Currency price = CurrencyCoder().decodeFromBytes(priceBytes);
    offset += 8;
    // Account to pay
    Uint8List toPayBytes = bytes.sublist(offset, offset + 4);
    AccountNumber accountToPay = acctNumCoder.decodeFromBytes(toPayBytes);
    offset += 4;
    // 6 zero-bytes are always here
    offset += 6;
    // New public key
    int newPublicKeyLength =
        Util.decodeLength(bytes.sublist(offset, offset + 2));
    offset += 2;
    Uint8List newPublicKeyBytes =
        bytes.sublist(offset, offset + newPublicKeyLength);
    PublicKey newPublicKey =
        PublicKeyCoder().decodeFromBytes(newPublicKeyBytes);
    offset += newPublicKeyLength;
    // Locked until block
    Uint8List lockedUntilBytes = bytes.sublist(offset, offset + 4);
    int lockedUntilBlock = Int32.decodeFromBytes(lockedUntilBytes);
    offset += 4;
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
    return ListForSaleOperation(
        accountSigner: signer,
        targetSigner: target,
        price: price,
        accountToPay: accountToPay)
      ..withNOperation(nOperation)
      ..withFee(fee)
      ..withPayload(payload)
      ..asPrivateSale(newPublicKey, lockedUntilBlock)
      ..withSignature(signature);
  }

  /// Encode this operation into raw bytes
  Uint8List encodeToBytes() {
    Uint8List signer = AccountNumberCoder().encodeToBytes(this.accountSigner);
    Uint8List target = AccountNumberCoder().encodeToBytes(this.targetSigner);
    Uint8List opType = OpTypeCoder(2).encodeToBytes(this.opType());
    Uint8List nOperation = Int32.encodeToBytes(this.nOperation);
    Uint8List price = CurrencyCoder().encodeToBytes(this.price);
    Uint8List accountToPay =
        AccountNumberCoder().encodeToBytes(this.accountToPay);
    Uint8List v2publickey = PublicKeyCoder().encodeToBytes(PublicKey.empty());
    Uint8List newPublicKey = PublicKeyCoder().encodeToBytes(this.newPublicKey);
    Uint8List newPublicKeyLength = Util.encodeLength(newPublicKey.length);
    Uint8List lockedUntilBlock = Int32.encodeToBytes(this.lockedUntilBlock);
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee);
    Uint8List payloadLength = Util.encodeLength(this.payload.length);
    Uint8List payload = this.payload;
    Uint8List r = Util.encodeBigInt(signature.r);
    Uint8List rLength = Util.encodeLength(r.length);
    Uint8List s = Util.encodeBigInt(signature.s);
    Uint8List sLength = Util.encodeLength(s.length);
    return Util.concat([
      signer,
      target,
      opType,
      nOperation,
      price,
      accountToPay,
      v2publickey,
      newPublicKeyLength,
      newPublicKey,
      lockedUntilBlock,
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
    Uint8List nOperation = Int32.encodeToBytes(this.nOperation);
    Uint8List price = CurrencyCoder().encodeToBytes(this.price);
    Uint8List accountToPay =
        AccountNumberCoder().encodeToBytes(this.accountToPay);
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee);
    Uint8List payload = this.payload;
    // Not used in modern pascal coin?
    Uint8List v2publickey = PublicKeyCoder().encodeToBytes(PublicKey.empty());
    Uint8List newPublicKey = PublicKeyCoder().encodeToBytes(this.newPublicKey);
    Uint8List lockedUntilBlock = Int32.encodeToBytes(this.lockedUntilBlock);
    Uint8List type = OpTypeCoder(1).encodeToBytes(this.opType());
    return Util.concat([
      signer,
      target,
      nOperation,
      price,
      accountToPay,
      fee,
      payload,
      v2publickey,
      newPublicKey,
      lockedUntilBlock,
      type
    ]);
  }
}
