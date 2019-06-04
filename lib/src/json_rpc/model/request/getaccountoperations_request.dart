import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:pascaldart/src/json_rpc/model/request/base_request.dart';

part 'getaccountoperations_request.g.dart';

@JsonSerializable()
class GetAccountOperationsRequest extends BaseRequest {
  @JsonKey(name: 'params')
  Map<String, dynamic> params;

  @JsonKey(ignore: true)
  get account {
    return params['account'];
  }

  @JsonKey(ignore: true)
  get depth {
    return params['depth'];
  }

  @JsonKey(ignore: true)
  get start {
    return params['start'];
  }

  @JsonKey(ignore: true)
  get max {
    return params['max'];
  }

  GetAccountOperationsRequest({@required int account, int depth, int start, int max}) : super(method: 'getaccountoperations') {
    this.params = Map();
    this.params['account'] = account;
    if (depth != null) {
      this.params['depth'] = depth;
    }
    if (start != null) {
      this.params['start'] = start;
    }
    if (max != null) {
      this.params['max'] = max;
    }
  }

  Map<String, dynamic> toJson() => _$GetAccountOperationsRequestToJson(this); 
}