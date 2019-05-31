import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse extends RPCResponse {
  @JsonKey(name:'jsonrpc')
  String jsonrpc;

  @JsonKey(name:'id')
  int id;

  @JsonKey(name:'result')
  dynamic result;

  BaseResponse({this.jsonrpc, this.id, this.result});

  factory BaseResponse.fromJson(Map<String, dynamic> json) => _$BaseResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}