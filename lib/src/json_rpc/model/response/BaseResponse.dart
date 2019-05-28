import 'package:json_annotation/json_annotation.dart';

part 'BaseResponse.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name:'jsonrpc')
  String jsonrpc;

  @JsonKey(name:'id')
  int id;

  @JsonKey(name:'result')
  Map<String, dynamic> result;

  BaseResponse({this.jsonrpc, this.id, this.result});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}