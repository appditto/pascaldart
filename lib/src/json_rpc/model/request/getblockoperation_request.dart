import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';

part 'getblockoperation_request.g.dart';

@JsonSerializable()
class GetBlockOperationRequest extends BaseRequest {
  @JsonKey(name: 'params')
  Map<String, dynamic>? params;

  @JsonKey(ignore: true)
  get block {
    return params!['block'];
  }

  @JsonKey(ignore: true)
  get opblock {
    return params!['opblock'];
  }

  GetBlockOperationRequest({int? block, int opblock = 0})
      : super(method: 'getblockoperation') {
    this.params = Map();
    if (block != null) {
      this.params!['block'] = block;
    }
    this.params!['opblock'] = opblock;
  }

  Map<String, dynamic> toJson() => _$GetBlockOperationRequestToJson(this);
  factory GetBlockOperationRequest.fromJson(Map<String, dynamic> json) =>
      _$GetBlockOperationRequestFromJson(json);
}
