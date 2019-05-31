import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse extends RPCResponse{
  @JsonKey(name:'code')
  int errorCode;

  @JsonKey(name:'message')
  String errorMessage;

  ErrorResponse({this.errorCode, this.errorMessage});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => _$ErrorResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);

  get isError => true;
}