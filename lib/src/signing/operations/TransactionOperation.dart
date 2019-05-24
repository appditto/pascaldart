import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:pascaldart/src/common/Util.dart';
import 'package:pascaldart/src/common/coding/core/Int8.dart';
import 'package:pascaldart/src/common/coding/pascal/AccountNumberCoder.dart';
import 'package:pascaldart/src/common/coding/pascal/CurrencyCoder.dart';
import 'package:pascaldart/src/common/coding/pascal/OpTypeCoder.dart';
import 'package:pascaldart/src/common/coding/pascal/keys/CurveCoder.dart';
import 'package:pascaldart/src/common/model/AccountNumber.dart';
import 'package:pascaldart/src/common/model/Currency.dart';
import 'package:pascaldart/src/common/model/keys/Curves.dart';
import 'package:pascaldart/src/signing/operations/BaseOperation.dart';

/// Representation of a signable Transaction operation.
class TransactionOperation extends BaseOperation<TransactionOperation> {
  AccountNumber sender;
  AccountNumber target;
  Currency amount;

  int opType() {
    return 1;
  }

  /// Creates a new Transaction instance with the given data. The payload is
  /// empty by default and not encoded.
  TransactionOperation({@required this.sender, @required this.target, @required this.amount}) : super();

  TransactionOperation decodeFromBytes(Uint8List bytes) {
    return null;
  }

  /// Gets the digest of this operation
  Uint8List encodeToBytes() {
    Uint8List sender = AccountNumberCoder().encodeToBytes(this.sender);
    Uint8List nOperation = Int8.encodeToBytes(this.nOperation);
    Uint8List target = AccountNumberCoder().encodeToBytes(this.target);
    Uint8List currency = CurrencyCoder().encodeToBytes(this.amount);
    Uint8List fee = CurrencyCoder().encodeToBytes(this.fee);
    Uint8List payload = this.payload;
    // Not used in modern pascal coin?
    Uint8List curve = CurveCoder().encodeToBytes(0);
    Uint8List type = OpTypeCoder(1).encodeToBytes(this.opType());
    return Util.concat([
      sender,
      nOperation,
      target,
      currency,
      fee,
      payload,
      curve,
      type
    ]);
  }
}