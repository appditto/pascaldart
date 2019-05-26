// ignore: implementation_imports
import "package:pointycastle/src/impl/base_padding.dart";
// ignore: implementation_imports
import "package:pointycastle/src/registry/registry.dart";
import "package:pointycastle/api.dart";
import "dart:typed_data";
/// transferred from ZeroBytePadding.java from bouncycastle
class ZeroBytePadding extends BasePadding {
  static final FactoryConfig FACTORY_CONFIG =
  StaticFactoryConfig(Padding, "ZeroByte", () => ZeroBytePadding());
  @override
  String get algorithmName => "ZeroByte";

  @override
  int padCount(Uint8List data) {
    int count = data.length;
    while (count > 0) {
      if (data[count - 1] != 0) {
        break;
      }
      count--;
    }
    return data.length - count;
  }

  @override
  int addPadding(Uint8List data, int offset) {
    int added = (data.length - offset);
    while (offset < data.length) {
      data[offset] = 0;
      offset++;
    }
    return added;
  }

  @override
  void init([CipherParameters params]) {

  }
}