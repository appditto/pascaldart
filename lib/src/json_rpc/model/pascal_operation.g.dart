// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pascal_operation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PascalOperation _$PascalOperationFromJson(Map<String, dynamic> json) {
  return PascalOperation(
    valid: json['valid'] as bool,
    errors: json['errors'] as String,
    block: json['block'] as int,
    time: toDateTime(json['time'] as int),
    opblock: json['opblock'] as int,
    maturation: json['maturation'] as int,
    optype: json['optype'] as int,
    account: intToAccountNum(json['account'] as int),
    optxt: json['optxt'] as String,
    amount: pascalToCurrency(json['amount'] as num),
    fee: pascalToCurrency(json['fee'] as num),
    balance: pascalToCurrency(json['balance'] as num),
    ophash: json['ophash'] as String,
    payload: json['payload'] as String,
    signerAccount: intToAccountNum(json['signer_account'] as int),
    senders: (json['senders'] as List)
        ?.map((e) =>
            e == null ? null : Sender.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    receivers: (json['receivers'] as List)
        ?.map((e) =>
            e == null ? null : Receiver.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    changers: (json['changers'] as List)
        ?.map((e) =>
            e == null ? null : Changer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    encPubkey: hexToPublicKey(json['enc_pubkey'] as String),
  );
}

Map<String, dynamic> _$PascalOperationToJson(PascalOperation instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('valid', instance.valid);
  writeNotNull('errors', instance.errors);
  writeNotNull('block', instance.block);
  writeNotNull('time', fromDateTime(instance.time));
  writeNotNull('opblock', instance.opblock);
  val['maturation'] = instance.maturation;
  writeNotNull('optype', instance.optype);
  writeNotNull('account', accountNumToInt(instance.account));
  writeNotNull('optxt', instance.optxt);
  writeNotNull('amount', currencyToDouble(instance.amount));
  writeNotNull('fee', currencyToDouble(instance.fee));
  writeNotNull('balance', currencyToDouble(instance.balance));
  writeNotNull('ophash', instance.ophash);
  writeNotNull('payload', instance.payload);
  writeNotNull('signer_account', accountNumToInt(instance.signerAccount));
  writeNotNull('senders', instance.senders);
  writeNotNull('receivers', instance.receivers);
  writeNotNull('changers', instance.changers);
  writeNotNull('enc_pubkey', publicKeyToHex(instance.encPubkey));
  return val;
}
