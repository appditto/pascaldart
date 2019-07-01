import 'dart:typed_data';

import 'package:meta/meta.dart';

class ECDHResult {
  bool isEncrypted;
  Uint8List data;
  Uint8List key;
  Uint8List publicKey;

  ECDHResult(
      {@required isEncrypted,
      @required this.data,
      @required this.key,
      this.publicKey});
}
