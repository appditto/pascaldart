import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';

part 'getblockoperations_request.g.dart';

@JsonSerializable()
class GetBlockOperationsRequest extends BaseRequest {
  @JsonKey(name: 'params')
  Map<String, dynamic> params;

  @JsonKey(ignore: true)
  get block {
    return params['block'];
  }

  @JsonKey(ignore: true)
  get start {
    return params['start'];
  }

  @JsonKey(ignore: true)
  get max {
    return params['max'];
  }

  GetBlockOperationsRequest({int block, int start, int max})
      : super(method: 'getblockoperations') {
    this.params = Map();
    if (block != null) {
      this.params['block'] = block;
    }
    if (start != null) {
      this.params['start'] = start;
    }
    if (max != null) {
      this.params['max'] = max;
    }
  }

  Map<String, dynamic> toJson() => _$GetBlockOperationsRequestToJson(this);
  factory GetBlockOperationsRequest.fromJson(Map<String, dynamic> json) =>
      _$GetBlockOperationsRequestFromJson(json);
}
