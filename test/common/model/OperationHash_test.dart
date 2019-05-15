
import 'package:pascaldart/common.dart';
import 'package:test/test.dart';

void main() {
  group('common.model.OperationHash', () {
    test('can be created manually and returns correct initialization values', () {
      OperationHash oph = OperationHash(1, 2, 3, Util.hexToBytes(List.filled(20, 'AA').join()));

      expect(oph.block, 1);
      expect(oph.account.account, 2);
      expect(oph.nOperation, 3);
      expect(Util.byteToHex(oph.md160), List.filled(20, 'AA').join());
    });

    test('checks a valid md160', () {
      expect(() => OperationHash(1, 2, 3, Util.hexToBytes('AAAAAAAAAAA')), throwsException);
    });
  });
}
