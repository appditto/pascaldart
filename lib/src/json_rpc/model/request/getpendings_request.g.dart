// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'getpendings_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPendingsRequest _$GetPendingsRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['method'],
  );
  return GetPendingsRequest()
    ..jsonrpc = json['jsonrpc'] as String? ?? '2.0'
    ..method = json['method'] as String?
    ..id = json['id'] as int? ?? 0
    ..params = json['params'] as Map<String, dynamic>?;
}

Map<String, dynamic> _$GetPendingsRequestToJson(GetPendingsRequest instance) {
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
