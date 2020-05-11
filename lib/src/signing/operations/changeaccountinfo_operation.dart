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

class ChangeAccountInfoOperation extends BaseOperation {
  AccountNumber accountSigner;
  AccountNumber targetSigner;
  PublicKey newPublicKey;
  AccountName newName;
  int newType;
  bool withNewPubkey;
  bool withNewName;
  bool withNewType;

  int opType() {
    return 8;
  }

  /// Creates a new List account for sale operation
  ChangeAccountInfoOperation(
      {@required this.accountSigner,
      @required this.targetSigner,
      this.newPublicKey,
      this.newName,
      this.newType = 0,
      this.withNewPubkey = false,
      this.withNewName = false,
      this.withNewType = false})
      : super() {
    this.newPublicKey = this.newPublicKey ?? PublicKey.empty();
    this.newName = this.newName ?? AccountName('');
  }

  void setNewPublickey(PublicKey publicKey) {
    this.newPublicKey = publicKey;
    this.withNewPubkey = true;
  }

  void setNewName(AccountName accountName) {
    this.newName = accountName;
    this.withNewName = true;
  }

  void setNewType(int type) {
    this.newType = type;
    this.withNewType = true;
  }

  /// Decode this operation from raw bytes
  static ChangeAccountInfoOperation decodeFromBytes(Uint8List bytes) {
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
    // 6 zero-bytes are always here
    offset += 6;
    // Change type
    //int changeType = Int8.decodeFromBytes(bytes.sublist(offset, offset + 1));
    offset++;
    // New public key
    Uint8List newPublicKeyBytes = bytes.sublist(offset, bytes.length);
    PublicKey newPublicKey =
        PublicKeyCoder().decodeFromBytes(newPublicKeyBytes);
    offset += PublicKeyCoder().encodeToBytes(newPublicKey).length;
    // New name
    int newNameLength = PDUtil.decodeLength(bytes.sublist(offset, offset + 2));
    Uint8List newNameBytes = bytes.sublist(offset, offset + newNameLength + 2);
    AccountName newName = AccountNameCoder().decodeFromBytes(newNameBytes);
    offset += newNameLength + 2;
    // New Type
    int newType = Int16.decodeFromBytes(bytes.sublist(offset, offset + 2));
    offset += 2;
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
    return ChangeAccountInfoOperation(
        accountSigner: signer, targetSigner: target)
      ..withNOperation(nOperation)
      ..withFee(fee)
      ..withPayload(payload)
      ..setNewName(newName)
      ..setNewPublickey(newPublicKey)
      ..setNewType(newType)
      ..withSignature(signature);
  }

  /// Encode this operation into raw bytes
  Uint8List encodeToBytes() {
    Uint8List signer = AccountNumberCoder().encodeToBytes(this.accountSigner);
    Uint8List target = AccountNumberCoder().encodeToBytes(this.targetSigner);
    Uint8List nOperation = Int32.encodeToBytes(this.nOperation);
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee);
    Uint8List payloadLength = PDUtil.encodeLength(this.payload.length);
    Uint8List payload = this.payload;
    Uint8List v2publickey = PublicKeyCoder().encodeToBytes(PublicKey.empty());
    Uint8List changeType = Int8.encodeToBytes(this.changeType);
    Uint8List newPublicKey = PublicKeyCoder().encodeToBytes(this.newPublicKey);
    Uint8List newName = AccountNameCoder().encodeToBytes(this.newName);
    Uint8List newType = Int16.encodeToBytes(this.newType);
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
      changeType,
      newPublicKey,
      newName,
      newType,
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
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee);
    Uint8List payloadLength = PDUtil.encodeLength(this.payload.length);
    Uint8List v2publickey = PublicKeyCoder().encodeToBytes(PublicKey.empty());
    Uint8List changeType = Int8.encodeToBytes(this.changeType);
    Uint8List newPublicKey = PublicKeyCoder().encodeToBytes(this.newPublicKey);
    Uint8List newName = AccountNameCoder().encodeToBytes(this.newName);
    Uint8List newType = Int16.encodeToBytes(this.newType);
    Uint8List type = OpTypeCoder(1).encodeToBytes(this.opType());
    return PDUtil.concat([
      signer,
      target,
      nOperation,
      fee,
      payloadLength,
      v2publickey,
      changeType,
      newPublicKey,
      newName,
      newType,
      type
    ]);
  }

  get changeType {
    int changeType = 0;

    if (this.withNewPubkey) {
      changeType |= 1;
    }
    if (this.withNewName) {
      changeType |= 2;
    }
    if (this.withNewType) {
      changeType |= 4;
    }

    return changeType;
  }
}
