import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:pascaldart/src/common/pascaldart_util.dart';

class Signature {
  BigInt r;
  BigInt s;

  Signature({@required this.r, @required this.s}) {
    if (Endian.host == Endian.little) { 
      this.r = PDUtil.decodeBigInt(PDUtil.encodeBigInt(this.r, endian: Endian.big));
      this.s = PDUtil.decodeBigInt(PDUtil.encodeBigInt(this.s, endian: Endian.big));
    }
  }
}
