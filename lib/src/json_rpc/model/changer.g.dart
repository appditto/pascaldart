// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'changer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Changer _$ChangerFromJson(Map<String, dynamic> json) {
  return Changer(
      changingAccount: intToAccountNum(json['account'] as int),
      nOperation: json['n_operation'] as int,
      newEncPubkey: hexToPublicKey(json['new_enc_pubkey'] as String),
      newName: strToAccountName(json['new_name'] as String),
      newType: json['new_type'] as int,
      sellerAccount: intToAccountNum(json['seller_account'] as int),
      accountPrice: pascalToCurrency(json['account_price'] as num),
      lockedUntilBlock: json['locked_until_block'] as int,
      fee: pascalToCurrency(json['fee'] as num));
}

Map<String, dynamic> _$ChangerToJson(Changer instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('account', accountNumToInt(instance.changingAccount));
  writeNotNull('n_operation', instance.nOperation);
  writeNotNull('new_enc_pubkey', publicKeyToHex(instance.newEncPubkey));
  writeNotNull('new_name', accountNameToStr(instance.newName));
  writeNotNull('new_type', instance.newType);
  writeNotNull('seller_account', accountNumToInt(instance.sellerAccount));
  writeNotNull('account_price', currencyToDouble(instance.accountPrice));
  writeNotNull('locked_until_block', instance.lockedUntilBlock);
  writeNotNull('fee', currencyToDouble(instance.fee));
  return val;
}
