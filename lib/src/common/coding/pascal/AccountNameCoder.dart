import 'dart:typed_data';

import 'package:pascaldart/src/common/model/AccountName.dart';
import 'package:pascaldart/src/common/Util.dart';

/// A special pascal type that can en/decode an account name
class AccountNameCoder {
  int byteSize;

  AccountNameCoder({this.byteSize = 2});

  /// Decode account name from given bytes
  AccountName decodeFromBytes(Uint8List bytes) {
    int length;
    if (byteSize == 2) {
      length = int.parse(Util.switchEndian(Util.byteToHex(bytes.sublist(0, 2))), radix: 16);
    } else {
      length = Util.bytesToInt([bytes[0]]);
      this.byteSize = 1;
    }
    Uint8List nameBytes = bytes.sublist(byteSize, length+byteSize);
    return AccountName(Util.bytesToUtf8String(nameBytes));
  }

  /// Encode account name to bytes
  Uint8List encodeToBytes(AccountName accountName) {
    int length = accountName.toString().length;
    String lengthHex = Util.byteToHex(Util.intToBytes(length)).padRight(byteSize == 2 ? 4 : 2, '0');
    return Util.hexToBytes(lengthHex + Util.byteToHex(Util.stringToBytesUtf8(accountName.toString())));
  }
}
