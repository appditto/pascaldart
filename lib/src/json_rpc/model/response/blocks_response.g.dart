// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlocksResponse _$BlocksResponseFromJson(Map<String, dynamic> json) =>
    BlocksResponse(
      blocks: (json['result'] as List<dynamic>?)
          ?.map((e) => PascalBlock.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BlocksResponseToJson(BlocksResponse instance) =>
    <String, dynamic>{
      'result': instance.blocks,
    };
