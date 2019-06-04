import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/pascal_block.dart';
import 'package:pascaldart/src/json_rpc/model/response/rpc_response.dart';

part 'blocks_response.g.dart';

@JsonSerializable()
class BlocksResponse extends RPCResponse {
  @JsonKey(name: 'result')
  List<PascalBlock> blocks;

  BlocksResponse({this.blocks});

  factory BlocksResponse.fromJson(Map<String, dynamic> json) => _$BlocksResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BlocksResponseToJson(this);
}