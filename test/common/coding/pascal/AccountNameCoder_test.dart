
import 'package:pascaldart/common.dart';
import 'package:test/test.dart';

void main() {
  group('common.coding.pascal.accountNameCoder', () {
    AccountNameCoder coderBS2;
    AccountNameCoder coderBS1;
    setUp(() {
      coderBS2 = AccountNameCoder();
      coderBS1 = AccountNameCoder(byteSize: 1);
    });
    test('can decode a pascalcoin account name', () {
      expect(coderBS2.decodeFromBytes(Util.hexToBytes('040074657374')).toString(), 'test');
      expect(coderBS2.decodeFromBytes(Util.hexToBytes('040074657374')) is AccountName, true);
      expect(coderBS1.decodeFromBytes(Util.hexToBytes('0474657374')).toString(), 'test');
      expect(coderBS1.decodeFromBytes(Util.hexToBytes('0474657374')) is AccountName, true);
    });
    test('can encode a pascalcoin account name', () {
      expect(Util.byteToHex(coderBS2.encodeToBytes(AccountName('test'))), '040074657374');
      expect(Util.byteToHex(coderBS1.encodeToBytes(AccountName('test'))), '0474657374');
    });
  });
}
