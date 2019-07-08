import 'dart:typed_data';

import 'package:meta/meta.dart';
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

class ChangeKeySignedOperation extends BaseOperation {
  AccountNumber signer;
  AccountNumber target;
  PublicKey newPublicKey;

  int opType() {
    return 7;
  }

  /// Creates a new Change Key operation
  ChangeKeySignedOperation(
      {@required this.signer,
      @required this.target,
      @required this.newPublicKey})
      : super();

  /// Decode this operation from raw bytes
  static ChangeKeySignedOperation decodeFromBytes(Uint8List bytes) {
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
    // Skip curve bytes
    // 6 zero-bytes are always here
    offset += 6;
    // New public key
    int newPublicKeyLength =
        PDUtil.decodeLength(bytes.sublist(offset, offset + 2));
    offset += 2;
    Uint8List newPublicKeyBytes =
        bytes.sublist(offset, offset + newPublicKeyLength);
    PublicKey newPublicKey =
        PublicKeyCoder().decodeFromBytes(newPublicKeyBytes);
    offset += newPublicKeyLength;
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
    return ChangeKeySignedOperation(
        signer: signer, target: target, newPublicKey: newPublicKey)
      ..withNOperation(nOperation)
      ..withFee(fee)
      ..withPayload(payload)
      ..withSignature(signature);
  }

  /// Encode this operation into raw bytes
  Uint8List encodeToBytes() {
    Uint8List signer = AccountNumberCoder().encodeToBytes(this.signer);
    Uint8List target = AccountNumberCoder().encodeToBytes(this.target);
    Uint8List nOperation = Int32.encodeToBytes(this.nOperation);
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee);
    Uint8List payloadLength = PDUtil.encodeLength(this.payload.length);
    Uint8List payload = this.payload;
    // Not used in modern pascal coin?
    Uint8List v2publickey = PublicKeyCoder().encodeToBytes(PublicKey.empty());
    Uint8List newPublicKey = PublicKeyCoder().encodeToBytes(this.newPublicKey);
    Uint8List newPublicKeyLength = PDUtil.encodeLength(newPublicKey.length);
    Uint8List r = PDUtil.encodeBigInt(signature.r);
    Uint8List rLength = PDUtil.encodeLength(r.length);
    Uint8List s = PDUtil.encodeBigInt(signature.s);
    Uint8List sLength = PDUtil.encodeLength(s.length);
    return PDUtil.concat([
      signer,
      target,
      nOperation,
      fee,
      payloadLength,
      payload,
      v2publickey,
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
    Uint8List signer = AccountNumberCoder().encodeToBytes(this.signer);
    Uint8List target = AccountNumberCoder().encodeToBytes(this.target);
    Uint8List nOperation = Int32.encodeToBytes(this.nOperation);
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee);
    Uint8List payload = this.payload;
    // Not used in modern pascal coin?
    Uint8List v2publickey = Uint8List.fromList([0, 0]);
    Uint8List newPublicKey = PublicKeyCoder().encodeToBytes(this.newPublicKey);
    Uint8List type = OpTypeCoder(1).encodeToBytes(this.opType());
    return PDUtil.concat([
      signer,
      target,
      nOperation,
      fee,
      payload,
      v2publickey,
      newPublicKey,
      type
    ]);
  }
}
