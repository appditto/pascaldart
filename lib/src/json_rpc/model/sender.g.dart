// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sender _$SenderFromJson(Map<String, dynamic> json) {
  return Sender(
      sendingAccount: intToAccountNum(json['account'] as int),
      nOperation: json['n_operation'] as int,
      amount: pascalToCurrency(json['amount'] as num),
      payload: json['payload'] as String);
}

Map<String, dynamic> _$SenderToJson(Sender instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('account', accountNumToInt(instance.sendingAccount));
  writeNotNull('n_operation', instance.nOperation);
  writeNotNull('amount', currencyToDouble(instance.amount));
  writeNotNull('payload', instance.payload);
  return val;
}
