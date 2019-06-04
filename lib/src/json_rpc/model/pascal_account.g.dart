// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pascal_account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PascalAccount _$PascalAccountFromJson(Map<String, dynamic> json) {
  return PascalAccount(
      account: intToAccountNum(json['account'] as int),
      encPubkey: hexToPublicKey(json['enc_pubkey'] as String),
      balance: pascalToCurrency(json['balance'] as num),
      nOperation: json['n_operation'] as int,
      updatedBlock: json['updated_b'] as int,
      state: accountStateFromJson(json['state'] as String),
      type: json['type'] as int,
      lockedUntilBlock: json['locked_until_block'] as int,
      price: pascalToCurrency(json['price'] as num),
      sellerAccount: intToAccountNum(json['seller_account'] as int),
      privateSale: json['private_sale'] as bool,
      newEncPubkey: hexToPublicKey(json['new_enc_pubkey'] as String))
    ..name = strToAccountName(json['name'] as String);
}

Map<String, dynamic> _$PascalAccountToJson(PascalAccount instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('account', accountNumToInt(instance.account));
  writeNotNull('enc_pubkey', publicKeyToHex(instance.encPubkey));
  writeNotNull('balance', currencyToDouble(instance.balance));
  writeNotNull('n_operation', instance.nOperation);
  writeNotNull('updated_b', instance.updatedBlock);
  writeNotNull('state', accountStateToJson(instance.state));
  writeNotNull('type', instance.type);
  writeNotNull('locked_until_block', instance.lockedUntilBlock);
  writeNotNull('price', currencyToDouble(instance.price));
  writeNotNull('seller_account', accountNumToInt(instance.sellerAccount));
  writeNotNull('private_sale', instance.privateSale);
  writeNotNull('new_enc_pubkey', publicKeyToHex(instance.newEncPubkey));
  writeNotNull('name', accountNameToStr(instance.name));
  return val;
}
