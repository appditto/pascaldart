// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetAccountResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountResponse _$GetAccountResponseFromJson(Map<String, dynamic> json) {
  return GetAccountResponse(
      account: json['account'] as int,
      encPubkey: json['enc_pubkey'] as String,
      balance: (json['balance'] as num)?.toDouble(),
      nOperation: json['n_operation'] as int,
      updatedBlock: json['updated_b'] as int)
    ..jsonrpc = json['jsonrpc'] as String
    ..id = json['id'] as int;
}

Map<String, dynamic> _$GetAccountResponseToJson(GetAccountResponse instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'account': instance.account,
      'enc_pubkey': instance.encPubkey,
      'balance': instance.balance,
      'n_operation': instance.nOperation,
      'updated_b': instance.updatedBlock
    };
