import 'dart:convert';
import 'dart:typed_data';

import 'package:pascaldart/src/common/BC.dart';
import 'package:test/test.dart';

void main() {
  group('Common.BC', () {
    test('Construct BC with hex string', () {
      const String hexString = '02CA';

      expect(BC.fromHex(hexString).toHex(), hexString);
    });
    test('Construct BC with int', () {
      const int val = 714;

      expect(BC.fromInt(val).toHex(), '02CA');
    });
    test('will append a leading 0 in case of mod 2 == 1 && not strict mode', () {
      const String hexString = '2CA';

      expect(BC.fromHex(hexString, strict: false).toHex(), '0$hexString');
    });
    test('will not append a leading 0 in case of mod 2 == 1 && strict mode', () {
      const String hexString = '2CA';

      expect(() => BC.fromHex(hexString, strict: true).toHex(), throwsException);
    });
    test('will return the length of the bytes', () {
      const String hexString = 'ABABABABAB';

      expect(BC.fromHex(hexString).length, 5);
    });
    test('will return the length of the resulting hexastring', () {
      const String hexString = 'ABABABABAB';

      expect(BC.fromHex(hexString).hexLength, 10);
    });
    test('can switch endianness', () {
      const String hexString = 'CA20';

      expect(BC.fromHex(hexString).switchEndian().toHex(), '20CA');
      expect(BC.fromHex(hexString).switchEndian().switchEndian().toHex(), hexString);
    });
    test('can concat one or more hexastrings', () {
      final List<BC> hexas = ['ABCD', '0020', 'FFFFFFDD'].map((hex) => BC.fromHex(hex)).toList();

      expect(BC.concat(hexas).toHex(), 'ABCD0020FFFFFFDD');
    });
    test('can append a hexastring to an existing hexastring', () {
      final BC base = BC.fromHex('ABCD');
      final BC append = BC.fromHex('DCBA');

      expect(base.append(append).toHex(), 'ABCDDCBA');
    });
    test('can prepend a hexastring to an existing hexastring', () {
      final BC base = BC.fromHex('ABCD');
      final BC append = BC.fromHex('DCBA');

      expect(base.prepend(append).toHex(), 'DCBAABCD');
    });
    test('can slice parts', () {
        final BC base = BC.fromHex('0123456789ABCDEF');
        final BC firstTwo = base.slice(0, end: 2);
        final BC midTwo = base.slice(4, end: 6);
        final BC lastTwo = base.slice(7);

        expect(firstTwo.toHex(), '0123');
        expect(midTwo.toHex(), '89AB');
        expect(lastTwo.toHex(), 'EF');
      });
    });
    test('can return the results as a string', () {
      final BC h = BC.fromString('Hello Techworker');

      expect(h.toString(), 'Hello Techworker');
    });
    test('can return the results as an int', () {
      final BC h = BC.fromInt(714);

      expect(h.toInt(), 714);
    });
    test('can return the results as hex', () {
      final BC h = BC.fromHex('ABCD');

      expect(h.toHex(), 'ABCD');
    });
    test('will throw an error when initializing from hex with non hex nibble', () {
      expect(() => BC.fromHex('ZZ'), throwsException);
    });
    test('can handle existing BC in from', () {
      final BC h = BC.fromHex('ABCD');
      final BC b = BC.from(h);

      expect(b.toHex(), 'ABCD');
    });
    test('returns a copy of the buffer and the originl buffer stays untouched', () {
      final BC h = BC.fromHex('5457');
      final Uint8List buffer = h.copyBuffer().asUint8List();

      buffer[0] = 85;

      expect(utf8.decode(buffer), 'UW');
      expect(h.toString(), 'TW');
    });
    test('will fill up missing bytes when initialized from an int with size', () {
      final BC h = BC.fromInt(1, nBytes: 3);

      expect(h.toHex(), '000001');
    });
    test('can return a lowercased hex value', () {
      final BC h = BC.fromHex('AABB');

      expect(h.toHex(lowerCase: true), 'aabb');
    });
    test('can compare', () {
      final BC h = BC.fromHex('AABB');
      final BC h2 = BC.fromHex('AABB');
      final BC h3 = BC.fromHex('AABBCC');

      expect(h == h2, true);
      expect(h == h3, false);
    });
    test('can be initialized via from', () {
      // hex string
      expect(BC.from('ABAB').toHex(),'ABAB');

      // string
      expect(BC.from('test', stringType: 'string').toString(), 'test');

      // buffer
      expect(BC.from(BC.from('ABAB').buffer).toHex(), 'ABAB');

      // BC
      expect(BC.from(BC.from('ABAB')).toHex(), 'ABAB');

      // Uint8List
      expect(BC.from(BC.from('ABAB').buffer.asUint8List()).toHex(), 'ABAB');
    });
}
