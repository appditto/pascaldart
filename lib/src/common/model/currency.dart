/// Pascal currency math/currency functions
class Currency {
  BigInt pasc; // Amount

  Currency(String value) {
    value = value.split(',').join(''); // remove commas
  
    final BigInt ten = BigInt.from(10);
    final BigInt base = ten.pow(4);

    // Is it negative?
    bool negative = (value.substring(0, 1) == '-');

    if (negative) {
      value = value.substring(1);
    }

    if (value == '.') {
      throw Exception(
        'Invalid value ${pasc} cannot be converted to base unit with 4 decimals.');
    }

    // Split it into a whole and fractional part
    List<String> comps = value.split('.');

    String whole;
    String fraction;

    if (comps.length > 2) { 
      throw Exception('Too many decimal points');
    } else if (comps.length == 2) {
      fraction = comps[1];
    }
    whole = comps[0];

    if (whole == null) { whole = '0'; }
    if (fraction == null) { fraction = '0'; }
    if (fraction.length > 4) {
      throw Exception('Too many decimal places');
    }

    while (fraction.length < 4) {
      fraction += '0';
    }

    BigInt wholeDec = BigInt.parse(whole);
    BigInt fractionDec = BigInt.parse(fraction);
    BigInt molina = wholeDec * base + fractionDec;

    if (negative) {
      molina = molina * BigInt.from(-1);
    }

    this.pasc = molina;
  }

  Currency.fromCurrency(Currency currency) {
    this.pasc = currency.pasc;
  }

  Currency.fromBigInt(BigInt pasc) {
    this.pasc = pasc;
  }

  Currency.fromMolina(String molina) {
    this.pasc = BigInt.parse(molina);
  }

  @override
  String toString() {
    return toFixed(this.pasc);
  }

  String toFixed(BigInt x) {
    BigInt base = BigInt.from(10).pow(4);
    String mod = (x % base).toString();
    String m = (x ~/ base).toString();

    // 0-pad
    while (mod.length % 4 != 0) {
      mod = '0' + mod;
    }

    bool isNegative = false;

    if (x.toString().substring(0, 1) == '-') {
      if (m.substring(0, 1) == '-') {
        m = m.substring(1);
      }
      if (mod.substring(0, 1) == '-') {
        mod = mod.substring(1);
      }
      isNegative = true;
    }

    return '${isNegative ? '-' : ''}$m.$mod';
  }

  /// Gets a value indicating that the current value has more decimals than
  /// allowed.
  bool isVague() {
    return this.toStringOpt(decimals: 5) != this.toStringOpt(decimals: 4);
  }

  /// Gets an optimized pascal value with less zeros as possible.
  String toStringOpt({decimals = 4}) {
    return toFixed(this.pasc)
      .replaceFirst(RegExp(r'[0]+$'), '')
      .replaceFirst(RegExp(r'[\.]+$'), '');
  }

  /// Get pascal value as string
  String toMolina() {
    return this.pasc.toString();
  }

  /// Adds the given value to the current value and returns a **new**
  /// value.
  Currency add(Currency addValue) {
    return Currency.fromBigInt(
      this.pasc + addValue.pasc,
    );
  }

  Currency addInt(int addValue) {
    return Currency.fromBigInt(this.pasc + BigInt.from(addValue));
  }

  Currency addString(String addValue) {
    return Currency.fromBigInt(this.pasc + Currency.fromMolina(addValue).pasc);
  }

  /// Subtracts the given value from the current value and returns a **new**
  /// value.
  Currency sub(Currency subValue) {
    return Currency.fromBigInt(
      this.pasc - subValue.pasc,
    );
  }

  Currency subInt(int subValue) {
    return Currency.fromBigInt(this.pasc - BigInt.from(subValue));
  }

  Currency subString(String subValue) {
    return Currency.fromBigInt(this.pasc + Currency.fromMolina(subValue).pasc);
  }

  /// Gets a positive variant of the value. If the value is already
  /// positive, the current instance will be returned, else a new
  /// instance.
  Currency toPositive() {
    if (this.pasc < BigInt.zero) {
      return Currency.fromBigInt(
        this.pasc * BigInt.from(-1),
      );
    }

    return this;
  }

  /// Comparative operators
  bool operator == (o) => (o is Currency && o.hashCode == hashCode) || (o is BigInt && o.hashCode == pasc.hashCode) || (o is String && o.hashCode == pasc.toString().hashCode);
  bool operator < (o) => o is Currency && pasc < o.pasc;
  bool operator <= (o) => o is Currency && pasc <= o.pasc;
  bool operator > (o) => o is Currency && pasc > o.pasc;
  bool operator >= (o) => o is Currency && pasc >= o.pasc;
  int get hashCode => pasc.hashCode;
}