// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pascal_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PascalBlock _$PascalBlockFromJson(Map<String, dynamic> json) => PascalBlock(
      block: json['block'] as int?,
      encPubkey: hexToPublicKey(json['enc_pubkey'] as String?),
      reward: pascalToCurrency(json['reward'] as num?),
      fee: pascalToCurrency(json['fee'] as num?),
      ver: json['ver'] as int?,
      ver_a: json['ver_a'] as int?,
      timestamp: toDateTime(json['timestamp'] as int?),
      target: json['target'] as int?,
      nonce: json['nonce'] as int?,
      payload: json['payload'] as String?,
      sbh: json['sbh'] as String?,
      oph: json['oph'] as String?,
      pow: json['pow'] as String?,
      operations: json['operations'] as int?,
      hashratekhs: json['hashratekhs'] as int?,
      maturation: json['maturation'] as int?,
    );

Map<String, dynamic> _$PascalBlockToJson(PascalBlock instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('block', instance.block);
  writeNotNull('enc_pubkey', publicKeyToHex(instance.encPubkey));
  writeNotNull('reward', currencyToDouble(instance.reward));
  writeNotNull('fee', currencyToDouble(instance.fee));
  writeNotNull('ver', instance.ver);
  writeNotNull('ver_a', instance.ver_a);
  writeNotNull('timestamp', fromDateTime(instance.timestamp));
  writeNotNull('target', instance.target);
  writeNotNull('nonce', instance.nonce);
  writeNotNull('payload', instance.payload);
  writeNotNull('sbh', instance.sbh);
  writeNotNull('oph', instance.oph);
  writeNotNull('pow', instance.pow);
  writeNotNull('operations', instance.operations);
  writeNotNull('hashratekhs', instance.hashratekhs);
  writeNotNull('maturation', instance.maturation);
  return val;
}
