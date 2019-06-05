import 'package:json_annotation/json_annotation.dart';
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';

part 'getpendings_request.g.dart';

@JsonSerializable()
class GetPendingsRequest extends BaseRequest {
  @JsonKey(name: 'params')
  Map<String, dynamic> params;

  @JsonKey(ignore: true)
  get start {
    return params['start'];
  }

  @JsonKey(ignore: true)
  get max {
    return params['max'];
  }

  GetPendingsRequest({int start, int max}) : super(method: 'getpendings') {
    this.params = Map();
    if (start != null) {
      this.params['start'] = start;
    }
    if (max != null) {
      this.params['max'] = max;
    }
  }

  Map<String, dynamic> toJson() => _$GetPendingsRequestToJson(this); 
}