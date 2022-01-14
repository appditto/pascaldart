// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiver.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Receiver _$ReceiverFromJson(Map<String, dynamic> json) => Receiver(
      receivingAccount: intToAccountNum(json['account'] as int?),
      amount: pascalToCurrency(json['amount'] as num?),
      payload: json['payload'] as String?,
    );

Map<String, dynamic> _$ReceiverToJson(Receiver instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('account', accountNumToInt(instance.receivingAccount));
  writeNotNull('amount', currencyToDouble(instance.amount));
  writeNotNull('payload', instance.payload);
  return val;
}
