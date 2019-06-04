import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/pascal_operation.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';

part 'operations_response.g.dart';

@JsonSerializable()
class OperationsResponse extends RPCResponse {
  @JsonKey(name: 'result')
  List<PascalOperation> operations;

  OperationsResponse({this.operations});

  factory OperationsResponse.fromJson(Map<String, dynamic> json) => _$OperationsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$OperationsResponseToJson(this);
}