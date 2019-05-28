// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getaccount_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAccountRequest _$GetAccountRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(json, disallowNullValues: const ['method']);
  return GetAccountRequest(params: json['params'] as Map<String, dynamic>)
    ..jsonrpc = json['jsonrpc'] as String ?? '2.0'
    ..method = json['method'] as String
    ..id = json['id'] as int ?? 0;
}

Map<String, dynamic> _$GetAccountRequestToJson(GetAccountRequest instance) {
  final val = <String, dynamic>{
    'jsonrpc': instance.jsonrpc,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('method', instance.method);
  val['id'] = instance.id;
  val['params'] = instance.params;
  return val;
}
