
import 'package:pascaldart/common.dart';
import 'package:test/test.dart';

import '../../fixtures/OperationHash.dart';

void main() {
  group('common.coding.pascal.OperationHashCoder', () {
    OperationHashFixtures fixture;

    setUp(() {
      fixture = OperationHashFixtures();
    });
    test('can decode a pascalcoin Operationhash', () {
      fixture.hashes.forEach((hashData) {
        OperationHash oph = OperationHashCoder().decodeFromBytes(Util.hexToBytes(hashData['ophash']));

        expect(oph.block, hashData['block']);
        expect(oph.account.account, hashData['account']);
        expect(oph.nOperation, hashData['n_operation']);
        expect(Util.byteToHex(oph.md160), hashData['ophash'].substring(hashData['ophash'].length - 40, hashData['ophash'].length));
      });
    });
    test('can encode a pascalcoin Operationhash', () {
      fixture.hashes.forEach((hashData) {
        OperationHash opHash = OperationHash(hashData['block'],
                                             hashData['account'],
                                             hashData['n_operation'],
                                             Util.hexToBytes(hashData['ophash'].substring(hashData['ophash'].length - 40, hashData['ophash'].length)));
        String hex = Util.byteToHex(OperationHashCoder().encodeToBytes(opHash));

        expect(hex, hashData['ophash']);
      });
    });
  });
}
