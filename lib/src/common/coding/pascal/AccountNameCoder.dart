import 'dart:typed_data';

import 'package:pascaldart/src/common/coding/core/StringWithLength.dart';
import 'package:pascaldart/src/common/model/AccountName.dart';
import 'package:pascaldart/src/common/Util.dart';

/// A special pascal type that can en/decode an account name
class AccountNameCoder {
  int byteSize;

  AccountNameCoder({this.byteSize = 2});

  /// Decode account name from given bytes
  AccountName decodeFromBytes(Uint8List bytes) {
    return AccountName(StringWithLength(byteSize: byteSize).decodeFromBytes(bytes));
  }

  /// Encode account name to bytes
  Uint8List encodeToBytes(AccountName accountName) {
    return StringWithLength(byteSize: byteSize).encodeToBytes(accountName.toString());
  }
}
