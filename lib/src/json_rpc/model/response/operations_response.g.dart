// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OperationsResponse _$OperationsResponseFromJson(Map<String, dynamic> json) =>
    OperationsResponse(
      operations: (json['result'] as List<dynamic>?)
          ?.map((e) => PascalOperation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OperationsResponseToJson(OperationsResponse instance) =>
    <String, dynamic>{
      'result': instance.operations,
    };
