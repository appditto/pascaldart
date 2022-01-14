import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';

part 'getblock_request.g.dart';

@JsonSerializable()
class GetBlockRequest extends BaseRequest {
  @JsonKey(name: 'params')
  Map<String, dynamic>? params;

  @JsonKey(ignore: true)
  get block {
    return params!['block'];
  }

  GetBlockRequest({int? block, this.params}) : super(method: 'getblock') {
    this.params = Map();
    this.params!['block'] = block;
  }

  Map<String, dynamic> toJson() => _$GetBlockRequestToJson(this);
  factory GetBlockRequest.fromJson(Map<String, dynamic> json) =>
      _$GetBlockRequestFromJson(json);
}
