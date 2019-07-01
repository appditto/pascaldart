import 'package:pascaldart/src/common/pascaldart_util.dart';

/// AccountName encoding for account names.
class AccountName {
  // the list of characters to escape.
  static final List<String> CHARS_TO_ESCAPE = '(){}[]:"<>'.split('');
  static final String REGEX_TO_ESCAPE =
      '(${CHARS_TO_ESCAPE.map((c) => PDUtil.escapeRegex(c)).join('|')})';

  static final List<String> ALLOWED_ALL =
      r'0123456789abcdefghijklmnopqrstuvwxyz!@#$%^&*()-+{}[]_:"|<>,.?/~'
          .split('');
  static final List<String> ALLOWED_START = ALLOWED_ALL.sublist(10);

  String accountName;

  AccountName(String accountName) {
    this.accountName = AccountName.validate(accountName);
  }

  /// Validates a string.
  static String validate(String value) {
    if (value.isEmpty) {
      return value;
    }

    if (value.length < 3) {
      throw Exception(
          'Invalid account name, must be at least 3 characters long.');
    }

    for (int pos = 0; pos < value.length; pos++) {
      if (pos == 0 && !ALLOWED_START.contains(value[pos])) {
        throw Exception(
            'Invalid AccountName encoding - character ${value[pos]} not allowed at position ');
      } else if (pos > 0 && !ALLOWED_ALL.contains(value[pos])) {
        throw Exception(
            'Invalid AccountName encoding - character ${value[pos]} not allowed at position $pos');
      }
    }

    return value;
  }

  @override
  String toString() {
    return this.accountName;
  }

  /// Gets an escaped string representation for EPasa usage.
  String toStringEscaped() {
    return this.accountName.replaceAllMapped(
        RegExp(REGEX_TO_ESCAPE), (match) => '\\${match.group(0)}');
  }

  /// Gets a value indicating whether the current char c1 is an escape modifier
  /// and the second is in the list of chars to escape.
  static bool isEscape(String c1, String c2) {
    return c1 == '\\' && CHARS_TO_ESCAPE.contains(c2);
  }
}
