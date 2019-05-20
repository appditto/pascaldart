
import 'package:pascaldart/common.dart';
import 'package:test/test.dart';

void main() {
  group('common.coding.pascal.AccountNumberCoder', () {
    AccountNumberCoder coder;
    setUp(() {
      coder = AccountNumberCoder();
    });
    test('can decode a pascalcoin account number', () {
      expect(coder.decodeFromBytes(Util.hexToBytes('EAFA1500')) is AccountNumber, true);
      expect(coder.decodeFromBytes(Util.hexToBytes('EAFA1500')).toString(), '1440490-43');
    });
    test('can encode a pascalcoin account number', () {
      expect(Util.byteToHex(coder.encodeToBytes(AccountNumber.fromInt(1440490))), 'EAFA1500');
    });
  });
}
