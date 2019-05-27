import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
abstract class BaseResponse {
  @JsonKey(name:'jsonrpc')
  String jsonrpc;

  @JsonKey(name:'id')
  int id;

  BaseResponse({this.jsonrpc, this.id});
}