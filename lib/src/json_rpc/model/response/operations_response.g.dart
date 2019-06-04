// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationsResponse _$OperationsResponseFromJson(Map<String, dynamic> json) {
  return OperationsResponse(
      operations: (json['result'] as List)
          ?.map((e) => e == null
              ? null
              : PascalOperation.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$OperationsResponseToJson(OperationsResponse instance) =>
    <String, dynamic>{'result': instance.operations};
