// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pascal_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PascalBlock _$PascalBlockFromJson(Map<String, dynamic> json) {
  return PascalBlock(
      block: json['block'] as int,
      encPubkey: json['enc_pubkey'] as String,
      reward: json['reward'] as int,
      fee: (json['fee'] as num)?.toDouble(),
      ver: json['ver'] as int,
      ver_a: json['ver_a'] as int,
      timestamp: _toDateTime(json['timestamp'] as int),
      target: json['target'] as int,
      nonce: json['nonce'] as int,
      payload: json['payload'] as String,
      sbh: json['sbh'] as String,
      oph: json['oph'] as String,
      pow: json['pow'] as String,
      operations: json['operations'] as int);
}

Map<String, dynamic> _$PascalBlockToJson(PascalBlock instance) =>
    <String, dynamic>{
      'block': instance.block,
      'enc_pubkey': instance.encPubkey,
      'reward': instance.reward,
      'fee': instance.fee,
      'ver': instance.ver,
      'ver_a': instance.ver_a,
      'timestamp': _fromDateTime(instance.timestamp),
      'target': instance.target,
      'nonce': instance.nonce,
      'payload': instance.payload,
      'sbh': instance.sbh,
      'oph': instance.oph,
      'pow': instance.pow,
      'operations': instance.operations
    };
