import 'package:pascaldart/src/common/model/currency.dart';
import 'package:pascaldart/src/json_rpc/model/pascal_account.dart';

/// Various serialization converters

String accountStateToJson(AccountState state) {
  return state == null ? null : state == AccountState.LISTED ? "listed" : "normal";
}

AccountState accountStateFromJson(String state) {
  return state == null ? null : state == "listed" ? AccountState.LISTED : AccountState.NORMAL;
}

DateTime toDateTime(int v) {
  return v == null ? null : DateTime.fromMicrosecondsSinceEpoch(v);
}

int fromDateTime(DateTime dt) {
  return dt?.millisecondsSinceEpoch;
}

Currency pascalToCurrency(num pascalAmount) {
  return pascalAmount == null ? null : Currency(pascalAmount.toString());
}

double currencyToDouble(Currency currency) {
  return currency == null ? null : double.parse(currency.toString());
}