import 'package:pascaldart/src/common/coding/pascal/keys/publickey_coder.dart';
import 'package:pascaldart/src/common/model/accountname.dart';
import 'package:pascaldart/src/common/model/accountnumber.dart';
import 'package:pascaldart/src/common/model/currency.dart';
import 'package:pascaldart/src/common/model/keys/publickey.dart';
import 'package:pascaldart/src/common/pascaldart_util.dart';
import 'package:pascaldart/src/json_rpc/model/pascal_account.dart';

/// Various serialization converters

String accountStateToJson(AccountState state) {
  return state == null ? null : state == AccountState.LISTED ? "listed" : "normal";
}

AccountState accountStateFromJson(String state) {
  return state == null ? null : state == "listed" ? AccountState.LISTED : AccountState.NORMAL;
}

DateTime toDateTime(int v) {
  return v == null ? null : DateTime.fromMillisecondsSinceEpoch(v * 1000, isUtc: true);
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

AccountNumber intToAccountNum(int pascalAccount) {
  return pascalAccount == null ? null : AccountNumber.fromInt(pascalAccount);
}

int accountNumToInt(AccountNumber accountNumber) {
  return accountNumber == null ? null : accountNumber.account;
}

AccountName strToAccountName(String name) {
  return name == null ? null : AccountName(name);
}

String accountNameToStr(AccountName name) {
  return name == null ? null : name.toString();
}

PublicKey hexToPublicKey(String hexKey) {
  return hexKey == null ? null : PublicKeyCoder().decodeFromBytes(PDUtil.hexToBytes(hexKey));
}

String publicKeyToHex(PublicKey pubKey) {
  return pubKey == null ? null : PDUtil.byteToHex(PublicKeyCoder().encodeToBytes(pubKey));
}