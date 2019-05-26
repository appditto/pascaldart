import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
abstract class BaseRequest {
  @JsonKey(name:'jsonrpc', defaultValue: '2.0')
  String jsonrpc;

  @JsonKey(name:'method', disallowNullValue: true)
  String method;

  @JsonKey(name:'id', defaultValue: 0)
  int id;

  BaseRequest({this.method, this.id = 0});
}